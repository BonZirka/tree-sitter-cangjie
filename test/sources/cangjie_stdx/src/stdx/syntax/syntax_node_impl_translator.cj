/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.{ArrayList, collectArray, map}
import std.convert

@When[!debug]
private func fail(info: String) {
}

@When[debug]
private func fail(info: String) {
    throw Exception("ParseException: " + info)
}

class SyntaxNodeImplTranslator {
    private init() {
    }

    static func translate(root: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): ?SyntaxTreeNode {
        match (root.kind) {
            case SyntaxNodeKind.File => SyntaxNodeImplTranslator().transFileNode(root, startPos.filePath, parent: parent)
            case _ => SyntaxNodeImplTranslator().transNode(root, startPos, parent)
        }
    }

    static func translateList<T>(root: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): Array<T> where T <: SyntaxTreeNode {
        SyntaxNodeImplTranslator().transList<T>(root, startPos, parent)
    }

    static func translateFile(root: SyntaxNodeImpl, filePath: String, parent!: ?SyntaxTreeNode = None): ?SyntaxTreeNode {
        SyntaxNodeImplTranslator().transFileNode(root, filePath, parent: parent)
    }

    private func addList<T>(nodes: ArrayList<T>, node: ?SyntaxTreeNode) where T <: SyntaxTreeNode {
        if (let Some(value) <- node) {
            if (let Some(target) <- (value as T)) {
                nodes.add(target)
            } else {
                fail("type cast fail")
            }
        } else {
            fail("the node is None!")
        }
    }

    // General conversion function between the two types
    private func cast<T, S>(node: ?S): ?T {
        if (let Some(value) <- node) {
            value as T
        } else {
            None
        }
    }

    private func isForeignModifier(node: SyntaxNodeImpl): Bool {
        let modi = (node as NonTerminal).getOrThrow()
        for (child in modi.children) {
            if (child.kind == SyntaxNodeKind.ForeignToken) {
                return true
            }
        }
        false
    }

    private func transList<T>(node: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): Array<T> where T <: SyntaxTreeNode {
        var result = ArrayList<T>()
        match (node) {
            case nt: NonTerminal =>
                var beginPos = startPos
                for (child in nt.children) {
                    if (child.kind == SyntaxNodeKind.Modifier && isForeignModifier(child)) {
                        continue
                    }
                    match (child.kind) {
                        case SyntaxNodeKind.NewlineToken | SyntaxNodeKind.SpaceToken => beginPos += child.offset
                        case _ =>
                            addList<T>(result, transNode(child, beginPos, parent))
                            beginPos += child.offset
                    }
                }
            case _ => fail("not support terminal for transList")
        }
        result.toArray()
    }

    private func transFileNode(node: SyntaxNodeImpl, filePath: String, parent!: ?SyntaxTreeNode = None): ?SyntaxTreeNode {
        let ret: ?SyntaxTreeNode = match (node) {
            case nt: NonTerminal => transFile(nt, filePath, parent: parent)
            case _ => None
        }
        ret
    }

    private func getBeginPos(node: SyntaxNodeImpl, startPos: CodePosition): CodePosition {
        let lp = LocalParser(node.preWhiteSpace)
        lp.consumeWhitespace()
        return startPos + lp.offset
    }

    // Recursive translation
    private func transNode(node: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): ?SyntaxTreeNode {
        let beginPos = getBeginPos(node, startPos)
        let ret: ?SyntaxTreeNode = match (node) {
            case nt: NonTerminal => transNonTerminal(nt, beginPos, parent)
            case _ =>
                fail("terminal node kind - ${node.kind.toString()} - ${node.toString()} need to be translated");
                None
        }
        ret
    }

