/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList
import std.collection.collectString
/**
 * @brief Enum representing different kinds of imports.
 */
public enum ImportKind {
    | Alias
    | All
    | Multi
    | Single
    | ...
}

/**
 * @brief Represents position information for import aliases.
 */
class ImportAliasPosInfos {
    let identifierPos: CodePosition
    let asPos: CodePosition
    let aliasNamePos: CodePosition

    init(identifierPos: CodePosition, asPos: CodePosition, aliasNamePos: CodePosition) {
        this.identifierPos = identifierPos
        this.asPos = asPos
        this.aliasNamePos = aliasNamePos
    }
}

/**
 * @brief Represents an import alias, which extends from ImportContent.
 */
public class ImportAlias <: ImportContent {
    private let aliasName_: String
    private let identifier_: String
    /**
     * @brief The position information for the import alias.
     */
    private let posInfos: ImportAliasPosInfos
    /**
     * @brief Gets the position range of the identifier in the import alias.
     *
     * @return A CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + identifier.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Gets the position range of the 'as' keyword in the import alias.
     *
     * @return A CodePositionRange representing the position range of the 'as' keyword.
     */
    public func getAsPos(): CodePositionRange {
        let endPos = posInfos.asPos + SyntaxNodeKind.AsToken.size
        return CodePositionRange(posInfos.asPos, endPos)
    }

    /**
     * @brief Gets the position range of the alias name in the import alias.
     *
     * @return A CodePositionRange representing the position range of the alias name.
     */
    public func getAliasNamePos(): CodePositionRange {
        let endPos = posInfos.aliasNamePos + aliasName.size
        return CodePositionRange(posInfos.aliasNamePos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportAliasPosInfos,
        importContentPosInfos: ImportContentPosInfos, aliasName_: String, identifier_: String, prefixes_: Array<String>,
        commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, importContentPosInfos, prefixes_, commentsPropInfo)
        this.posInfos = posInfos
        this.aliasName_ = aliasName_
        this.identifier_ = identifier_
    }

    /**
     * @brief Initialize node with prefixes, package name and alias name.
     */
    public init(prefixes: Array<String>, identifier: String, alias: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createImportAliasImpl(prefixes, identifier, alias, comments: comments), prefixes)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportAlias>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.aliasName_ = alias
        this.identifier_ = identifier
    }

    /**
     * @brief The name of the alias.
     */
    public prop aliasName: String {
        get() {
            aliasName_
        }
    }

    /**
     * @brief The identifier of the import alias.
     */
    public prop identifier: String {
        get() {
            identifier_
        }
    }
}

/**
 * @brief Represents information about multiple positions.
 */
class ImportAllPosInfos {
    /**
     * @brief The multiple positions stored in the ImportAllPosInfos.
     */
    let mulPos: CodePosition

    init(mulPos: CodePosition) {
        this.mulPos = mulPos
    }
}

/**
 * @brief Represents an import of all elements, extending ImportContent.
 */
public class ImportAll <: ImportContent {
    private let posInfos: ImportAllPosInfos

    /**
     * @brief Gets the position range of the 'mul' token in the import content.
     *
     * @return A CodePositionRange representing the position range of the 'mul' token.
     */
    public func getMulPos(): CodePositionRange {
        let endPos = posInfos.mulPos + SyntaxNodeKind.MulToken.size
        return CodePositionRange(posInfos.mulPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportAllPosInfos,
        importContentPosInfos: ImportContentPosInfos, prefixes_: Array<String>, commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, importContentPosInfos, prefixes_, commentsPropInfo)
        this.posInfos = posInfos
    }

    /**
     * @brief Initialize node with prefixes.
     */
    public init(prefixes: Array<String>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createImportAllImpl(prefixes, comments: comments), prefixes)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportAll>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
    }
}

/**
 * @brief Represents information about positions in import content.
 */
class ImportContentPosInfos {
    /**
     * @brief The positions of dots in the import content.
     */
    let dotsPos: Array<CodePosition>

