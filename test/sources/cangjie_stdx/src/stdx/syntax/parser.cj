/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList
import std.fs.*
import std.sort.*

class Parser {
    private let impl: ParserImpl
    private let filePath: String

    private init(filePath: String) {
        impl = ParserImpl(filePath)
        this.filePath = filePath
    }

    static func parseFile(filePath: String): (?SourceFile, Array<Diagnostic>) {
        let fileInfo = try {
            let path = canonicalize(filePath)
            FileInfo(path)
        } catch (e: Exception) {
            throw Exception("IOException: ${e.message}")
        }
        if (fileInfo.path.extensionName != "cj") {
            throw Exception("IOException: The file extension of the source file must be 'cj'.")
        } else if (!fileInfo.canRead()) {
            throw Exception("IOException: The file is not readable.")
        } else if (!fileInfo.isRegular()) {
            throw Exception("IOException: The path ${fileInfo.path.toString()} is not a file!")
        }
        let (node, diags) = Parser(fileInfo.path.toString()).parse()
        let file: ?SourceFile = if (let Some(root) <- node) {
            root as SourceFile
        } else {
            None
        }
        (file, diags)
    }

    static func parseText(text: String): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (node, diags) = Parser("").parseFromText(text)
        let res: ?SyntaxTreeNode = if (let Some(root) <- node) {
            root as SyntaxTreeNode
        } else {
            None
        }
        (res, diags)
    }

    static func parseTokens(tokens: Tokens, refreshPos: Bool): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (node, diags) = Parser("").parseFromTokens(tokens, refreshPos)
        let res: ?SyntaxTreeNode = if (let Some(root) <- node) {
            root as SyntaxTreeNode
        } else {
            None
        }
        (res, diags)
    }

    static func parsePackage(dirPath: String): (?Package, Array<Diagnostic>) {
        let fileList = ArrayList<SourceFile>()
        let fileImpls = ArrayList<(SyntaxNodeImpl, String)>()
        let diagsList = ArrayList<Diagnostic>()
        var parseFailed = false
        var pkg: ?Package = None
        let fileInfos = try {
            let path: Path = Path(dirPath)
            var fileInfos = Directory.readFrom(dirPath)
            let comparator = {l: FileInfo, r: FileInfo => l.name.compare(r.name)}
            sort(fileInfos, by: comparator)
            fileInfos
        } catch (e: Exception) {
            throw Exception("IOException: ${e.message}")
        }
        for (fileInfo in fileInfos) {
            if (fileInfo.path.extensionName != "cj") {
                continue
            }
            var (file, diags) = parseFile(fileInfo.path.toString())
            diagsList.add(all: diags)
            if (parseFailed) {
                continue
            }
            if (let Some(f) <- file) {
                fileList.add(f)
                fileImpls.add((f.nodeImpl, fileInfo.path.toString()))
            } else {
                parseFailed = true
            }
        }

        if (!parseFailed) {
            let (isMacro, name) = checkPackage(fileList)
            pkg = Package(isMacro, name, fileImpls.toArray())
        }
        (pkg, diagsList.toArray())
    }

    private func parse(): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (root, diags) = impl.parseFile()
        (buildSyntaxTree(root), diags)
    }

    private func parseFromText(text: String): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (root, diags) = impl.parseText(text)
        (buildSyntaxTree(root), diags)
    }

    private func parseFromTokens(tokens: Tokens, refreshPos: Bool): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (root, diags) = impl.parseTokens(tokens, refreshPos)
        if (!refreshPos) {
            var startIndex = 0
            while (startIndex < tokens.size && tokens.get(startIndex).kind == TokenKind.NL) {
                startIndex++
            }
            let startPos = CodePosition(tokens.get(startIndex).pos.line, tokens.get(startIndex).pos.column,
                FileInfos("", ""))
            return (buildSyntaxTree(root, startPos: startPos), diags)
        }
        (buildSyntaxTree(root), diags)
    }

    // build syntax tree by syntax impl tree
    private func buildSyntaxTree(node: ?SyntaxNodeImpl, startPos!: ?CodePosition = None): ?SyntaxTreeNode {
        if (let Some(root) <- node) {
            if (filePath.size > 0) { // called from parseFile
                SyntaxNodeImplTranslator.translateFile(root, filePath)
            } else if (let Some(stPos) <- startPos) { // called from parseTokens with refreshPos is false
                SyntaxNodeImplTranslator.translate(root, stPos, Option<SyntaxTreeNode>.None)
            } else { // called from parseText or parseTokens
                SyntaxNodeImplTranslator.translate(root, CodePosition(1, 1, FileInfos("", "")),
                    Option<SyntaxTreeNode>.None)
            }
        } else {
            None
        }
    }
}

func getPackageName(file: SourceFile) {
    if (let Some(pkgHeader) <- file.pkgHeader) {
        return String.join(pkgHeader.packageNameIdentifiers, delimiter: ".")
    }
    return "default"
}

func checkPackage(sourceFiles: ArrayList<SourceFile>): (Bool, String) {
    if (sourceFiles.size == 0) {
        return (false, "")
    }
    var packageName = getPackageName(sourceFiles[0])
    var isMacro: Bool = sourceFiles[0].isMacroPackage
    for (f in sourceFiles) {
        if (packageName != getPackageName(f)) {
            throw Exception("ParseException: found more than one package declaration for the package.")
        }
        if (isMacro != f.isMacroPackage) {
            throw Exception("ParseException: found different macro package declaration.")
        }
    }
    return (isMacro, packageName)
}
