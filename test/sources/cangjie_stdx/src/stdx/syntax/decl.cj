/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList

private func createPositionRange(pos: CodePosition, size: Int64): CodePositionRange {
    return CodePositionRange(pos, pos + size)
}

private func createOptionalTokenRange(pos: Option<CodePosition>, size: Int64): Option<CodePositionRange> {
    if (let Some(v) <- pos) {
        return createPositionRange(v, size)
    }
    return None
}

private func createTokenRanges(positions: Array<CodePosition>, size: Int64): Array<CodePositionRange> {
    let ret = ArrayList<CodePositionRange>()
    for (pos in positions) {
        ret.add(createPositionRange(pos, size))
    }
    return ret.toArray()
}

private func translateChild<T>(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfo: PropInfo): T where T <: SyntaxTreeNode {
    let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
    return cast<T>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, parentNode)).getOrThrow()
}

private func translateOptionalChild<T>(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfo: Option<PropInfo>): Option<T> where T <: SyntaxTreeNode {
    if (let Some(v) <- propInfo) {
        return translateChild<T>(nodeImpl, startPos, parentNode, v)
    }
    return None
}

private func translateChildList<T>(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfos: Array<PropInfo>): Array<T> where T <: SyntaxTreeNode {
    let nodes = ArrayList<T>()
    for (propInfo in propInfos) {
        nodes.add(translateChild<T>(nodeImpl, startPos, parentNode, propInfo))
    }
    return nodes.toArray()
}

private func translateGenericParams(node: SyntaxNodeImpl, startPos: CodePosition,
    parentNode: ?SyntaxTreeNode): ArrayList<GenericParam> {
    // BNF :LT GenericParam (Comma GenericParam)* GT
    let lp = LocalParser(((node as NonTerminal).getOrThrow()).children)
    let typeArguments = ArrayList<GenericParam>()
    lp.offset.move(lp.consume().getOrThrow().offset)
    while (!lp.look(SyntaxNodeKind.GtToken)) {
        var impl = lp.consume()
        typeArguments.add(
            cast<GenericParam>(SyntaxNodeImplTranslator.translate(impl.getOrThrow(), startPos + lp.offset, parentNode))
                .getOrThrow())
        lp.offset.move(impl.getOrThrow().offset)
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
            lp.offset.move(v.offset)
        }
    }
    return typeArguments
}

private func translateOptionalGenericParams(nodeImpl: SyntaxNodeImpl, startPos: CodePosition,
    parentNode: ?SyntaxTreeNode, propInfo: Option<PropInfo>): Array<GenericParam> {
    let typeArguments = ArrayList<GenericParam>()
    if (let Some(v) <- propInfo) {
        let curNode = (nodeImpl as NonTerminal).getOrThrow().children[v.index]
        return translateGenericParams(curNode, startPos + v.offset, parentNode).toArray()
    }
    return typeArguments.toArray()
}

/**
 * @brief Represents a declaration in the abstract syntax tree (AST).
 *
 * This abstract class is used as a base class for various types of
 * declarations in the syntax tree.
 */
sealed abstract class Decl <: SyntaxTreeNode {
    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(nodePos, nodeImpl, parentNode, commentsPropInfo)
    }

    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
    }

    /**
     * @brief The array of annotations applied to the declaration.
     *
     * This variable holds an array of annotations that are applied to
     * the declaration. Annotations can provide additional metadata or
     * modify the behavior of the declaration.
     */
    public prop annotations: Array<Annotation> {
        get() {
            var annos = Array<Annotation>()
            var offset = Offset()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, offset)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
                annos = SyntaxNodeImplTranslator.translateList<Annotation>(v,
                    CodePosition(nodePos.beginLine, nodePos.beginColumn, FileInfos(nodePos.fileName, nodePos.filePath)) +
                        lp.offset, this)
            }
            return annos
        }
    }

    /**
     * @brief The array of modifiers applied to the declaration.
     *
     * This variable holds an array of modifiers that are applied to
     * the declaration. Modifiers can affect the visibility, mutability,
     * or other properties of the declaration.
     */
    public prop modifiers: Array<Modifier> {
        get() {
            var modis = Array<Modifier>()
            var offset = Offset()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, offset)

            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.AnnotationList)) {
                lp.offset.move(v.offset)
            }
            if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.ModifierList)) {
                modis = SyntaxNodeImplTranslator.translateList<Modifier>(v,
                    CodePosition(nodePos.beginLine, nodePos.beginColumn, FileInfos(nodePos.fileName, nodePos.filePath)) +
                        lp.offset, this)
            }
            return modis
        }
    }
}

class ClassDeclPropInfos {
    let bodyPropInfo: PropInfo
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let superTyAnnotationsPropInfo: Array<PropInfo>

    init(
        bodyPropInfo: PropInfo,
        genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>,
        superTyAnnotationsPropInfo: Array<PropInfo>
    ) {
        this.bodyPropInfo = bodyPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.superTyAnnotationsPropInfo = superTyAnnotationsPropInfo
    }
}

class ClassDeclPosInfos {
    let classKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let upperBoundPos: Option<CodePosition>
    let superTyAnnotationsBitAndsPos: Array<CodePosition>

    init(
        classKeyWordPos: CodePosition,
        identifierPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>,
        genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>,
        upperBoundPos: Option<CodePosition>,
        superTyAnnotationsBitAndsPos: Array<CodePosition>
    ) {
        this.classKeyWordPos = classKeyWordPos
        this.identifierPos = identifierPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.upperBoundPos = upperBoundPos
        this.superTyAnnotationsBitAndsPos = superTyAnnotationsBitAndsPos
    }
}

/**
 * @brief Represents a class declaration.
 *
 * This class is used to represent a class declaration.
 */
public class ClassDecl <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: ClassDeclPropInfos

    private let posInfos: ClassDeclPosInfos

    public func getClassKeyWordPos(): CodePositionRange {
        let endPos = posInfos.classKeyWordPos + SyntaxNodeKind.ClassToken.size
        CodePositionRange(posInfos.classKeyWordPos, endPos)
    }
    public func getIdentifierPos(): CodePositionRange {
        return createPositionRange(posInfos.identifierPos, name.size)
    }
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsLAnglePos, SyntaxNodeKind.LtToken.size)
    }
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.genericParamsCommasPos, SyntaxNodeKind.CommaToken.size)
    }
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsRAnglePos, SyntaxNodeKind.GtToken.size)
    }
    public func getUpperBoundPos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.upperBoundPos, SyntaxNodeKind.UpperBoundToken.size)
    }
    public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.superTyAnnotationsBitAndsPos, SyntaxNodeKind.BitAndToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: ClassDeclPosInfos, propInfos: ClassDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new ClassDecl node.
     */
    public init(body: Body, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createClassDeclImpl(body, genericConstraints, genericParams, name, superTyAnnotations,
                annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ClassDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the class decl.
     *
     * This variable represents the body of the declaration, which can
     * contain member declarations.
     */
    public prop body: Body {
        get() {
            return translateChild<Body>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The optional set of generic constraints on the declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief The name of the declaration.
     *
     * This variable holds the name of the declaration.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of type annotations for the declaration's supertypes.
     *
     * This variable holds an array of type annotations that represent
     * the supertypes of the declaration.
     */
    public prop superTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.superTyAnnotationsPropInfo)
        }
    }
}

class EnumConstructorPropInfos {
    let paramTyAnnotationsPropInfo: Array<PropInfo>

    init(paramTyAnnotationsPropInfo: Array<PropInfo>) {
        this.paramTyAnnotationsPropInfo = paramTyAnnotationsPropInfo
    }
}

class EnumConstructorPosInfos {
    let identifierPos: CodePosition
    let paramsLParenPos: Option<CodePosition>
    let paramsCommasPos: Array<CodePosition>
    let paramsRParenPos: Option<CodePosition>

    init(
        identifierPos: CodePosition,
        paramsLParenPos: Option<CodePosition>,
        paramsCommasPos: Array<CodePosition>,
        paramsRParenPos: Option<CodePosition>
    ) {
        this.identifierPos = identifierPos
        this.paramsLParenPos = paramsLParenPos
        this.paramsCommasPos = paramsCommasPos
        this.paramsRParenPos = paramsRParenPos
    }
}