    /**
     * @brief The positions of prefixes in the import content.
     */
    let prefixesPos: Array<CodePosition>

    init(dotsPos: Array<CodePosition>, prefixesPos: Array<CodePosition>) {
        this.dotsPos = dotsPos
        this.prefixesPos = prefixesPos
    }
}

/**
 * @brief Represents an import content node in the syntax tree.
 */
public open class ImportContent <: SyntaxTreeNode {
    internal let startPos: CodePosition
    /**
     * @brief The position information for the import content.
     */
    private let posInfos: ImportContentPosInfos
    private let prefixes_: Array<String>

    /**
     * @brief Gets the position ranges of dots in the import content.
     *
     * @return An array of CodePositionRange representing the positions of dots.
     */
    public func getDotsPos(): Array<CodePositionRange> {
        let size = posInfos.dotsPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.dotsPos[i] + SyntaxNodeKind.DotToken.size
            ret[i] = CodePositionRange(posInfos.dotsPos[i], endPos)
        }
        ret
    }

    /**
     * @brief Gets the position ranges of prefixes in the import content.
     *
     * @return An array of CodePositionRange representing the positions of prefixes.
     */
    public func getPrefixesPos(): Array<CodePositionRange> {
        let size = posInfos.prefixesPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.prefixesPos[i] + prefixes[i].size
            ret[i] = CodePositionRange(posInfos.prefixesPos[i], endPos)
        }
        ret
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportContentPosInfos,
        prefixes_: Array<String>, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.prefixes_ = prefixes_
    }

    init(nodeImpl: SyntaxNodeImpl, prefixes: Array<String>, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportContent>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.prefixes_ = prefixes
        this.startPos = startPos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The prefixes of the import content.
     */
    public prop prefixes: Array<String> {
        get() {
            prefixes_
        }
    }
}

/**
 * @brief Represents position information for an import list.
 */
class ImportListPosInfos {
    let importKeyWordPos: CodePosition

    init(importKeyWordPos: CodePosition) {
        this.importKeyWordPos = importKeyWordPos
    }
}

class ImportListPropInfos {
    let contentsPropInfo: PropInfo
    let modifierPropInfo: Option<PropInfo>

    init(contentsPropInfo: PropInfo, modifierPropInfo: Option<PropInfo>) {
        this.contentsPropInfo = contentsPropInfo
        this.modifierPropInfo = modifierPropInfo
    }
}

/**
 * @brief Represents a list of imports, extending SyntaxTreeNode.
 */
