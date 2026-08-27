/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.fs.{Path, FileInfo, File, SymbolicLink, OpenMode, exists}
import std.io.{InputStream, OutputStream, copy}
import std.time.DateTime

public abstract class TarEntry {
    static const PADDING = 512

    let _header: TarHeader
    let _stream: ?InputStream

    public prop stream: ?InputStream {
        get() { return this._stream }
    }

    public mut prop name: String {
        get() { _header.name }
        set(value) {
            _header.name = value.normalizePath()
            if (entryType == TarEntryType.Directory && !name.endsWith("/")) {
                _header.name += "/"
            }
        }
    }

    public mut prop mode: Int32 {
        get() { _header.mode }
        set(value) { _header.mode = value }
    }

    public mut prop uid: Int32 {
        get() { _header.uid }
        set(value) { _header.uid = value }
    }

    public mut prop gid: Int32 {
        get() { _header.gid }
        set(value) { _header.gid = value }
    }

    public prop size: Int64 {
        get() { return _header.size }
    }

    public prop modificationTime: DateTime {
        get() { return _header.mTime }
    }

    public prop checksum: Int32 {
        get() { _header.checksum }
    }

    public prop entryType: TarEntryType {
        get() { _header.entryType }
    }

    public prop linkName: String {
        get() { return _header.linkName.normalizePath() }
    }

    init(header: TarHeader) {
        this._header = header
        this._stream = None
    }

    init(header: TarHeader, stream: ?InputStream) {
        this._header = header
        this._stream = stream
    }

    protected init(path: String) {
        this(Path(path))
    }

    protected init(path: Path) {
        if (!exists(path)) {
            throw TarException("Target not exists: ${path}.")
        }

        let fileInfo = FileInfo(path)

        var targetName: String = path.normalizePath()
        var targetSize = 0
        var targetLinkName = ""
        let targetEntryType: TarEntryType
        if (fileInfo.isDirectory()) {
            if (!targetName.endsWith("/")) {
                targetName += "/"
            }
            _stream = None
            targetEntryType = TarEntryType.Directory
        } else if (fileInfo.isRegular()) {
            targetSize = fileInfo.size
            _stream = File(path, Read)
            targetEntryType = TarEntryType.RegularFile
        } else if (fileInfo.isSymbolicLink()) {
            targetLinkName = SymbolicLink.readFrom(path).toString()
            _stream = None
            targetEntryType = TarEntryType.Symlink
        } else {
            throw TarException("Target ${path} type is not directory/regular file/symbolic link, not supported.")
        }

        _header = TarHeader(
            format: TarEntryFormat.V7,
            name: targetName,
            mode: Native.getMode(path),
            mTime: fileInfo.lastModificationTime,
            entryType: targetEntryType,
            checksum: 0,
            size: targetSize,
            uid: Native.getUid(path),
            gid: Native.getGid(path),
            linkName: targetLinkName
        )
    }

    func writeNameDirectly(buffer: TarHeaderBuffer): Unit {
        if (name.isEmpty()) {
            return
        }
        name.encodeTo(buffer[FieldLocation.NAME])
    }

    func writeLinkNameDirectly(buffer: TarHeaderBuffer): Unit {
        if (_header.linkName.isEmpty()) {
            return
        }
        _header.linkName.encodeTo(buffer[FieldLocation.LINK_NAME])
    }

    func writeCommonFieldsWithoutNameChecksumLinkName(buffer: TarHeaderBuffer): Unit {
        _header.mode.encodeOcatalTo(buffer[FieldLocation.MODE])
        _header.uid.encodeOcatalTo(buffer[FieldLocation.UID])
        _header.gid.encodeOcatalTo(buffer[FieldLocation.GID])
        _header.size.encodeOcatalTo(buffer[FieldLocation.SIZE])
        _header.mTime.encodeTo(buffer[FieldLocation.M_TIME])
        buffer[FieldLocation.TYPE_FLAG][0] = _header.entryType.flag
    }

    func writeDataTo(target: OutputStream): Unit {
        if (let Some(s) <- _stream) {
            if (_header.size < 0) {
                throw TarException("TarEntry size is ${_header.size} < 0.")
            }
            let copySize = copy(s, to: target)
            if (copySize != _header.size) {
                throw TarException("TarEntry size is ${_header.size} but " +
                    "write ${copySize} bytes to target from stream.")
            }
            let paddingSize = PADDING - copySize % PADDING
            if (paddingSize != PADDING) {
                writeZeros(target, paddingSize)
            }
        } else if (_header.size > 0) {
            throw TarException("TarEntry size is ${_header.size} > 0 but stream is None.")
        }
    }

    public open func writeTo(target: OutputStream): Unit {
        let buffer = TarHeaderBuffer()
        if (name.size > FieldLocation.NAME.length) {
            throw TarException("Name `${name}` size is ${name.size} " +
                "which is longer than the maximum ${FieldLocation.NAME.length}.")
        }
        writeNameDirectly(buffer)
        if (linkName.size > FieldLocation.LINK_NAME.length) {
            throw TarException("LinkName `${name}` size is ${linkName.size} " +
                "which is longer than the maximum ${FieldLocation.LINK_NAME.length}.")
        }
        writeLinkNameDirectly(buffer)
        writeCommonFieldsWithoutNameChecksumLinkName(buffer)

        buffer.writeTo(target)

        writeDataTo(target)
    }
}