    func transNonTerminal(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ?SyntaxTreeNode {
        match (node.kind) {
            case SyntaxNodeKind.GenericParam => transGenericParam(node, startPos, parent)
            case SyntaxNodeKind.PrimitiveType => transAtomicType(node, startPos, parent)
            case SyntaxNodeKind.ValuedLiteral => transValuedLitConstExpr(node, startPos, parent)
            case SyntaxNodeKind.Modifier => transModifier(node, startPos, parent)
            case SyntaxNodeKind.Comment => transComment(node, startPos, parent)
            case SyntaxNodeKind.CommentGroup => transCommentGroup(node, startPos, parent)
            case SyntaxNodeKind.Argument => transArgument(node, startPos, parent)
            case SyntaxNodeKind.Annotation => transAnnotation(node, startPos, parent)
            case SyntaxNodeKind.CatchPattern => transCatchPattern(node, startPos, parent)
            case SyntaxNodeKind.PackageSpec => transPackageHeader(node, startPos, parent)
            case SyntaxNodeKind.GenericConstraints => transGenericConstraints(node, startPos, parent)
            case SyntaxNodeKind.GenericConstraint => transGenericConstraint(node, startPos, parent)
            case SyntaxNodeKind.DisjunctionCondition => transDisjunctionCondition(node, startPos, parent)
            case SyntaxNodeKind.ConjunctionCondition => transConjunctionCondition(node, startPos, parent)
            case SyntaxNodeKind.ParenCondition => transParenCondition(node, startPos, parent)
            case SyntaxNodeKind.LetPattern => transLetPattern(node, startPos, parent)
            case SyntaxNodeKind.FuncDecl => transFuncDecl(node, startPos, parent)
            case SyntaxNodeKind.VarDecl => transVarDecl(node, startPos, parent)
            case SyntaxNodeKind.MainDecl => transMainDecl(node, startPos, parent)
            case SyntaxNodeKind.TypeAlias => transTypeAlias(node, startPos, parent)
            case SyntaxNodeKind.Body => transBody(node, startPos, parent)
            case SyntaxNodeKind.ClassDecl => transClassDecl(node, startPos, parent)
            case SyntaxNodeKind.PropDecl => transPropDecl(node, startPos, parent)
            case SyntaxNodeKind.PropGetterOrSetter => transPropGetterOrSetter(node, startPos, parent)
            case SyntaxNodeKind.StaticInit => transStaticInit(node, startPos, parent)
            case SyntaxNodeKind.StructDecl => transStructDecl(node, startPos, parent)
            case SyntaxNodeKind.InterfaceDecl => transInterfaceDecl(node, startPos, parent)
            case SyntaxNodeKind.ExtendDecl => transExtendDecl(node, startPos, parent)
            case SyntaxNodeKind.EnumDecl => transEnumDecl(node, startPos, parent)
            case SyntaxNodeKind.EnumConstructor => transEnumConstructor(node, startPos, parent)
            case SyntaxNodeKind.MacroDecl => transMacroDecl(node, startPos, parent)
            case SyntaxNodeKind.MacroExpandDecl => transMacroExpandDecl(node, startPos, parent)
            case SyntaxNodeKind.MacroExpandParam => transMacroExpandParam(node, startPos, parent)
            case SyntaxNodeKind.MacroExpandExpr => transMacroExpandExpr(node, startPos, parent)
            case SyntaxNodeKind.Block => transBlock(node, startPos, parent)
            case SyntaxNodeKind.FuncParam => transFuncParam(node, startPos, parent)
            case SyntaxNodeKind.LambdaParam => transLambdaParam(node, startPos, parent)
            case SyntaxNodeKind.ParameterList => transParameterList(node, startPos, parent)
            case SyntaxNodeKind.ImportSpec => transImportList(node, startPos, parent)
            case SyntaxNodeKind.LineStringLiteral | SyntaxNodeKind.MultiLineStringLiteral
                | SyntaxNodeKind.MultiLineRawStringLiteral => transStringLitConstExpr(node, startPos, parent)
            case SyntaxNodeKind.RuneLiteral => transLitConstRuneExpr(node, startPos, parent)
            case SyntaxNodeKind.UnitLiteral => transUnitLitConstExpr(node, startPos, parent)
            case SyntaxNodeKind.InterpolationExpr => transInterpolationExpr(node, startPos, parent)
            case SyntaxNodeKind.BinaryExpr => transBinaryExpr(node, startPos, parent)
            case SyntaxNodeKind.IsExpr => transIsExpr(node, startPos, parent)
            case SyntaxNodeKind.AsExpr => transAsExpr(node, startPos, parent)
            case SyntaxNodeKind.ParenExpr => transParenExpr(node, startPos, parent)
            case SyntaxNodeKind.ReturnExpr => transReturnExpr(node, startPos, parent)
            case SyntaxNodeKind.IncOrDecExpr => transIncOrDecExpr(node, startPos, parent)
            case SyntaxNodeKind.RangeExpr => transRangeExpr(node, startPos, parent)
            case SyntaxNodeKind.BreakExpr => transBreakExpr(node, startPos, parent)
            case SyntaxNodeKind.ContinueExpr => transContinueExpr(node, startPos, parent)
            case SyntaxNodeKind.MemberAccess => transMemberAccess(node, startPos, parent)
            case SyntaxNodeKind.SubscriptExpr => transSubscriptExpr(node, startPos, parent)
            case SyntaxNodeKind.Lambda => transLambda(node, startPos, parent)
            case SyntaxNodeKind.ThrowExpr => transThrowExpr(node, startPos, parent)
            case SyntaxNodeKind.SynchronizedExpr => transSynchronizedExpr(node, startPos, parent)
            case SyntaxNodeKind.SpawnExpr => transSpawnExpr(node, startPos, parent)
            case SyntaxNodeKind.IfExpr => transIfExpr(node, startPos, parent)
            case SyntaxNodeKind.WhileExpr => transWhileExpr(node, startPos, parent)
            case SyntaxNodeKind.DoWhileExpr => transDoWhileExpr(node, startPos, parent)
            case SyntaxNodeKind.ForInExpr => transForInExpr(node, startPos, parent)
            case SyntaxNodeKind.TryExpr => transTryCatch(node, startPos, parent)
            case SyntaxNodeKind.QuoteExpr => transQuoteExpr(node, startPos, parent)
            case SyntaxNodeKind.QuoteTokenExpr => transQuoteTokenExpr(node, startPos, parent)
            case SyntaxNodeKind.QuoteInterpolationExpr => transQuoteInterpolationExpr(node, startPos, parent)
            case SyntaxNodeKind.TrailingClosureExpr => transTrailingClosureExpr(node, startPos, parent)
            case SyntaxNodeKind.UnsafeExpr => transUnsafeExpr(node, startPos, parent)
            // MatchExpr
            case SyntaxNodeKind.MatchExpr => transMatchExpr(node, startPos, parent)
            case SyntaxNodeKind.MatchCase => transMatchCase(node, startPos, parent)
            case SyntaxNodeKind.ConstPattern => transConstPattern(node, startPos, parent)
            case SyntaxNodeKind.WildcardPattern => transWildcardPattern(node, startPos, parent)
            case SyntaxNodeKind.VarBindingPattern => transVarBindingPattern(node, startPos, parent)
            case SyntaxNodeKind.VarOrEnumPattern => transVarOrEnumPattern(node, startPos, parent)
            case SyntaxNodeKind.TypePattern => transTypePattern(node, startPos, parent)
            case SyntaxNodeKind.EnumPattern => transEnumPattern(node, startPos, parent)
            case SyntaxNodeKind.TuplePattern => transTuplePattern(node, startPos, parent)

            case SyntaxNodeKind.TupleType => transTupleType(node, startPos, parent)
            case SyntaxNodeKind.FuncType => transFuncType(node, startPos, parent)
            case SyntaxNodeKind.VArrayType => transVArrayType(node, startPos, parent)
            case SyntaxNodeKind.ParenType => transParenType(node, startPos, parent)
            case SyntaxNodeKind.CompositeType | SyntaxNodeKind.QualifiedType | SyntaxNodeKind.RefType => transCompositeType(
                node, startPos, parent)
            case SyntaxNodeKind.OptionType => transPrefixType(node, startPos, parent)
            case SyntaxNodeKind.UnaryExpr => transUnaryExpr(node, startPos, parent)
            case SyntaxNodeKind.AssignExpr => transAssignExpr(node, startPos, parent)
            case SyntaxNodeKind.ArrayLiteral => transArrayLiteralExpr(node, startPos, parent)
            case SyntaxNodeKind.TupleLiteral => transTupleLiteralExpr(node, startPos, parent)
            case SyntaxNodeKind.RefExpr => transSymbolRef(node, startPos, parent)
            case SyntaxNodeKind.CallExpr => transCallExpr(node, startPos, parent)
            case SyntaxNodeKind.TypeConvExpr => transTypeConvExpr(node, startPos, parent)
            case SyntaxNodeKind.OptionalExpr => transOptionalExpr(node, startPos, parent)
            case SyntaxNodeKind.VArrayExpr => transVArrayExpr(node, startPos, parent)
            case SyntaxNodeKind.ImportAlias => transImportAlias(node, startPos, parent)
            case SyntaxNodeKind.ImportAll => transImportAll(node, startPos, parent)
            case SyntaxNodeKind.ImportMulti => transImportMulti(node, startPos, parent)
            case SyntaxNodeKind.ImportSingle => transImportSingle(node, startPos, parent)
            case SyntaxNodeKind.FeaturesDirective => transFeaturesDirective(node, startPos, parent)
            case SyntaxNodeKind.FeaturesSet => transFeaturesSet(node, startPos, parent)
            case SyntaxNodeKind.FeatureId => transFeatureId(node, startPos, parent)
            case _ =>
                fail("nonterminal node kind - ${node.kind.toString()} - ${node.toString()} need to be translated");
                None
        }
    }

    private func transFile(node: NonTerminal, filePath: String, parent!: ?SyntaxTreeNode = None): SourceFile {
        // BNF: (featuresDirective)? (packageSpec)? (importSpec)? decls*
        var filePathArray = filePath.split(SEPARATOR)
        var fileName = filePathArray[filePathArray.size - 1]
        let fileInfo = FileInfos(fileName, filePath)
        let beginLine: Int32 = 1
        let beginColumn: Int32 = 1
        let beginPos = CodePosition(beginLine, beginColumn, fileInfo)
        let lp = LocalParser(node.children)

        var ftrDirectivePropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.FeaturesDirective)) {
            ftrDirectivePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        var pkgHeaderPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.PackageSpec)) {
            pkgHeaderPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        let importListsPropInfo = ArrayList<PropInfo>()
        while (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ImportSpec)) {
            importListsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(v)
        }
        let predictDecl = {
            kind: SyntaxNodeKind => kind.isDecl()
        }
        let declsPropInfo = ArrayList<PropInfo>()
        while (lp.look(predictDecl)) {
            let declNode = lp.consume()
            declsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(declNode)
        }
        let propInfos = SourceFilePropInfos(importListsPropInfo.toArray(), pkgHeaderPropInfo, declsPropInfo.toArray(),
            ftrDirectivePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        SourceFile(node, beginPos, parent, fileName, filePath, propInfos, commentsPropInfos)
    }

    private func transCommentGroup(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): CommentGroup {
        let lp = LocalParser(node.children)

        let commentsPropInfo = ArrayList<PropInfo>()
        while (lp.look(SyntaxNodeKind.Comment)) {
            let cmtNode = lp.consume()
            commentsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(cmtNode)
        }
        let propInfos = CommentGroupPropInfos(commentsPropInfo.toArray())
        CommentGroup(node, startPos, parent, propInfos)
    }

    private func transComment(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Comment {
        let lp = LocalParser(node.children)

        var kind = CommentKind.Line
        var content = ""
        let tokenNode = lp.consume()
        if (let Some(tkNode) <- tokenNode && let Some(tk) <- (tkNode as TokenTerminal)) {
            content = tk.value
        }
        if (content.startsWith("/**") && content != "/**/") {
            kind = CommentKind.Document
        } else if (content.startsWith("/*")) {
            kind = CommentKind.Block
        }
        Comment(node, startPos, parent, kind, content)
    }

    private func transFeaturesDirective(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FeaturesDirective {
        // BNF: annotationList? FEATURES NL* featuresSet end+
        var featuresKeywordPos = CodePosition()
        var ftrSetPropInfo = PropInfo()
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(keyNode) <- lp.consume(kind: SyntaxNodeKind.FeaturesToken)) {
            featuresKeywordPos = startPos + lp.offset
            lp.moveOffset(keyNode)
        }
        if (let Some(ftrSetNode) <- lp.consume(kind: SyntaxNodeKind.FeaturesSet)) {
            ftrSetPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(ftrSetNode)
        }
        let ftrDIrectivePosInfos = FeaturesDirectivePosInfos(featuresKeywordPos)
        let ftrDirectivePropInfos = FeaturesDirectivePropInfos(ftrSetPropInfo)
        FeaturesDirective(node, startPos, parent, ftrDIrectivePosInfos, ftrDirectivePropInfos)
    }

    private func transFeaturesSet(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FeaturesSet {
        // BNF: LCURL NL* featureId NL* (COMMA NL* featureId NL*)* RCURL
        var lCurlPos = CodePosition()
        var rCurlPos = CodePosition()
        let commaPoses = ArrayList<CodePosition>()
        let contentPropInfos = ArrayList<PropInfo>()
        let lp = LocalParser(node.children)
        if (let Some(lCurlNode) <- lp.lookAndConsume(SyntaxNodeKind.LCurlToken)) {
            lCurlPos = startPos + lp.offset
            lp.moveOffset(lCurlNode)
        }
        while (lp.look(SyntaxNodeKind.FeatureId)) {
            let node = lp.consume()
            if (let Some(ftrIdNode) <- node) {
                contentPropInfos.add(PropInfo(lp.cur - 1, lp.offset))
                lp.moveOffset(ftrIdNode)
            }
            if (let Some(commaNode) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                commaPoses.add(startPos + lp.offset)
                lp.moveOffset(commaNode)
            }
        }
        if (let Some(rCurlNode) <- lp.lookAndConsume(SyntaxNodeKind.RCurlToken)) {
            rCurlPos = startPos + lp.offset
            lp.moveOffset(rCurlNode)
        }
        let ftrSetPosInfos = FeaturesSetPosInfos(lCurlPos, rCurlPos, commaPoses.toArray())
        let ftrSetPropInfos = FeaturesSetPropInfos(contentPropInfos.toArray())
        FeaturesSet(node, startPos, parent, ftrSetPosInfos, ftrSetPropInfos)
    }

    private func transFeatureId(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FeatureId {
        // BNF: Identifier (DOT Identifier)*
        let identValues = ArrayList<String>()
        let identifierPos = ArrayList<CodePosition>()
        let dotPoses = ArrayList<CodePosition>()
        let lp = LocalParser((node as NonTerminal).getOrThrow().children)
        while (true) {
            let ident = lp.consume()
            if (let Some(node) <- ident) {
                identValues.add(getValue(node))
                identifierPos.add(startPos + lp.offset)
                lp.moveOffset(node)
            }
            if (let Some(node) <- lp.lookAndConsume(SyntaxNodeKind.DotToken)) {
                dotPoses.add(startPos + lp.offset)
                lp.moveOffset(node)
            } else {
                break
            }
        }
        let ftrIdPosInfos = FeatureIdPosInfos(identifierPos.toArray(), dotPoses.toArray())
        return FeatureId(node, startPos, parent, identValues.toArray(), ftrIdPosInfos)
    }

    private func transPackageHeader(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): PackageHeader {
        // BNF: packageModifier? (MACRO)? PACKAGE fullPackageName
        let lp = LocalParser(node.children)

        var modifierPropInfo: ?PropInfo = None
        if (lp.look(SyntaxNodeKind.Modifier)) {
            let modifierNode = lp.consume()
            modifierPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(modifierNode?.offset)
        }
        var macroKeyWordPos: ?CodePosition = None
        var isMacroPkg: Bool = false
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.MacroToken)) {
            isMacroPkg = true
            macroKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let packageNode = lp.consume(kind: SyntaxNodeKind.PackageToken)
        let packageKeyWordPos = startPos + lp.offset
        lp.offset.move(packageNode?.offset)

        var packageNameIdentifiers = ArrayList<String>()
        var pkgIdentifiersPos = ArrayList<CodePosition>()
        var dotsPos = ArrayList<CodePosition>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.PackagePrefixes)) {
            (packageNameIdentifiers, pkgIdentifiersPos, dotsPos) = transPackageName(v, startPos + lp.offset)
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            packageNameIdentifiers.add(getValue(v))
            pkgIdentifiersPos.add(startPos + lp.offset)
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.PackageIdentifierToken)) {
            packageNameIdentifiers.add(getValue(v))
            pkgIdentifiersPos.add(startPos + lp.offset)
            lp.offset.move(v.offset)
        }
        let propInfos = PackageHeaderPropInfos(modifierPropInfo)
        let posInfo = PackageHeaderPosInfos(macroKeyWordPos, packageKeyWordPos, pkgIdentifiersPos.toArray(),
            dotsPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        PackageHeader(node, startPos, parent, isMacroPkg, packageNameIdentifiers.toArray(), posInfo, propInfos,
            commentsPropInfos)
    }

    private func transPackageName(node: SyntaxNodeImpl, startPos: CodePosition) {
        // BNF: (IDENT .)*
        let result = ArrayList<String>()
        let identifierPos = ArrayList<CodePosition>()
        let dotsPos = ArrayList<CodePosition>()
        let lp = LocalParser((node as NonTerminal).getOrThrow().children)
        while (!lp.isEnd()) {
            let ident = lp.consume()
            if (let Some(v) <- ident) {
                result.add(getValue(v))
                identifierPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
            let dotNode = lp.consume(kind: SyntaxNodeKind.DotToken)
            dotsPos.add(startPos + lp.offset)
            lp.offset.move(dotNode?.offset)
        }
        (result, identifierPos, dotsPos)
    }

    private func transAnnotation(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Annotation {
        // BNF: AT identifier (LSQUARE Argument (COMMA Argument)* RSQUARE)?
        let lp = LocalParser(node.children)

        var opKind = AtOpKind.At
        var atOpPos = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AtToken)) {
            opKind = AtOpKind.At
            atOpPos = startPos + lp.offset
            lp.offset.move(v.offset)
        } else if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AtExclToken)) {
            opKind = AtOpKind.AtExcl
            atOpPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        var identifier: String = ""
        var identifierPos = CodePosition()
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            identifier = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        var argumentPropInfos = ArrayList<PropInfo>()

        var lSquarePos: ?CodePosition = None
        var rSquarePos: ?CodePosition = None
        let commasPos = ArrayList<CodePosition>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LSquareToken)) {
            lSquarePos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        while (!lSquarePos.isNone() && !lp.look(SyntaxNodeKind.RSquareToken)) {
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Argument)) {
                argumentPropInfos.add(PropInfo(lp.cur - 1, lp.offset))
                lp.offset.move(v.offset)
                if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                    commasPos.add(startPos + lp.offset)
                    lp.offset.move(v.offset)
                }
            } else {
                // note: attr not designed
                lp.offset.move(lp.consume().getOrThrow().offset)
            }
        }
        if (lSquarePos.isSome()) {
            rSquarePos = startPos + lp.offset
        }

        let propInfo = AnnotationPropInfos(argumentPropInfos.toArray())
        let posInfo = AnnotationPosInfos(atOpPos, lSquarePos, rSquarePos, identifierPos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Annotation(node, startPos, parent, identifier, opKind, posInfo, propInfo, commentsPropInfos)
    }

    private func transArgument(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Argument {
        // BNF: identifier NL* COLON NL* expression
        // | expression
        // | INOUT (expression DOT)? identifier
        let lp = LocalParser(node.children)
        var identifier: ?String = None
        var isInOut: Bool = false
        var isNamed: Bool = false
        var valuePropInfo = PropInfo()
        var inoutKeyWordPos: ?CodePosition = None
        var identifierPos: ?CodePosition = None
        var colonPos: ?CodePosition = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            isNamed = true
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
            identifier = getValue(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            colonPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.InoutToken)) {
            isInOut = true
            inoutKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            let exprNode = lp.consume()
            valuePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(exprNode?.offset)
        }

        let propInfos = ArgumentPropInfos(valuePropInfo)
        let posInfo = ArgumentPosInfos(inoutKeyWordPos, identifierPos, colonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Argument(node, startPos, parent, identifier, isInOut, isNamed, posInfo, propInfos, commentsPropInfos)
    }

    private func transModifier(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Modifier {
        let lp = LocalParser(node.children)
        let kindNode = (lp.consume().getOrThrow() as Terminal).getOrThrow()
        let kind = match (kindNode.kind) {
            case SyntaxNodeKind.AbstractToken => ModifierKind.Abstract
            case SyntaxNodeKind.InternalToken => ModifierKind.Internal
            case SyntaxNodeKind.MutToken => ModifierKind.Mut
            case SyntaxNodeKind.OpenToken => ModifierKind.Open
            case SyntaxNodeKind.OperatorToken => ModifierKind.Operator
            case SyntaxNodeKind.OverrideToken => ModifierKind.Override
            case SyntaxNodeKind.PrivateToken => ModifierKind.Private
            case SyntaxNodeKind.ProtectedToken => ModifierKind.Protected
            case SyntaxNodeKind.PublicToken => ModifierKind.Public
            case SyntaxNodeKind.RedefToken => ModifierKind.Redef
            case SyntaxNodeKind.SealedToken => ModifierKind.Sealed
            case SyntaxNodeKind.StaticToken => ModifierKind.Static
            case SyntaxNodeKind.UnsafeToken => ModifierKind.Unsafe
            case SyntaxNodeKind.ConstToken => ModifierKind.Const
            case _ => throw Exception("ParseException: This SyntaxNode kind is not modifier.")
        }
        lp.moveOffset(kindNode)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Modifier(node, startPos, parent, kind, commentsPropInfos)
    }

    private func transBlock(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Block {
        // BNF: LCurl (expressionOrDeclarations)* RCurl
        let lp = LocalParser(node.children)

        let lCurlNode = lp.consume(kind: SyntaxNodeKind.LCurlToken)
        let lCurlPos = startPos + lp.offset
        lp.offset.move(lCurlNode?.offset)

        var nodesPropInfo: ?PropInfo = None
        var foundNodes = false
        while (!lp.look(SyntaxNodeKind.RCurlToken)) {
            let curNode = lp.consume()
            if (!foundNodes) {
                nodesPropInfo = PropInfo(lp.cur - 1, lp.offset)
                foundNodes = true
            }
            lp.offset.move(curNode?.offset)
        }

        let rCurlNode = lp.consume(kind: SyntaxNodeKind.RCurlToken)
        let rCurlPos = startPos + lp.offset
        lp.offset.move(rCurlNode?.offset)

        let propInfos = BlockPropInfos(nodesPropInfo)
        let posInfos = BlockPosInfos(lCurlPos, rCurlPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Block(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transLambdaParam(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LambdaParam {
        // BNF: identifier (COLON type)?
        let lp = LocalParser(node.children)

        var identifierPos: CodePosition = CodePosition()
        var name = ""
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        var colonPos: ?CodePosition = None
        var typeAnnotationPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            colonPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let tyAnnoNode = lp.consume()
            typeAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
        }

        let propInfo = LambdaParamPropInfos(typeAnnotationPropInfo)
        let posInfo = LambdaParamPosInfos(identifierPos, colonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LambdaParam(node, startPos, parent, name, posInfo, propInfo, commentsPropInfos)
    }

    private func transFuncParam(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FuncParam {
        // BNF: (anno)* (modifier)* identifier Not? COLON type (ASSIGN expr)
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        var kind: ?VarKind = None
        var varKindKeyWordPos: ?CodePosition = None
        if (let Some(v) <- lp.look([SyntaxNodeKind.VarToken, SyntaxNodeKind.LetToken])) {
            if (let Some(node) <- lp.consume(kind: v)) {
                kind = transVarKind(node)
                varKindKeyWordPos = startPos + lp.offset
                lp.offset.move(node.offset)
            }
        }

        var identifierPos: CodePosition = CodePosition()
        var name = ""
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        var notPos: ?CodePosition = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.NotToken)) {
            notPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let colonNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
        let colonPos = startPos + lp.offset
        lp.offset.move(colonNode?.offset)

        let typeAnnoNode = lp.consume()
        let tyAnnoPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(typeAnnoNode?.offset)

        var assignPos: ?CodePosition = None
        var defaultValuePropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AssignToken)) {
            assignPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let valueNode = lp.consume()
            defaultValuePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(valueNode?.offset)
        }

        let propInfo = FuncParamPropInfos(defaultValuePropInfo, tyAnnoPropInfo)
        let posInfo = FuncParamPosInfos(varKindKeyWordPos, identifierPos, colonPos, assignPos, notPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        FuncParam(node, startPos, parent, kind, name, posInfo, propInfo, commentsPropInfos)
    }

    private func transParameterList(node: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): ParameterList {
        // BNF :LPAREN？ FuncParam (Comma FuncParam)* RPAREN？
        // BNF :LPAREN？ RPAREN？
        let lp = LocalParser(((node as NonTerminal).getOrThrow()).children)
        var lParenPos: ?CodePosition = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let paramsPropInfo = ArrayList<PropInfo>()
        let commasPos = ArrayList<CodePosition>()
        while (!lp.look([SyntaxNodeKind.FuncParam, SyntaxNodeKind.MacroExpandParam, SyntaxNodeKind.LambdaParam])
                .isNone()) {
            let paramNode = lp.consume()
            paramsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.offset.move(paramNode?.offset)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                commasPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }
        var rParenPos: ?CodePosition = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let propInfo = ParameterListPropInfos(paramsPropInfo.toArray())
        let posInfo = ParameterListPosInfos(lParenPos, commasPos.toArray(), rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ParameterList(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transImportAll(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ImportAll {
        // BNF: (packageNameIdentifier NL* DOT NL*)+ MUL
        let lp = LocalParser(node.children)
        let (idents, identPos, dotsPos) = lp.consumeListOfPos(startPos, kind: SyntaxNodeKind.IdentToken,
            sep: SyntaxNodeKind.DotToken)
        lp.consume()
        let prefixes = idents |> map({ident: SyntaxNodeImpl => getValue(ident)}) |> collectArray<String>
        let mulPos = startPos + lp.offset
        let posInfo = ImportAllPosInfos(mulPos)
        let posInfo1 = ImportContentPosInfos(dotsPos.toArray(), identPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ImportAll(node, startPos, parent, posInfo, posInfo1, prefixes, commentsPropInfos)
    }

    private func transImportSingle(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ImportSingle {
        // BNF: (packageNameIdentifier NL* DOT NL*)* (identifier | packageNameIdentifier)
        let lp = LocalParser(node.children)
        let (idents, identPos, dotsPos) = lp.consumeListOfPos(startPos, kind: SyntaxNodeKind.IdentToken,
            sep: SyntaxNodeKind.DotToken)
        let prefixes = idents |> map({ident: SyntaxNodeImpl => getValue(ident)}) |> collectArray<String>
        let sz = identPos.size
        let posInfo = ImportSinglePosInfos(identPos[sz - 1])
        let posInfo1 = ImportContentPosInfos(dotsPos.toArray(), identPos.toArray()[..sz - 1])
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ImportSingle(node, startPos, parent, posInfo, posInfo1, prefixes[sz - 1], prefixes[..sz - 1], commentsPropInfos)
    }

    private func transImportAlias(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ImportAlias {
        // BNF: importSingle NL* AS NL* identifier
        let lp = LocalParser(node.children)
        let (idents, identPos, dotsPos) = lp.consumeListOfPos(startPos, kind: SyntaxNodeKind.IdentToken,
            sep: SyntaxNodeKind.DotToken)
        let prefixes = idents |> map({ident: SyntaxNodeImpl => getValue(ident)}) |> collectArray<String>
        var curNode = lp.consume()
        let asPos = startPos + lp.offset
        lp.offset.move(curNode?.offset)
        let aliasName = lp.consume(kind: SyntaxNodeKind.IdentToken).getOrThrow()
        let aliasNamePos = startPos + lp.offset
        let sz = identPos.size
        let posInfo = ImportAliasPosInfos(identPos[sz - 1], asPos, aliasNamePos)
        let posInfo1 = ImportContentPosInfos(dotsPos.toArray(), identPos.toArray()[..sz - 1])
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ImportAlias(node, startPos, parent, posInfo, posInfo1, getValue(aliasName), prefixes[sz - 1], prefixes[..sz - 1],
            commentsPropInfos)
    }

    private func transImportMulti(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ImportMulti {
        // BNF: (packageNameIdentifier NL* DOT NL*)* LCURL NL*
        // (importSingle | importAlias | importAll) NL*
        // (COMMA NL* (importSingle | importAlias | importAll))* NL*
        // COMMA? NL* RCURL
        let lp = LocalParser(node.children)
        let importContents = ArrayList<ImportContent>()
        let (idents, identPos, dotsPos) = lp.consumeListOfPos(startPos, kind: SyntaxNodeKind.IdentToken,
            sep: SyntaxNodeKind.DotToken)
        let prefixes = idents |> map({ident: SyntaxNodeImpl => getValue(ident)}) |> collectArray<String>
        let commasPos = ArrayList<CodePosition>()
        var (lCurlPos, rCurlPos) = (CodePosition(), CodePosition())
        var findImportContent = false
        var contentsPropInfo = PropInfo()
        while (let Some(node) <- lp.consume()) {
            match (node) {
                case nt: NonTerminal =>
                    if (!findImportContent) {
                        findImportContent = true
                        contentsPropInfo = PropInfo(lp.cur - 1, lp.offset)
                    }
                case _ => match (node.kind) {
                    case SyntaxNodeKind.CommaToken => commasPos.add(startPos + lp.offset)
                    case SyntaxNodeKind.LCurlToken => lCurlPos = startPos + lp.offset
                    case SyntaxNodeKind.RCurlToken =>
                        rCurlPos = startPos + lp.offset
                        break
                    case _ => fail("unExpected node kind in importMulti")
                }
            }
            lp.offset.move(node.offset)
        }
        let posInfo = ImportMultiPosInfos(lCurlPos, rCurlPos, commasPos.toArray())
        let posInfo1 = ImportContentPosInfos(dotsPos.toArray(), identPos.toArray())
        let propInfo = ImportMultiPropInfos(contentsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ImportMulti(node, startPos, parent, posInfo, propInfo, posInfo1, prefixes, commentsPropInfos)
    }

    private func transImportList(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ImportList {
        // BNF: importModifier? NL* IMPORT NL* importContent end+
        let lp = LocalParser(node.children)
        var modifier: ?Modifier = None
        var content: ?ImportContent = None
        var kind = ImportKind.Alias
        var contentsPropInfo = PropInfo()
        var modifierPropInfo: ?PropInfo = None
        if (lp.look(SyntaxNodeKind.Modifier)) {
            let curNode = lp.consume()
            modifierPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        let importNode = lp.consume(kind: SyntaxNodeKind.ImportToken)
        let importKeyWordPos = startPos + lp.offset
        lp.moveOffset(importNode)
        if (let Some(importContent) <- lp.consume()) {
            contentsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            kind = match (importContent.kind) {
                case SyntaxNodeKind.ImportAlias => ImportKind.Alias
                case SyntaxNodeKind.ImportAll => ImportKind.All
                case SyntaxNodeKind.ImportMulti => ImportKind.Multi
                case SyntaxNodeKind.ImportSingle => ImportKind.Single
                case _ =>
                    fail("translate ImportList error, not find import content")
                    kind
            }
        }
        let posInfo = ImportListPosInfos(importKeyWordPos)
        let propInfo = ImportListPropInfos(contentsPropInfo, modifierPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ImportList(node, startPos, None, posInfo, propInfo, kind, commentsPropInfos)
    }

    private func transGenericConstraint(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): GenericConstraint {
        // BNF type UPPERBOUND type (BITAND type)*
        let lp = LocalParser(node.children)

        let typeAnnoNode = lp.consume()
        let tyAnnoPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(typeAnnoNode?.offset)
        let upperNode = lp.consume(kind: SyntaxNodeKind.UpperBoundToken)
        let upBoundPos = startPos + lp.offset
        lp.offset.move(upperNode?.offset)
        let upperBoundsPropInfos = ArrayList<PropInfo>()
        let bitEndPos = ArrayList<CodePosition>()
        while (!lp.isEnd()) {
            if (let Some(node) <- lp.tryConsume()) {
                upperBoundsPropInfos.add(PropInfo(lp.cur - 1, lp.offset))
                lp.offset.move(node.offset)
            }

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitAndToken)) {
                bitEndPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }

        let propInfo = GenericConstraintPropInfos(tyAnnoPropInfo, upperBoundsPropInfos.toArray())
        let posInfo = GenericConstraintPosInfos(upBoundPos, bitEndPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        GenericConstraint(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transGenericConstraints(node: SyntaxNodeImpl, startPos: CodePosition, parent: ?SyntaxTreeNode): GenericConstraints {
        // BNF: WHERE constraints (, constraints)*
        let lp = LocalParser((node as NonTerminal).getOrThrow().children)
        let whereNode = lp.consume(kind: SyntaxNodeKind.WhereToken)
        let wherePos = startPos + lp.offset
        lp.offset.move(whereNode?.offset)
        let commasPos = ArrayList<CodePosition>()
        let constraintsPropInfos = ArrayList<PropInfo>()
        while (!lp.isEnd()) {
            let constraintNode = lp.consume(kind: SyntaxNodeKind.GenericConstraint)
            if (constraintNode.isSome()) {
                constraintsPropInfos.add(PropInfo(lp.cur - 1, lp.offset))
                lp.offset.move(constraintNode?.offset)
            }

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                commasPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }

        let propInfo = GenericConstraintsPropInfos(constraintsPropInfos.toArray())
        let posInfo = GenericConstraintsPosInfos(wherePos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        GenericConstraints(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    // Decl

    private func transGenericParam(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): GenericParam {
        let lp = LocalParser(node.children)
        var name: String = ""

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            lp.moveOffset(v)
        }

        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        GenericParam(node, startPos, parent, name, commentsPropInfos)
    }

    private func transFuncDeclModifierList(startPos: CodePosition, modifierList: NonTerminal, lp: LocalParser) {
        var operatorFlag = false
        var kind = FuncKind.PrimaryConstructor
        var funcKindKeyWordPos: Option<CodePosition> = None
        let mlp = LocalParser(modifierList.children)
        while (let Some(modifier) <- mlp.tryConsume()) {
            let mp = LocalParser((modifier as NonTerminal).getOrThrow().children)
            while (let Some(vm) <- mp.tryConsume()) {
                match (vm.kind) {
                    case SyntaxNodeKind.ForeignToken =>
                        kind = FuncKind.Foreign
                        funcKindKeyWordPos = startPos + lp.offset + mlp.offset + mp.offset
                        mp.offset.move(vm.offset)
                    case SyntaxNodeKind.OperatorToken =>
                        operatorFlag = true
                        mp.offset.move(vm.offset)
                    case _ => mp.offset.move(vm.offset)
                }
            }
            mlp.moveOffset(modifier)
        }
        return (kind, funcKindKeyWordPos, operatorFlag)
    }

    private func consumeParamsAndRetTyAnnotation(lp: LocalParser, startPos: CodePosition) {
        var paramNode = lp.consume()
        let paramsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(paramNode?.offset)

        var retTyAnnotationPropInfo: Option<PropInfo> = None
        var retTyAnnotationColonPos: Option<CodePosition> = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            retTyAnnotationColonPos = startPos + lp.offset
            lp.offset.move(v.offset)

            var tyAnnoNode = lp.consume()
            retTyAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(tyAnnoNode?.offset)
        }

        return (paramsPropInfo, retTyAnnotationPropInfo, retTyAnnotationColonPos)
    }

    private func consumeNamedGenericDeclHead(lp: LocalParser, startPos: CodePosition) {
        var (name, identifierPos) = ("", CodePosition())
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        var genericParamsPropInfo: ?PropInfo = None
        var genericParamsCommasPos = Array<CodePosition>()
        var (genericParamsLAnglePos, genericParamsRAnglePos): (Option<CodePosition>, Option<CodePosition>) = (None, None)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeArguments)) {
            genericParamsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            (genericParamsLAnglePos, genericParamsCommasPos, genericParamsRAnglePos) = transGenericParams(v,
                startPos + lp.offset)
            lp.moveOffset(v)
        }

        return (name, identifierPos, genericParamsPropInfo, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos)
    }

    private func consumeUpperBoundSuperTypes(lp: LocalParser, startPos: CodePosition) {
        var upperBoundPos: Option<CodePosition> = None
        var (superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = (ArrayList<PropInfo>(), ArrayList<CodePosition>())
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.UpperBoundToken)) {
            upperBoundPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let predictTypeAnnotation = {
                kind: SyntaxNodeKind => kind.isTypeAnnotation()
            }
            while (lp.look(predictTypeAnnotation)) {
                let tyAnnoNode = lp.consume()
                superTyAnnotationsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
                lp.offset.move(tyAnnoNode?.offset)

                if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitAndToken)) {
                    superTyAnnotationsBitAndPos.add(startPos + lp.offset)
                    lp.moveOffset(v)
                }
            }
        }

        return (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos)
    }

    private func consumeGenericConstraintsPropInfo(lp: LocalParser): ?PropInfo {
        var genericConstraintsPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.GenericConstraints)) {
            genericConstraintsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        }
        return genericConstraintsPropInfo
    }

    private func consumeBodyNodeAndPropInfo(lp: LocalParser) {
        let bodyNode = lp.consume(kind: SyntaxNodeKind.Body)
        let bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
        return (bodyNode, bodyPropInfo)
    }

    private func consumeMacroExpandCommon(lp: LocalParser, startPos: CodePosition) {
        var (calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo) = (PropInfo(), PropInfo(), PropInfo())
        var (lSquarePos, rSquarePos): (?CodePosition, ?CodePosition) = (None, None)
        var (lParenPos, rParenPos): (?CodePosition, ?CodePosition) = (None, None)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }
        let atNode = lp.consume(kind: SyntaxNodeKind.AtToken)
        let atPos = startPos + lp.offset
        lp.moveOffset(atNode)

        let calleeNode = lp.consume()
        calleePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(calleeNode)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LSquareToken)) {
            lSquarePos = startPos + lp.offset
            lp.moveOffset(v)
        }
        if (lp.look(SyntaxNodeKind.TokenList) && let Some(v) <- lp.consume()) {
            macroAttrsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RSquareToken)) {
            rSquarePos = startPos + lp.offset
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
            if (lp.look(SyntaxNodeKind.TokenList) && let Some(v) <- lp.consume()) {
                macroInputsPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(v)
            }
            let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            rParenPos = startPos + lp.offset
            lp.moveOffset(rParenNode)
        } else {
            let inputNode = lp.consume()
            macroInputsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(inputNode)
        }

        return (calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo, atPos, lSquarePos, rSquarePos, lParenPos,
            rParenPos)
    }

    private func consumeSeparatedElementsStartPropInfo(lp: LocalParser, startPos: CodePosition,
        shouldConsumeElement: (SyntaxNodeKind) -> Bool, sep: SyntaxNodeKind) {
        let commasPos = ArrayList<CodePosition>()
        var findStart = false
        var elementsPropInfo = PropInfo()
        while (lp.look(shouldConsumeElement)) {
            if (let Some(node) <- lp.consume()) {
                if (!findStart) {
                    findStart = true
                    elementsPropInfo = PropInfo(lp.cur - 1, lp.offset)
                }
                lp.moveOffset(node)
            }
            if (lp.look(sep)) {
                let curSep = lp.consume(kind: sep)
                commasPos.add(startPos + lp.offset)
                lp.moveOffset(curSep)
            }
        }
        return (elementsPropInfo, commasPos)
    }

    private func consumeParenConditionPropInfo(lp: LocalParser, startPos: CodePosition) {
        var curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(curNode)

        curNode = lp.consume()
        let conditionPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(curNode)

        return (conditionPropInfo, lParenPos, rParenPos)
    }

    private func consumeCommaPos(lp: LocalParser, startPos: CodePosition) {
        let curNode = lp.consume(kind: SyntaxNodeKind.CommaToken)
        let pos = startPos + lp.offset
        lp.moveOffset(curNode)
        return pos
    }

    private func consumeOptionalTypeLabel(lp: LocalParser, startPos: CodePosition, labels: ArrayList<String>,
        labelsPos: ArrayList<CodePosition>, colonPos: ArrayList<CodePosition>) {
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            labels.add(getValue(v))
            labelsPos.add(startPos + lp.offset)
            lp.moveOffset(v)

            let curNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
            colonPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)
        }
    }

    private func transFuncDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FuncDecl {
        // BNF: anno? modifier? (FUNC？ IDENT | INIT | ~INIT)  typeParams? funcParams (COLON type)? genericConstraints? block?
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        var operatorFlag = false
        var kind = FuncKind.PrimaryConstructor
        var funcKindKeyWordPos: Option<CodePosition> = None
        // check if foreign func
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList) && let Some(modifierList) <- (v as NonTerminal)) {
            (kind, funcKindKeyWordPos, operatorFlag) = transFuncDeclModifierList(startPos, modifierList, lp)
            lp.offset.move(v.offset)
        }
        var funcKeyWordPos: Option<CodePosition> = None
        var identifierPos: CodePosition = CodePosition()
        var name = ""
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        } else if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.FuncToken)) {
            kind = match (kind) {
                case Foreign => FuncKind.Foreign
                case _ => FuncKind.Normal
            }
            funcKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
            if (let Some(ident) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
                name = getValue(ident)
                identifierPos = startPos + lp.offset
                lp.offset.move(ident.offset)
            }
        } else if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitNotToken)) {
            name = "~init"
            funcKindKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
            kind = FuncKind.Finalizer
            if (let Some(ident) <- lp.consume(kind: SyntaxNodeKind.InitToken)) {
                identifierPos = startPos + lp.offset
                lp.offset.move(ident.offset)
            }
        } else if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.InitToken)) {
            name = "init"
            kind = FuncKind.Constructor
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        var genericParamsPropInfo: ?PropInfo = None
        var genericParamsLAnglePos: Option<CodePosition> = None
        var genericParamsCommasPos: Array<CodePosition> = Array<CodePosition>()
        var genericParamsRAnglePos: Option<CodePosition> = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeArguments)) {
            genericParamsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            (genericParamsLAnglePos, genericParamsCommasPos, genericParamsRAnglePos) = transGenericParams(v,
                startPos + lp.offset)
            lp.moveOffset(v)
        }
        let paramsNode = lp.consume(kind: SyntaxNodeKind.ParameterList)
        let paramsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(paramsNode?.offset)

        var retTyAnnotationPropInfo: ?PropInfo = None
        var retTyAnnotationColonPos: Option<CodePosition> = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            retTyAnnotationColonPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let annoNode = lp.consume()
            retTyAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(annoNode?.offset)
        }

        var genericConstraintsPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.GenericConstraints)) {
            genericConstraintsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        }

        var bodyPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Block)) {
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        }

        if (operatorFlag) {
            kind = FuncKind.Operator
        }

        let propInfo = FuncDeclPropInfos(bodyPropInfo, genericConstraintsPropInfo, genericParamsPropInfo, paramsPropInfo,
            retTyAnnotationPropInfo)
        let posInfo = FuncDeclPosInfos(funcKindKeyWordPos, funcKeyWordPos, identifierPos, genericParamsLAnglePos,
            genericParamsCommasPos, genericParamsRAnglePos, retTyAnnotationColonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        FuncDecl(node, startPos, parent, name, kind, posInfo, propInfo, commentsPropInfos)
    }

    private func transVarKind(node: SyntaxNodeImpl): VarKind {
        return match (node.kind) {
            case SyntaxNodeKind.VarToken => VarKind.Var
            case SyntaxNodeKind.LetToken => VarKind.Let
            case SyntaxNodeKind.ConstToken => VarKind.Const
            case _ => throw Exception("ParseException: This SyntaxNode kind is not var kind.")
        }
    }

    // var a = 1
    private func transVarDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): VarDecl {
        // BNF: annotationList? variableModifier* NL* (LET | VAR) NL* patternsMaybeIrrefutable ( (NL* COLON NL* type)? (NL* ASSIGN NL* expression)
        //    | (NL* COLON NL* type)
        let lp = LocalParser(node.children)
        var initializerPropInfo: ?PropInfo = None
        var patternPropInfo = PropInfo()
        var tyAnnoPropInfo: ?PropInfo = None

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        var modifiers = Array<Modifier>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }
        var (kind, varKindKeyWordPos) = (VarKind.Const, CodePosition())
        var (identifierPos, tyAnnotationColonPos, assignPos): (?CodePosition, ?CodePosition, ?CodePosition) = (None, None,
            None)
        if (let Some(v) <- lp.look([SyntaxNodeKind.VarToken, SyntaxNodeKind.LetToken, SyntaxNodeKind.ConstToken])) {
            if (let Some(node) <- lp.consume(kind: v)) {
                kind = transVarKind(node)
                varKindKeyWordPos = startPos + lp.offset
                lp.offset.move(node.offset)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.VarBindingPattern)) {
            identifierPos = startPos + lp.offset
            patternPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        } else if (let Some(v) <- lp.look([SyntaxNodeKind.WildcardPattern, SyntaxNodeKind.TuplePattern])) {
            let patternNode = lp.consume(kind: v)
            patternPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(patternNode?.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            tyAnnotationColonPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let annoNode = lp.consume()
            tyAnnoPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(annoNode?.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AssignToken)) {
            assignPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let initNode = lp.consume()
            initializerPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(initNode?.offset)
        }

        let propInfos = VarDeclPropInfos(initializerPropInfo, patternPropInfo, tyAnnoPropInfo)
        let posInfos = VarDeclPosInfos(varKindKeyWordPos, identifierPos, tyAnnotationColonPos, assignPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        VarDecl(node, startPos, parent, kind, posInfos, propInfos, commentsPropInfos)
    }

    private func transMainDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MainDecl {
        // BNF: MAIN funcParams (COLON type)？ Block
        let lp = LocalParser(node.children)
        var mainKeyWordPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.MainToken)) {
            mainKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        let (paramsPropInfo, retTyAnnotationPropInfo, retTyAnnotationColonPos) = consumeParamsAndRetTyAnnotation(lp,
            startPos)

        var blockNode = lp.consume()
        let blockPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(blockNode?.offset)

        let propInfos = MainDeclPropInfos(blockPropInfo, paramsPropInfo, retTyAnnotationPropInfo)
        let posInfo = MainDeclPosInfos(mainKeyWordPos, retTyAnnotationColonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MainDecl(node, startPos, parent, posInfo, propInfos, commentsPropInfos)
    }

    private func transTypeAlias(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TypeAlias {
        // BNF: annotationList? (typeModifier NL*)? TYPE_ALIAS NL* identifier (NL* typeParameters)? NL* ASSIGN NL* type end*
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }
        var aliasName: String = ""
        var typeParametersPropInfo: ?PropInfo = None
        var typeAliasKeyWordPos = CodePosition()
        var identifierPos = CodePosition()
        var assignPos = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeToken)) {
            typeAliasKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
            aliasName = getValue(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeArguments)) {
            typeParametersPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AssignToken)) {
            assignPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let tyAnnoNode = lp.consume()
        let tyAnnoPropInfo = PropInfo(lp.cur - 1, lp.offset)

        let propInfo = TypeAliasPropInfos(tyAnnoPropInfo, typeParametersPropInfo)
        let posInfo = TypeAliasPosInfos(typeAliasKeyWordPos, identifierPos, assignPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TypeAlias(node, startPos, parent, aliasName, posInfo, propInfo, commentsPropInfos)
    }

    private func transBody(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Body {
        var memberDeclsPropInfo = ArrayList<PropInfo>()
        let bitOrsPos = ArrayList<CodePosition>()
        var ellipsisPos: ?CodePosition = None
        let lp = LocalParser(node.children)
        let lCurlNode = lp.consume(kind: SyntaxNodeKind.LCurlToken)
        let lCurlPos = startPos + lp.offset
        lp.offset.move(lCurlNode?.offset)

        let predictDecl = {
            kind: SyntaxNodeKind => kind.isDecl()
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitOrToken)) {
            bitOrsPos.add(startPos + lp.offset)
            lp.offset.move(v.offset)
        }
        while (lp.look(predictDecl)) {
            let declNode = lp.consume()
            memberDeclsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.offset.move(declNode?.offset)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitOrToken)) {
                bitOrsPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.EllipsisToken)) {
                ellipsisPos = startPos + lp.offset
                lp.offset.move(v.offset)
            }
        }

        let rCurlNode = lp.consume(kind: SyntaxNodeKind.RCurlToken)
        let rCurlPos = startPos + lp.offset
        lp.offset.move(rCurlNode?.offset)

        let propInfos = BodyPropInfos(memberDeclsPropInfo.toArray())
        let enumBodyPosInfos = EnumBodyPosInfos(bitOrsPos.toArray(), ellipsisPos)
        let posInfos = BodyPosInfos(lCurlPos, rCurlPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Body(node, startPos, parent, posInfos, enumBodyPosInfos, propInfos, commentsPropInfos)
    }

    private func transClassDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ClassDecl {
        // BNF: annotationList? (classModifierList NL*)? CLASS NL* identifier (NL* typeParameters NL*)? (NL* UPPERBOUND NL* superClassOrInterfaces)? (NL* genericConstraints)? (NL* classBody)
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let classNode = lp.consume(kind: SyntaxNodeKind.ClassToken)
        let classKeyWordPos = startPos + lp.offset
        lp.offset.move(classNode?.offset)

        let (name, identifierPos, genericParamsPropInfo, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos) = consumeNamedGenericDeclHead(lp, startPos)
        let (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = consumeUpperBoundSuperTypes(lp,
            startPos)
        let genericConstraintsPropInfo = consumeGenericConstraintsPropInfo(lp)
        let (bodyNode, bodyPropInfo) = consumeBodyNodeAndPropInfo(lp)
        lp.offset.move(bodyNode?.offset)

        let propInfos = ClassDeclPropInfos(bodyPropInfo, genericConstraintsPropInfo, genericParamsPropInfo,
            superTyAnnotationsPropInfo.toArray())
        let posInfos = ClassDeclPosInfos(classKeyWordPos, identifierPos, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos, upperBoundPos, superTyAnnotationsBitAndPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ClassDecl(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transPropGetterOrSetter(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): PropGetterOrSetter {
        // BNF: GET NL* LPAREN RPAREN NL* block end* 
        //    | annotationList? SET NL* LPAREN identifier RPAREN NL* block end*
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        var identifier: ?String = None
        var isGetter: Bool = false
        var setKeyWordPos: ?CodePosition = None
        var getKeyWordPos: ?CodePosition = None
        var identifierPos: ?CodePosition = None
        var lParenPos: CodePosition = CodePosition()
        var rParenPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.SetToken)) {
            setKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)

            let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
            lParenPos = startPos + lp.offset
            lp.offset.move(lParenNode?.offset)
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
                identifier = getValue(v)
                identifierPos = startPos + lp.offset
                lp.offset.move(v.offset)
            }
            let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            rParenPos = startPos + lp.offset
            lp.offset.move(rParenNode?.offset)
        } else if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.GetToken)) {
            isGetter = true
            getKeyWordPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
            lParenPos = startPos + lp.offset
            lp.offset.move(lParenNode?.offset)

            let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            rParenPos = startPos + lp.offset
            lp.offset.move(rParenNode?.offset)
        }

        var blockPropInfo = PropInfo()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Block)) {
            blockPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        }

        let propInfos = PropGetterOrSetterPropInfos(blockPropInfo)
        let posInfos = PropGetterOrSetterPosInfos(getKeyWordPos, setKeyWordPos, identifierPos, lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        PropGetterOrSetter(node, startPos, parent, identifier, isGetter, posInfos, propInfos, commentsPropInfos)
    }

    private func transPropDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): PropDecl {
        // BNF: annotationList? propertyModifier* NL* PROP NL* identifier NL* propertyTypeAndBody
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let propNode = lp.consume(kind: SyntaxNodeKind.PropToken)
        let propKeyWordPos = startPos + lp.offset
        lp.offset.move(propNode?.offset)

        var name: String = ""
        var identifierPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        var tyAnnotationColonPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            tyAnnotationColonPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        let predictTypeAnnotation = {
            kind: SyntaxNodeKind => kind.isTypeAnnotation()
        }

        var tyAnnotationPropInfo = PropInfo()
        if (lp.look(predictTypeAnnotation)) {
            let tyAnnoNode = lp.consume()
            tyAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(tyAnnoNode?.offset)
        }

        var lCurlPos: ?CodePosition = None
        var rCurlPos: ?CodePosition = None
        var getterPropInfo: ?PropInfo = None
        var setterPropInfo: ?PropInfo = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LCurlToken)) {
            lCurlPos = startPos + lp.offset
            lp.offset.move(v.offset)
            while (lp.look(SyntaxNodeKind.PropGetterOrSetter)) {
                let node = lp.consume()
                var cur = cast<PropGetterOrSetter>(transNode(node.getOrThrow(), startPos + lp.offset, parent))
                if (let Some(ty) <- cur && ty.isGetter) {
                    getterPropInfo = PropInfo(lp.cur - 1, lp.offset)
                } else {
                    setterPropInfo = PropInfo(lp.cur - 1, lp.offset)
                }
                lp.offset.move(node?.offset)
            }
            let rCurlNode = lp.consume(kind: SyntaxNodeKind.RCurlToken)
            rCurlPos = startPos + lp.offset
            lp.offset.move(rCurlNode?.offset)
        }
        let propInfos = PropDeclPropInfos(getterPropInfo, setterPropInfo, tyAnnotationPropInfo)
        let posInfos = PropDeclPosInfos(propKeyWordPos, identifierPos, tyAnnotationColonPos, lCurlPos, rCurlPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        PropDecl(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transStaticInitModifierList(startPos: CodePosition, modifierList: NonTerminal, lp: LocalParser) {
        var staticKeyWordPos: CodePosition = CodePosition()
        let mlp = LocalParser(modifierList.children)
        while (let Some(modifier) <- mlp.tryConsume()) {
            let mp = LocalParser((modifier as NonTerminal).getOrThrow().children)
            while (let Some(vm) <- mp.tryConsume()) {
                match (vm.kind) {
                    case SyntaxNodeKind.StaticToken =>
                        staticKeyWordPos = startPos + lp.offset + mlp.offset + mp.offset
                        break
                    case _ => continue
                }
            }
            mlp.moveOffset(modifier)
        }
        staticKeyWordPos
    }

    private func transStaticInit(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): StaticInit {
        // BNF: STATIC INIT LPAREN RPAREN LCURL expressionOrDeclarations? RCURL
        let lp = LocalParser(node.children)

        var staticKeyWordPos: CodePosition = CodePosition()

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList) && let Some(modifierList) <- (v as NonTerminal)) {
            staticKeyWordPos = transStaticInitModifierList(startPos, modifierList, lp)
            lp.offset.move(v.offset)
        }
        let initNode = lp.consume(kind: SyntaxNodeKind.InitToken)
        let initKeyWordPos = startPos + lp.offset
        lp.offset.move(initNode?.offset)
        let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        var lParenPos = startPos + lp.offset
        lp.offset.move(lParenNode?.offset)
        let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        var rParenPos = startPos + lp.offset
        lp.offset.move(rParenNode?.offset)

        let bodyNode = lp.consume()
        let bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(bodyNode?.offset)

        let propInfo = StaticInitPropInfos(bodyPropInfo)
        let posInfo = StaticInitPosInfos(staticKeyWordPos, initKeyWordPos, lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        StaticInit(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transStructDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): StructDecl {
        // BNF: annotationList? (structModifier NL*)? STRUCT NL* identifier (NL* typeParameters)? (NL* UPPERBOUND NL* superInterfaces)? (NL* genericConstraints)? NL* structBody
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let structNode = lp.consume(kind: SyntaxNodeKind.StructToken)
        let structKeyWordPos = startPos + lp.offset
        lp.offset.move(structNode?.offset)

        let (name, identifierPos, genericParamsPropInfo, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos) = consumeNamedGenericDeclHead(lp, startPos)
        let (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = consumeUpperBoundSuperTypes(lp,
            startPos)
        let genericConstraintsPropInfo = consumeGenericConstraintsPropInfo(lp)
        let (bodyNode, bodyPropInfo) = consumeBodyNodeAndPropInfo(lp)
        lp.offset.move(bodyNode?.offset)

        let propInfos = StructDeclPropInfos(bodyPropInfo, genericConstraintsPropInfo, genericParamsPropInfo,
            superTyAnnotationsPropInfo.toArray())
        let posInfos = StructDeclPosInfos(structKeyWordPos, identifierPos, genericParamsLAnglePos,
            genericParamsCommasPos, genericParamsRAnglePos, upperBoundPos, superTyAnnotationsBitAndPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        StructDecl(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transInterfaceDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): InterfaceDecl {
        // BNF: annotationList? (interfaceModifierList NL*)? INTERFACE NL* identifier (NL* typeParameters NL*)? (NL* UPPERBOUND NL* superInterfaces)? (NL* genericConstraints)? (NL* interfaceBody)
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let interfaceNode = lp.consume(kind: SyntaxNodeKind.InterfaceToken)
        let interfaceKeyWordPos = startPos + lp.offset
        lp.offset.move(interfaceNode?.offset)

        let (name, identifierPos, genericParamsPropInfo, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos) = consumeNamedGenericDeclHead(lp, startPos)
        let (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = consumeUpperBoundSuperTypes(lp,
            startPos)
        let genericConstraintsPropInfo = consumeGenericConstraintsPropInfo(lp)
        let (bodyNode, bodyPropInfo) = consumeBodyNodeAndPropInfo(lp)
        lp.offset.move(bodyNode?.offset)

        let propInfos = InterfaceDeclPropInfos(bodyPropInfo, genericConstraintsPropInfo, genericParamsPropInfo,
            superTyAnnotationsPropInfo.toArray())
        let posInfos = InterfaceDeclPosInfos(interfaceKeyWordPos, identifierPos, genericParamsLAnglePos,
            genericParamsCommasPos, genericParamsRAnglePos, upperBoundPos, superTyAnnotationsBitAndPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        InterfaceDecl(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transExtendDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ExtendDecl {
        // BNF: annotationList? (interfaceModifierList NL*)? INTERFACE NL* identifier (NL* typeParameters NL*)? (NL* UPPERBOUND NL* superInterfaces)? (NL* genericConstraints)? (NL* interfaceBody)
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let extendNode = lp.consume(kind: SyntaxNodeKind.ExtendToken)
        let extendKeyWordPos = startPos + lp.offset
        lp.offset.move(extendNode?.offset)

        var genericParamsPropInfo: ?PropInfo = None
        var genericParamsCommasPos = Array<CodePosition>()
        var (genericParamsLAnglePos, genericParamsRAnglePos): (Option<CodePosition>, Option<CodePosition>) = (None, None)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeArguments)) {
            genericParamsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            (genericParamsLAnglePos, genericParamsCommasPos, genericParamsRAnglePos) = transGenericParams(v,
                startPos + lp.offset)
            lp.moveOffset(v)
        }

        let predictTypeAnnotation = {
            kind: SyntaxNodeKind => kind.isTypeAnnotation()
        }

        var extendedTyAnnotationPropInfo = PropInfo()
        if (lp.look(predictTypeAnnotation)) {
            let extendedTyNode = lp.consume()
            extendedTyAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(extendedTyNode?.offset)
        }

        let (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = consumeUpperBoundSuperTypes(lp,
            startPos)
        let genericConstraintsPropInfo = consumeGenericConstraintsPropInfo(lp)
        let (bodyNode, bodyPropInfo) = consumeBodyNodeAndPropInfo(lp)
        lp.offset.move(bodyNode?.offset)

        let propInfos = ExtendDeclPropInfos(bodyPropInfo, extendedTyAnnotationPropInfo, genericConstraintsPropInfo,
            genericParamsPropInfo, superTyAnnotationsPropInfo.toArray())
        let posInfos = ExtendDeclPosInfos(extendKeyWordPos, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos, upperBoundPos, superTyAnnotationsBitAndPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ExtendDecl(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transEnumDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): EnumDecl {
        // BNF: annotationList? (enumModifier NL*)? ENUM NL* identifier (NL* typeParameters NL*)? (NL* UPPERBOUND NL* superInterfaces)? (NL* genericConstraints)? NL* LCURL end* enumBody end* RCURL
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let enumNode = lp.consume(kind: SyntaxNodeKind.EnumToken)
        let enumKeyWordPos = startPos + lp.offset
        lp.offset.move(enumNode?.offset)

        let (name, identifierPos, genericParamsPropInfo, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos) = consumeNamedGenericDeclHead(lp, startPos)
        let (upperBoundPos, superTyAnnotationsPropInfo, superTyAnnotationsBitAndPos) = consumeUpperBoundSuperTypes(lp,
            startPos)
        let genericConstraintsPropInfo = consumeGenericConstraintsPropInfo(lp)
        let (bodyNode, bodyPropInfo) = consumeBodyNodeAndPropInfo(lp)
        var body: ?Body = cast<Body>(transNode(bodyNode.getOrThrow(), startPos + lp.offset, parent))
        lp.offset.move(bodyNode?.offset)

        var caseSeparatorPos = Array<CodePosition>()
        var nonExhaustiveTripleDotPos: ?CodePosition = None
        if (let Some(bd) <- body) {
            caseSeparatorPos = bd.enumBodyPosInfos.bitOrsPos
            nonExhaustiveTripleDotPos = bd.enumBodyPosInfos.ellipsisPos
        }
        let isNonExhaustive = !nonExhaustiveTripleDotPos.isNone()

        let propInfos = EnumDeclPropInfos(bodyPropInfo, genericConstraintsPropInfo, genericParamsPropInfo,
            superTyAnnotationsPropInfo.toArray())
        let posInfos = EnumDeclPosInfos(enumKeyWordPos, identifierPos, genericParamsLAnglePos, genericParamsCommasPos,
            genericParamsRAnglePos, upperBoundPos, superTyAnnotationsBitAndPos.toArray(), caseSeparatorPos,
            nonExhaustiveTripleDotPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        EnumDecl(node, startPos, parent, isNonExhaustive, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transEnumConstructor(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): EnumConstructor {
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        var name: String = ""
        var identifierPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        var lParenPos: ?CodePosition = None
        var rParenPos: ?CodePosition = None
        var paramTyAnnotationsPorpInfo = ArrayList<PropInfo>()
        var paramsCommasPos = ArrayList<CodePosition>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
            let predictTypeAnnotation = {
                kind: SyntaxNodeKind => kind.isTypeAnnotation()
            }
            while (lp.look(predictTypeAnnotation)) {
                let tyAnnoNode = lp.consume()
                paramTyAnnotationsPorpInfo.add(PropInfo(lp.cur - 1, lp.offset))
                lp.offset.move(tyAnnoNode?.offset)
                if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                    paramsCommasPos.add(startPos + lp.offset)
                    lp.offset.move(v.offset)
                }
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        let propInfos = EnumConstructorPropInfos(paramTyAnnotationsPorpInfo.toArray())
        let posInfos = EnumConstructorPosInfos(identifierPos, lParenPos, paramsCommasPos.toArray(), rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        EnumConstructor(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transMacroDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MacroDecl {
        // BNF: annotationList? macroModifierList? NL* MACRO NL* identifier NL* functionParameters (COLON NL* identifier NL*)? block
        let lp = LocalParser(node.children)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
            lp.offset.move(v.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
            lp.offset.move(v.offset)
        }

        let macroNode = lp.consume(kind: SyntaxNodeKind.MacroToken)
        let macroPos = startPos + lp.offset
        lp.offset.move(macroNode?.offset)

        var name: String = ""
        var identifierPos: CodePosition = CodePosition()
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            name = getValue(v)
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        let (paramsPropInfo, retTyAnnotationPropInfo, retTyAnnotationColonPos) = consumeParamsAndRetTyAnnotation(lp,
            startPos)

        var bodyPropInfo = PropInfo()
        if (let Some(v) <- lp.consume(kind: SyntaxNodeKind.Block)) {
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(v.offset)
        }

        let propInfos = MacroDeclPropInfos(bodyPropInfo, paramsPropInfo, retTyAnnotationPropInfo)
        let posInfos = MacroDeclPosInfos(macroPos, identifierPos, retTyAnnotationColonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MacroDecl(node, startPos, parent, name, posInfos, propInfos, commentsPropInfos)
    }

    private func transMacroExpandDecl(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MacroExpandDecl {
        let lp = LocalParser(node.children)
        let (calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo, atPos, lSquarePos, rSquarePos, lParenPos,
            rParenPos) = consumeMacroExpandCommon(lp, startPos)

        let propInfos = MacroExpandDeclPropInfos(calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo)
        let posInfos = MacroExpandDeclPosInfos(atPos, lSquarePos, rSquarePos, lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MacroExpandDecl(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transMacroExpandParam(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MacroExpandParam {
        let lp = LocalParser(node.children)
        let (calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo, atPos, lSquarePos, rSquarePos, lParenPos,
            rParenPos) = consumeMacroExpandCommon(lp, startPos)

        let propInfos = MacroExpandParamPropInfos(calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo)
        let posInfos = MacroExpandParamPosInfos(atPos, lSquarePos, rSquarePos, lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MacroExpandParam(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    // Expr
    private func transValuedLitConstExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LitConstExpr {
        let lp = LocalParser(node.children)
        let litNode = lp.consume().getOrThrow()
        var kind: LitConstKind = match (litNode.kind) {
            case SyntaxNodeKind.IntegerLiteralToken => LitConstKind.IntergerLiteral
            case SyntaxNodeKind.FloatLiteralToken => LitConstKind.FloatLiteral
            case SyntaxNodeKind.BooleanLiteralToken => LitConstKind.BoolLiteral
            case _ => throw Exception(
                "ParseException: This SyntaxNode kind is not integer literal, float literal or bool literal.")
        }
        let rawValue = match (litNode) {
            case vt: ValuedTerminal => vt.value
            case _ => ""
        }
        lp.moveOffset(litNode)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LitConstExpr(node, startPos, parent, kind, rawValue, commentsPropInfos)
    }

    private func transUnitLitConstExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LitConstExpr {
        let lp = LocalParser(node.children)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LitConstExpr(node, startPos, parent, LitConstKind.UnitLiteral, node.toString(), commentsPropInfos)
    }

    private func transLitConstRuneExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LitConstRuneExpr {
        var rawValue = ""
        var isSingleQuote = false
        for (child in node.children) {
            match (child) {
                case vt: ValuedTerminal => rawValue = vt.toString()
                case t: Terminal => isSingleQuote = getIsSingleQuote(t)
                case _ => ()
            }
        }
        let lp = LocalParser(node.children)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LitConstRuneExpr(node, startPos, parent, rawValue, isSingleQuote, commentsPropInfos)
    }

    private func transInterpolationExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): StrInterpolationContent {
        // BNF: $ + Block
        let lp = LocalParser(node.children)
        let dollarPos = startPos
        lp.offset.move(lp.consume()?.offset)
        lp.consume()
        let blockPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        StrInterpolationContent(node, startPos, parent, StrInterpolationContentPosInfos(dollarPos),
            StrInterpolationContentPropInfos(blockPropInfo), commentsPropInfos)
    }

    private func transStringLitConstExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LitConstStrExpr {
        let lp = LocalParser(node.children)
        var kind = match (node.kind) {
            case SyntaxNodeKind.LineStringLiteral => LitConstStrKind.StringLiteral
            // case SyntaxNodeKind.JStringLiteral
            case SyntaxNodeKind.MultiLineStringLiteral => LitConstStrKind.MultiLineString
            case SyntaxNodeKind.MultiLineRawStringLiteral => LitConstStrKind.MultiLineRawString
            case _ => throw Exception("ParseException: This SyntaxNode kind is not string literal.")
        }
        var delimiterNum = 0
        var isSingleQuote = false
        var rawValue = ""
        var strPartExprs = ArrayList<StrLiteralPart>()
        var findStart = false
        var strPartExprsPropInfo = PropInfo()

        for (i in 0..node.children.size) {
            let child = node.children[i]
            match (child.kind) {
                case SyntaxNodeKind.StringLiteralToken => rawValue += child.toString()
                case SyntaxNodeKind.HashToken =>
                    if (let Some(rt) <- (child as RepeatedTerminal)) {
                        delimiterNum = rt.repeat
                    }
                case SyntaxNodeKind.SingleQuoteToken => isSingleQuote = true
                case SyntaxNodeKind.InterpolationExpr =>
                    if (!findStart) {
                        findStart = true
                        strPartExprsPropInfo = PropInfo(i, lp.offset)
                    }
                    if (let Some(interpol) <- cast<StrInterpolationContent>(transNode(child, startPos + lp.offset, None))) {
                        rawValue += interpol.toString()
                    }
                case SyntaxNodeKind.LineStringLiteral | SyntaxNodeKind.MultiLineStringLiteral
                    | SyntaxNodeKind.MultiLineRawStringLiteral =>
                    if (!findStart) {
                        findStart = true
                        strPartExprsPropInfo = PropInfo(i, lp.offset)
                    }
                    if (let Some(litConst) <- cast<LitConstExpr>(transNode(child, startPos + lp.offset, None))) {
                        rawValue += litConst.rawValue
                    }
                case _ => ()
            }
            lp.moveOffset(child)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LitConstStrExpr(node, startPos, parent, delimiterNum, isSingleQuote, rawValue, kind,
            LitConstStrExprPropInfos(strPartExprsPropInfo), commentsPropInfos)
    }

    private func getIsSingleQuote(node: Terminal): Bool {
        return match (node.kind) {
            case SyntaxNodeKind.SingleQuoteToken | SyntaxNodeKind.TripleSingleQuoteToken => true
            case SyntaxNodeKind.DoubleQuoteToken | SyntaxNodeKind.TripleDoubleQuoteToken => false
            case _ => false
        }
    }

    private func transSymbolRef(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): SymbolRef {
        var identifierPos = CodePosition()
        var lAnglePos: ?CodePosition = None
        var rAnglePos: ?CodePosition = None
        var commasPos = ArrayList<CodePosition>()
        var name = ""
        var typeArgumentsPropInfo: ?PropInfo = None

        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            identifierPos = startPos + lp.offset
            lp.offset.move(v.offset)
            name = getValue(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.TypeArguments)) {
            typeArgumentsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            (lAnglePos, commasPos, rAnglePos) = transTypeArguments(v, startPos + lp.offset)
        }

        let propInfos = SymbolRefPropInfos(typeArgumentsPropInfo)
        let posInfo = SymbolRefPosInfos(identifierPos, lAnglePos, rAnglePos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        SymbolRef(node, startPos, parent, name, posInfo, propInfos, commentsPropInfos)
    }

    private func transArrayLiteralExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ArrayLiteral {
        // BNF: LSQUARE (NL* elements)? NL* RSQUARE
        let lSquarePos = startPos
        var rSquarePos = CodePosition()
        let lp = LocalParser(node.children)
        lp.moveOffset(lp.consume(kind: SyntaxNodeKind.LSquareToken))
        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        let sep = SyntaxNodeKind.CommaToken
        let (exprsPropInfo, commasPos) = consumeSeparatedElementsStartPropInfo(lp, startPos, predictExpr, sep)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RSquareToken)) {
            rSquarePos = startPos + lp.offset
        }
        let posInfo = ArrayLiteralPosInfos(lSquarePos, rSquarePos, commasPos.toArray())
        let propInfo = ArrayLiteralPropInfos(exprsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ArrayLiteral(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transTupleLiteralExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TupleLiteral {
        // BNF: LSQUARE (NL* elements)? NL* RSQUARE
        let lParenPos = startPos
        var rParenPos = CodePosition()
        let lp = LocalParser(node.children)
        lp.moveOffset(lp.consume(kind: SyntaxNodeKind.LParenToken))
        let predictTupleElement = {
            kind: SyntaxNodeKind => kind.isExpr() || kind == SyntaxNodeKind.WildcardPattern
        }
        let sep = SyntaxNodeKind.CommaToken
        let (exprsPropInfo, commasPos) = consumeSeparatedElementsStartPropInfo(lp, startPos, predictTupleElement, sep)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
        }
        let posInfo = TupleLiteralPosInfos(lParenPos, rParenPos, commasPos.toArray())
        let propInfo = TupleLiteralPropInfos(exprsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TupleLiteral(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transVArrayExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): VArrayExpr {
        // BNF: VArray<Int64, $5>({ i => i})
        var argumentPropInfo = PropInfo()
        var vArrayTypePropInfo = PropInfo()
        var lParenPos = CodePosition()
        var rParenPos = CodePosition()
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.VArrayType)) {
            vArrayTypePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Argument)) {
            argumentPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let posInfo = VArrayExprPosInfos(lParenPos, rParenPos)
        let propInfo = VArrayExprPropInfos(argumentPropInfo, vArrayTypePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        VArrayExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transCallExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): CallExpr {
        // BNF: expr LPAREN NL* (valueArgument (NL* COMMA NL* valueArgument)* NL*)? RPAREN
        var argumentPropInfo = ArrayList<PropInfo>()
        var calleePropInfo = PropInfo()
        var lParenPos = CodePosition()
        var rParenPos = CodePosition()
        let lp = LocalParser(node.children)
        let commasPos = ArrayList<CodePosition>()

        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            let exprNode = lp.consume()
            calleePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(exprNode?.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let sep = SyntaxNodeKind.CommaToken
        while (lp.look(SyntaxNodeKind.Argument)) {
            let argumentNode = lp.consume()
            argumentPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.offset.move(argumentNode?.offset)
            if (let Some(v) <- lp.lookAndConsume(sep)) {
                commasPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }

        let propInfos = CallExprPropInfos(calleePropInfo, argumentPropInfo.toArray())
        let posInfos = CallExprPosInfos(lParenPos, rParenPos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        CallExpr(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transTypeConvExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TypeConvExpr {
        //BNF:  (INT8...) LPAREN NL* expression NL* RPAREN
        let lp = LocalParser(node.children)

        let annoNode = lp.consume()
        let targetTypeAnnotationPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(annoNode?.offset)

        let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.offset.move(lParenNode?.offset)

        let srcValNode = lp.consume()
        let srcValPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(srcValNode?.offset)

        let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.offset.move(rParenNode?.offset)

        let propInfo = TypeConvExprPropInfos(srcValPropInfo, targetTypeAnnotationPropInfo)
        let posInfo = TypeConvExprPosInfos(lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TypeConvExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transOptionalExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): OptionalExpr {
        let lp = LocalParser(node.children)
        var curNode = lp.consume()
        let basePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.QuestToken)
        let questPos = startPos + lp.offset
        let posInfo = OptionalExprPosInfos(questPos)
        let propInfo = OptionalExprPropInfos(basePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        OptionalExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transAssignOpKind(node: SyntaxNodeImpl): AssignOpKind {
        return match (node) {
            case t: Terminal => match (t.kind) {
                case SyntaxNodeKind.AssignToken => AssignOpKind.Assign
                case SyntaxNodeKind.AddAssignToken => AssignOpKind.AddAssign
                case SyntaxNodeKind.SubAssignToken => AssignOpKind.SubAssign
                case SyntaxNodeKind.MulAssignToken => AssignOpKind.MulAssign
                case SyntaxNodeKind.ExpAssignToken => AssignOpKind.ExpAssign
                case SyntaxNodeKind.DivAssignToken => AssignOpKind.DivAssign
                case SyntaxNodeKind.ModAssignToken => AssignOpKind.ModAssign
                case SyntaxNodeKind.AndAssignToken => AssignOpKind.AndAssign
                case SyntaxNodeKind.OrAssignToken => AssignOpKind.OrAssign
                case SyntaxNodeKind.BitAndAssignToken => AssignOpKind.BitAndAssign
                case SyntaxNodeKind.BitOrAssignToken => AssignOpKind.BitOrAssign
                case SyntaxNodeKind.BitXorAssignToken => AssignOpKind.BitXorAssign
                case SyntaxNodeKind.LShiftAssignToken => AssignOpKind.LShiftAssign
                case SyntaxNodeKind.RShiftAssignToken => AssignOpKind.RShiftAssign
                case _ => throw Exception("ParseException: This SyntaxNode kind is not assign operator.")
            }
            case _ => throw Exception("ParseException: This SyntaxNode kind is not assign operator.")
        }
    }

    private func transAssignExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): AssignExpr {
        let lp = LocalParser(node.children)
        // lhs
        var curNode = lp.consume()
        let lhsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)
        var opKind: AssignOpKind = AssignOpKind.Assign
        var opPos = CodePosition()
        if (let Some(v) <- lp.consume()) {
            opKind = transAssignOpKind(v)
            opPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        //rhs
        curNode = lp.consume()
        let rhsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        let posInfo = AssignExprPosInfos(opPos)
        let propInfo = AssignExprPropInfos(lhsPropInfo, rhsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        AssignExpr(node, startPos, parent, opKind, posInfo, propInfo, commentsPropInfos)
    }

    private func transBinaryOpKind(node: SyntaxNodeImpl): BinaryOpKind {
        return match (node) {
            case t: Terminal => match (t.kind) {
                case SyntaxNodeKind.AddToken => BinaryOpKind.Add
                case SyntaxNodeKind.AndToken => BinaryOpKind.And
                case SyntaxNodeKind.BitAndToken => BinaryOpKind.BitAnd
                case SyntaxNodeKind.BitOrToken => BinaryOpKind.BitOr
                case SyntaxNodeKind.BitXorToken => BinaryOpKind.BitXor
                case SyntaxNodeKind.CoalescingToken => BinaryOpKind.Coalescing
                case SyntaxNodeKind.CompositionToken => BinaryOpKind.Composition
                case SyntaxNodeKind.DivToken => BinaryOpKind.Div
                case SyntaxNodeKind.EqualToken => BinaryOpKind.Equal
                case SyntaxNodeKind.ExpToken => BinaryOpKind.Exp
                case SyntaxNodeKind.GeToken => BinaryOpKind.Ge
                case SyntaxNodeKind.GtToken => BinaryOpKind.Gt
                case SyntaxNodeKind.LeToken => BinaryOpKind.Le
                case SyntaxNodeKind.LShiftToken => BinaryOpKind.LShift
                case SyntaxNodeKind.LtToken => BinaryOpKind.Lt
                case SyntaxNodeKind.ModToken => BinaryOpKind.Mod
                case SyntaxNodeKind.MulToken => BinaryOpKind.Mul
                case SyntaxNodeKind.NotEqToken => BinaryOpKind.NotEq
                case SyntaxNodeKind.OrToken => BinaryOpKind.Or
                case SyntaxNodeKind.PipelineToken => BinaryOpKind.Pipeline
                case SyntaxNodeKind.RShiftToken => BinaryOpKind.RShift
                case SyntaxNodeKind.SubToken => BinaryOpKind.Sub
                case _ => throw Exception("ParseException: This SyntaxNode kind is not binary operator.")
            }
            case _ => throw Exception("ParseException: This SyntaxNode kind is not binary operator.")
        }
    }

    private func transBinaryExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): BinaryExpr {
        // BNF: lhs op rhs
        let lp = LocalParser(node.children)
        let lhsNode = lp.consume()
        let lhsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(lhsNode?.offset)

        let op = lp.consume().getOrThrow()
        let opKind = transBinaryOpKind(op)
        let opPos = startPos + lp.offset
        lp.offset.move(op.offset)

        let rhsNode = lp.consume()
        let rhsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(rhsNode?.offset)

        let propInfos = BinaryExprPropInfos(lhsPropInfo, rhsPropInfo)
        let posInfo = BinaryExprPosInfos(opPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        BinaryExpr(node, startPos, parent, opKind, posInfo, propInfos, commentsPropInfos)
    }

    private func transUnaryExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): UnaryExpr {
        let lp = LocalParser(node.children)
        let op = lp.consume().getOrThrow()
        var opKind: UnaryOpKind = match (op) {
            case t: Terminal => match (t.kind) {
                case SyntaxNodeKind.NotToken => UnaryOpKind.Not
                case SyntaxNodeKind.SubToken => UnaryOpKind.Sub
                case _ => throw Exception("ParseException: This SyntaxNode kind is not unary operator.")
            }
            case _ => throw Exception("ParseException: This SyntaxNode kind is not unary operator.")
        }
        let opPos = startPos + lp.offset
        let curNode = lp.consume()
        let operandPropInfo = PropInfo(lp.cur - 1, lp.offset)
        let posInfo = UnaryExprPosInfos(opPos)
        let propInfo = UnaryExprPropInfos(operandPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        UnaryExpr(node, startPos, parent, opKind, posInfo, propInfo, commentsPropInfos)
    }

    private func transIsExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): IsExpr {
        let lp = LocalParser(node.children)

        let exprNode = lp.consume()
        let exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(exprNode?.offset)

        let isNode = lp.consume(kind: SyntaxNodeKind.IsToken)
        let isPos = startPos + lp.offset
        lp.offset.move(isNode?.offset)

        let typeNode = lp.consume()
        let typePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(typeNode?.offset)

        let propInfo = IsExprPropInfos(exprPropInfo, typePropInfo)
        let posInfo = IsExprPosInfos(isPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        IsExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transAsExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): AsExpr {
        // BNF: expr AS targetType
        let lp = LocalParser(node.children)

        let exprNode = lp.consume()
        let exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(exprNode?.offset)

        let asNode = lp.consume(kind: SyntaxNodeKind.AsToken)
        let asPos = startPos + lp.offset
        lp.offset.move(asNode?.offset)

        let typeNode = lp.consume()
        let typePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(typeNode?.offset)

        let propInfo = AsExprPropInfos(exprPropInfo, typePropInfo)
        let posInfo = AsExprPosInfos(asPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        AsExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transParenExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ParenExpr {
        // BNF: LPAREN expr RPAREN
        let lp = LocalParser(node.children)

        let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.offset.move(lParenNode?.offset)
        let exprNode = lp.consume()
        let exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(exprNode?.offset)
        let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.offset.move(rParenNode?.offset)

        let propInfo = ParenExprPropInfos(exprPropInfo)
        let posInfo = ParenExprPosInfos(lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ParenExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transReturnExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ReturnExpr {
        // BNF: RETURN (NL* expression)?
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.ReturnToken)
        let returnPos = startPos + lp.offset
        lp.moveOffset(curNode)

        var retValPropInfo: ?PropInfo = None
        if (!lp.isEnd()) {
            if (lp.tryConsume().isSome()) {
                retValPropInfo = PropInfo(lp.cur - 1, lp.offset)
            }
        }
        let posInfo = ReturnExprPosInfos(returnPos)
        let propInfo = (ReturnExprPropInfos(retValPropInfo))
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ReturnExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transIncOrDecExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): IncOrDecExpr {
        // BNF: postfixExpression (INC | DEC )
        let lp = LocalParser(node.children)

        var kind: IncOrDecOpKind = IncOrDecOpKind.Decr

        let exprNode = lp.consume()
        let exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(exprNode?.offset)

        var opPos = CodePosition()
        if (lp.look(SyntaxNodeKind.IncrToken)) {
            kind = IncOrDecOpKind.Incr
            let opNode = lp.consume(kind: SyntaxNodeKind.IncrToken)
            opPos = startPos + lp.offset
            lp.offset.move(opNode?.offset)
        } else {
            kind = IncOrDecOpKind.Decr
            let opNode = lp.consume(kind: SyntaxNodeKind.DecrToken)
            opPos = startPos + lp.offset
            lp.offset.move(opNode?.offset)
        }

        let propInfo = IncOrDecExprPropInfos(exprPropInfo)
        let posInfo = IncOrDecExprPosInfos(opPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        IncOrDecExpr(node, startPos, parent, kind, posInfo, propInfo, commentsPropInfos)
    }

    private func transRangeExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): RangeExpr {
        // BNF: shiftingExpression NL* rangeOp NL* shiftingExpression (NL* COLON NL* shiftingExpression)?
        let lp = LocalParser(node.children)

        var startPropInfo: ?PropInfo = None
        if (!lp.look(SyntaxNodeKind.RangeOpToken) && !lp.look(SyntaxNodeKind.ClosedRangeOpToken)) {
            let startNode = lp.consume()
            startPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(startNode?.offset)
        }
        let op = lp.consume().getOrThrow()
        var kind: RangeKind = match (op) {
            case t: Terminal => match (t.kind) {
                case SyntaxNodeKind.RangeOpToken => RangeKind.RangeOp
                case SyntaxNodeKind.ClosedRangeOpToken => RangeKind.ClosedRangeOp
                case _ => throw Exception("ParseException: This SyntaxNode kind is not range operator.")
            }
            case _ => throw Exception("ParseException: This SyntaxNode kind is not range operator.")
        }
        var opPos = startPos + lp.offset
        lp.offset.move(op.offset)

        var endPropInfo: ?PropInfo = None
        if (!lp.look(SyntaxNodeKind.ColonToken) && !lp.isEnd()) {
            if (let Some(endNode) <- lp.tryConsume()) {
                endPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.offset.move(endNode.offset)
            }
        }
        var colonPos: ?CodePosition = None
        var stepPropInfo: ?PropInfo = None

        if (lp.look(SyntaxNodeKind.ColonToken)) {
            let colonNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
            colonPos = startPos + lp.offset
            lp.offset.move(colonNode?.offset)

            let stepNode = lp.consume()
            stepPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(stepNode?.offset)
        }

        let propInfo = RangeExprPropInfos(startPropInfo, stepPropInfo, endPropInfo)
        let posInfo = RangeExprPosInfos(opPos, colonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        RangeExpr(node, startPos, parent, kind, posInfo, propInfo, commentsPropInfos)
    }

    private func transBreakExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): BreakExpr {
        let lp = LocalParser(node.children)
        if (lp.look(SyntaxNodeKind.BreakToken)) {
            let breakNode = lp.consume()
            lp.offset.move(breakNode?.offset)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        BreakExpr(node, startPos, parent, commentsPropInfos)
    }

    private func transContinueExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ContinueExpr {
        let lp = LocalParser(node.children)
        if (lp.look(SyntaxNodeKind.ContinueToken)) {
            let continueNode = lp.consume()
            lp.offset.move(continueNode?.offset)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ContinueExpr(node, startPos, parent, commentsPropInfos)
    }

    private func transMemberAccess(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MemberAccess {
        // BNF: base.field
        var basePropInfo = PropInfo()
        var field: ?SymbolRef = None
        var dotPos = CodePosition()
        let lp = LocalParser(node.children)

        let predictNode = {
            kind: SyntaxNodeKind => kind.isExpr() || kind.isTypeAnnotation()
        }
        if (lp.look(predictNode)) {
            let baseNode = lp.consume()
            basePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.offset.move(baseNode?.offset)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.DotToken)) {
            dotPos = startPos + lp.offset
            lp.offset.move(v.offset)
        }
        let fieldNode = lp.consume(kind: SyntaxNodeKind.RefExpr)
        let fieldPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.offset.move(fieldNode?.offset)

        let propInfos = MemberAccessPropInfos(basePropInfo, fieldPropInfo)
        let posInfo = MemberAccessPosInfos(dotPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MemberAccess(node, startPos, parent, posInfo, propInfos, commentsPropInfos)
    }

    private func transSubscriptExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): SubscriptExpr {
        // BNF: expression LSQUARE NL* (expression | rangeElement) NL* RSQUARE
        var basePropInfo = PropInfo()
        var indexsPropInfo = PropInfo()
        var lSquarePos = CodePosition()
        var rSquarePos = CodePosition()
        var commasPos = ArrayList<CodePosition>()
        let lp = LocalParser(node.children)
        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            if (let Some(node) <- lp.consume()) {
                basePropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(node)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LSquareToken)) {
            lSquarePos = startPos + lp.offset
            lp.moveOffset(v)
        }
        var findFirstIndex = false
        let sep = SyntaxNodeKind.CommaToken
        while (lp.look(predictExpr)) {
            if (let Some(node) <- lp.consume()) {
                if (!findFirstIndex) {
                    findFirstIndex = true
                    indexsPropInfo = PropInfo(lp.cur - 1, lp.offset)
                }
                lp.moveOffset(node)
            }
            if (lp.look(sep)) {
                var curNode = lp.consume(kind: sep)
                commasPos.add(startPos + lp.offset)
                lp.moveOffset(curNode)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RSquareToken)) {
            rSquarePos = startPos + lp.offset
        }
        let posInfo = SubscriptExprPosInfos(lSquarePos, rSquarePos, commasPos.toArray())
        let propInfo = SubscriptExprPropInfos(basePropInfo, indexsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        SubscriptExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transLambda(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Lambda {
        // BNF: LCURL NL* lambdaParameters? NL* DOUBLE_ARROW NL* expressionOrDeclarations? RCURL
        var bodyPropInfo: ?PropInfo = None
        var lCurlPos = CodePosition()
        var rCurlPos = CodePosition()
        var doubleArrowPos: ?CodePosition = None
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LCurlToken)) {
            lCurlPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        var curNode = lp.consume(kind: SyntaxNodeKind.ParameterList)
        let paramsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.DoubleArrowToken)) {
            doubleArrowPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let predictExprOrDecl = {
            kind: SyntaxNodeKind => kind.isExpr() || kind.isDecl()
        }
        var findFirst = false
        while (lp.look(predictExprOrDecl)) {
            if (let Some(node) <- lp.consume()) {
                if (!findFirst) {
                    findFirst = true
                    bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
                }
                lp.moveOffset(node)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RCurlToken)) {
            rCurlPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let posInfo = LambdaPosInfos(lCurlPos, rCurlPos, doubleArrowPos)
        let propInfo = LambdaPropInfos(bodyPropInfo, paramsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        Lambda(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transThrowExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ThrowExpr {
        // BNF: THROW NL* expression
        var throwValPropInfo = PropInfo()
        var throwKeyWordPos = CodePosition()
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ThrowToken)) {
            throwKeyWordPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            if (let Some(node) <- lp.consume()) {
                throwValPropInfo = PropInfo(lp.cur - 1, lp.offset)
            }
        }
        let posInfo = ThrowExprPosInfos(throwKeyWordPos)
        let propInfo = ThrowExprPropInfos(throwValPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ThrowExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transSynchronizedExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): SynchronizedExpr {
        var structuredMutexPropInfo = PropInfo()
        var blockPropInfo = PropInfo()
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.SynchronizedToken)
        let synchronizedKeywordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume()
        structuredMutexPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        if (lp.look(SyntaxNodeKind.Block)) {
            curNode = lp.consume()
            blockPropInfo = PropInfo(lp.cur - 1, lp.offset)
        }
        let posInfo = SynchronizedExprPosInfos(lParenPos, rParenPos, synchronizedKeywordPos)
        let propInfo = SynchronizedExprPropInfos(blockPropInfo, structuredMutexPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        SynchronizedExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transSpawnExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): SpawnExpr {
        var threadContextPropInfo: ?PropInfo = None
        var trailingLambdaExprPropInfo = PropInfo()
        var lParenPos: ?CodePosition = None
        var rParenPos: ?CodePosition = None
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.SpawnToken)
        let spawnKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        if (lp.look(SyntaxNodeKind.LParenToken)) {
            curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
            lParenPos = startPos + lp.offset
            lp.moveOffset(curNode)
            curNode = lp.consume()
            threadContextPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
            curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            rParenPos = startPos + lp.offset
            lp.moveOffset(curNode)
        }

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Lambda)) {
            trailingLambdaExprPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        let posInfo = SpawnExprPosInfos(spawnKeyWordPos, lParenPos, rParenPos)
        let propInfo = SpawnExprPropInfos(threadContextPropInfo, trailingLambdaExprPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        SpawnExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transIfExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): IfExpr {
        var conditionPropInfo = PropInfo()
        var ifBlockPropInfo = PropInfo()
        var elseBlockPropInfo: ?PropInfo = None
        var elseIfPropInfo: ?PropInfo = None
        var elseKeyWordPos: ?CodePosition = None
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.IfToken)
        let ifKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let condLParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume()
        conditionPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)
        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let condRParenPos = startPos + lp.offset
        lp.moveOffset(curNode)

        curNode = lp.consume()
        ifBlockPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ElseToken)) {
            elseKeyWordPos = startPos + lp.offset
            lp.moveOffset(curNode)
            if (lp.look(SyntaxNodeKind.Block)) {
                curNode = lp.consume()
                elseBlockPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(curNode)
            }
            if (lp.look(SyntaxNodeKind.IfExpr)) {
                curNode = lp.consume()
                elseIfPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(curNode)
            }
        }
        let posInfo = IfExprPosInfos(ifKeyWordPos, condLParenPos, condRParenPos, elseKeyWordPos)
        let propInfo = IfExprPropInfos(conditionPropInfo, elseBlockPropInfo, elseIfPropInfo, ifBlockPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        IfExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transParenCondition(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ParenCondition {
        // BNF: LPAREN NL* condition NL* RPAREN
        let lp = LocalParser(node.children)

        let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(lParenNode)

        let condNode = lp.consume()
        let condPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(condNode)

        let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(rParenNode)

        let propInfos = ParenConditionPropInfo(condPropInfo)
        let posInfos = ParenConditionPosInfo(lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ParenCondition(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transDisjunctionCondition(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): DisjunctionCondition {
        // BNF: conjunctionCondition NL* (OR NL* conjunctionCondition NL*)*
        var condPropInfo = ArrayList<PropInfo>()
        var orPos = ArrayList<CodePosition>()
        let lp = LocalParser(node.children)
        while (lp.look(SyntaxNodeKind.ConjunctionCondition)) {
            let conjuncNode = lp.consume(kind: SyntaxNodeKind.ConjunctionCondition)
            condPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(conjuncNode)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.OrToken)) {
                orPos.add(startPos + lp.offset)
                lp.moveOffset(v)
            }
        }

        let propInfos = DisjunctionConditionPropInfos(condPropInfo.toArray())
        let posInfos = DisjunctionConditionPosInfos(orPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        DisjunctionCondition(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transConjunctionCondition(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ConjunctionCondition {
        // BNF: atomicCondition NL* (AND NL* atomicCondition NL*)*
        let condPropInfo = ArrayList<PropInfo>()
        var andPos = ArrayList<CodePosition>()
        let lp = LocalParser(node.children)

        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        while (lp.look(SyntaxNodeKind.LetPattern) || lp.look(SyntaxNodeKind.ParenCondition) || lp.look(predictExpr)) {
            let node = lp.consume()
            condPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(node)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AndToken)) {
                andPos.add(startPos + lp.offset)
                lp.moveOffset(v)
            }
        }

        let propInfos = ConjunctionConditionPropInfos(condPropInfo.toArray())
        let posInfos = ConjunctionConditionPosInfos(andPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ConjunctionCondition(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transLetPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): LetPattern {
        // LET NL* pattern (NL* BITOR NL* pattern)* NL* BACKARROW NL* rangeExpression
        var exprPropInfo = PropInfo()
        let patternsPropInfo = ArrayList<PropInfo>()
        var bitOrPos = ArrayList<CodePosition>()
        let lp = LocalParser(node.children)

        let letNode = lp.consume(kind: SyntaxNodeKind.LetToken)
        let letPos = startPos + lp.offset
        lp.moveOffset(letNode)

        let predictPattern = {
            kind: SyntaxNodeKind => kind.isPattern()
        }
        while (lp.look(predictPattern)) {
            let patternNode = lp.consume()
            patternsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(patternNode)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitOrToken)) {
                bitOrPos.add(startPos + lp.offset)
                lp.moveOffset(v)
            }
        }
        let backArrowNode = lp.consume(kind: SyntaxNodeKind.BackArrowToken)
        let backArrowPos = startPos + lp.offset
        lp.moveOffset(backArrowNode)

        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            let exprNode = lp.consume()
            exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(exprNode)
        }

        let propInfos = LetPatternPropInfo(exprPropInfo, patternsPropInfo.toArray())
        let posInfos = LetPatternPosInfo(letPos, bitOrPos.toArray(), backArrowPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        LetPattern(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transWhileExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): WhileExpr {
        var bodyPropInfo = PropInfo()
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.WhileToken)
        let whileKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        let (conditionPropInfo, lParenPos, rParenPos) = consumeParenConditionPropInfo(lp, startPos)
        if (lp.look(SyntaxNodeKind.Block)) {
            curNode = lp.consume(kind: SyntaxNodeKind.Block)
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        let posInfo = WhileExprPosInfos(lParenPos, rParenPos, whileKeyWordPos)
        let propInfo = WhileExprPropInfos(bodyPropInfo, conditionPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        WhileExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transDoWhileExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): DoWhileExpr {
        var bodyPropInfo = PropInfo()
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.DoToken)
        let doKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)

        if (lp.look(SyntaxNodeKind.Block)) {
            curNode = lp.consume(kind: SyntaxNodeKind.Block)
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        curNode = lp.consume(kind: SyntaxNodeKind.WhileToken)
        let whileKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        let (conditionPropInfo, lParenPos, rParenPos) = consumeParenConditionPropInfo(lp, startPos)
        let posInfo = DoWhileExprPosInfos(lParenPos, rParenPos, doKeyWordPos, whileKeyWordPos)
        let propInfo = DoWhileExprPropInfos(bodyPropInfo, conditionPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        DoWhileExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transForInExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ForInExpr {
        var exprPropInfo = PropInfo()
        var patternPropInfo = PropInfo()
        var patternGuardPropInfo: ?PropInfo = None
        var bodyPropInfo = PropInfo()
        var whereKeyWordPos: ?CodePosition = None
        let lp = LocalParser(node.children)

        var curNode = lp.consume(kind: SyntaxNodeKind.ForToken)
        let forKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume()
        patternPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.InToken)
        let inKeywordPos = startPos + lp.offset
        lp.moveOffset(curNode)

        curNode = lp.consume()
        exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        if (lp.look(SyntaxNodeKind.WhereToken)) {
            curNode = lp.consume(kind: SyntaxNodeKind.WhereToken)
            whereKeyWordPos = startPos + lp.offset
            lp.moveOffset(curNode)
            curNode = lp.consume()
            patternGuardPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        if (lp.look(SyntaxNodeKind.Block)) {
            curNode = lp.consume()
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        let posInfo = ForInExprPosInfos(forKeyWordPos, inKeywordPos, lParenPos, rParenPos, whereKeyWordPos)
        let propInfo = ForInExprPropInfos(bodyPropInfo, exprPropInfo, patternPropInfo, patternGuardPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ForInExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transTryCatch(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TryCatch {
        // BNF: TRY NL* block NL* FINALLY NL* block
        //      | TRY NL* block (NL* CATCH NL* LPAREN NL* catchPattern NL* RPAREN NL* block)+ (NL* FINALLY NL* block)?
        //      | TRY NL* LPAREN NL* resourceSpecifications NL* RPAREN NL* block
        //          (NL* CATCH NL* LPAREN NL* catchPattern NL* RPAREN NL* block)* (NL* FINALLY NL* block)?
        var (catchBlocksPropInfo, catchPatternsPropInfo) = (ArrayList<PropInfo>(), ArrayList<PropInfo>())
        var (resourceSpecPropInfo, finallyBlockPropInfo): (?PropInfo, ?PropInfo) = (None, None)
        var (resourceSpecCommasPos, catchKeyWordsPos) = (ArrayList<CodePosition>(), ArrayList<CodePosition>())
        var (catchLParensPos, catchRParensPos) = (ArrayList<CodePosition>(), ArrayList<CodePosition>())

        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.TryToken)
        let tryKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)

        var resourceSpecLParenPos: ?CodePosition = None
        if (let Some(node) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            resourceSpecLParenPos = startPos + lp.offset
            lp.moveOffset(node)
        }
        let sep = SyntaxNodeKind.CommaToken
        while (lp.look(SyntaxNodeKind.VarDecl)) {
            curNode = lp.consume(kind: SyntaxNodeKind.VarDecl)
            if (resourceSpecPropInfo.isNone()) {
                resourceSpecPropInfo = PropInfo(lp.cur - 1, lp.offset)
            }
            lp.moveOffset(curNode)

            if (let Some(node) <- lp.lookAndConsume(sep)) {
                resourceSpecCommasPos.add(startPos + lp.offset)
                lp.moveOffset(node)
            }
        }
        var resourceSpecRParenPos: ?CodePosition = None
        if (let Some(node) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            resourceSpecRParenPos = startPos + lp.offset
            lp.moveOffset(node)
        }
        curNode = lp.consume(kind: SyntaxNodeKind.Block)
        let tryBlockPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        while (lp.look(SyntaxNodeKind.CatchToken)) {
            curNode = lp.consume()
            catchKeyWordsPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)

            curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
            catchLParensPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)

            curNode = lp.consume(kind: SyntaxNodeKind.CatchPattern)
            catchPatternsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(curNode)

            curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            catchRParensPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)

            if (let Some(blk) <- lp.lookAndConsume(SyntaxNodeKind.Block)) {
                catchBlocksPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
                lp.moveOffset(blk)
            }
        }

        var finallyKeyWordPos = Option<CodePosition>.None
        if (let Some(node) <- lp.lookAndConsume(SyntaxNodeKind.FinallyToken)) {
            finallyKeyWordPos = startPos + lp.offset
            lp.moveOffset(node)

            curNode = lp.lookAndConsume(SyntaxNodeKind.Block)
            finallyBlockPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }

        let posInfo = TryExprPosInfos(tryKeyWordPos, resourceSpecLParenPos, resourceSpecCommasPos.toArray(),
            resourceSpecRParenPos, catchKeyWordsPos.toArray(), catchLParensPos.toArray(), catchRParensPos.toArray(),
            finallyKeyWordPos)
        let propInfo = TryExprPropInfos(catchBlocksPropInfo.toArray(), catchPatternsPropInfo.toArray(),
            finallyBlockPropInfo, resourceSpecPropInfo, tryBlockPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TryCatch(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transQuoteTokenExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): QuoteToken {
        let lp = LocalParser(node.children)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        QuoteToken(node, startPos, parent, commentsPropInfos)
    }

    private func transQuoteInterpolationExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): QuoteInterpolationExpr {
        // BNF: DOLLAR LPAREN NL* expression NL* RPAREN
        var exprPropInfo = PropInfo()
        var dollarPos = CodePosition()
        var lParenPos: ?CodePosition = None
        var rParenPos: ?CodePosition = None

        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.DollarToken)) {
            dollarPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let predictExpr = {
            kind: SyntaxNodeKind => kind.isExpr()
        }
        if (lp.look(predictExpr)) {
            if (let Some(node) <- lp.consume()) {
                exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(node)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let posInfo = QuoteInterpolationExprPosInfos(dollarPos, lParenPos, rParenPos)
        let propInfo = QuoteInterpolationExprPropInfos(exprPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        QuoteInterpolationExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transQuoteExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): QuoteExpr {
        // BNF: QUOTE NL* LPAREN NL* (NL* quoteToken | NL* quoteInterpolate | NL* macroExpression)+ NL* RPAREN
        var tokensOrRefExprPropInfo = ArrayList<PropInfo>()
        var lParenPos = CodePosition()
        var rParenPos = CodePosition()
        var quoteKeyWordPos = CodePosition()
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.QuoteToken)) {
            quoteKeyWordPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        var findFirst = false
        while (let Some(kind) <- lp.look([SyntaxNodeKind.QuoteTokenExpr, SyntaxNodeKind.QuoteInterpolationExpr])) {
            let node = lp.consume(kind: kind)
            tokensOrRefExprPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(node)
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let posInfo = QuoteExprPosInfos(quoteKeyWordPos, lParenPos, rParenPos)
        let propInfo = QuoteExprPropInfos(tokensOrRefExprPropInfo.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        QuoteExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transTrailingClosureExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TrailingClosureExpr {
        var calleePropInfo = PropInfo()
        var trailingLambdaExprPropInfo = PropInfo()
        let lp = LocalParser(node.children)
        if (let Some(v) <- lp.consume()) {
            calleePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }

        var lParenPos = CodePosition()
        var rParenPos = CodePosition()
        let commasPos = ArrayList<CodePosition>()
        var argumentsPropInfo = PropInfo()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }
        let sep = SyntaxNodeKind.CommaToken
        var findFirst = false
        while (lp.look(SyntaxNodeKind.Argument)) {
            if (let Some(node) <- lp.consume()) {
                if (!findFirst) {
                    findFirst = true
                    argumentsPropInfo = PropInfo(lp.cur - 1, lp.offset)
                }
                lp.moveOffset(node)
            }
            if (lp.look(sep)) {
                var curNode = lp.consume(kind: sep)
                commasPos.add(startPos + lp.offset)
                lp.moveOffset(curNode)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.RParenToken)) {
            rParenPos = startPos + lp.offset
            lp.moveOffset(v)
        }

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.Lambda)) {
            trailingLambdaExprPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }
        let posInfo = TrailingClosureExprPosInfos(commasPos.toArray(), lParenPos, rParenPos)
        let propInfo = TrailingClosureExprPropInfos(argumentsPropInfo, calleePropInfo, trailingLambdaExprPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TrailingClosureExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transUnsafeExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): UnsafeExpr {
        // BNF: Unsafe Block
        var unsafePos = CodePosition()
        let lp = LocalParser(node.children)
        // unsafe
        var curNode = lp.consume(kind: SyntaxNodeKind.UnsafeToken)
        unsafePos = startPos + lp.offset
        lp.moveOffset(curNode)

        var blockPropInfo = PropInfo()
        if (lp.look(SyntaxNodeKind.Block)) {
            curNode = lp.consume(kind: SyntaxNodeKind.Block)
            blockPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        UnsafeExpr(node, startPos, parent, UnsafeExprPosInfos(unsafePos), UnsafeExprPropInfos(blockPropInfo),
            commentsPropInfos)
    }

    private func transMacroExpandExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MacroExpandExpr {
        let lp = LocalParser(node.children)
        let (calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo, atPos, lSquarePos, rSquarePos, lParenPos,
            rParenPos) = consumeMacroExpandCommon(lp, startPos)

        let propInfos = MacroExpandExprPropInfos(calleePropInfo, macroAttrsPropInfo, macroInputsPropInfo)
        let posInfos = MacroExpandExprPosInfos(atPos, lSquarePos, rSquarePos, lParenPos, rParenPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MacroExpandExpr(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transMatchExpr(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MatchExpr {
        // case 1: match (cond) { cases }
        // case 2: match { cases }
        var selectorPropInfo: ?PropInfo = None
        var matchKeyWordPos = CodePosition()
        var selectorLParenPos: ?CodePosition = None
        var selectorRParenPos: ?CodePosition = None
        var matchCasesLCurlPos = CodePosition()
        var matchCasesRCurlPos = CodePosition()
        let lp = LocalParser(node.children)
        // match
        var curNode = lp.consume(kind: SyntaxNodeKind.MatchToken)
        matchKeyWordPos = startPos + lp.offset
        lp.moveOffset(curNode)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            // case 1:  (cond)
            selectorLParenPos = startPos + lp.offset
            lp.moveOffset(v)
            curNode = lp.consume()
            selectorPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
            curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            selectorRParenPos = startPos + lp.offset
            lp.moveOffset(curNode)
        }
        // case 1 & case 2:  { cases }
        curNode = lp.consume(kind: SyntaxNodeKind.LCurlToken)
        matchCasesLCurlPos = startPos + lp.offset
        lp.moveOffset(curNode)
        var matchCasesPropInfo = ArrayList<PropInfo>()
        var findFirstCase = false
        while (!lp.look(SyntaxNodeKind.RCurlToken)) {
            curNode = lp.consume()
            matchCasesPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(curNode)
        }
        curNode = lp.consume(kind: SyntaxNodeKind.RCurlToken)
        matchCasesRCurlPos = startPos + lp.offset
        lp.moveOffset(curNode)
        let posInfo = MatchExprPosInfos(matchKeyWordPos, selectorLParenPos, selectorRParenPos, matchCasesLCurlPos,
            matchCasesRCurlPos)
        let propInfo = MatchExprPropInfos(matchCasesPropInfo.toArray(), selectorPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MatchExpr(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transMatchCase(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): MatchCase {
        // BNF: case patterns patternGuard? => caseBody
        //      | case expr => caseBody
        var bodyPropInfo = PropInfo()
        var caseCondPropInfo: ?PropInfo = None
        var patternGuardCondPropInfo: ?PropInfo = None
        var patternsPropInfo = ArrayList<PropInfo>()
        var casePos = CodePosition()
        var bitOrsPos = ArrayList<CodePosition>()
        var wherePos: ?CodePosition = None
        var doubleArrowPos = CodePosition()
        let lp = LocalParser(node.children)
        // case 
        let caseNode = lp.consume(kind: SyntaxNodeKind.CaseToken)
        casePos = startPos + lp.offset
        lp.moveOffset(caseNode)

        let predictPattern = {
            kind: SyntaxNodeKind => kind.isPattern()
        }
        if (lp.look(predictPattern)) {
            // case 1: pattern (| pattern)*, maybe more patterns such as 1 | 2 | 3
            while (!lp.look(SyntaxNodeKind.DoubleArrowToken) && !lp.look(SyntaxNodeKind.WhereToken)) {
                let patternNode = lp.consume()
                patternsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
                lp.moveOffset(patternNode)

                if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.BitOrToken)) {
                    bitOrsPos.add(startPos + lp.offset)
                    lp.moveOffset(v)
                }
            }
            // patternGuard
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.WhereToken)) {
                wherePos = startPos + lp.offset
                lp.moveOffset(v)
                let patternGuardNode = lp.consume()
                patternGuardCondPropInfo = PropInfo(lp.cur - 1, lp.offset)
                lp.moveOffset(patternGuardNode)
            }
        } else {
            // case 2: expr
            let caseCondNode = lp.consume()
            caseCondPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(caseCondNode)
        }
        // =>
        let doubleArrowNode = lp.consume(kind: SyntaxNodeKind.DoubleArrowToken)
        doubleArrowPos = startPos + lp.offset
        lp.moveOffset(doubleArrowNode)
        // case body
        if (let Some(bodyImpl) <- lp.consume(kind: SyntaxNodeKind.MatchCaseBody) && let Some(caseBody) <- (bodyImpl as NonTerminal)) {
            bodyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(bodyImpl)
        }

        let propInfos = MatchCasePropInfos(bodyPropInfo, caseCondPropInfo, patternGuardCondPropInfo,
            patternsPropInfo.toArray())
        let posInfos = MatchCasePosInfos(casePos, bitOrsPos.toArray(), wherePos, doubleArrowPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        MatchCase(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transConstPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ConstPattern {
        // BNF: literalConst
        let lp = LocalParser(node.children)
        let litExprNode = lp.consume()
        let exprPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(litExprNode)

        let propInfos = ConstPatternPropInfos(exprPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ConstPattern(node, startPos, parent, propInfos, commentsPropInfos)
    }

    private func transWildcardPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): WildcardPattern {
        let lp = LocalParser(node.children)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        WildcardPattern(node, startPos, parent, commentsPropInfos)
    }

    private func transVarBindingPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): VarPattern {
        // BNF: identifier
        let lp = LocalParser(node.children)
        var name: String = ""
        if (let Some(id) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            name = getValue(id)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        VarPattern(node, startPos, parent, name, commentsPropInfos)
    }

    private func transVarOrEnumPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): VarOrEnumPattern {
        // BNF: identifier with enum pattern context
        let lp = LocalParser(node.children)
        var name: String = ""
        if (let Some(id) <- lp.consume(kind: SyntaxNodeKind.IdentToken)) {
            name = getValue(id)
        }
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        VarOrEnumPattern(node, startPos, parent, name, commentsPropInfos)
    }

    private func transTypePattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TypePattern {
        // BNF: subPattern : type, subPattern must be var binding pattern or wild
        let lp = LocalParser(node.children)
        var subPatternPropInfo = PropInfo()
        var patternTyPropInfo = PropInfo()
        var colonPos = CodePosition()
        if (let Some(kind) <- lp.look([SyntaxNodeKind.VarBindingPattern, SyntaxNodeKind.WildcardPattern])) {
            let subPatternNode = lp.consume(kind: kind)
            subPatternPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(subPatternNode)

            let colonNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
            colonPos = startPos + lp.offset
            lp.moveOffset(colonNode)

            let patternTyNode = lp.consume()
            patternTyPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(patternTyNode)
        }
        let propInfos = TypePatternPropInfos(patternTyPropInfo, subPatternPropInfo)
        let posInfos = TypePatternPosInfos(colonPos)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TypePattern(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transEnumPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): EnumPattern {
        // BNF: (compositeType DOT)? identifier (LPAREN pattern (COMMA pattern)* RPAREN)?
        let lp = LocalParser(node.children)
        var enumTypePropInfo: ?PropInfo = None
        var enumConstructorPropInfo = PropInfo()
        var dotPos: Option<CodePosition> = None
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CompositeType)) {
            enumTypePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)

            let dotNode = lp.consume(kind: SyntaxNodeKind.DotToken)
            dotPos = startPos + lp.offset
            lp.moveOffset(dotNode)
        }

        let refNode = lp.consume(kind: SyntaxNodeKind.RefExpr)
        enumConstructorPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(refNode)

        var lParenPos: Option<CodePosition> = None
        var rParenPos: Option<CodePosition> = None
        var commasPos = ArrayList<CodePosition>()
        var subPatternsPropInfo = ArrayList<PropInfo>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LParenToken)) {
            lParenPos = startPos + lp.offset
            lp.moveOffset(v)
            while (!lp.look(SyntaxNodeKind.RParenToken)) {
                let patternNode = lp.consume()
                subPatternsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
                lp.moveOffset(patternNode)
                if (let Some(b) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                    commasPos.add(startPos + lp.offset)
                    lp.moveOffset(b)
                }
            }
            let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
            rParenPos = startPos + lp.offset
            lp.moveOffset(rParenNode)
        }

        let propInfos = EnumPatternPropInfos(enumConstructorPropInfo, enumTypePropInfo, subPatternsPropInfo.toArray())
        let posInfos = EnumPatternPosInfos(dotPos, lParenPos, rParenPos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        EnumPattern(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transTuplePattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TuplePattern {
        // BNF: (pattern (COMMA pattern)+)
        let lp = LocalParser(node.children)
        let lParenNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(lParenNode)

        let subPatternsPropInfo = ArrayList<PropInfo>()
        let commasPos = ArrayList<CodePosition>()
        while (!lp.look(SyntaxNodeKind.RParenToken)) {
            let patternNode = lp.consume()
            subPatternsPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
            lp.moveOffset(patternNode)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                commasPos.add(startPos + lp.offset)
                lp.moveOffset(v)
            }
        }
        let rParenNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(rParenNode)

        let propInfos = TuplePatternPropInfos(subPatternsPropInfo.toArray())
        let posInfos = TuplePatternPosInfos(lParenPos, rParenPos, commasPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TuplePattern(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    private func transCatchPattern(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): CatchPattern {
        // BNF: wildcardPattern |
        //      (wildcardPattern | identifier) COLON type (BITOR type)*
        let lp = LocalParser(node.children)
        let patternNode = lp.consume()
        let patternPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(patternNode)

        let exceptionTypesPropInfo = ArrayList<PropInfo>()
        var colonPos: ?CodePosition = None
        let bitOrsPos = ArrayList<CodePosition>()
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ColonToken)) {
            colonPos = startPos + lp.offset
            lp.moveOffset(v)
            while (!lp.isEnd()) {
                if (let Some(typeNode) <- lp.tryConsume()) {
                    exceptionTypesPropInfo.add(PropInfo(lp.cur - 1, lp.offset))
                    lp.moveOffset(typeNode)
                }

                if (let Some(b) <- lp.lookAndConsume(SyntaxNodeKind.BitOrToken)) {
                    bitOrsPos.add(startPos + lp.offset)
                    lp.moveOffset(b)
                }
            }
        }

        let propInfos = CatchPatternPropInfos(exceptionTypesPropInfo.toArray(), patternPropInfo)
        let posInfos = CatchPatternPosInfos(colonPos, bitOrsPos.toArray())
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        CatchPattern(node, startPos, parent, posInfos, propInfos, commentsPropInfos)
    }

    // TypeAnnotation
    private func transAtomicType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): AtomicType {
        let lp = LocalParser(node.children)
        let kindNode = lp.consume().getOrThrow()
        let kind = match (kindNode.kind) {
            case SyntaxNodeKind.BooleanToken => AtomicTypeKind.BoolType
            case SyntaxNodeKind.Float16Token => AtomicTypeKind.Float16Type
            case SyntaxNodeKind.Float32Token => AtomicTypeKind.Float32Type
            case SyntaxNodeKind.Float64Token => AtomicTypeKind.Float64Type
            case SyntaxNodeKind.Int16Token => AtomicTypeKind.Int16Type
            case SyntaxNodeKind.Int32Token => AtomicTypeKind.Int32Type
            case SyntaxNodeKind.Int64Token => AtomicTypeKind.Int64Type
            case SyntaxNodeKind.Int8Token => AtomicTypeKind.Int8Type
            case SyntaxNodeKind.IntNativeToken => AtomicTypeKind.IntNativeType
            case SyntaxNodeKind.NothingToken => AtomicTypeKind.NothingType
            case SyntaxNodeKind.RuneToken => AtomicTypeKind.RuneType
            case SyntaxNodeKind.UInt16Token => AtomicTypeKind.UInt16Type
            case SyntaxNodeKind.UInt32Token => AtomicTypeKind.UInt32Type
            case SyntaxNodeKind.UInt64Token => AtomicTypeKind.UInt64Type
            case SyntaxNodeKind.UInt8Token => AtomicTypeKind.UInt8Type
            case SyntaxNodeKind.UIntNativeToken => AtomicTypeKind.UIntNativeType
            case SyntaxNodeKind.UnitToken => AtomicTypeKind.UnitType
            case SyntaxNodeKind.ThisTypeToken => AtomicTypeKind.ThisType
            case _ => throw Exception("ParseException: This SyntaxNode kind is not Atomic type.")
        }
        lp.moveOffset(kindNode)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        AtomicType(node, startPos, parent, kind, commentsPropInfos)
    }

    private func transCompositeType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): CompositeType {
        // BNF: (identifier NL* DOT NL*)* identifier ( NL* typeArguments)?
        let lp = LocalParser(node.children)
        // (identifier DOT)* identifier
        let (ids, identPos, dotsPos) = lp.consumeListOfPos(startPos, kind: SyntaxNodeKind.IdentToken,
            sep: SyntaxNodeKind.DotToken)

        var lAngelPos: ?CodePosition = None
        var commaPos = ArrayList<CodePosition>()
        var rAngelPos: ?CodePosition = None
        var typeArgumentsPropInfo: ?PropInfo = None
        if (lp.look(SyntaxNodeKind.TypeArguments) && let Some(v) <- lp.consume()) {
            // LT type (COMMA type)* GT
            typeArgumentsPropInfo = PropInfo(lp.cur - 1, lp.offset)
            (lAngelPos, commaPos, rAngelPos) = transTypeArguments(v, startPos + lp.offset)
        }
        let posInfo = CompositeTypePosInfos(lAngelPos, rAngelPos, commaPos.toArray(), dotsPos.toArray(),
            identPos.toArray())
        let propInfo = CompositeTypePropInfos(typeArgumentsPropInfo)
        let size = ids.size
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        CompositeType(node, startPos, parent, posInfo, propInfo, getValue(ids[size - 1]),
            Array(size - 1, {i => getValue(ids[i])}), commentsPropInfos)
    }

    private func transTupleType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): TupleType {
        // BNF: LPAREN NL* type (NL* COMMA NL* type)+ NL* COMMA? NL* RPAREN
        // BNF: LPAREN NL* identifier NL* COLON NL* type (NL* COMMA NL* identifier NL* COLON NL* type)+ NL* COMMA? NL* RPAREN
        let lp = LocalParser(node.children)
        let lParenPos = startPos
        lp.moveOffset(lp.consume(kind: SyntaxNodeKind.LParenToken))

        var labels = ArrayList<String>()
        var labelsPos = ArrayList<CodePosition>()
        var colonPos = ArrayList<CodePosition>()
        var commaPos = ArrayList<CodePosition>()

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            labels.add(getValue(v))
            labelsPos.add(startPos + lp.offset)
            lp.moveOffset(v)

            let curNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
            colonPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)
        }
        var elementsPropInfo = PropInfo()
        var curNode = lp.consume()
        elementsPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)
        while (lp.look(SyntaxNodeKind.CommaToken)) {
            commaPos.add(consumeCommaPos(lp, startPos))
            consumeOptionalTypeLabel(lp, startPos, labels, labelsPos, colonPos)
            lp.moveOffset(lp.consume())
        }

        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset

        let posInfo = TupleTypePosInfos(lParenPos, rParenPos, commaPos.toArray(), labelsPos.toArray(),
            colonPos.toArray())
        let propInfo = TupleTypePropInfos(elementsPropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        TupleType(node, startPos, parent, posInfo, propInfo, labels.toArray(), commentsPropInfos)
    }

    private func transFuncType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): FuncType {
        // BNF: arrowParameters NL* ARROW NL* type
        let lp = LocalParser(node.children)
        var curNode = lp.consume(kind: SyntaxNodeKind.LParenToken)
        let lParenPos = startPos + lp.offset
        lp.moveOffset(curNode)

        var labels = ArrayList<String>()
        var labelsPos = ArrayList<CodePosition>()
        var colonPos = ArrayList<CodePosition>()
        var commaPos = ArrayList<CodePosition>()

        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            labels.add(getValue(v))
            labelsPos.add(startPos + lp.offset)
            lp.moveOffset(v)
            curNode = lp.consume(kind: SyntaxNodeKind.ColonToken)
            colonPos.add(startPos + lp.offset)
            lp.moveOffset(curNode)
        }
        var paramTypesPropInfo: ?PropInfo = None
        if (!lp.look(SyntaxNodeKind.RParenToken)) {
            curNode = lp.consume()
            paramTypesPropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(curNode)
        }
        while (lp.look(SyntaxNodeKind.CommaToken)) {
            commaPos.add(consumeCommaPos(lp, startPos))
            consumeOptionalTypeLabel(lp, startPos, labels, labelsPos, colonPos)
            lp.moveOffset(lp.consume())
        }

        curNode = lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset
        lp.moveOffset(curNode)
        curNode = lp.consume(kind: SyntaxNodeKind.ArrowToken)
        let arrowPos = startPos + lp.offset
        lp.moveOffset(curNode)
        let retType = lp.consume()
        let retTypePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(retType)

        let posInfo = FuncTypePosInfos(lParenPos, rParenPos, commaPos.toArray(), arrowPos, labelsPos.toArray(),
            colonPos.toArray())
        let propInfo = FuncTypePropInfos(paramTypesPropInfo, retTypePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        FuncType(node, startPos, parent, posInfo, propInfo, labels.toArray(), commentsPropInfos)
    }

    private func transVArrayType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): VArrayType {
        let lp = LocalParser(node.children)
        let varrayPos = startPos
        lp.moveOffset(lp.consume(kind: SyntaxNodeKind.VArrayToken))
        var curNode = lp.consume(kind: SyntaxNodeKind.LtToken)
        let lAngelPos = startPos + lp.offset
        lp.moveOffset(curNode)

        curNode = lp.consume()
        let elementPropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.CommaToken)
        let commaPos = startPos + lp.offset
        lp.moveOffset(curNode)

        curNode = lp.consume(kind: SyntaxNodeKind.DollarToken)
        let dollarPos = startPos + lp.offset
        lp.moveOffset(curNode)

        var sizePropInfo = PropInfo()
        if (let Some(v) <- lp.lookAndConsume(ValuedLiteral)) {
            sizePropInfo = PropInfo(lp.cur - 1, lp.offset)
            lp.moveOffset(v)
        }

        curNode = lp.consume(kind: SyntaxNodeKind.GtToken)
        let rAngelPos = startPos + lp.offset
        lp.moveOffset(curNode)

        let posInfo = VArrayTypePosInfos(varrayPos, lAngelPos, rAngelPos, dollarPos, commaPos)
        let propInfo = VArrayTypePropInfos(elementPropInfo, sizePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        VArrayType(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transTypeArguments(node: SyntaxNodeImpl, startPos: CodePosition): (CodePosition, ArrayList<CodePosition>, 
        CodePosition) {
        // BNF: identifier (NL* typeArguments)?
        var lAnglePos = CodePosition()
        var rAnglePos = CodePosition()
        let commasPos = ArrayList<CodePosition>()

        let lp = LocalParser((node as NonTerminal).getOrThrow().children)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.LtToken)) {
            lAnglePos = startPos
            lp.offset.move(v.offset)
        }
        let sep = SyntaxNodeKind.CommaToken
        let predictType = {
            kind: SyntaxNodeKind => kind.isTypeAnnotation()
        }
        while (lp.look(predictType)) {
            lp.offset.move(lp.consume().getOrThrow().offset)
            if (let Some(v) <- lp.lookAndConsume(sep)) {
                commasPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.GtToken)) {
            rAnglePos = startPos + lp.offset
        }
        return (lAnglePos, commasPos, rAnglePos)
    }

    private func transGenericParams(node: SyntaxNodeImpl, startPos: CodePosition) {
        // BNF :LT GenericParam (Comma GenericParam)* GT
        let lp = LocalParser(((node as NonTerminal).getOrThrow()).children)
        let ltNode = lp.consume(kind: SyntaxNodeKind.LtToken)
        let lAnglePos = startPos + lp.offset
        lp.offset.move(ltNode?.offset)
        let commasPos = ArrayList<CodePosition>()
        while (!lp.look(SyntaxNodeKind.GtToken)) {
            lp.offset.move(lp.consume().getOrThrow().offset)
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                commasPos.add(startPos + lp.offset)
                lp.offset.move(v.offset)
            }
        }
        let rAnglePos = startPos + lp.offset
        (lAnglePos, commasPos.toArray(), rAnglePos)
    }

    private func transParenType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): ParenType {
        // BNF: LPAREN NL* type NL* RPAREN
        let lp = LocalParser(node.children)
        let lParenPos = startPos
        lp.moveOffset(lp.consume(kind: SyntaxNodeKind.LParenToken))
        let curNode = lp.consume()
        let subTypePropInfo = PropInfo(lp.cur - 1, lp.offset)
        lp.moveOffset(curNode)
        lp.consume(kind: SyntaxNodeKind.RParenToken)
        let rParenPos = startPos + lp.offset

        let posInfo = ParenTypePosInfos(lParenPos, rParenPos)
        let propInfo = ParenTypePropInfos(subTypePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        ParenType(node, startPos, parent, posInfo, propInfo, commentsPropInfos)
    }

    private func transPrefixType(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): PrefixType {
        // BNF: prefixTypeOperator type
        let lp = LocalParser(node.children)
        var prefixTypeOpKind = PrefixTypeOpKind.Quest

        let prefixTypeOpPos = startPos
        let prefix = lp.consume()
        if (let Some(pre) <- prefix) {
            prefixTypeOpKind = match (pre.kind) {
                case SyntaxNodeKind.QuestToken => PrefixTypeOpKind.Quest
                case _ =>
                    fail("unsupported prefixTypeOperator")
                    PrefixTypeOpKind.Quest
            }
            lp.moveOffset(pre)
        }
        lp.consume()
        let baseTypePropInfo = PropInfo(lp.cur - 1, lp.offset)

        let posInfo = PrefixTypePosInfos(prefixTypeOpPos)
        let propInfo = PrefixTypePropInfos(baseTypePropInfo)
        lp.consumeToEnd()
        let commentsPropInfos = lp.commentGroupListPropInfos.toArray()
        PrefixType(node, startPos, parent, posInfo, propInfo, prefixTypeOpKind, commentsPropInfos)
    }
}

class LocalParser {
    var cur: Int64 = 0
    private let end: Int64
    let offset: Offset
    let commentGroupListPropInfos: ArrayList<PropInfo> = ArrayList<PropInfo>()

    LocalParser(let nodes: Array<SyntaxNodeImpl>) {
        end = nodes.size
        offset = Offset()
    }

    init(nodes: Array<SyntaxNodeImpl>, off: Offset, index!: Int64 = 0) {
        this.nodes = nodes
        end = nodes.size
        offset = Offset(off.line, off.column)
        cur = index
    }

    // try look up one token, and consume it
    func lookAndConsume(kind: SyntaxNodeKind): ?SyntaxNodeImpl {
        var ret: ?SyntaxNodeImpl = None
        if (look(kind)) {
            return consume()
        }
        return ret
    }

    // consume one token non white space token.
    func consume(): ?SyntaxNodeImpl {
        var ret: ?SyntaxNodeImpl = None
        consumeWhitespace()
        if (!isEnd()) {
            ret = nodes[cur]
            cur++
        } else {
            fail("expect node but empty")
        }
        ret
    }

    // consume one node, can be empty.
    func tryConsume(): ?SyntaxNodeImpl {
        var ret: ?SyntaxNodeImpl = None
        consumeWhitespace()
        if (!isEnd()) {
            ret = nodes[cur]
            cur++
        }
        ret
    }

    // consume one token with kind.
    func consume(kind!: SyntaxNodeKind): ?SyntaxNodeImpl {
        var ret: ?SyntaxNodeImpl = None
        consumeWhitespace()
        if (!isEnd()) {
            if (nodes[cur].kind == kind) {
                ret = nodes[cur]
                cur++
            } else {
                fail("expect ${kind} but get ${nodes[cur].kind}")
            }
        } else {
            fail("expect node but empty")
        }
        ret
    }

    // consume list: node sep? node -> [node, node] when node with kind and record pos.
    func consumeListOfPos(startPos: CodePosition, kind!: SyntaxNodeKind, sep!: ?SyntaxNodeKind = None): (ArrayList<SyntaxNodeImpl>, 
        ArrayList<CodePosition>, ArrayList<CodePosition>) {
        var (ret, pos1, pos2) = (ArrayList<SyntaxNodeImpl>(), ArrayList<CodePosition>(), ArrayList<CodePosition>())
        while (look(kind)) {
            if (let Some(node) <- consume(kind: kind)) {
                ret.add(node)
                pos1.add(startPos + offset)
                moveOffset(node)
            }
            if (let Some(sp) <- sep && look(sp)) {
                let spp = consume(kind: sp)
                pos2.add(startPos + offset)
                moveOffset(spp)
            }
        }
        (ret, pos1, pos2)
    }

    // look ahead one token with kind.
    func look(kind: SyntaxNodeKind): Bool {
        if (let Some(top) <- peek() && top.kind == kind) {
            true
        } else {
            false
        }
    }

    // look ahead one token with multi kinds.
    func look(kinds: Array<SyntaxNodeKind>): ?SyntaxNodeKind {
        if (let Some(top) <- peek()) {
            for (kind in kinds) {
                if (top.kind == kind) {
                    return kind
                }
            }
        }
        return None
    }

    // look ahead one token when predict(token) is true.
    func look(predict: (SyntaxNodeKind) -> Bool): Bool {
        if (let Some(top) <- peek() && predict(top.kind)) {
            true
        } else {
            false
        }
    }

    func isEnd(): Bool {
        cur >= end
    }

    private func peek(): ?SyntaxNodeImpl {
        consumeWhitespace()
        if (!isEnd()) {
            nodes[cur]
        } else {
            None
        }
    }

    func moveOffset(node: ?SyntaxNodeImpl) {
        offset.moveNode(node)
    }

    func consumeWhitespace() {
        while (!isEnd()) {
            if (nodes[cur].kind.isWhitespace()) {
                moveOffset(nodes[cur])
                cur++
            } else if (nodes[cur].kind == CommentGroupList) {
                commentGroupListPropInfos.add(PropInfo(cur, offset))
                moveOffset(nodes[cur])
                cur++
            } else {
                break
            }
        }
    }

    func consumeToEnd() {
        while (!isEnd()) {
            moveOffset(tryConsume())
        }
    }
}

func cast<T>(node: ?SyntaxTreeNode): ?T where T <: SyntaxTreeNode {
    if (let Some(value) <- node) {
        value as T
    } else {
        None
    }
}

func getValue(s: SyntaxNodeImpl): String {
    if (let Some(vt) <- (s as ValuedTerminal)) {
        vt.value
    } else {
        ""
    }
}
