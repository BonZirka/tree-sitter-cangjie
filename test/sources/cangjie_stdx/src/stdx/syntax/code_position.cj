/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

class FileInfos {
    FileInfos(let name: String, let path: String) {}

    operator func ==(right: FileInfos): Bool {
        if (this.name == right.name && this.path == right.path) {
            true
        } else {
            false
        }
    }
}

struct CodePosition {
    public let line: Int32
    public let column: Int32

    let fileInfo: FileInfos

    public prop fileName: String {
        get() {
            return fileInfo.name
        }
    }

    public prop filePath: String {
        get() {
            return fileInfo.path
        }
    }

    init() {
        this.line = 0
        this.column = 0
        this.fileInfo = FileInfos("", "")
    }

    init(line: Int32, column: Int32, fileInfo: FileInfos) {
        this.line = line
        this.column = column
        this.fileInfo = fileInfo
    }

    operator func +(right: Int64): CodePosition {
        CodePosition(this.line, this.column + Int32(right), fileInfo)
    }

    operator func +(right: Offset): CodePosition {
        if (right.line > 0) {
            CodePosition(this.line + right.line, right.column, this.fileInfo)
        } else {
            CodePosition(this.line, this.column + Int32(right.column), fileInfo)
        }
    }

    operator func ==(right: CodePosition): Bool {
        if (this.fileInfo == right.fileInfo && this.line == right.line && this.column == right.column) {
            true
        } else {
            false
        }
    }
}

public struct CodePositionRange {
    public let beginLine: Int32
    public let beginColumn: Int32
    public let endLine: Int32
    public let endColumn: Int32

    private let fileInfo: FileInfos

    public prop fileName: String {
        get() {
            return fileInfo.name
        }
    }

    public prop filePath: String {
        get() {
            return fileInfo.path
        }
    }

    prop begin: CodePosition {
        get() {
            return CodePosition(beginLine, beginColumn, fileInfo)
        }
    }

    init() {
        this.beginLine = 0
        this.beginColumn = 0
        this.endLine = 0
        this.endColumn = 0
        this.fileInfo = FileInfos("", "")
    }

    init(begin: CodePosition, end: CodePosition) {
        this.beginLine = begin.line
        this.beginColumn = begin.column
        this.endLine = end.line
        this.endColumn = end.column
        this.fileInfo = begin.fileInfo
    }

    operator func ==(that: CodePositionRange) {
        this.beginLine == that.beginLine && this.beginColumn == that.beginColumn && this.endLine == that.endLine &&
            this.endColumn == that.endColumn && this.filePath == that.filePath
    }

    operator func !=(that: CodePositionRange) {
        !(this == that)
    }
}

let DEFAULT_START_POS = CodePosition(1, 1, FileInfos("", ""))