public class ImportList <: SyntaxTreeNode {
    private let startPos: CodePosition
    private let kind_: ImportKind
    private let posInfos: ImportListPosInfos
    private let propInfos: ImportListPropInfos
    /**
     * @brief Gets the position range of the 'import' keyword in the import statement.
     *
     * @return A CodePositionRange representing the position range of the 'import' keyword.
     */
    public func getImportKeyWordPos(): CodePositionRange {
        let endPos = posInfos.importKeyWordPos + SyntaxNodeKind.ImportToken.size
        return CodePositionRange(posInfos.importKeyWordPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportListPosInfos,
        propInfos: ImportListPropInfos, kind_: ImportKind, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
        this.kind_ = kind_
    }

    /**
     * @brief Initialize node with imported content, import kind and modifier.
     */
    public init(contents: ImportContent, modifier: Option<Modifier>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createImportListImpl(contents, modifier, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportList>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.kind_ = redNode.kind
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Contents of the import.
     */
    public prop contents: ImportContent {
        get() {
            let propInfo = propInfos.contentsPropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<ImportContent>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
        }
    }
    /**
     * @brief Kind of import.
     */
    public prop kind: ImportKind {
        get() {
            kind_
        }
    }
    /**
     * @brief Modifier for the import.
     */
    public prop modifier: Option<Modifier> {
        get() {
            if (let Some(propInfo) <- propInfos.modifierPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                cast<Modifier>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                    .getOrThrow()
            } else {
                None
            }
        }
    }
}

/**
 * @brief Represents position information for a multi-import statement.
 */
class ImportMultiPosInfos {
    let lCurlPos: CodePosition
    let rCurlPos: CodePosition
    let commasPos: Array<CodePosition>

    init(lCurlPos: CodePosition, rCurlPos: CodePosition, commasPos: Array<CodePosition>) {
        this.lCurlPos = lCurlPos
        this.rCurlPos = rCurlPos
        this.commasPos = commasPos
    }
}

class ImportMultiPropInfos {
    let contentsPropInfo: PropInfo

    init(contentsPropInfo: PropInfo) {
        this.contentsPropInfo = contentsPropInfo
    }
}

/**
 * @brief Represents a multi-import statement, which extends from ImportContent.
 */
public class ImportMulti <: ImportContent {
    /**
     * @brief CodePosition information for the multi-import statement.
     */
    private let posInfos: ImportMultiPosInfos
    private let propInfos: ImportMultiPropInfos

    /**
     * @brief Gets the position range of the left Curl in the multi-import statement.
     *
     * @return A CodePositionRange representing the position range of the left Curl.
     */
    public func getLCurlPos(): CodePositionRange {
        let endPos = posInfos.lCurlPos + SyntaxNodeKind.LCurlToken.size
        return CodePositionRange(posInfos.lCurlPos, endPos)
    }

    /**
     * @brief Gets the position range of the right Curl in the multi-import statement.
     *
     * @return A CodePositionRange representing the position range of the right Curl.
     */
    public func getRCurlPos(): CodePositionRange {
        let endPos = posInfos.rCurlPos + SyntaxNodeKind.RCurlToken.size
        return CodePositionRange(posInfos.rCurlPos, endPos)
    }

    /**
     * @brief Gets the position ranges of the commas in the multi-import statement.
     *
     * @return An Array of CodePositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let size = posInfos.commasPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.commasPos[i] + SyntaxNodeKind.CommaToken.size
            ret[i] = CodePositionRange(posInfos.commasPos[i], endPos)
        }
        ret
    }

    /**
     * @brief Initializes a new instance of ImportMulti.
     *
     * @param prefixes The prefixes of the multi-import statement.
     * @param contents The list of import contents.
     */
    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportMultiPosInfos,
        propInfos: ImportMultiPropInfos, importContentPosInfos: ImportContentPosInfos, prefixes_: Array<String>,
        commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, importContentPosInfos, prefixes_, commentsPropInfo)
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with prefixes, package name and sub package import contents.
     */
    public init(prefixes: Array<String>, contents: Array<ImportContent>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createImportMultiImpl(prefixes, contents, comments: comments), prefixes)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportMulti>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief List of import contents.
     */
    public prop contents: Array<ImportContent> {
        get() {
            let importContents = ArrayList<ImportContent>()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.contentsPropInfo.offset,
                index: propInfos.contentsPropInfo.index)
            let kinds = [SyntaxNodeKind.ImportSingle, SyntaxNodeKind.ImportAll, SyntaxNodeKind.ImportAlias]
            while (let Some(kind) <- lp.look(kinds)) {
                if (let Some(node) <- lp.consume(kind: kind)) {
                    importContents.add(
                        cast<ImportContent>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.moveOffset(node)
                }
                lp.moveOffset(lp.lookAndConsume(SyntaxNodeKind.CommaToken))
            }
            importContents.toArray()
        }
    }
}

/**
 * @brief Represents position information for a single import identifier.
 */
class ImportSinglePosInfos {
    /**
     * @brief The position of the identifier in the import statement.
     */
    let identifierPos: CodePosition

    init(identifierPos: CodePosition) {
        this.identifierPos = identifierPos
    }
}

/**
 * @brief Represents a single import statement, which extends from ImportContent.
 */
public class ImportSingle <: ImportContent {
    private let posInfos: ImportSinglePosInfos
    private let identifier_: String
    /**
     * @brief Gets the position range of the identifier in the import statement.
     *
     * @return A CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + identifier.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ImportSinglePosInfos,
        importContentPosInfos: ImportContentPosInfos, identifier_: String, prefixes_: Array<String>,
        commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, importContentPosInfos, prefixes_, commentsPropInfo)
        this.posInfos = posInfos
        this.identifier_ = identifier_
    }

    /**
     * @brief Initialize node with prefixes, package name and alias name.
     */
    public init(prefixes: Array<String>, identifier: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createImportSingleImpl(prefixes, identifier, comments: comments), prefixes)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ImportSingle>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.identifier_ = identifier
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The identifier for the import.
     */
    public prop identifier: String {
        get() {
            identifier_
        }
    }
}

/**
 * @brief Class representing a package in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains information about a package,
 * including its name, whether it is a macro package, and its source files.
 */
public class Package <: SyntaxTreeNode {
    private let name_: String

    private let isMacroPkg_: Bool

    private let srcFileImpls: Array<(SyntaxNodeImpl, String)>

    init(isMacroPkg_: Bool, name_: String, srcFileImpls: Array<(SyntaxNodeImpl, String)>) {
        super(CodePositionRange(), NonTerminal(SyntaxNodeKind.Package), None)
        this.isMacroPkg_ = isMacroPkg_
        this.name_ = name_
        this.srcFileImpls = srcFileImpls
    }

    /**
     * @brief Initialize a new Package node.
     */
    public init(isMacroPkg: Bool, name: String, srcFile: Array<SourceFile>) {
        super(CodePositionRange(), Terminal(SyntaxNodeKind.Invalid), None)

        let (isMacro, pkgName) = checkPackage(ArrayList(srcFile))
        if (isMacro != isMacroPkg || pkgName != name) {
            throw Exception("InitException: the input params are illegal for Package Init.")
        }

        this.isMacroPkg_ = isMacroPkg
        this.name_ = name

        let fileImpls = ArrayList<(SyntaxNodeImpl, String)>()
        for (file in srcFile) {
            fileImpls.add((file.nodeImpl, file.path))
        }
        this.srcFileImpls = fileImpls.toArray()
    }

    /**
     * @brief Returns a string representation of the package.
     *
     * @return A string representation of the package, include the file name and file content.
     */
    public func toString(): String {
        var res: String = ""
        let srcFile_ = srcFile
        let size = srcFile_.size
        for (i in 0..size) {
            res += "// " + srcFile_[i].name + NEWLINE
            if (i < size - 1) {
                res += srcFile_[i].toString() + NEWLINE
            } else {
                res += srcFile_[i].toString()
            }
        }
        res
    }

    public func toTokens(): Tokens {
        var tks = Tokens()
        let srcFile_ = srcFile
        let size = srcFile_.size
        for (i in 0..size) {
            tks += Token(TokenKind.COMMENT, NEWLINE + "// " + srcFile_[i].name + NEWLINE)
            tks += srcFile_[i].toTokens()
        }
        tks
    }

    /**
     * @brief Indicates if the package is a macro package.
     *
     * This boolean field specifies whether the package is a macro package.
     */
    public prop isMacroPkg: Bool {
        get() {
            isMacroPkg_
        }
    }

    /**
     * @brief The name of the package.
     *
     * This string field holds the name of the package.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The source files of the package.
     *
     * This array field contains the source files associated with the package.
     */
    public prop srcFile: Array<SourceFile> {
        get() {
            let srcFile = ArrayList<SourceFile>()
            for ((impl, path) in srcFileImpls) {
                if (let Some(fileNode) <- SyntaxNodeImplTranslator.translateFile(impl, path, parent: this)) {
                    if (let Some(file) <- (fileNode as SourceFile)) {
                        srcFile.add(file)
                    }
                }
            }
            srcFile.toArray()
        }
    }
}

class PackageHeaderPropInfos {
    let accessModifierPropInfo: Option<PropInfo>

    init(accessModifierPropInfo: Option<PropInfo>) {
        this.accessModifierPropInfo = accessModifierPropInfo
    }
}

class PackageHeaderPosInfos {
    let macroKeyWordPos: Option<CodePosition>
    let packageKeyWordPos: CodePosition
    let pkgIdentifiersPos: Array<CodePosition>
    let dotsPos: Array<CodePosition>

    init(macroKeyWordPos: Option<CodePosition>, packageKeyWordPos: CodePosition, pkgIdentifiersPos: Array<CodePosition>,
        dotsPos: Array<CodePosition>) {
        this.macroKeyWordPos = macroKeyWordPos
        this.packageKeyWordPos = packageKeyWordPos
        this.pkgIdentifiersPos = pkgIdentifiersPos
        this.dotsPos = dotsPos
    }
}

/**
 * @brief Represents a package header, extending SyntaxTreeNode.
 */
public class PackageHeader <: SyntaxTreeNode {
    private let isMacroPkg_: Bool

    private let packageNameIdentifiers_: Array<String>

    private let startPos: CodePosition

    private let propInfos: PackageHeaderPropInfos

    private let posInfos: PackageHeaderPosInfos

    /**
     * @brief Returns array of position ranges for dot tokens in the package path
     *
     * @param none
     * @return Array of CodePositionRange objects for dot tokens
     *
     * @throws none
     */
    public func getDotsPos(): Array<CodePositionRange> {
        let size = posInfos.dotsPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.dotsPos[i] + SyntaxNodeKind.DotToken.size
            ret[i] = CodePositionRange(posInfos.dotsPos[i], endPos)
        }
        ret
    }

    /**
     * @brief Returns optional position range for macro keyword if present
     *
     * @param none
     * @return CodePositionRange if macro keyword exists, None otherwise
     *
     * @throws none
     */
    public func getMacroKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.macroKeyWordPos) {
            let endPos = v + SyntaxNodeKind.MacroToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Returns array of position ranges for each package identifier token
     *
     * @param none
     * @return Array of CodePositionRange objects for package name identifiers
     *
     * @throws none
     */
    public func getPackageIdentifiersPos(): Array<CodePositionRange> {
        let size = posInfos.pkgIdentifiersPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.pkgIdentifiersPos[i] + packageNameIdentifiers[i].size
            ret[i] = CodePositionRange(posInfos.pkgIdentifiersPos[i], endPos)
        }
        ret
    }

