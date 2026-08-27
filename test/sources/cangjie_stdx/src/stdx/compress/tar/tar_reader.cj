/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.io.{InputStream, Seekable}
import std.collection.{Map, HashMap, concat, forEach}
import std.deriving.Derive

// PAX record format
// <length> <keyword>=<value>\n
@Derive[Equatable]
private enum PaxDataState {
    Length |
    Keyword |
    Value
}

func calculateDataBlockPadding(size: Int64): Int64 {
    return (TAR_BLOCK_SIZE - (size % TAR_BLOCK_SIZE)) % TAR_BLOCK_SIZE
}

public class TarReader<T> <: Iterable<TarEntry> where T <: InputStream {
    let stream: T

    // IEEE 1003.1-2008, pax Format
    // Section: Extended Header Records
    // For each file in the archive, there may be one or more extended header records immediately preceding the file data.
    // Each record consists of a series of keyword/value pairs that apply to the file that follows it.
    // If a global extended header record appears before any file in the archive, its keywords shall be considered defaults for all subsequent files until another global extended header record is encountered.
    // Any keywords defined in a per-file extended header shall override the corresponding keywords defined by the most recent global extended header.
    private let paxGlobalData: Map<String, String> = HashMap()
    private let paxData: Map<String, String> = HashMap()
    private var gnuLongName: ?String = None
    private var gnuLongLink: ?String = None

    // Total archive size if the input stream is seekable; used for basic sanity checks.
    private let archiveSize: ?Int64
    // Tracks the current entry stream so we can drain unread bytes before parsing the next header.
    private var activeDataStream: ?TarDataInputStream = None

    private var paxGlobalDataBytes: Int64 = 0

    public init(stream: T) {
        this.stream = stream
        this.archiveSize = getArchiveSize(stream)
    }

    public func iterator(): Iterator<TarEntry> {
        return TarEntryIterator(this)
    }

    func tryGetNextEntry(): ?TarEntry {
        // Keep reader state aligned even when caller does not fully consume entry.stream.
        drainPreviousEntryData()
        var header: TarHeader
        do {
            header = TarHeader.tryReadHeader(TarHeaderBuffer(stream)) ?? return None
            validateDataBlockSize(header.size)
            match (header.entryType) {
                case TarEntryType.GlobalExtendedHeader =>
                    validatePaxHeaderSize(header.size, header.entryType)
                    mergePaxGlobalData(readPaxData(header.size))
                case TarEntryType.ExtendedHeader =>
                    validatePaxHeaderSize(header.size, header.entryType)
                    paxData.add(all: readPaxData(header.size))
                case TarEntryType.GnuLongName =>
                    validateGnuLongPathSize(header.size, header.entryType)
                    gnuLongName = String.fromUtf8(readDataBlock(header.size))
                case TarEntryType.GnuLongLink =>
                    validateGnuLongPathSize(header.size, header.entryType)
                    gnuLongLink = String.fromUtf8(readDataBlock(header.size))
                case TarEntryType.GnuSparse |
                     TarEntryType.GnuDumpDir |
                     TarEntryType.GnuMultiVolume |
                     TarEntryType.GnuName |
                     TarEntryType.GnuVolumeHeader => () // Not support.
                case _ => break
            }
        } while (true)

        return generateEntry(header)
    }

    private func generateEntry(header: TarHeader): TarEntry {
        // Apply GNU first for legacy compatibility, then PAX to override per POSIX standard.
        // Industry convention: PAX takes precedence when both exist.
        applyGnuData(header)
        let hasPaxData = applyPaxData(header)

        let dataStream = readDataStream(header.size)
        if (hasPaxData) {
            return PaxTarEntry(header, dataStream)
        }
        return match (header.format) {
            case TarEntryFormat.Ustar => UstarTarEntry(header, dataStream)
            case TarEntryFormat.V7 => V7TarEntry(header, dataStream)
            case TarEntryFormat.Gnu => GnuTarEntry(header, dataStream)
            case TarEntryFormat.Pax => PaxTarEntry(header, dataStream)
        }
    }

    private func applyGnuData(header: TarHeader): Bool {
        var hasGnuData = false
        if (let Some(longName) <- gnuLongName && !longName.isEmpty()) {
            header.name = longName
            gnuLongName = None
            hasGnuData = true
        }
        if (let Some(longLink) <- gnuLongLink && !longLink.isEmpty()) {
            header.linkName = longLink
            gnuLongLink = None
            hasGnuData = true
        }
        return hasGnuData
    }

