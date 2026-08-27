/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.fs.{Path, FileInfo}
import std.io.{OutputStream}
import std.core.Resource

public class TarWriter<T> where T <: OutputStream {
    let stream: T
    let entryFormat: TarEntryFormat
    var finished: Bool = false

    public prop format: TarEntryFormat {
        get() {
            return this.entryFormat
        }
    }

    public init(stream: T) {
        this.stream = stream
        this.entryFormat = TarEntryFormat.Pax
    }

    public init(stream: T, format: TarEntryFormat) {
        this.stream = stream
        this.entryFormat = format
    }

    public func write(path!: String, entryName!: String): Unit {
        this.write(Path(path), entryName: entryName)
    }

    public func write(path: Path, entryName!: String): Unit {
        let entry = match (this.entryFormat) {
            case TarEntryFormat.V7 => V7TarEntry(path)
            case TarEntryFormat.Ustar => UstarTarEntry(path)
            case TarEntryFormat.Pax => PaxTarEntry(path)
            case TarEntryFormat.Gnu => GnuTarEntry(path)
        }
        entry.name = entryName

        this.write(entry)
    }

    public func write(info: FileInfo, entryName!: String): Unit {
        write(info.path, entryName: entryName)
    }

    public func write(entry: TarEntry): Unit {
        if (this.finished) {
            throw TarException("TarWriter is already finished, cannot write more entries.")
        }
        entry.writeTo(this.stream)
    }

    public func write(it: Iterable<TarEntry>): Unit {
        for (entry in it) {
            this.write(entry)
        }
    }

    public func flush(): Unit {
        if (this.finished) {
            throw TarException("TarWriter is already finished, cannot flush.")
        }
        
        this.stream.flush()
    }

    public func finish(): Unit {
        if (this.finished) {
            throw TarException("TarWriter is already finished, cannot finish again.")
        }
        
        // Write two 512-byte zero blocks as the end mark
        let zeroBlock = Array<UInt8>(512, repeat: 0)
        this.stream.write(zeroBlock)
        this.stream.write(zeroBlock)
        flush()

        this.finished = true
    }
}

extend<T> TarWriter<T> <: Resource where T <: Resource {
    public func close(): Unit {
        if (!this.finished) {
            this.finish()
        }
        this.stream.close()
    }

    public func isClosed(): Bool {
        return this.stream.isClosed()
    }
}