    /**
     * @brief Returns position range for package keyword token
     *
     * @param none
     * @return CodePositionRange for "package" keyword
     *
     * @throws none
     */
    public func getPackageKeyWordPos(): CodePositionRange {
        let endPos = posInfos.packageKeyWordPos + SyntaxNodeKind.PackageToken.size
        CodePositionRange(posInfos.packageKeyWordPos, endPos)
    }

    /**
     * @brief Returns fully qualified package name from identifier array
     *
     * @param none
     * @return Last element of packageNameIdentifiers as the main package name
     *
     * @throws none
     */
    public func getPackageName(): String {
        return packageNameIdentifiers[packageNameIdentifiers.size - 1]
    }

    /**
     * @brief Returns parent package name by joining all but last identifier
     *
     * @param none
     * @return Concatenated parent package name string
     *
     * @throws none
     */
    public func getParentPackageName(): String {
        return collectString<String>(delimiter: ".")(packageNameIdentifiers[..packageNameIdentifiers.size - 1])
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, isMacroPkg_: Bool,
        packageNameIdentifiers_: Array<String>, posInfos: PackageHeaderPosInfos, propInfos: PackageHeaderPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.isMacroPkg_ = isMacroPkg_
        this.packageNameIdentifiers_ = packageNameIdentifiers_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new PackageHeader node.
     */
    public init(accessModifier: Option<Modifier>, isMacroPkg: Bool, packageNameIdentifiers: Array<String>,
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createPackageHeaderImpl(accessModifier, isMacroPkg, packageNameIdentifiers,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<PackageHeader>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.isMacroPkg_ = isMacroPkg
        this.packageNameIdentifiers_ = packageNameIdentifiers
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Access modifier for the package.
     */
    public prop accessModifier: Option<Modifier> {
        get() {
            if (let Some(propInfo) <- propInfos.accessModifierPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Modifier>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief Flag for macro package.
     */
    public prop isMacroPkg: Bool {
        get() {
            isMacroPkg_
        }
    }

    /**
     * @brief Identifiers for the package header.
     */
    public prop packageNameIdentifiers: Array<String> {
        get() {
            packageNameIdentifiers_
        }
    }
}

class FeatureIdPosInfos {
    FeatureIdPosInfos(let ftrIdIdentifiersPos: Array<CodePosition>, let dotsPoses: Array<CodePosition>) {}
}

/**
 * @brief Represents a feature id and contains information about
 * feature identifiers and dots, extending SyntaxTreeNode.
 */
public class FeatureId <: SyntaxTreeNode {
    private let featureNameIdentifiers_: Array<String>
    private let posInfos: FeatureIdPosInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        featureNameIdentifiers: Array<String>, posInfos: FeatureIdPosInfos) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode)
        this.featureNameIdentifiers_ = featureNameIdentifiers
        this.posInfos = posInfos
    }

    /**
     * @brief Initialize a new FeatureId node.
     */
    public init(identifiers: Array<String>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createFeatureIdImpl(identifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let retNode = cast<FeatureId>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.featureNameIdentifiers_ = retNode.featureNameIdentifiers
        this.posInfos = retNode.posInfos
    }

    /**
     * @brief Gets the position range of identifiers in the feature id.
     *
     * @param none
     * @return An Array of CodePositionRange representing the position ranges of the identifiers.
     *
     * @throws none
     */
    public func getIdentifierPos(): Array<CodePositionRange> {
        let size = posInfos.ftrIdIdentifiersPos.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.ftrIdIdentifiersPos[i] + featureNameIdentifiers_[i].size
            ret[i] = CodePositionRange(posInfos.ftrIdIdentifiersPos[i], endPos)
        }
        ret
    }

    /**
     * @brief Gets the position range of the dots in the feature id.
     *
     * @param none
     * @return An Array of CodePositionRange representing the position ranges of the dots.
     *
     * @throws none
     */
    public func getDotPoses(): Array<CodePositionRange> {
        let size = posInfos.dotsPoses.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.dotsPoses[i] + SyntaxNodeKind.DotToken.size
            ret[i] = CodePositionRange(posInfos.dotsPoses[i], endPos)
        }
        ret
    }

    /**
     * @brief Gets the value of identifiers in the feature id.
     */
    public prop featureNameIdentifiers: Array<String> {
        get() {
            return featureNameIdentifiers_
        }
    }
}

class FeaturesSetPosInfos {
    FeaturesSetPosInfos(let lCurlPos: CodePosition,
        let rCurlPos: CodePosition, let commaPoses: Array<CodePosition>) {}
}

class FeaturesSetPropInfos {
    FeaturesSetPropInfos(let contentPropInfos: Array<PropInfo>) {}
}

/**
 * @brief Represents a features set and contains information about
 * used features, extending SyntaxTreeNode.
 */
public class FeaturesSet <: SyntaxTreeNode {
    private let startPos: CodePosition
    private let posInfos: FeaturesSetPosInfos
    private let propInfos: FeaturesSetPropInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: FeaturesSetPosInfos, propInfos: FeaturesSetPropInfos) {
            super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode)
            this.startPos = startPos
            this.posInfos = posInfos
            this.propInfos = propInfos
        }
    