/**
 * @brief Represents an enum constructor in the abstract syntax tree (AST).
 *
 * This class is used to represent an enum constructor.
 */
public class EnumConstructor <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: EnumConstructorPropInfos

    private let posInfos: EnumConstructorPosInfos

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + name.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Get the position range of the left parenthesis in the parameter list if present.
     */
    public func getParamsLParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.paramsLParenPos) {
            let endPos = v + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position ranges of commas in the parameter list.
     */
    public func getParamsCommasPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.paramsCommasPos.size) {
            let endPos = posInfos.paramsCommasPos[i] + SyntaxNodeKind.CommaToken.size
            ret.add(CodePositionRange(posInfos.paramsCommasPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Get the position range of the right parenthesis in the parameter list if present.
     */
    public func getParamsRParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.paramsRParenPos) {
            let endPos = v + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: EnumConstructorPosInfos, propInfos: EnumConstructorPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new EnumConstructor node.
     */
    public init(name: String, paramTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createEnumConstructorImpl(name, paramTyAnnotations, annotations: annotations,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<EnumConstructor>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The name of the enum constructor.
     *
     * This variable holds the name of the enum constructor.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of type annotations for the constructor's parameters.
     *
     * This variable holds an array of type annotations that represent
     * the types of the constructor's parameters.
     */
    public prop paramTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.paramTyAnnotationsPropInfo)
        }
    }
}

class EnumDeclPropInfos {
    let bodyPropInfo: PropInfo
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let superTyAnnotationsPropInfo: Array<PropInfo>

    init(
        bodyPropInfo: PropInfo,
        genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>,
        superTyAnnotationsPropInfo: Array<PropInfo>
    ) {
        this.bodyPropInfo = bodyPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.superTyAnnotationsPropInfo = superTyAnnotationsPropInfo
    }
}

class EnumDeclPosInfos {
    let enumKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let upperBoundPos: Option<CodePosition>
    let superTyAnnotationsBitAndsPos: Array<CodePosition>
    let caseSeparatorsPos: Array<CodePosition>
    let nonExhaustiveTripleDotPos: Option<CodePosition>

    init(
        enumKeyWordPos: CodePosition,
        identifierPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>,
        genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>,
        upperBoundPos: Option<CodePosition>,
        superTyAnnotationsBitAndsPos: Array<CodePosition>,
        caseSeparatorsPos: Array<CodePosition>,
        nonExhaustiveTripleDotPos: Option<CodePosition>
    ) {
        this.enumKeyWordPos = enumKeyWordPos
        this.identifierPos = identifierPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.upperBoundPos = upperBoundPos
        this.superTyAnnotationsBitAndsPos = superTyAnnotationsBitAndsPos
        this.caseSeparatorsPos = caseSeparatorsPos
        this.nonExhaustiveTripleDotPos = nonExhaustiveTripleDotPos
    }
}

/**
 * @brief Represents an enum declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent an enum declaration in the syntax tree.
 */
public class EnumDecl <: Decl {
    private let isNonExhaustive_: Bool

    private let name_: String

    private let startPos: CodePosition

    private let propInfos: EnumDeclPropInfos

    private let posInfos: EnumDeclPosInfos

    /**
     * @brief Get the position range of the 'enum' keyword.
     */
    public func getEnumKeyWordPos(): CodePositionRange {
        let endPos = posInfos.enumKeyWordPos + SyntaxNodeKind.EnumToken.size
        CodePositionRange(posInfos.enumKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        return createPositionRange(posInfos.identifierPos, name.size)
    }

    /**
     * @brief Get the position range of the left angle bracket for generic parameters if present.
     */
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsLAnglePos, SyntaxNodeKind.LtToken.size)
    }

    /**
     * @brief Get the position ranges of commas in generic parameters.
     */
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.genericParamsCommasPos, SyntaxNodeKind.CommaToken.size)
    }

    /**
     * @brief Get the position range of the right angle bracket for generic parameters if present.
     */
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsRAnglePos, SyntaxNodeKind.GtToken.size)
    }

    /**
     * @brief Get the position range of the upper bound token if present.
     */
    public func getUpperBoundPos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.upperBoundPos, SyntaxNodeKind.UpperBoundToken.size)
    }

    /**
     * @brief Get the position ranges of bit-and tokens in super type annotations.
     */
    public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.superTyAnnotationsBitAndsPos, SyntaxNodeKind.BitAndToken.size)
    }

    /**
     * @brief Get the position ranges of case separators.
     */
    public func getCaseSeparatorsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.caseSeparatorsPos.size) {
            let endPos = posInfos.caseSeparatorsPos[i] + SyntaxNodeKind.BitOrToken.size
            ret.add(CodePositionRange(posInfos.caseSeparatorsPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Get the position range of the non-exhaustive triple dot token if present.
     */
    public func getNonExhaustiveTripleDotPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.nonExhaustiveTripleDotPos) {
            let endPos = v + SyntaxNodeKind.EllipsisToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, isNonExhaustive_: Bool,
        name_: String, posInfos: EnumDeclPosInfos, propInfos: EnumDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.isNonExhaustive_ = isNonExhaustive_
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new EnumDecl node.
     */
    public init(body: Body, constructors: Array<EnumConstructor>, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, isNonExhaustive: Bool, name: String,
        superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createEnumDeclImpl(body, constructors, genericConstraints, genericParams,
                isNonExhaustive, name, superTyAnnotations, annotations: annotations, modifiers: modifiers,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<EnumDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.isNonExhaustive_ = isNonExhaustive
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the enum declaration.
     *
     * This variable represents the body of the enum declaration, which can
     * contain member declarations.
     */
    public prop body: Body {
        get() {
            return translateChild<Body>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The optional set of generic constraints on the enum declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the enum declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the enum declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the enum declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief Indicates whether the enum declaration is non-exhaustive.
     *
     * This variable is a boolean flag that indicates whether the enum
     * declaration is non-exhaustive.
     */
    public prop isNonExhaustive: Bool {
        get() {
            isNonExhaustive_
        }
    }

    /**
     * @brief The name of the enum declaration.
     *
     * This variable holds the name of the enum declaration.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of type annotations for the declaration's supertypes.
     *
     * This variable holds an array of type annotations that represent
     * the supertypes of the enum declaration.
     */
    public prop superTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.superTyAnnotationsPropInfo)
        }
    }
}

class ExtendDeclPropInfos {
    let bodyPropInfo: PropInfo
    let extendedTyAnnotationPropInfo: PropInfo
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let superTyAnnotationsPropInfo: Array<PropInfo>

    init(
        bodyPropInfo: PropInfo,
        extendedTyAnnotationPropInfo: PropInfo,
        genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>,
        superTyAnnotationsPropInfo: Array<PropInfo>
    ) {
        this.bodyPropInfo = bodyPropInfo
        this.extendedTyAnnotationPropInfo = extendedTyAnnotationPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.superTyAnnotationsPropInfo = superTyAnnotationsPropInfo
    }
}

class ExtendDeclPosInfos {
    let extendKeyWordPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let upperBoundPos: Option<CodePosition>
    let superTyAnnotationsBitAndsPos: Array<CodePosition>

    init(
        extendKeyWordPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>,
        genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>,
        upperBoundPos: Option<CodePosition>,
        superTyAnnotationsBitAndsPos: Array<CodePosition>
    ) {
        this.extendKeyWordPos = extendKeyWordPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.upperBoundPos = upperBoundPos
        this.superTyAnnotationsBitAndsPos = superTyAnnotationsBitAndsPos
    }
}

/**
 * @brief Represents an extension declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent an extension declaration in the syntax tree.
 */
public class ExtendDecl <: Decl {
    private let startPos: CodePosition

    private let propInfos: ExtendDeclPropInfos

    private let posInfos: ExtendDeclPosInfos

    /**
     * @brief Get the position range of the 'extend' keyword.
     */
    public func getExtendKeyWordPos(): CodePositionRange {
        let endPos = posInfos.extendKeyWordPos + SyntaxNodeKind.ExtendToken.size
        CodePositionRange(posInfos.extendKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the left angle bracket for generic parameters if present.
     */
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsLAnglePos, SyntaxNodeKind.LtToken.size)
    }

    /**
     * @brief Get the position ranges of commas in generic parameters.
     */
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.genericParamsCommasPos, SyntaxNodeKind.CommaToken.size)
    }

    /**
     * @brief Get the position range of the right angle bracket for generic parameters if present.
     */
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsRAnglePos, SyntaxNodeKind.GtToken.size)
    }

    /**
     * @brief Get the position range of the upper bound token if present.
     */
    public func getUpperBoundPos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.upperBoundPos, SyntaxNodeKind.UpperBoundToken.size)
    }

    /**
     * @brief Get the position ranges of bit-and tokens in super type annotations.
     */
    public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.superTyAnnotationsBitAndsPos, SyntaxNodeKind.BitAndToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ExtendDeclPosInfos,
        propInfos: ExtendDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new ExtendDecl node.
     */
    public init(body: Body, extendedTyAnnotation: TypeAnnotation, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, superTyAnnotations: Array<TypeAnnotation>,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createExtendDeclImpl(body, extendedTyAnnotation, genericConstraints, genericParams,
                superTyAnnotations, annotations: annotations, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ExtendDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the extension declaration.
     *
     * This variable represents the body of the extension declaration, which can
     * contain member declarations.
     */
    public prop body: Body {
        get() {
            return translateChild<Body>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The type annotation of the extended type.
     *
     * This variable holds the type annotation that represents the type being
     * extended by the extension declaration.
     */
    public prop extendedTyAnnotation: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.extendedTyAnnotationPropInfo.index]
            let offset = propInfos.extendedTyAnnotationPropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The optional set of generic constraints on the extension declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the extension declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the extension declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the extension declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief The array of type annotations for the declaration's supertypes.
     *
     * This variable holds an array of type annotations that represent
     * the supertypes of the extension declaration.
     */
    public prop superTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.superTyAnnotationsPropInfo)
        }
    }
}

