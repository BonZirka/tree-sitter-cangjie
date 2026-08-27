/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress

import std.fs.{Path, File, OpenMode}
import std.io.{InputStream, OutputStream}
import stdx.compress.tar.Tar
import stdx.compress.zlib.{DecompressInputStream, CompressOutputStream, WrapType}

public class TarGzip {
    private init() { } // static class

    public static func archive(fromDir!: String, destFile!: String, includeBaseDirectory!: Bool): Unit {
        try (file = File(destFile, OpenMode.Write)) {
            TarGzip.archive(fromDir: Path(fromDir), destStream: file, includeBaseDirectory: includeBaseDirectory)
        }
    }

    public static func archive(fromDir!: Path, destFile!: Path, includeBaseDirectory!: Bool): Unit {
        try (file = File(destFile, OpenMode.Write)) {
            TarGzip.archive(fromDir: fromDir, destStream: file, includeBaseDirectory: includeBaseDirectory)
        }
    }

    public static func archive<T>(fromDir!: String, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream {
        TarGzip.archive(fromDir: Path(fromDir), destStream: destStream, includeBaseDirectory: includeBaseDirectory)
    }

    public static func archive<T>(fromDir!: Path, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream {
        TarGzip.archive(fromDir: fromDir, filter: { _ => true }, destStream: destStream, includeBaseDirectory: includeBaseDirectory)
    }

    public static func archive(fromDir!: String, filter!: (String) -> Bool, destFile!: String, includeBaseDirectory!: Bool): Unit {
        try (file = File(destFile, OpenMode.Write)) {
            TarGzip.archive(fromDir: Path(fromDir), filter: { p: Path => filter(p.toString()) },
                destStream: file, includeBaseDirectory: includeBaseDirectory)
        }
    }

    public static func archive(fromDir!: Path, filter!: (Path) -> Bool, destFile!: Path, includeBaseDirectory!: Bool): Unit {
        try (file = File(destFile, OpenMode.Write)) {
            TarGzip.archive(fromDir: fromDir, filter: filter,
                destStream: file, includeBaseDirectory: includeBaseDirectory)
        }
    }

    private static func archive<T>(fromDir!: Path, filter!: (Path) -> Bool, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream {
        var gzip = CompressOutputStream(destStream, wrap: GzipFormat)
        Tar.archive(fromDir: fromDir, filter: filter, destStream: gzip, includeBaseDirectory: includeBaseDirectory)
        gzip.close()
    }

    public static func extract(fromTarGzip!: String, destDir!: String, overwrite!: Bool): Unit {
        try (file = File(fromTarGzip, OpenMode.Read)) {
            TarGzip.extract(fromStream: file, destDir: Path(destDir), overwrite: overwrite)
        }
    }

    public static func extract(fromTarGzip!: Path, destDir!: Path, overwrite!: Bool): Unit {
        try (file = File(fromTarGzip, OpenMode.Read)) {
            TarGzip.extract(fromStream: file, destDir: destDir, overwrite: overwrite)
        }
    }

    public static func extract<T>(fromStream!: T, destDir!: String, overwrite!: Bool): Unit where T <: InputStream {
        TarGzip.extract(fromStream: fromStream, destDir: Path(destDir), overwrite: overwrite)
    }

    public static func extract<T>(fromStream!: T, destDir!: Path, overwrite!: Bool): Unit where T <: InputStream {
        var gzip = DecompressInputStream(fromStream, wrap: GzipFormat)
        Tar.extract(fromStream: gzip, destDir: destDir, overwrite: overwrite)
        gzip.close()
    }
}