    private func applyPaxData(header: TarHeader): Bool {
        var hasPaxData = false
        if (paxGlobalData.size > 0 || paxData.size > 0) {
            hasPaxData = true
        }
        paxGlobalData |> concat(paxData) |> forEach(header.addPaxData)
        paxData.clear()
        return hasPaxData
    }

    private func mergePaxGlobalData(newData: HashMap<String, String>): Unit {
        var nextPaxGlobalDataBytes = paxGlobalDataBytes
        for ((key, value) in newData) {
            nextPaxGlobalDataBytes += key.size
            if (let Some(oldValue) <- paxGlobalData.get(key)) {
                nextPaxGlobalDataBytes -= oldValue.size
            }
            nextPaxGlobalDataBytes += value.size
        }

        const MAX_PAX_GLOBAL_DATA_BYTES = 32 * 1024 * 1024
        if (nextPaxGlobalDataBytes > MAX_PAX_GLOBAL_DATA_BYTES) {
            throw TarException("Global pax metadata exceeds supported maximum ${MAX_PAX_GLOBAL_DATA_BYTES} bytes.")
        }

        paxGlobalData.add(all: newData)
        paxGlobalDataBytes = nextPaxGlobalDataBytes
    }

    private func readPaxData(size: Int64): HashMap<String, String> {
        let data = readDataBlock(size)

        let result = HashMap<String, String>()
        var state = PaxDataState.Length
        var position = 0
        var current = 0

        var length = -1
        var end = -1
        var key = ""
        var value = ""

        while (current < data.size) {
            let c = data[current]
            match (state) {
                case PaxDataState.Length =>
                    if (b'0' <= c && c <= b'9') {
                        current++
                    } else if (c == b' ') {
                        if (position == current) {
                            throw TarException("Invalid PAX record, empty length field.")
                        }
                        length = parseInt64(data[position..current])
                        if (length < 1) {
                            throw TarException("Invalid PAX record, length must be positive.")
                        }
                        end = position + length
                        if (end > data.size) {
                            throw TarException("Invalid PAX record, length ${length} exceeds available data size ${data.size - position}.")
                        }
                        current++
                        position = current
                        state = PaxDataState.Keyword
                    } else {
                        throw TarException("Invalid PAX record, length field includes non-digit character '${c}'.")
                    }
                case PaxDataState.Keyword =>
                    if (end - 1 <= current) {
                        throw TarException("Invalid PAX record, keyword length exceeds record length.")
                    } else if (c == b'=') {
                        key = String.fromUtf8(data[position..current])
                        current++
                        position = current
                        state = PaxDataState.Value
                    } else {
                        current++
                    }
                case PaxDataState.Value =>
                    if (end - 1 > current) {
                        current++
                    } else if (end - 1 < current) {
                        throw TarException("Invalid PAX record, value length exceeds record length.")
                    } else if (c != b'\n') {
                        throw TarException("Invalid PAX record, value does not end with newline.")
                    } else {
                        value = String.fromUtf8(data[position..current])
                        result[key] = value
                        current++
                        position = current
                        state = PaxDataState.Length
                    }
            }
        }
        if (state != PaxDataState.Length) { 
            throw TarException("Invalid PAX record, incomplete record.")
        }
        return result
    }

    private static func parseInt64(data: Array<UInt8>): Int64 {
        var result: Int64 = 0
        for (digit in data) {
            result = result * 10 + Int64(digit - b'0')
        }
        return result
    }

    private func skipDataBlockPadding(size: Int64) {
        let padding = calculateDataBlockPadding(size)
        skip(stream, padding)
        return padding
    }

    private func validateDataBlockSize(size: Int64) {
        if (size < 0) {
            throw TarException("Invalid tar entry size: ${size}.")
        }
        // Reject clearly malicious/corrupted headers that declare a single entry larger than the archive itself.
        if (let Some(totalSize) <- archiveSize && size > totalSize) {
            throw TarException("Invalid tar entry size ${size}: exceeds tar archive size ${totalSize}.")
        }
    }

    private func validatePaxHeaderSize(size: Int64, entryType: TarEntryType) {
        // PAX headers carry textual key-value metadata. In practice they are small.
        const MAX_PAX_HEADER_SIZE = 8 * 1024 * 1024 // 8 MiB
        if (size > MAX_PAX_HEADER_SIZE) {
            throw TarException("${entryType} size ${size} exceeds supported maximum ${MAX_PAX_HEADER_SIZE}.")
        }
    }