/**
 * @brief Represents the kind of a function declaration.
 *
 * This enum is used to represent the different kinds of function declarations
 * that can exist in the syntax tree. It provides a way to distinguish between
 * constructors, foreign functions, normal functions, operator overloads, and
 * primary constructors.
 */
public enum FuncKind {
    | Constructor // Functions that are constructors, responsible for initializing objects.
    | Finalizer // Functions that are finalizers, responsible for performing cleanup operations before an object is garbage collected.
    | Foreign // Functions that are foreign, typically defined in another language.
    | Normal // Standard functions that perform a specific task.
    | Operator // Functions that overload operators for custom behavior.
    | PrimaryConstructor // Functions that are primary constructors, often used in class definitions.
    | ...
}

class FuncDeclPropInfos {
    let bodyPropInfo: Option<PropInfo>
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let paramsPropInfo: PropInfo
    let retTyAnnotationPropInfo: Option<PropInfo>

    init(bodyPropInfo: Option<PropInfo>, genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>, paramsPropInfo: PropInfo, retTyAnnotationPropInfo: Option<PropInfo>) {
        this.bodyPropInfo = bodyPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.paramsPropInfo = paramsPropInfo
        this.retTyAnnotationPropInfo = retTyAnnotationPropInfo
    }
}

class FuncDeclPosInfos {
    let funcKindKeyWordPos: Option<CodePosition>
    let funcKeyWordPos: Option<CodePosition>
    let identifierPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let retTyAnnotationColonPos: Option<CodePosition>

    init(funcKindKeyWordPos: Option<CodePosition>, funcKeyWordPos: Option<CodePosition>, identifierPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>, genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>, retTyAnnotationColonPos: Option<CodePosition>) {
        this.funcKindKeyWordPos = funcKindKeyWordPos
        this.funcKeyWordPos = funcKeyWordPos
        this.identifierPos = identifierPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.retTyAnnotationColonPos = retTyAnnotationColonPos
    }
}
/**
 * @brief Represents a function declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a function declaration in the syntax tree.
 */
public class FuncDecl <: Decl {
    private let name_: String

    private let kind_: FuncKind

    private let startPos: CodePosition

    private let propInfos: FuncDeclPropInfos

    private let posInfos: FuncDeclPosInfos

