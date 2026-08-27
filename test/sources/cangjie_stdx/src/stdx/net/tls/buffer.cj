/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.net.tls.common.TlsException

abstract class Buffer {
    protected static const DEFAULT_SIZE = 4096
    protected static const DEFAULT_SIZE_LIMIT = 65536
    protected static const COMPACT_TRESHOLD = 512

    protected var buffer: Array<Byte>
    private let sizeLimit: Int64
    protected var start = 0
    protected var end = 0

    prop isEmpty: Bool {
        get() {
            start == end
        }
    }

    prop mayCompact: Bool {
        get() {
            start > 0 && (end - start <= COMPACT_TRESHOLD || buffer.size - end <= COMPACT_TRESHOLD)
        }
    }

    protected init(size: Int64, sizeLimit: Int64) {
        if (sizeLimit <= 0) {
            throw IllegalArgumentException("SizeLimit should be positive: ${sizeLimit}.")
        }
        if (size <= 0) {
            throw IllegalArgumentException("Size should be positive: ${size}.")
        }
        if (size > sizeLimit) {
            throw IllegalArgumentException("Size is greater than the limit: size = ${size}, sizeLimit = ${sizeLimit}.")
        }

        this.buffer = Array<Byte>(size, repeat: 0)
        this.sizeLimit = sizeLimit
    }

    func grow(): Unit {
        var newSize = buffer.size * 3 / 2
        if (newSize <= buffer.size) {
            newSize = buffer.size * 2
        }
        let shifted = newSize >> 2 << 2
        if (shifted > buffer.size) {
            newSize = shifted
        }
        if (newSize > sizeLimit) {
            newSize = sizeLimit
        }

        if (newSize <= buffer.size) {
            throw TlsException("Failed to grow buffer.")
        }
        let newBuffer = Array<Byte>(newSize, repeat: 0)
        buffer.copyTo(newBuffer, 0, 0, buffer.size)
        buffer = newBuffer
    }

    func compact(): Unit {
        if (start > 0) {
            if (start < end) {
                buffer.copyTo(buffer, start, 0, end - start)
            }
            end -= start
            start = 0
        }
    }
}

class OutputBuffer <: Buffer {
    init(size!: Int64 = DEFAULT_SIZE, sizeLimit!: Int64 = max(DEFAULT_SIZE_LIMIT, size * 2)) {
        super(size, sizeLimit)
    }

    prop hasFreeSpace: Bool {
        get() {
            end < buffer.size
        }
    }

    // usage: socket.write(buffer.data)
    prop data: Array<Byte> {
        get() {
            buffer[start..end]
        }
    }

    // for mapping to openssl
    prop freeSpace: Array<Byte> {
        get() {
            buffer[end..]
        }
    }

    // after socket.write()
    func consumed(bytes: Int64) {
        start += bytes
    }

    func commit(bytesWritten!: Int64) {
        end += bytesWritten
    }
}

class InputBuffer <: Buffer {
    private var eof_: Bool = false

    init(size!: Int64 = DEFAULT_SIZE, sizeLimit!: Int64 = max(DEFAULT_SIZE_LIMIT, size * 2)) {
        super(size, sizeLimit)
    }

    prop hasFreeSpace: Bool {
        get() {
            end < buffer.size
        }
    }

    prop eof: Bool {
        get() {
            eof_
        }
    }

    // usage: socket.read(buffer.freeSpace)
    prop freeSpace: Array<Byte> {
        get() {
            buffer[end..]
        }
    }

    // for mapping to openssl
    prop data: Array<Byte> {
        get() {
            buffer[start..end]
        }
    }

    // invoked after socket.read(freeSpace)
    func commit(bytesRead!: Int64) {
        end += bytesRead
    }

    // invoked after socket.read(freeSpace)
    func markEof() {
        eof_ = true
    }

    // invoked after withMappedData
    func consumed(bytes: Int64) {
        start += bytes
    }
}

func max(a: Int64, b: Int64) {
    if (a > b) {
        a
    } else {
        b
    }
}