    private func validateGnuLongPathSize(size: Int64, entryType: TarEntryType) {
        // GNU long name/link store a single long path string (usually path length + '\0').
        const MAX_GNU_LONG_PATH_SIZE = 256 * 1024 // 256 KiB
        if (size > MAX_GNU_LONG_PATH_SIZE) {
            throw TarException("${entryType} size ${size} exceeds supported maximum ${MAX_GNU_LONG_PATH_SIZE}.")
        }
    }

    private func readDataBlock(size: Int64): Array<UInt8> {
        validateDataBlockSize(size)
        if (size == 0) {
            return []
        }

        let result = Array<UInt8>(size, repeat: 0)
        readExactly(stream, result)
        skipDataBlockPadding(size)
        return result
    }

    private func readDataStream(size: Int64): ?InputStream {
        validateDataBlockSize(size)
        // Lazily read entry payload to avoid allocating a huge byte array up front.
        let dataStream = TarDataInputStream(stream, size)
        activeDataStream = dataStream
        return dataStream
    }

    private func drainPreviousEntryData() {
        if (let Some(dataStream) <- activeDataStream) {
            // Consume any unread payload + padding so next header starts at a block boundary.
            dataStream.discardRemaining()
            activeDataStream = None
        }
    }

    private static func getArchiveSize(stream: InputStream): ?Int64 {
        match (stream) {
            case s: Seekable =>
                if (s.length >= 0) {
                    return s.length
                }
                return None
            case _ => return None
        }
    }
}

extend<T> TarReader<T> <: Resource where T <: Resource {
    public func close(): Unit {
        this.stream.close()
    }

    public func isClosed(): Bool {
        return this.stream.isClosed()
    }
}

class TarEntryIterator<T> <: Iterator<TarEntry> where T <: InputStream {
    let tarReader: TarReader<T>
    
    init(tarReader: TarReader<T>) {
        this.tarReader = tarReader
    }

    public func next(): ?TarEntry {
        tarReader.tryGetNextEntry()
    }
}

private class TarDataInputStream <: InputStream {
    private static const SKIP_BUFFER_SIZE = 8 * 1024

    private let source: InputStream
    private let skipBuffer = Array<UInt8>(SKIP_BUFFER_SIZE, repeat: 0)
    private let paddingSize: Int64

    private var remainingDataSize: Int64
    private var finished = false

    init(source: InputStream, dataSize: Int64) {
        this.source = source
        this.remainingDataSize = dataSize
        this.paddingSize = calculateDataBlockPadding(dataSize)
    }

    public func read(outBuf: Array<UInt8>): Int64 {
        if (finished || outBuf.isEmpty()) {
            return 0
        }
        if (remainingDataSize == 0) {
            finishAndSkipPadding()
            return 0
        }

        let expect = if (remainingDataSize > outBuf.size) {
            outBuf.size
        } else {
            remainingDataSize
        }
        let readSize = source.read(outBuf[..expect])
        if (readSize == 0) {
            throw TarException("End of stream reached before tar data block was exactly read.")
        }

        remainingDataSize -= readSize
        if (remainingDataSize == 0) {
            finishAndSkipPadding()
        }
        return readSize
    }

    func discardRemaining() {
        if (finished) {
            return
        }

        // Fast-forward remaining payload with a fixed-size scratch buffer.
        while (remainingDataSize > 0) {
            let chunkSize = if (remainingDataSize > skipBuffer.size) {
                skipBuffer.size
            } else {
                remainingDataSize
            }
            let readSize = source.read(skipBuffer[..chunkSize])
            if (readSize == 0) {
                throw TarException("End of stream reached before tar data block was exactly read.")
            }
            remainingDataSize -= readSize
        }
        finishAndSkipPadding()
    }

    private func finishAndSkipPadding() {
        if (finished) {
            return
        }
        if (paddingSize > 0) {
            skipExactly(paddingSize)
        }
        finished = true
    }

    private func skipExactly(size: Int64) {
        var remaining = size
        while (remaining > 0) {
            let chunkSize = if (remaining > skipBuffer.size) {
                skipBuffer.size
            } else {
                remaining
            }
            let readSize = source.read(skipBuffer[..chunkSize])
            if (readSize == 0) {
                throw TarException("End of stream reached before tar data block padding was exactly read.")
            }
            remaining -= readSize
        }
    }
}