    /**
     * @brief Get the position range of the 'func' keyword in the code.
     *
     * @return Option<CodePositionRange> representing the position range of the 'func' keyword.
     */
    public func getFuncKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.funcKeyWordPos) {
            let endPos = v + SyntaxNodeKind.FuncToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the function kind keyword in the code.
     * Finalizer: '~', Operator/Foreign: operator modifier Pos
     * @return Option<CodePositionRange> representing the position range of the function kind keyword.
     */
    public func getFuncKindKeyWordPos(): Option<CodePositionRange> {
        match (kind) {
            case Finalizer =>
                if (let Some(v) <- posInfos.funcKindKeyWordPos) {
                    return CodePositionRange(v, v + SyntaxNodeKind.BitNotToken.size)
                }
            case Foreign =>
                if (let Some(v) <- posInfos.funcKindKeyWordPos) {
                    return CodePositionRange(v, v + SyntaxNodeKind.ForeignToken.size)
                }
            case _ => ()
        }
        for (modifier in modifiers) {
            match (modifier.kind) {
                case ModifierKind.Operator => return modifier.nodePos
                case _ => continue
            }
        }
        return None
    }

    /**
     * @brief Get the positions of commas in generic parameters.
     *
     * @return Array<CodePositionRange> containing the positions of commas.
     */
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        let commasPos = ArrayList<CodePositionRange>()
        for (comma in posInfos.genericParamsCommasPos) {
            commasPos.add(CodePositionRange(comma, comma + SyntaxNodeKind.CommaToken.size))
        }
        return commasPos.toArray()
    }

    /**
     * @brief Get the position of the left angle bracket in generic parameters.
     *
     * @return Option<CodePositionRange> representing the position of the left angle bracket.
     */
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.genericParamsLAnglePos) {
            return CodePositionRange(v, v + SyntaxNodeKind.LtToken.size)
        }
        return None
    }

    /**
     * @brief Get the position of the right angle bracket in generic parameters.
     *
     * @return Option<CodePositionRange> representing the position of the right angle bracket.
     */
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.genericParamsRAnglePos) {
            return CodePositionRange(v, v + SyntaxNodeKind.GtToken.size)
        }
        return None
    }

    /**
     * @brief Get the position range of the identifier in the code.
     *
     * @return CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        var nameSize = name.size
        if (name == "~init") {
            nameSize = nameSize - 1
        }
        let endPos = posInfos.identifierPos + nameSize
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Get the position of the colon in the return type annotation.
     *
     * @return Option<CodePositionRange> representing the position of the colon.
     */
    public func getRetTyAnnotationColonPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.retTyAnnotationColonPos) {
            return CodePositionRange(v, v + SyntaxNodeKind.ColonToken.size)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String, kind_: FuncKind,
        posInfos: FuncDeclPosInfos, propInfos: FuncDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.kind_ = kind_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new FuncDecl node.
     */
    public init(body: Option<Block>, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        kind: FuncKind, name: String, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createFuncDeclImpl(body, genericConstraints, genericParams, kind, name, params,
                retTyAnnotation, annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<FuncDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.kind_ = kind
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The optional block representing the body of the function.
     *
     * This variable holds an optional block that represents the body of the
     * function. The block contains the statements that make up the function's
     * implementation.
     */
    public prop body: Option<Block> {
        get() {
            if (let Some(propInfo) <- propInfos.bodyPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The optional set of generic constraints on the function declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the function declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the function declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the function declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief The kind of the function declaration.
     *
     * This variable represents the kind of the function declaration, which can
     * be one of several variants such as Constructor, Foreign, Normal, Operator,
     * or PrimaryConstructor.
     */
    public prop kind: FuncKind {
        get() {
            kind_
        }
    }

    /**
     * @brief The name of the function declaration.
     *
     * This variable holds the name of the function declaration.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of function parameters.
     *
     * This variable holds an array of function parameters, each of which
     * has a name and a type annotation.
     */
    public prop params: ParameterList {
        get() {
            return translateChild<ParameterList>(nodeImpl, startPos, this, propInfos.paramsPropInfo)
        }
    }

    /**
     * @brief The optional return type annotation of the function.
     *
     * This variable holds an optional type annotation that represents
     * the return type of the function.
     */
    public prop retTyAnnotation: Option<TypeAnnotation> {
        get() {
            return translateOptionalChild<TypeAnnotation>(nodeImpl, startPos, this, propInfos.retTyAnnotationPropInfo)
        }
    }
}

sealed abstract class Parameter <: Decl {
    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(nodePos, nodeImpl, parentNode, commentsPropInfo)
    }

    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
    }
}

class LambdaParamPropInfos {
    let typeAnnotationPropInfo: Option<PropInfo>

    init(typeAnnotationPropInfo: Option<PropInfo>) {
        this.typeAnnotationPropInfo = typeAnnotationPropInfo
    }
}

class LambdaParamPosInfos {
    let identifierPos: CodePosition
    let typeAnnotationColonPos: Option<CodePosition>

    init(
        identifierPos: CodePosition,
        typeAnnotationColonPos: Option<CodePosition>
    ) {
        this.identifierPos = identifierPos
        this.typeAnnotationColonPos = typeAnnotationColonPos
    }
}

public open class LambdaParam <: Parameter {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: LambdaParamPropInfos

    /**
     * @brief Get the position range of the identifier.
     *
     * @return CodePositionRange representing the identifier's position.
     */
    public func getIdentifierPos(): CodePositionRange {
        return CodePositionRange(posInfos.identifierPos, posInfos.identifierPos + name.size)
    }
    /**
     * @brief Get the position range of the type annotation colon.
     *
     * @return Option<CodePositionRange> representing the position of the colon, or None if it doesn't exist.
     */
    public func getTypeAnnotationColonPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.typeAnnotationColonPos) {
            return CodePositionRange(v, v + SyntaxNodeKind.ColonToken.size)
        }
        return None
    }

    private let posInfos: LambdaParamPosInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfo: LambdaParamPosInfos, propInfo: LambdaParamPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.name_ = name_
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize a new LambdaParam node.
     */
    public init(name: String, typeAnnotation: Option<TypeAnnotation>, comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createLambdaParamImpl(name, typeAnnotation, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<LambdaParam>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The name of the lambda parameter as a String.
     */
    public prop name: String {
        get() {
            name_
        }
    }
    /**
     * @brief The type annotation associated with the lambda parameter, if any.
     */
    public prop typeAnnotation: Option<TypeAnnotation> {
        get() {
            if (let Some(propInfo) <- propInfos.typeAnnotationPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}

class FuncParamPropInfos {
    let defaultValuePropInfo: Option<PropInfo>
    let typeAnnotationPropInfo: PropInfo

    init(
        defaultValuePropInfo: Option<PropInfo>,
        typeAnnotationPropInfo: PropInfo
    ) {
        this.defaultValuePropInfo = defaultValuePropInfo
        this.typeAnnotationPropInfo = typeAnnotationPropInfo
    }
}

class FuncParamPosInfos {
    let varKindKeyWordPos: Option<CodePosition>
    let identifierPos: CodePosition
    let typeAnnotationColonPos: CodePosition
    let assignPos: Option<CodePosition>
    let notPos: Option<CodePosition>

    init(
        varKindKeyWordPos: Option<CodePosition>,
        identifierPos: CodePosition,
        typeAnnotationColonPos: CodePosition,
        assignPos: Option<CodePosition>,
        notPos: Option<CodePosition>
    ) {
        this.varKindKeyWordPos = varKindKeyWordPos
        this.identifierPos = identifierPos
        this.typeAnnotationColonPos = typeAnnotationColonPos
        this.assignPos = assignPos
        this.notPos = notPos
    }
}

/**
 * @brief Represents a function parameter in the abstract syntax tree (AST).
 *
 * This class is used to represent a function parameter in the syntax tree.
 */
public open class FuncParam <: Parameter {
    private let kind_: Option<VarKind>

    private let name_: String

    private let startPos: CodePosition

    private let propInfos: FuncParamPropInfos

    private let posInfos: FuncParamPosInfos

    /**
     * @brief Get the position of the assignment operator.
     *
     * @return Option<PositionRange> representing the position of the assignment operator.
     */
    public func getAssignPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.assignPos) {
            return CodePositionRange(v, v + SyntaxNodeKind.AssignToken.size)
        }
        return None
    }
    /**
     * @brief Get the position range of the identifier.
     *
     * @return CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        return CodePositionRange(posInfos.identifierPos, posInfos.identifierPos + name.size)
    }

    /**
     * @brief Get the position of the 'not' keyword.
     *
     * @return Option<CodePositionRange> representing the position of the 'not' keyword.
     */
    public func getNotPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.notPos) {
            return CodePositionRange(v, v + SyntaxNodeKind.NotToken.size)
        }
        return None
    }

    /**
     * @brief Get the position of the colon in the type annotation.
     *
     * @return Option<CodePositionRange> representing the position of the colon.
     */
    public func getTypeAnnotationColonPos(): CodePositionRange {
        return CodePositionRange(posInfos.typeAnnotationColonPos,
            posInfos.typeAnnotationColonPos + SyntaxNodeKind.ColonToken.size)
    }

    /**
     * @brief Gets the position range of the variable kind keyword in the declaration if present.
     *
     * @return Option<CodePositionRange> representing the position range of the variable kind keyword.
     */
    public func getVarKindKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.varKindKeyWordPos && let Some(k) <- kind) {
            let varKindSize = match (k) {
                case VarKind.Let => SyntaxNodeKind.LetToken.size
                case VarKind.Var => SyntaxNodeKind.VarToken.size
                case _ => throw Exception("ParseException: " + "unexpected VarKind keyword")
            }
            return CodePositionRange(v, v + varKindSize)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: Option<VarKind>,
        name_: String, posInfo: FuncParamPosInfos, propInfo: FuncParamPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.kind_ = kind_
        this.name_ = name_
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize a new FuncParam node.
     */
    public init(defaultValue: Option<Expr>, kind: Option<VarKind>, name: String, typeAnnotation: TypeAnnotation,
        isNamed!: Bool = false, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createFuncParamImpl(defaultValue, kind, name, typeAnnotation, isNamed: isNamed,
                annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<FuncParam>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.kind_ = kind
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The optional default value for the parameter.
     *
     * This variable holds an optional expression that represents the default
     * value for the parameter. If a default value is provided, the parameter
     * can be omitted when calling the function.
     */
    public prop defaultValue: Option<Expr> {
        get() {
            if (let Some(valuePropInfo) <- propInfos.defaultValuePropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[valuePropInfo.index]
                let offset = valuePropInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The kind of the variable declaration if present.
     *
     * This variable specifies the kind of the variable declaration using the
     * VarKind enum, which can be Let or Var.
     */
    public prop kind: Option<VarKind> {
        get() {
            kind_
        }
    }

    /**
     * @brief The name of the function parameter.
     *
     * This variable holds the name of the function parameter, which can be
     * used to identify and reference the parameter within the function body.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The type annotation of the function parameter.
     *
     * This variable holds the type annotation that represents the type of
     * the function parameter. The type annotation specifies the expected
     * type of the argument that must be passed to the function.
     */
    public prop typeAnnotation: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.typeAnnotationPropInfo.index]
            let offset = propInfos.typeAnnotationPropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

/**
 * @brief Represents a generic parameter in the abstract syntax tree (AST).
 *
 * This class is used to represent a generic parameter in the syntax tree.
 */
public class GenericParam <: Decl {
    private let name_: String

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name: String,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name
    }

    /**
     * @brief Initialize a new GenericParam node.
     */
    public init(name: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createGenericParamImpl(name, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<GenericParam>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.name_ = name
    }

    /**
     * @brief The name of the generic parameter.
     *
     * This variable holds the name of the generic parameter.
     */
    public prop name: String {
        get() {
            name_
        }
    }
}

class InterfaceDeclPropInfos {
    let bodyPropInfo: PropInfo
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let superTyAnnotationsPropInfo: Array<PropInfo>

    init(
        bodyPropInfo: PropInfo,
        genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>,
        superTyAnnotationsPropInfo: Array<PropInfo>
    ) {
        this.bodyPropInfo = bodyPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.superTyAnnotationsPropInfo = superTyAnnotationsPropInfo
    }
}

class InterfaceDeclPosInfos {
    let interfaceKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let upperBoundPos: Option<CodePosition>
    let superTyAnnotationsBitAndsPos: Array<CodePosition>

    init(
        interfaceKeyWordPos: CodePosition,
        identifierPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>,
        genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>,
        upperBoundPos: Option<CodePosition>,
        superTyAnnotationsBitAndsPos: Array<CodePosition>
    ) {
        this.interfaceKeyWordPos = interfaceKeyWordPos
        this.identifierPos = identifierPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.upperBoundPos = upperBoundPos
        this.superTyAnnotationsBitAndsPos = superTyAnnotationsBitAndsPos
    }
}

/**
 * @brief Represents an interface declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent an interface declaration in the syntax tree.
 */
public class InterfaceDecl <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: InterfaceDeclPropInfos

    private let posInfos: InterfaceDeclPosInfos

    /**
     * @brief Get the position range of the 'interface' keyword.
     */
    public func getInterfaceKeyWordPos(): CodePositionRange {
        let endPos = posInfos.interfaceKeyWordPos + SyntaxNodeKind.InterfaceToken.size
        CodePositionRange(posInfos.interfaceKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        return createPositionRange(posInfos.identifierPos, name.size)
    }

    /**
     * @brief Get the position range of the left angle bracket for generic parameters if present.
     */
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsLAnglePos, SyntaxNodeKind.LtToken.size)
    }

    /**
     * @brief Get the position ranges of commas in generic parameters.
     */
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.genericParamsCommasPos, SyntaxNodeKind.CommaToken.size)
    }

    /**
     * @brief Get the position range of the right angle bracket for generic parameters if present.
     */
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsRAnglePos, SyntaxNodeKind.GtToken.size)
    }

    /**
     * @brief Get the position range of the upper bound token if present.
     */
    public func getUpperBoundPos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.upperBoundPos, SyntaxNodeKind.UpperBoundToken.size)
    }

    /**
     * @brief Get the position ranges of bit-and tokens in super type annotations.
     */
    public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.superTyAnnotationsBitAndsPos, SyntaxNodeKind.BitAndToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: InterfaceDeclPosInfos, propInfos: InterfaceDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new InterfaceDecl node.
     */
    public init(body: Body, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createInterfaceDeclImpl(body, genericConstraints, genericParams, name,
                superTyAnnotations, annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<InterfaceDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the interface declaration.
     *
     * This variable represents the body of the interface declaration, which can
     * contain member declarations.
     */
    public prop body: Body {
        get() {
            return translateChild<Body>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The optional set of generic constraints on the interface declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the interface declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the interface declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the interface declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief The name of the interface declaration.
     *
     * This variable holds the name of the interface declaration。
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of type annotations for the declaration's supertypes.
     *
     * This variable holds an array of type annotations that represent
     * the supertypes of the interface declaration.
     */
    public prop superTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.superTyAnnotationsPropInfo)
        }
    }
}

