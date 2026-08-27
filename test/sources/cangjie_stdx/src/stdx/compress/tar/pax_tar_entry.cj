/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.fs.Path
import std.io.{InputStream, OutputStream}
import std.collection.{HashMap, Map, ArrayList}
import std.env.getProcessId

extend Int64 {
    func decimalDigitsCount(): Int64 {
        var n = this
        var count = 0
        while (n != 0) {
            n /= 10
            count++
        }
        return count
    }
}

private class PaxExtensionTarEntry {
    private let header = TarHeaderBuffer()
    private var datas = ArrayList<Array<UInt8>>()
    private var lastDataIndex = 0

    private prop size: Int64 {
        get() {
            return (datas.size - 1) * TAR_BLOCK_SIZE + lastDataIndex
        }
    }

    private func initializeHeader() {
        "./PaxHeaders.${getProcessId()}/".encodeTo(header[FieldLocation.NAME])
        "0000644".encodeTo(header[FieldLocation.MODE])
        "17777777770".encodeTo(header[FieldLocation.M_TIME])
        header[FieldLocation.TYPE_FLAG][0] = TarEntryType.ExtendedHeader.flag
        USTAR_MAGIC.encodeTo(header[FieldLocation.MAGIC])
        USTAR_VERSION.encodeTo(header[FieldLocation.VERSION])
    }

    private func addPaxItem(item: Array<UInt8>) {
        if (datas.size == 0 || lastDataIndex == TAR_BLOCK_SIZE) {
            datas.add(Array(TAR_BLOCK_SIZE, repeat: 0))
            lastDataIndex = 0
        }

        var index = 0
        while (index < item.size) {
            let remainWrite = item.size - index
            let remainSpace = TAR_BLOCK_SIZE - lastDataIndex
            let canWriteComplete = remainSpace >= remainWrite
            let writeSize = if (canWriteComplete) {
                remainWrite
            } else {
                remainSpace
            }
            let last = datas[datas.size - 1]
            for (i in 0..writeSize) {
                last[lastDataIndex] = item[index]
                lastDataIndex++
                index++
            }
            if (!canWriteComplete) {
                datas.add(Array(TAR_BLOCK_SIZE, repeat: 0))
                lastDataIndex = 0
            }
        }
    }

    private func addPaxItem(item: String) {
        addPaxItem(unsafe { item.rawData() })
    }

    private func addPaxData(key: String, value: String) {
        // ' ' + <key> + '=' + <value> + '\n'
        let suffixLength = 1 + key.size + 1 + value.size + 1
        let currentLength = suffixLength + suffixLength.decimalDigitsCount()
        let realLength = suffixLength + currentLength.decimalDigitsCount()
        addPaxItem("${realLength} ${key}=${value}\n")
    }

    private func addPaxData(paxData: Map<String, String>) {
        for ((key, value) in paxData) {
            addPaxData(key, value)
        }
    }

    init(paxData: Map<String, String>) {
        initializeHeader()
        addPaxData(paxData)
    }

    func writeTo(target: OutputStream): Unit {
        size.encodeOcatalTo(header[FieldLocation.SIZE])
        header.writeTo(target)
        for (data in datas) {
            target.write(data)
        }
    }
}

public class PaxTarEntry <: PosixTarEntry {
    init(header: TarHeader) {
        super(header)
    }

    init(header: TarHeader, stream: ?InputStream) {
        super(header, stream)
    }

    public func getPaxData(key: String): ?String {
        return _header.paxData.get(key)
    }

    public init(path: String) {
        this(Path(path))
    }

    public init(path: Path) {
        super(path)

        _header.format = TarEntryFormat.Pax
    }

    private static func writePaxExtensionEntry(target: OutputStream, paxData: Map<String, String>) {
        PaxExtensionTarEntry(paxData).writeTo(target)
    }

    public override func writeTo(target: OutputStream): Unit {
        let buffer = TarHeaderBuffer()
        let paxData = HashMap(_header.paxData)
        if (name.size > FieldLocation.NAME.length) {
            paxData.add("path", name)
        } else {
            writeNameDirectly(buffer)
        }
        if (linkName.size > FieldLocation.LINK_NAME.length) {
            paxData.add("linkpath", linkName)
        } else {
            writeLinkNameDirectly(buffer)
        }
        if (paxData.size > 0) {
            writePaxExtensionEntry(target, paxData)
        }
        writeCommonFieldsWithoutNameChecksumLinkName(buffer)
        writePosixFields(buffer, USTAR_MAGIC, USTAR_VERSION)

        buffer.writeTo(target)

        writeDataTo(target)
    }
}
