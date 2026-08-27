/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.deriving.Derive

@Derive[Equatable]
@Derive[ToString]
public enum TarEntryType {
    V7RegularFile |
    RegularFile |
    ContiguousFile |

    HardLink |
    Symlink |
    CharDevice |
    BlockDevice |
    Directory |
    Fifo |

    ExtendedHeader |
    GlobalExtendedHeader |

    GnuLongName |
    GnuLongLink |
    GnuSparse |
    GnuDumpDir |
    GnuMultiVolume |
    GnuName |
    GnuVolumeHeader |

    Unknown(UInt8)

    public prop flag: UInt8 {
        get() {
            match (this) {
                // V7 / Legacy
                case V7RegularFile        => b'\0'
                case RegularFile          => b'0'
                case ContiguousFile       => b'7'

                // USTAR
                case HardLink             => b'1'
                case Symlink              => b'2'
                case CharDevice           => b'3'
                case BlockDevice          => b'4'
                case Directory            => b'5'
                case Fifo                 => b'6'

                // PAX
                case ExtendedHeader       => b'x'
                case GlobalExtendedHeader => b'g'

                // GNU
                case GnuLongName          => b'L'
                case GnuLongLink          => b'K'
                case GnuSparse            => b'S'
                case GnuDumpDir           => b'D'
                case GnuMultiVolume       => b'M'
                case GnuName              => b'N'
                case GnuVolumeHeader      => b'V'

                // Unknown
                case Unknown(x)           => x
            }
        }
    }

    public static func fromFlag(flag: UInt8): TarEntryType {
        match (flag) {
            // V7 / Legacy
            case b'\0'    => V7RegularFile
            case b'0'     => RegularFile
            case b'7'     => ContiguousFile

            // USTAR
            case b'1'     => HardLink
            case b'2'     => Symlink
            case b'3'     => CharDevice
            case b'4'     => BlockDevice
            case b'5'     => Directory
            case b'6'     => Fifo

            // PAX
            case b'x'     => ExtendedHeader
            case b'g'     => GlobalExtendedHeader

            // GNU
            case b'L'     => GnuLongName
            case b'K'     => GnuLongLink
            case b'S'     => GnuSparse
            case b'D'     => GnuDumpDir
            case b'M'     => GnuMultiVolume
            case b'N'     => GnuName
            case b'V'     => GnuVolumeHeader

            // Fallback: preserve unknown byte
            case _        => Unknown(flag)
        }
    }
}