class MacroDeclPropInfos {
    let bodyPropInfo: PropInfo
    let paramsPropInfo: PropInfo
    let retTyAnnotationPropInfo: Option<PropInfo>

    init(bodyPropInfo: PropInfo, paramsPropInfo: PropInfo, retTyAnnotationPropInfo: Option<PropInfo>) {
        this.bodyPropInfo = bodyPropInfo
        this.paramsPropInfo = paramsPropInfo
        this.retTyAnnotationPropInfo = retTyAnnotationPropInfo
    }
}

class MacroDeclPosInfos {
    let macroKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let retTyAnnotationColonPos: Option<CodePosition>

    init(macroKeyWordPos: CodePosition, identifierPos: CodePosition, retTyAnnotationColonPos: Option<CodePosition>) {
        this.macroKeyWordPos = macroKeyWordPos
        this.identifierPos = identifierPos
        this.retTyAnnotationColonPos = retTyAnnotationColonPos
    }
}

/**
 * @brief Represents a macro declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a macro declaration in the syntax tree.
 */
public class MacroDecl <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: MacroDeclPropInfos

    private let posInfos: MacroDeclPosInfos

    /**
     * @brief Get the position range of the 'macro' keyword.
     */
    public func getMacroKeyWordPos(): CodePositionRange {
        let endPos = posInfos.macroKeyWordPos + SyntaxNodeKind.MacroToken.size
        CodePositionRange(posInfos.macroKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + name.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Get the position range of the colon in the return type annotation if present.
     */
    public func getRetTyAnnotationColonPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.retTyAnnotationColonPos) {
            let endPos = v + SyntaxNodeKind.ColonToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: MacroDeclPosInfos, propInfos: MacroDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MacroDecl node.
     */
    public init(body: Block, name: String, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createMacroDeclImpl(body, name, params, retTyAnnotation, annotations: annotations,
                modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MacroDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block representing the body of the macro.
     *
     * This variable holds the block that represents the body of the
     * macro. The block contains the statements that make up the macro's
     * implementation.
     */
    public prop body: Block {
        get() {
            return translateChild<Block>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The name of the macro declaration.
     *
     * This variable holds the name of the macro declaration.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of macro parameters.
     *
     * This variable holds an array of macro parameters, each of which
     * has a name and a type annotation. These parameters define the inputs
     * to the macro.
     */
    public prop params: ParameterList {
        get() {
            return translateChild<ParameterList>(nodeImpl, startPos, this, propInfos.paramsPropInfo)
        }
    }

    /**
     * @brief The optional return type annotation of the macro.
     *
     * This variable holds an optional type annotation that represents
     * the return type of the macro.
     */
    public prop retTyAnnotation: Option<TypeAnnotation> {
        get() {
            return translateOptionalChild<TypeAnnotation>(nodeImpl, startPos, this, propInfos.retTyAnnotationPropInfo)
        }
    }
}

class MainDeclPropInfos {
    let bodyPropInfo: PropInfo
    let paramsPropInfo: PropInfo
    let retTyAnnotationPropInfo: Option<PropInfo>

    init(bodyPropInfo: PropInfo, paramsPropInfo: PropInfo, retTyAnnotationPropInfo: Option<PropInfo>) {
        this.bodyPropInfo = bodyPropInfo
        this.paramsPropInfo = paramsPropInfo
        this.retTyAnnotationPropInfo = retTyAnnotationPropInfo
    }
}

class MainDeclPosInfos {
    let mainKeyWordPos: CodePosition
    let retTyAnnotationColonPos: Option<CodePosition>

    init(mainKeyWordPos: CodePosition, retTyAnnotationColonPos: Option<CodePosition>) {
        this.mainKeyWordPos = mainKeyWordPos
        this.retTyAnnotationColonPos = retTyAnnotationColonPos
    }
}
/**
 * @brief Represents a main function declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent the main function declaration in the syntax tree.
 */
public class MainDecl <: Decl {
    private let startPos: CodePosition

    private let propInfos: MainDeclPropInfos

    private let posInfos: MainDeclPosInfos

    /**
     * @brief Get the position of the 'main' keyword.
     *
     * @return CodePositionRange representing the position of the 'main' keyword.
     */
    public func getMainKeyWordPos(): CodePositionRange {
        return CodePositionRange(posInfos.mainKeyWordPos, posInfos.mainKeyWordPos + SyntaxNodeKind.MainToken.size)
    }

    /**
     * @brief Get the position of the colon in the return type annotation.
     *
     * @return Option<CodePositionRange> representing the position of the colon.
     */
    public func getRetTyAnnotationColonPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.retTyAnnotationColonPos) {
            return CodePositionRange(v, v + SyntaxNodeKind.ColonToken.size)
        } else {
            return None
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: MainDeclPosInfos,
        propInfos: MainDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MainDecl node.
     */
    public init(body: Block, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createMainDeclImpl(body, params, retTyAnnotation, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MainDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block representing the body of the main function.
     *
     * This variable holds the block that represents the body of the
     * main function.
     */
    public prop body: Block {
        get() {
            return translateChild<Block>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The array of main function parameters.
     *
     * This variable holds an array of main function parameters, each of which
     * has a name and a type annotation.
     */
    public prop params: ParameterList {
        get() {
            return translateChild<ParameterList>(nodeImpl, startPos, this, propInfos.paramsPropInfo)
        }
    }

    /**
     * @brief The optional return type annotation of the main function.
     *
     * This variable holds an optional type annotation that represents
     * the return type of the main function.
     */
    public prop retTyAnnotation: Option<TypeAnnotation> {
        get() {
            return translateOptionalChild<TypeAnnotation>(nodeImpl, startPos, this, propInfos.retTyAnnotationPropInfo)
        }
    }
}

class PropDeclPropInfos {
    let getterPropInfo: Option<PropInfo>
    let setterPropInfo: Option<PropInfo>
    let tyAnnotationPropInfo: PropInfo

    init(
        getterPropInfo: Option<PropInfo>,
        setterPropInfo: Option<PropInfo>,
        tyAnnotationPropInfo: PropInfo
    ) {
        this.getterPropInfo = getterPropInfo
        this.setterPropInfo = setterPropInfo
        this.tyAnnotationPropInfo = tyAnnotationPropInfo
    }
}

class PropDeclPosInfos {
    let propKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let tyAnnotationColonPos: CodePosition
    let lCurlPos: Option<CodePosition>
    let rCurlPos: Option<CodePosition>

    init(
        propKeyWordPos: CodePosition,
        identifierPos: CodePosition,
        tyAnnotationColonPos: CodePosition,
        lCurlPos: Option<CodePosition>,
        rCurlPos: Option<CodePosition>
    ) {
        this.propKeyWordPos = propKeyWordPos
        this.identifierPos = identifierPos
        this.tyAnnotationColonPos = tyAnnotationColonPos
        this.lCurlPos = lCurlPos
        this.rCurlPos = rCurlPos
    }
}

/**
 * @brief Represents a property declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a property declaration in the syntax tree.
 */
public class PropDecl <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: PropDeclPropInfos

    private let posInfos: PropDeclPosInfos

    /**
     * @brief Get the position range of the 'prop' keyword.
     */
    public func getPropKeyWordPos(): CodePositionRange {
        let endPos = posInfos.propKeyWordPos + SyntaxNodeKind.PropToken.size
        CodePositionRange(posInfos.propKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + name.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Get the position range of the colon in type annotation if present.
     */
    public func getTyAnnotationColonPos(): CodePositionRange {
        let endPos = posInfos.tyAnnotationColonPos + SyntaxNodeKind.ColonToken.size
        return CodePositionRange(posInfos.tyAnnotationColonPos, endPos)
    }

    /**
     * @brief Get the position range of the left curly brace if present.
     */
    public func getLCurlPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.lCurlPos) {
            let endPos = v + SyntaxNodeKind.LCurlToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the right curly brace if present.
     */
    public func getRCurlPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.rCurlPos) {
            let endPos = v + SyntaxNodeKind.RCurlToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: PropDeclPosInfos, propInfos: PropDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new PropDecl node.
     */
    public init(getter: Option<PropGetterOrSetter>, name: String, setter: Option<PropGetterOrSetter>,
        tyAnnotation: TypeAnnotation, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createPropDeclImpl(getter, name, setter, tyAnnotation, annotations: annotations,
                modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<PropDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    public prop isMut: Bool {
        get() {
            for (mod in modifiers) {
                match (mod.kind) {
                    case ModifierKind.Mut => return true
                    case _ => continue
                }
            }
            return false
        }
    }

    /**
     * @brief The getter part of the property.
     *
     * This variable represents the getter part of the property, which is
     * responsible for returning the value of the property when it is accessed.
     */
    public prop getter: Option<PropGetterOrSetter> {
        get() {
            if (let Some(propInfo) <- propInfos.getterPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<PropGetterOrSetter>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                    .getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The name of the property declaration.
     *
     * This variable holds the name of the property declaration, which can be
     * used to identify and reference the declaration within the code.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The optional setter part of the property.
     *
     * This variable represents the optional setter part of the property, which
     * is responsible for setting the value of the property when it is assigned.
     * The presence of a setter indicates that the property is writable.
     */
    public prop setter: Option<PropGetterOrSetter> {
        get() {
            if (let Some(propInfo) <- propInfos.setterPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<PropGetterOrSetter>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                    .getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The optional type annotation of the property.
     *
     * This variable holds an optional type annotation that represents
     * the type of the property.
     */
    public prop tyAnnotation: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.tyAnnotationPropInfo.index]
            let offset = propInfos.tyAnnotationPropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class PropGetterOrSetterPropInfos {
    let blockPropInfo: PropInfo

    init(blockPropInfo: PropInfo) {
        this.blockPropInfo = blockPropInfo
    }
}

class PropGetterOrSetterPosInfos {
    let getKeyWordPos: Option<CodePosition>
    let setKeyWordPos: Option<CodePosition>
    let identifierPos: Option<CodePosition>
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(
        getKeyWordPos: Option<CodePosition>,
        setKeyWordPos: Option<CodePosition>,
        identifierPos: Option<CodePosition>,
        lParenPos: CodePosition,
        rParenPos: CodePosition
    ) {
        this.getKeyWordPos = getKeyWordPos
        this.setKeyWordPos = setKeyWordPos
        this.identifierPos = identifierPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a property getter or setter in the abstract syntax tree (AST).
 *
 * This class is used to represent the getter or setter part of a property
 * declaration in the syntax tree.
 */
public class PropGetterOrSetter <: Decl {
    private let identifier_: Option<String>

    private let isGetter_: Bool

    private let startPos: CodePosition

    private let propInfos: PropGetterOrSetterPropInfos

    private let posInfos: PropGetterOrSetterPosInfos

    /**
     * @brief Get the position range of the 'get' keyword if present.
     */
    public func getGetKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.getKeyWordPos) {
            let endPos = v + SyntaxNodeKind.GetToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the 'set' keyword if present.
     */
    public func getSetKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.setKeyWordPos) {
            let endPos = v + SyntaxNodeKind.SetToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the identifier if present.
     */
    public func getIdentifierPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.identifierPos && let Some(name) <- identifier) {
            let endPos = v + name.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        return CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Get the position range of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        return CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, identifier_: Option<String>,
        isGetter_: Bool, posInfos: PropGetterOrSetterPosInfos, propInfos: PropGetterOrSetterPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.identifier_ = identifier_
        this.isGetter_ = isGetter_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new PropGetterOrSetter node.
     */
    public init(block: Block, identifier: Option<String>, isGetter: Bool, annotations!: Array<Annotation> = [],
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createPropGetterOrSetterImpl(block, identifier, isGetter, annotations: annotations,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<PropGetterOrSetter>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.identifier_ = identifier
        this.isGetter_ = isGetter
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block representing the body of the getter or setter.
     *
     * This variable holds the block that represents the body of the
     * getter or setter. The block contains the statements that make up the
     * implementation of the property accessor.
     */
    public prop block: Block {
        get() {
            return translateChild<Block>(nodeImpl, startPos, this, propInfos.blockPropInfo)
        }
    }

    /**
     * @brief The optional identifier for the getter or setter.
     *
     * This variable holds an optional identifier that can be used to
     * name the getter or setter.
     */
    public prop identifier: Option<String> {
        get() {
            identifier_
        }
    }

    /**
     * @brief Indicates whether this is a getter.
     *
     * This variable is a boolean flag that indicates whether the
     * PropGetterOrSetter represents a getter. If true, it is a getter;
     * otherwise, it is not.
     */
    public prop isGetter: Bool {
        get() {
            isGetter_
        }
    }
}

class StaticInitPropInfos {
    let bodyPropInfo: PropInfo

    init(bodyPropInfo: PropInfo) {
        this.bodyPropInfo = bodyPropInfo
    }
}

class StaticInitPosInfos {
    let staticKeyWordPos: CodePosition
    let initKeyWordPos: CodePosition
    let paramsLParenPos: CodePosition
    let paramsRParenPos: CodePosition

    init(
        staticKeyWordPos: CodePosition,
        initKeyWordPos: CodePosition,
        paramsLParenPos: CodePosition,
        paramsRParenPos: CodePosition
    ) {
        this.staticKeyWordPos = staticKeyWordPos
        this.initKeyWordPos = initKeyWordPos
        this.paramsLParenPos = paramsLParenPos
        this.paramsRParenPos = paramsRParenPos
    }
}

/**
 * @brief Represents a static initializer in the abstract syntax tree (AST).
 *
 * This class is used to represent a static initializer in the syntax tree.
 */
public class StaticInit <: Decl {
    private let startPos: CodePosition

    private let propInfos: StaticInitPropInfos

    private let posInfos: StaticInitPosInfos

    /**
     * @brief Get the position range of the 'static' keyword.
     */
    public func getStaticKeyWordPos(): CodePositionRange {
        let endPos = posInfos.staticKeyWordPos + SyntaxNodeKind.StaticToken.size
        CodePositionRange(posInfos.staticKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the 'init' keyword.
     */
    public func getInitKeyWordPos(): CodePositionRange {
        let endPos = posInfos.initKeyWordPos + SyntaxNodeKind.InitToken.size
        CodePositionRange(posInfos.initKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the left parenthesis in the parameter list.
     */
    public func getParamsLParenPos(): CodePositionRange {
        let endPos = posInfos.paramsLParenPos + SyntaxNodeKind.LParenToken.size
        CodePositionRange(posInfos.paramsLParenPos, endPos)
    }

    /**
     * @brief Get the position range of the right parenthesis in the parameter list.
     */
    public func getParamsRParenPos(): CodePositionRange {
        let endPos = posInfos.paramsRParenPos + SyntaxNodeKind.RParenToken.size
        CodePositionRange(posInfos.paramsRParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfo: StaticInitPosInfos,
        propInfo: StaticInitPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize a new StaticInit node.
     */
    public init(body: Block, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createStaticInitImpl(body, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<StaticInit>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block representing the body of the static initializer.
     *
     * This variable holds the block that represents the body of the
     * static initializer. The block contains the statements that make up the
     * implementation of the static initialization code.
     */
    public prop body: Block {
        get() {
            return translateChild<Block>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }
}

class StructDeclPropInfos {
    let bodyPropInfo: PropInfo
    let genericConstraintsPropInfo: Option<PropInfo>
    let genericParamsPropInfo: Option<PropInfo>
    let superTyAnnotationsPropInfo: Array<PropInfo>

    init(
        bodyPropInfo: PropInfo,
        genericConstraintsPropInfo: Option<PropInfo>,
        genericParamsPropInfo: Option<PropInfo>,
        superTyAnnotationsPropInfo: Array<PropInfo>
    ) {
        this.bodyPropInfo = bodyPropInfo
        this.genericConstraintsPropInfo = genericConstraintsPropInfo
        this.genericParamsPropInfo = genericParamsPropInfo
        this.superTyAnnotationsPropInfo = superTyAnnotationsPropInfo
    }
}

class StructDeclPosInfos {
    let structKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let genericParamsLAnglePos: Option<CodePosition>
    let genericParamsCommasPos: Array<CodePosition>
    let genericParamsRAnglePos: Option<CodePosition>
    let upperBoundPos: Option<CodePosition>
    let superTyAnnotationsBitAndsPos: Array<CodePosition>

    init(
        structKeyWordPos: CodePosition,
        identifierPos: CodePosition,
        genericParamsLAnglePos: Option<CodePosition>,
        genericParamsCommasPos: Array<CodePosition>,
        genericParamsRAnglePos: Option<CodePosition>,
        upperBoundPos: Option<CodePosition>,
        superTyAnnotationsBitAndsPos: Array<CodePosition>
    ) {
        this.structKeyWordPos = structKeyWordPos
        this.identifierPos = identifierPos
        this.genericParamsLAnglePos = genericParamsLAnglePos
        this.genericParamsCommasPos = genericParamsCommasPos
        this.genericParamsRAnglePos = genericParamsRAnglePos
        this.upperBoundPos = upperBoundPos
        this.superTyAnnotationsBitAndsPos = superTyAnnotationsBitAndsPos
    }
}

/**
 * @brief Represents a struct declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a struct declaration in the syntax tree.
 */
public class StructDecl <: Decl {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: StructDeclPropInfos

    private let posInfos: StructDeclPosInfos

    /**
     * @brief Get the position range of the 'struct' keyword.
     */
    public func getStructKeyWordPos(): CodePositionRange {
        let endPos = posInfos.structKeyWordPos + SyntaxNodeKind.StructToken.size
        CodePositionRange(posInfos.structKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        return createPositionRange(posInfos.identifierPos, name.size)
    }

    /**
     * @brief Get the position range of the left angle bracket for generic parameters if present.
     */
    public func getGenericParamsLAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsLAnglePos, SyntaxNodeKind.LtToken.size)
    }

    /**
     * @brief Get the position ranges of commas in generic parameters.
     */
    public func getGenericParamsCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.genericParamsCommasPos, SyntaxNodeKind.CommaToken.size)
    }

    /**
     * @brief Get the position range of the right angle bracket for generic parameters if present.
     */
    public func getGenericParamsRAnglePos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.genericParamsRAnglePos, SyntaxNodeKind.GtToken.size)
    }

    /**
     * @brief Get the position range of the upper bound token if present.
     */
    public func getUpperBoundPos(): Option<CodePositionRange> {
        return createOptionalTokenRange(posInfos.upperBoundPos, SyntaxNodeKind.UpperBoundToken.size)
    }

    /**
     * @brief Get the position ranges of bit-and tokens in super type annotations.
     */
    public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.superTyAnnotationsBitAndsPos, SyntaxNodeKind.BitAndToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: StructDeclPosInfos, propInfos: StructDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new StructDecl node.
     */
    public init(body: Body, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createStructDeclImpl(body, genericConstraints, genericParams, name, superTyAnnotations,
                annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<StructDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the struct declaration.
     *
     * This variable represents the body of the struct declaration, which can
     * contain member declarations.
     */
    public prop body: Body {
        get() {
            return translateChild<Body>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The optional set of generic constraints on the struct declaration.
     *
     * This variable holds an optional set of generic constraints that
     * are applied to the struct declaration.
     */
    public prop genericConstraints: Option<GenericConstraints> {
        get() {
            return translateOptionalChild<GenericConstraints>(nodeImpl, startPos, this,
                propInfos.genericConstraintsPropInfo)
        }
    }

    /**
     * @brief The array of generic parameters for the struct declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the struct declaration.
     */
    public prop genericParams: Array<GenericParam> {
        get() {
            return translateOptionalGenericParams(nodeImpl, startPos, this, propInfos.genericParamsPropInfo)
        }
    }

    /**
     * @brief The name of the struct declaration.
     *
     * This variable holds the name of the struct declaration.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The array of type annotations for the declaration's supertypes.
     *
     * This variable holds an array of type annotations that represent
     * the supertypes of the struct declaration.
     */
    public prop superTyAnnotations: Array<TypeAnnotation> {
        get() {
            return translateChildList<TypeAnnotation>(nodeImpl, startPos, this, propInfos.superTyAnnotationsPropInfo)
        }
    }
}

class TypeAliasPropInfos {
    let originalTyAnnotationPropInfo: PropInfo
    let typeParametersPropInfo: Option<PropInfo>

    init(originalTyAnnotationPropInfo: PropInfo, typeParametersPropInfo: Option<PropInfo>) {
        this.originalTyAnnotationPropInfo = originalTyAnnotationPropInfo
        this.typeParametersPropInfo = typeParametersPropInfo
    }
}

class TypeAliasPosInfos {
    let typeAliasKeyWordPos: CodePosition
    let identifierPos: CodePosition
    let assignPos: CodePosition

    init(typeAliasKeyWordPos: CodePosition, identifierPos: CodePosition, assignPos: CodePosition) {
        this.typeAliasKeyWordPos = typeAliasKeyWordPos
        this.identifierPos = identifierPos
        this.assignPos = assignPos
    }
}

/**
 * @brief Represents a type alias declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a type alias declaration in the syntax tree.
 */
public class TypeAlias <: Decl {
    private let aliasName_: String

    private let startPos: CodePosition

    private let propInfos: TypeAliasPropInfos

    private let posInfos: TypeAliasPosInfos

    /**
     * @brief Gets the position range of the 'type' keyword in the type alias declaration.
     *
     * @return A CodePositionRange representing the position range of the 'type' keyword.
     */
    public func getTypeAliasKeyWordPos(): CodePositionRange {
        let endPos = posInfos.typeAliasKeyWordPos + SyntaxNodeKind.TypeToken.size
        return CodePositionRange(posInfos.typeAliasKeyWordPos, endPos)
    }

    /**
     * @brief Gets the position range of the identifier in the type alias declaration.
     *
     * @return A CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + aliasName.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Gets the position range of the assignment operator in the type alias declaration.
     *
     * @return A CodePositionRange representing the position range of the assignment operator.
     */
    public func getAssignPos(): CodePositionRange {
        let endPos = posInfos.assignPos + SyntaxNodeKind.AssignToken.size
        return CodePositionRange(posInfos.assignPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, aliasName_: String,
        posInfo: TypeAliasPosInfos, propInfo: TypeAliasPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.aliasName_ = aliasName_
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize a new TypeAlias node.
     */
    public init(aliasName: String, originalTyAnnotation: TypeAnnotation, typeParameters: Array<GenericParam>,
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createTypeAliasImpl(aliasName, originalTyAnnotation, typeParameters,
                modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TypeAlias>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.aliasName_ = aliasName
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The name of the type alias.
     *
     * This variable holds the name of the type alias, which can be
     * used to identify and reference the alias within the code.
     */
    public prop aliasName: String {
        get() {
            aliasName_
        }
    }

    /**
     * @brief The optional type annotation representing the original type.
     *
     * This variable holds an optional type annotation that represents
     * the original type that the alias is referring to.
     */
    public prop originalTyAnnotation: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.originalTyAnnotationPropInfo.index]
            let offset = propInfos.originalTyAnnotationPropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The array of generic parameters for the declaration.
     *
     * This variable holds an array of generic parameters that are
     * associated with the declaration.
     */
    public prop typeParameters: Array<GenericParam> {
        get() {
            let params = ArrayList<GenericParam>()
            if (let Some(propInfo) <- propInfos.typeParametersPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset

                let lp = LocalParser(((curNode as NonTerminal).getOrThrow()).children, offset)
                lp.offset.move(lp.consume(kind: SyntaxNodeKind.LtToken).getOrThrow().offset)
                while (!lp.look(SyntaxNodeKind.GtToken)) {
                    let identNode = lp.consume().getOrThrow()
                    params.add(
                        cast<GenericParam>(SyntaxNodeImplTranslator.translate(identNode, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.offset.move(identNode.offset)
                    if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.CommaToken)) {
                        lp.offset.move(v.offset)
                    }
                }
            }
            params.toArray()
        }
    }
}

/**
 * @brief Represents the kind of a variable declaration.
 *
 * This enum is used to represent the different kinds of variable declarations
 * that can exist in the syntax tree. It provides a way to distinguish between
 * constants, let variables, and other variable types.
 */
public enum VarKind {
    | Const // Constants that cannot be reassigned after initialization (e.g., const x).
    | Let // Variables that can be reassigned (e.g., let x).
    | Var // Variables with a specific scope or behavior (e.g., var x).
    | ... // Additional variable kinds can be added here.
}

class VarDeclPropInfos {
    let initializerPropInfo: Option<PropInfo>
    let patternPropInfo: PropInfo
    let tyAnnotationPropInfo: Option<PropInfo>

    init(initializerPropInfo: Option<PropInfo>, patternPropInfo: PropInfo, tyAnnotationPropInfo: Option<PropInfo>) {
        this.initializerPropInfo = initializerPropInfo
        this.patternPropInfo = patternPropInfo
        this.tyAnnotationPropInfo = tyAnnotationPropInfo
    }
}

class VarDeclPosInfos {
    let varKindKeyWordPos: CodePosition
    let identifierPos: Option<CodePosition>
    let tyAnnotationColonPos: Option<CodePosition>
    let assignPos: Option<CodePosition>

    init(varKindKeyWordPos: CodePosition, identifierPos: Option<CodePosition>,
        tyAnnotationColonPos: Option<CodePosition>, assignPos: Option<CodePosition>) {
        this.varKindKeyWordPos = varKindKeyWordPos
        this.identifierPos = identifierPos
        this.tyAnnotationColonPos = tyAnnotationColonPos
        this.assignPos = assignPos
    }
}

/**
 * @brief Represents a variable declaration in the abstract syntax tree (AST).
 *
 * This class is used to represent a variable declaration in the syntax tree.
 */
public class VarDecl <: Decl {
    private let kind_: VarKind

    private let startPos: CodePosition

    private let propInfos: VarDeclPropInfos

    private let posInfos: VarDeclPosInfos

    /**
     * @brief Gets the position range of the variable kind keyword in the declaration.
     *
     * @return A CodePositionRange representing the position range of the variable kind keyword.
     */
    public func getVarKindKeyWordPos(): CodePositionRange {
        let varKindSize = match (kind) {
            case VarKind.Const => SyntaxNodeKind.ConstToken.size
            case VarKind.Let => SyntaxNodeKind.LetToken.size
            case VarKind.Var => SyntaxNodeKind.VarToken.size
            case _ => throw Exception("ParseException: " + "unexpected VarKind keyword")
        }
        let endPos = posInfos.varKindKeyWordPos + varKindSize
        return CodePositionRange(posInfos.varKindKeyWordPos, endPos)
    }

    /**
     * @brief Gets the position range of the identifier in the declaration.
     *
     * @return A CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): Option<CodePositionRange> {
        if (let Some(identifierPos) <- posInfos.identifierPos) {
            let endPos = identifierPos + name.size
            return CodePositionRange(identifierPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the type annotation colon in the declaration.
     *
     * @return An Option of CodePositionRange representing the position range of the type annotation colon, if present.
     */
    public func getTyAnnotationColonPos(): Option<CodePositionRange> {
        if (let Some(colonPos) <- posInfos.tyAnnotationColonPos) {
            let endPos = colonPos + SyntaxNodeKind.ColonToken.size
            return CodePositionRange(colonPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the assignment operator in the declaration.
     *
     * @return An Option of CodePositionRange representing the position range of the assignment operator, if present.
     */
    public func getAssignPos(): Option<CodePositionRange> {
        if (let Some(assignPos) <- posInfos.assignPos) {
            let endPos = assignPos + SyntaxNodeKind.AssignToken.size
            return CodePositionRange(assignPos, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: VarKind,
        posInfos: VarDeclPosInfos, propInfos: VarDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.kind_ = kind_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new VarDecl node.
     */
    public init(initializer: Option<Expr>, kind: VarKind, name: String, pattern: Pattern,
        tyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createVarDeclImpl(initializer, kind, name, pattern, tyAnnotation,
                annotations: annotations, modifiers: modifiers, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<VarDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.kind_ = kind
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The optional expression representing the initializer of the variable.
     *
     * This variable holds an optional expression that initializes the variable
     * at the time of declaration. Local variables allow declaration before initialization.
     */
    public prop initializer: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.initializerPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The kind of the variable declaration.
     *
     * This variable specifies the kind of the variable declaration using the
     * VarKind enum, which can be Const, Let, Var, or other custom kinds.
     */
    public prop kind: VarKind {
        get() {
            kind_
        }
    }

    /**
     * @brief The name of the variable declaration if it is varbinding pattern.
     *
     * This variable holds the name of the variable declaration.
     * For scenarios where the declaration includes other patterns, the name is empty.
     */
    public prop name: String {
        get() {
            if (let Some(pat) <- (pattern as VarPattern)) {
                pat.name
            } else {
                ""
            }
        }
    }

    /**
     * @brief The pattern representing the variable's structure.
     *
     * This variable holds a pattern that represents the structure of the
     * variable.
     */
    public prop pattern: Pattern {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.patternPropInfo.index]
            let offset = propInfos.patternPropInfo.offset
            cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The optional type annotation of the variable.
     *
     * This variable holds an optional type annotation that represents
     * the type of the variable.
     */
    public prop tyAnnotation: Option<TypeAnnotation> {
        get() {
            if (let Some(propInfo) <- propInfos.tyAnnotationPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}