    /**
     * @brief Initialize a new FeaturesSet node.
     */
    public init(features: Array<FeatureId>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createFeaturesSetImpl(features, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let retNode = cast<FeaturesSet>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.posInfos = retNode.posInfos
        this.propInfos = retNode.propInfos
    }

    /**
     * @brief Gets the position ranges of the '{' in the features set.
     *
     * @param none
     * @return A CodePositionRange representing the position ranges of the '{'.
     *
     * @throws none
     */
    public func getLCurlPos(): CodePositionRange {
        let endPos = posInfos.lCurlPos + SyntaxNodeKind.LCurlToken.size
        return CodePositionRange(posInfos.lCurlPos, endPos)
    }

    /**
     * @brief Gets the position ranges of the '}' in the features set.
     *
     * @param none
     * @return A CodePositionRange representing the position ranges of the '}'.
     *
     * @throws none
     */
    public func getRCurlPos(): CodePositionRange {
        let endPos = posInfos.rCurlPos + SyntaxNodeKind.RCurlToken.size
        return CodePositionRange(posInfos.rCurlPos, endPos)
    }

    /**
     * @brief Gets the position ranges of the commas in the features set.
     *
     * @param none
     * @return An Array of CodePositionRange representing the position ranges of the commas.
     *
     * @throws none
     */
    public func getCommaPoses(): Array<CodePositionRange> {
        let size = posInfos.commaPoses.size
        let ret = Array<CodePositionRange>(size, repeat: CodePositionRange())
        for (i in 0..size) {
            let endPos = posInfos.commaPoses[i] + SyntaxNodeKind.CommaToken.size
            ret[i] = CodePositionRange(posInfos.commaPoses[i], endPos)
        }
        ret
    }

    /**
     * @brief Gets the content of the features set.
     */
    public prop content: Array<FeatureId> {
        get() {
            let ret = ArrayList<FeatureId>()
            for (propInfo in propInfos.contentPropInfos) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                ret.add(
                    cast<FeatureId>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                        .getOrThrow()
                )
            }
            return ret.toArray()
        }
    }

}

