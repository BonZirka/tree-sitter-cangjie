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

public class UstarTarEntry <: PosixTarEntry {
    init(header: TarHeader) {
        super(header)
    }

    init(header: TarHeader, stream: ?InputStream) {
        super(header, stream)
    }

    public init(path: String) {
        this(Path(path))
    }

    public init(path: Path) {
        super(path)

        _header.format = TarEntryFormat.Ustar
    }

    private func writeNameUsePrefix(buffer: TarHeaderBuffer) {
        var findFeasibleSeparator = false
        var name = ""
        var prefix = ""
        for (i in 0.._header.name.size) {
            if (_header.name[i] != b'/') {
                continue
            }
            if (i < FieldLocation.NAME.length && _header.name.size - i - 1 < FieldLocation.PREFIX.length) {
                name = _header.name[0..i]
                prefix = _header.name[i + 1..name.size]
                findFeasibleSeparator = true
                break
            }
        }
        if (!findFeasibleSeparator) {
            throw TarException("Can not find a feasible solution to split name and prefix of '${name}'.")
        }
        name.encodeTo(buffer[FieldLocation.NAME])
        prefix.encodeTo(buffer[FieldLocation.PREFIX])
    }

    public override func writeTo(target: OutputStream): Unit {
        let buffer = TarHeaderBuffer()
        if (name.size > FieldLocation.NAME.length) {
            writeNameUsePrefix(buffer)
        } else {
            writeNameDirectly(buffer)
        }
        if (linkName.size > FieldLocation.LINK_NAME.length) {
            throw TarException("LinkName `${name}` size is ${linkName.size} " +
                "which is longer than the maximum ${FieldLocation.LINK_NAME.length}.")
        }
        writeLinkNameDirectly(buffer)
        writeCommonFieldsWithoutNameChecksumLinkName(buffer)
        writePosixFields(buffer, USTAR_MAGIC, USTAR_VERSION)

        buffer.writeTo(target)

        writeDataTo(target)
    }
}
