/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.io.{InputStream, OutputStream}
import std.fs.{Directory, Path, FileInfo}
import std.deriving.Derive

extend Array<UInt8> {
    func isAllZero() {
        for (i in this) {
            if (i != 0) {
                return false
            }
        }
        return true
    }
}

func readExactly(stream: InputStream, buffer: Array<UInt8>): Unit {
    var start = 0
    while (start < buffer.size) {
        let num = stream.read(buffer.slice(start, buffer.size - start))
        if (num == 0) {
            throw TarException("End of stream reached before tar header was exactly read.")
        }
        start += num
    }
}

func skip(archiveStream: InputStream, skipSize: Int64): Unit {
    readExactly(archiveStream, Array<UInt8>(skipSize, repeat: 0))
}

func writeZeros(stream: OutputStream, size: Int64): Unit {
    if (size <= 0) {
        return
    }
    stream.write(Array<UInt8>(size, repeat: 0))
}

extend String {
    func trimZero(): String { this.trimStart('\0').trimEnd('\0') }

    func normalizePath(): String {
        Path(this).normalizePath()
    }
}

extend Path {
    func normalizePath(): String {
        normalizeTarPathSeparators(this.normalize().toString()).trimZero()
    }
}

@When[os == "Windows"]
private func normalizeTarPathSeparators(path: String): String {
    return path.replace('\\', '/')
}

@When[os != "Windows"]
private func normalizeTarPathSeparators(path: String): String {
    return path
}

@Derive[Equatable]
enum TargetType {
    File | Directory | Symlink
}

extend Directory {
    static func walkRecursively(path: Path, f: (FileInfo, TargetType) -> Unit): Unit {
        Directory.walk(path) { info =>
            match {
                case info.isDirectory() =>
                    f(info, TargetType.Directory)
                    Directory.walkRecursively(info.path, f)
                case info.isSymbolicLink() =>
                    f(info, TargetType.Symlink)
                case info.isRegular() =>
                    f(info, TargetType.File)
                case _ => ()
            }
            true
        }
    }
}

extend Array<Byte> {
    func equalsIgnoreCaseAndSlash(that: String): Bool {
        // size is the same, and not 0
        var (b1, b2): (Byte, Byte)
        for (i in 0..this.size) {
            b1 = this[i]
            b2 = that[i]
            if (isSlash(b1)) {
                if (!isSlash(b2)) {
                    return false
                }
                continue
            }
            if (!byteEqualsIgnoreAsciiCase(b1, b2)) {
                return false
            }
        }
        return true
    }

    func byteEqualsIgnoreAsciiCase(b1: Byte, b2: Byte): Bool {
        if (b1 == b2) {
            return true
        }
        // b1 in 'A' ~ 'Z', and the lower case of b1 equals to b2
        if (b1 >= b'A' && b1 <= b'Z' && (b1 + 32) == b2) {
            return true
        }
        if (b2 >= b'A' && b2 <= b'Z' && (b2 + 32) == b1) {
            return true
        }
        return false
    }
}

func isSlash(b: Byte) {
    return b == b'/' || b == b'\\'
}

@When[os == "Windows"]
func countSeparator(path: Array<Byte>, idx!: Int64, cnt!: Int64): Int64 {
    var n = cnt
    for (i in idx..path.size where isSlash(path[i])) {
        n--
        if (n == 0) {
            return i + 1
        }
    }
    return path.size
}

// cjlint-ignore -start !G.EXP.03
@When[os == "Windows"]
func getRootLen(path: String): Int64 {
    let raw = unsafe { path.rawData() }
    // "c:" || "c:\\"
    if (raw.size > 1 && raw[1] == b':') {
        if (raw.size > 2 && isSlash(raw[2])) {
            return 3
        }
        return 2
    }
    // "\\\\?\\UNC\\" || "\\\\.\\UNC\\"
    if (raw.size > 7 && (raw[..8].equalsIgnoreCaseAndSlash("\\\\?\\UNC\\") ||
        raw[..8].equalsIgnoreCaseAndSlash("\\\\.\\UNC\\"))) {
        return countSeparator(raw, idx: 8, cnt: 2)
    }
    // "\\\\?\\" || "\\\\.\\"
    if (raw.size > 3 && (raw[..4].equalsIgnoreCaseAndSlash("\\\\?\\") || raw[..4].equalsIgnoreCaseAndSlash("\\\\.\\"))) {
        return countSeparator(raw, idx: 4, cnt: 1)
    }
    if (isSlash(raw[0])) {
        // "\\\\" UNC path
        if (raw.size > 1 && isSlash(raw[1])) {
            return countSeparator(raw, idx: 2, cnt: 2)
        }
        // "\\"
        return 1
    }
    return 0
}
// cjlint-ignore -end

@When[os != "Windows"]
func isRootPath(path: String) {
    return path == "/"
}

@When[os == "Windows"]
func isRootPath(path: String) {
    getRootLen(path) == path.size
}