class FeaturesDirectivePosInfos {
    FeaturesDirectivePosInfos(let featuresKeywordPos: CodePosition) {}
}

class FeaturesDirectivePropInfos {
    FeaturesDirectivePropInfos(let featuresSetPropInfo: PropInfo) {}
}

/**
 * @brief Represents a features directive and contains information
 * about declared features in the source file, extending SyntaxTreeNode.
 */
public class FeaturesDirective <: SyntaxTreeNode {
    private let startPos: CodePosition
    private let posInfos: FeaturesDirectivePosInfos
    private let propInfos: FeaturesDirectivePropInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: FeaturesDirectivePosInfos, propInfos: FeaturesDirectivePropInfos) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new FeaturesDirective node.
     */
    public init(annotations: Array<Annotation>, set: FeaturesSet, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createFeaturesDirectiveImpl(annotations, set, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let retNode = cast<FeaturesDirective>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.posInfos = retNode.posInfos
        this.propInfos = retNode.propInfos
    }

    /**
     * @brief Gets the position range of the 'features' keyword in the features directive.
     *
     * @param none
     * @return A CodePositionRange representing the position range of the 'features' keyword.
     *
     * @throws none
     */
    public func getFeaturesKeywordPos(): CodePositionRange {
        let endPos = posInfos.featuresKeywordPos + SyntaxNodeKind.FeaturesToken.size
        return CodePositionRange(posInfos.featuresKeywordPos, endPos)
    }

    /**
     * @brief Gets an array of annotations in the features directive.
     */
    public prop annotations: Array<Annotation> {
        get() {
            var annos = Array<Annotation>()
            if (let Some(node) <- (nodeImpl as NonTerminal)) {
                var offset = Offset()
                let lp = LocalParser(node.children, offset)
                if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
                    annos = SyntaxNodeImplTranslator.translateList<Annotation>(v,
                        CodePosition(nodePos.beginLine, nodePos.beginColumn, FileInfos(nodePos.fileName, nodePos.filePath)) +
                            lp.offset, this)
                }
            }
            return annos
        }
    }

    /**
     * @brief Gets the features set with information about declared features in the features directive.
     */
    public prop featuresSet: FeaturesSet {
        get() {
            let propInfo = propInfos.featuresSetPropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            let ftrSet = cast<FeaturesSet>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
            
            return ftrSet
        }
    }
}
