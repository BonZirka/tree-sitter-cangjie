/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.collection.{Map, HashMap}
import std.time.DateTime

class TarHeader {
    var format: TarEntryFormat

    // Common (V7)
    var name: String
    var size: Int64
    var entryType: TarEntryType
    var mode: Int32
    var uid: Int32
    var gid: Int32
    var mTime: DateTime
    var linkName: String
    var checksum: Int32

    // USTAR and GNU (POSIX)
    var magic: String = ""
    var version: String = ""
    var uName: String = ""
    var gName: String = ""
    var devMajor: Int32 = 0
    var devMinor: Int32 = 0

    // There is no unique "prefix" field specific to Ustar here, as it will automatically be combined with the "name" field.

    // PAX
    var paxData: Map<String, String> = HashMap<String, String>()

    // GNU
    var aTime: DateTime = DateTime.UnixEpoch
    var cTime: DateTime = DateTime.UnixEpoch

    init(
        format!: TarEntryFormat,
        name!: String,
        mode!: Int32,
        mTime!: DateTime,
        entryType!: TarEntryType,
        checksum!: Int32,
        size!: Int64,
        uid!: Int32,
        gid!: Int32,
        linkName!: String) {
        this.format = format
        this.name = name
        this.mode = mode
        this.mTime = mTime
        this.entryType = entryType
        magic = format.getMagic()
        version = format.getVersion()
        this.checksum = checksum
        this.size = size
        this.uid = uid
        this.gid = gid
        this.linkName = linkName
    }

    func addPaxData(tuple: (String, String)): Unit {
        addPaxData(tuple[0], tuple[1])
    }

    func addPaxData(key: String, value: String): Unit {
        let valueData = unsafe { value.rawData() }
        match (key) {
            case "path"      => name = value.normalizePath()
            case "size"      => size = Int64.parseDecimal(valueData)
            case "mode"      => mode = Int32.parseOctal(valueData)
            case "uid"       => uid = Int32.parseDecimal(valueData)
            case "gid"       => gid = Int32.parseDecimal(valueData)
            case "mtime"     => mTime = parsePaxTimestamp(valueData)
            case "linkpath"  => linkName = value.normalizePath()
            case "uname"     => uName = value
            case "gname"     => gName = value
            case "atime"     => aTime = parsePaxTimestamp(valueData)
            case "ctime"     => cTime = parsePaxTimestamp(valueData)
            case "devmajor"  => devMajor = Int32.parseDecimal(valueData)
            case "devminor"  => devMinor = Int32.parseDecimal(valueData)
            case _           => paxData[key] = value
        }
    }

    static func tryReadHeader(buffer: TarHeaderBuffer): ?TarHeader {
        let header = tryReadCommonFields(buffer) ?? return None
        header.readMagic(buffer)

        // If it is in V7 format, the header reading has been completed.
        if (header.format == TarEntryFormat.V7) {
            return header
        }

        header.readVersion(buffer)
        header.readPosixFields(buffer)
        if (header.format == TarEntryFormat.Ustar) {
            header.readUstarFields(buffer)
        } else if (header.format == TarEntryFormat.Gnu) {
            header.readGnuFields(buffer)
        }
        return header
    }

    private static func tryReadCommonFields(buffer: TarHeaderBuffer): ?TarHeader {
        let checksum = buffer.readChecksumAndValidate() ?? return None

        let size = Int64.parseNumeric(buffer[FieldLocation.SIZE])
        if (size < 0) {
            throw TarException("Invalid size field ${buffer[FieldLocation.SIZE]}.")
        }

        let entryType = TarEntryType.fromFlag(buffer[FieldLocation.TYPE_FLAG][0])

        // This is the initial format determination.
        // The final format will be fully determined by the "magic" field.
        let format = match (entryType) {
            case TarEntryType.ExtendedHeader |
                 TarEntryType.GlobalExtendedHeader => TarEntryFormat.Pax
            case TarEntryType.GnuLongName |  
                 TarEntryType.GnuLongLink |
                 TarEntryType.GnuDumpDir |
                 TarEntryType.GnuMultiVolume |
                 TarEntryType.GnuName |
                 TarEntryType.GnuVolumeHeader => TarEntryFormat.Gnu
            case TarEntryType.V7RegularFile => TarEntryFormat.V7
            case TarEntryType.RegularFile => TarEntryFormat.Ustar
            case TarEntryType.GnuSparse => throw TarException("Sparse files are not supported.")
            case _ => TarEntryFormat.V7
        }

        let header = TarHeader(
            format: format,
            name: parseString(buffer[FieldLocation.NAME]).normalizePath(),
            mode: Int32.parseOctal(buffer[FieldLocation.MODE]),
            mTime: parseTimestamp(buffer[FieldLocation.M_TIME]),
            entryType: entryType,
            checksum: checksum,
            size: size,
            uid: Int32.parseOctal(buffer[FieldLocation.UID]),
            gid: Int32.parseOctal(buffer[FieldLocation.GID]),
            linkName: parseString(buffer[FieldLocation.LINK_NAME]).normalizePath()
        )

        return header
    }

    private func readMagic(buffer: TarHeaderBuffer): Unit {
        let magicBuffer = buffer[FieldLocation.MAGIC]
        if (magicBuffer.isAllZero()) {
            format = TarEntryFormat.V7
            return
        }

        if (magicBuffer == GNU_MAGIC) {
            magic = GNU_MAGIC
            format = TarEntryFormat.Gnu
        } else if (magicBuffer == USTAR_MAGIC) {
            magic = USTAR_MAGIC
            if (format == TarEntryFormat.V7) {
                format = TarEntryFormat.Ustar
            }
        } else {
            magic = String.fromUtf8(magicBuffer)
        }
    }

    private func readVersion(buffer: TarHeaderBuffer): Unit {
        if (format == TarEntryFormat.V7) {
            return
        }

        let versionBuffer = buffer[FieldLocation.VERSION]
        if (versionBuffer == USTAR_VERSION) {
            version = USTAR_VERSION
        } else if (versionBuffer == GNU_VERSION) {
            version = GNU_VERSION
        } else {
            throw TarException("Invalid version ${versionBuffer}.")
        }
    }

    private func readPosixFields(buffer: TarHeaderBuffer): Unit {
        uName = String.fromUtf8(buffer[FieldLocation.U_NAME])
        gName = String.fromUtf8(buffer[FieldLocation.G_NAME])

        if (entryType == TarEntryType.CharDevice || entryType == TarEntryType.BlockDevice) {
            devMajor = Int32.parseNumeric(buffer[FieldLocation.DEV_MAJOR])
            devMinor = Int32.parseNumeric(buffer[FieldLocation.DEV_MINOR])
        }
    }

    private func readUstarFields(buffer: TarHeaderBuffer): Unit {
        let prefix = String.fromUtf8(buffer[FieldLocation.PREFIX]).trimZero()
        if (!prefix.isEmpty()) {
            name = "${prefix}/${name}"
            name = name.normalizePath()
        }
    }

    private func readGnuFields(buffer: TarHeaderBuffer): Unit {
        aTime = parseTimestamp(buffer[FieldLocation.A_TIME])
        cTime = parseTimestamp(buffer[FieldLocation.C_TIME])

        // Not support sparse files and long names
    }
}
