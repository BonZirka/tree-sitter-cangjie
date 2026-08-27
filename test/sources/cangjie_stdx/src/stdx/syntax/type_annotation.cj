/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList
import std.convert

private func createTokenRanges(positions: Array<CodePosition>, kind: SyntaxNodeKind): Array<CodePositionRange> {
    let ranges: ArrayList<CodePositionRange> = ArrayList<CodePositionRange>()
    for (pos in positions) {
        ranges.add(CodePositionRange(pos, pos + kind.size))
    }
    return ranges.toArray()
}

private func createTextRanges(positions: Array<CodePosition>, texts: Array<String>): Array<CodePositionRange> {
    let ranges: ArrayList<CodePositionRange> = ArrayList<CodePositionRange>()
    for (i in 0..positions.size) {
        ranges.add(CodePositionRange(positions[i], positions[i] + texts[i].size))
    }
    return ranges.toArray()
}

private func collectLabeledTypeAnnotations(lp: LocalParser, startPos: CodePosition,
    parentNode: ?SyntaxTreeNode): Array<TypeAnnotation> {
    let typeAnnotations = ArrayList<TypeAnnotation>()
    if (let Some(node) <- lp.consume()) {
        typeAnnotations.add(
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, parentNode))
                .getOrThrow())
        lp.moveOffset(node)
    }
    while (lp.look(SyntaxNodeKind.CommaToken)) {
        lp.moveOffset(lp.consume())
        if (let Some(v) <- lp.lookAndConsume(SyntaxNodeKind.IdentToken)) {
            lp.moveOffset(v)
            lp.moveOffset(lp.consume())
        }
        if (let Some(node) <- lp.consume()) {
            typeAnnotations.add(
                cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, parentNode))
                    .getOrThrow())
            lp.moveOffset(node)
        }
    }
    return typeAnnotations.toArray()
}

sealed abstract class TypeAnnotation <: SyntaxTreeNode {
    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(nodePos, nodeImpl, parentNode, commentsPropInfo)
    }

    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
    }
}

class CompositeTypePosInfos {
    let lAnglePos: Option<CodePosition>
    let rAnglePos: Option<CodePosition>
    let commasPos: Array<CodePosition>
    let dotsPos: Array<CodePosition>
    let identPos: Array<CodePosition>

    init(lAnglePos: Option<CodePosition>, rAnglePos: Option<CodePosition>, commasPos: Array<CodePosition>,
        dotsPos: Array<CodePosition>, identPos: Array<CodePosition>) {
        this.lAnglePos = lAnglePos
        this.rAnglePos = rAnglePos
        this.commasPos = commasPos
        this.dotsPos = dotsPos
        this.identPos = identPos
    }
}

class CompositeTypePropInfos {
    let typeArgumentsPropInfo: Option<PropInfo>

    init(typeArgumentsPropInfo: Option<PropInfo>) {
        this.typeArgumentsPropInfo = typeArgumentsPropInfo
    }
}

/**
 * @brief Represents a composite type annotation.
 *
 * For example, one composite type is `p1.p0.A<Int64>`
 */
public class CompositeType <: TypeAnnotation {
    private let prefixes_: Array<String>
    private let name_: String
    private let startPos: CodePosition
    private let posInfos: CompositeTypePosInfos
    private let propInfos: CompositeTypePropInfos

    /**
     * @brief Retrieves the position range of the left angle bracket.
     *
     * @return A CodePositionRange object representing the start and end positions of the left angle bracket.
     */
    public func getLAnglePos(): Option<CodePositionRange> {
        if (let Some(pos) <- posInfos.lAnglePos) {
            let endPos = pos + SyntaxNodeKind.LtToken.size
            return CodePositionRange(pos, endPos)
        } else {
            return None
        }
    }

    /**
     * @brief Retrieves the position range of the right angle bracket.
     *
     * @return A CodePositionRange object representing the start and end positions of the right angle bracket.
     */
    public func getRAnglePos(): Option<CodePositionRange> {
        if (let Some(pos) <- posInfos.rAnglePos) {
            let endPos = pos + SyntaxNodeKind.GtToken.size
            return CodePositionRange(pos, endPos)
        } else {
            return None
        }
    }

    /**
     * @brief Retrieves the position ranges of all commas.
     *
     * @return An array of CodePositionRange objects, each representing the start and end positions of a comma.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let commasPos: ArrayList<CodePositionRange> = ArrayList<CodePositionRange>()
        for (pos in posInfos.commasPos) {
            let endPos = pos + SyntaxNodeKind.CommaToken.size
            commasPos.add(CodePositionRange(pos, endPos))
        }
        return commasPos.toArray()
    }

    /**
     * @brief Retrieves the position ranges of all commas.
     *
     * @return An array of CodePositionRange objects, each representing the start and end positions of a comma.
     */
    public func getDotsPos(): Array<CodePositionRange> {
        let dotsPos: ArrayList<CodePositionRange> = ArrayList<CodePositionRange>()
        for (pos in posInfos.dotsPos) {
            let endPos = pos + SyntaxNodeKind.DotToken.size
            dotsPos.add(CodePositionRange(pos, endPos))
        }
        return dotsPos.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: CompositeTypePosInfos,
        propInfos: CompositeTypePropInfos, name_: String, prefixes_: Array<String>, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
        this.name_ = name_
        this.prefixes_ = prefixes_
    }

    /**
     * @brief Initialize node with type prefixes, type name and type arguments.
     */
    public init(name: String, prefixes: Array<String>, typeArguments: Array<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createCompositeTypeImpl(name, prefixes, typeArguments, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<CompositeType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.prefixes_ = prefixes
        this.name_ = name
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The prefixes types of composite type.
     *
     * The `p1.p0` is the prefixes of `p1.p0.A<Int64>`
     */
    public prop prefixes: Array<String> {
        get() {
            prefixes_
        }
    }
    /**
     * @brief The name of the composite type.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The type arguments of the composite type.
     */
    public prop typeArguments: Array<TypeAnnotation> {
        get() {
            // Array<TypeAnnotation>()
            let typeArguments = ArrayList<TypeAnnotation>()

            if (let Some(propInfo) <- propInfos.typeArgumentsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                let lp = LocalParser((curNode as NonTerminal).getOrThrow().children, offset)

                lp.moveOffset(lp.lookAndConsume(SyntaxNodeKind.LtToken))

                let predictType = {
                    kind: SyntaxNodeKind => kind.isTypeAnnotation()
                }
                while (lp.look(predictType)) {
                    if (let Some(node) <- lp.consume()) {
                        typeArguments.add(
                            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                                .getOrThrow())
                        lp.moveOffset(node)
                        lp.moveOffset(lp.lookAndConsume(SyntaxNodeKind.CommaToken))
                    }
                }
            }
            typeArguments.toArray()
        }
    }
}

class FuncTypePosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let commasPos: Array<CodePosition>
    let arrowPos: CodePosition
    let labelsPos: Array<CodePosition>
    let colonsPos: Array<CodePosition>

    init(lParenPos: CodePosition, rParenPos: CodePosition, commasPos: Array<CodePosition>, arrowPos: CodePosition,
        labelsPos: Array<CodePosition>, colonsPos: Array<CodePosition>) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
        this.arrowPos = arrowPos
        this.labelsPos = labelsPos
        this.colonsPos = colonsPos
    }
}

class FuncTypePropInfos {
    let paramTypesPropInfo: Option<PropInfo>
    let retTypePropInfo: PropInfo

    init(paramTypesPropInfo: Option<PropInfo>, retTypePropInfo: PropInfo) {
        this.paramTypesPropInfo = paramTypesPropInfo
        this.retTypePropInfo = retTypePropInfo
    }
}

/**
 * @brief Represents a function type annotation.
 */
public class FuncType <: TypeAnnotation {
    private let labels_: Array<String>
    private let startPos: CodePosition
    private let posInfos: FuncTypePosInfos
    private let propInfos: FuncTypePropInfos

    /**
     * @brief Retrieves the position range of the left parenthesis.
     * @return CodePositionRange representing the position of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        return CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Retrieves the position range of the right parenthesis.
     * @return CodePositionRange representing the position of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        return CodePositionRange(posInfos.rParenPos, endPos)
    }

    /**
     * @brief Retrieves the position ranges of all commas.
     * @return Array of CodePositionRange objects representing the positions of commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken)
    }

    /**
     * @brief Retrieves the position range of the arrow.
     * @return CodePositionRange representing the position of the arrow.
     */
    public func getArrowPos(): CodePositionRange {
        let endPos = posInfos.arrowPos + SyntaxNodeKind.ArrowToken.size
        return CodePositionRange(posInfos.arrowPos, endPos)
    }

    /**
     * @brief Retrieves the position ranges of all labels.
     * @return Array of CodePositionRange objects representing the positions of labels.
     */
    public func getLabelsPos(): Array<CodePositionRange> {
        return createTextRanges(posInfos.labelsPos, labels)
    }

    /**
     * @brief Retrieves the position ranges of all colons.
     * @return Array of CodePositionRange objects representing the positions of colons.
     */
    public func getColonsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.colonsPos, SyntaxNodeKind.ColonToken)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: FuncTypePosInfos,
        propInfos: FuncTypePropInfos, labels_: Array<String>, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
        this.labels_ = labels_
    }

    /**
     * @brief Initialize node with parameters and return type.
     */
    public init(paramTypes: Array<TypeAnnotation>, labels: Array<String>, retType: TypeAnnotation,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createFuncTypeImpl(paramTypes, labels, retType, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<FuncType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.labels_ = labels
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The type parameter names of the function.
     */
    public prop labels: Array<String> {
        get() {
            labels_
        }
    }
    /**
     * @brief The parameter types of the function.
     */
    public prop paramTypes: Array<TypeAnnotation> {
        get() {
            if (let Some(propInfo) <- propInfos.paramTypesPropInfo) {
                let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfo.offset,
                    index: propInfo.index)
                collectLabeledTypeAnnotations(lp, startPos, this)
            } else {
                Array<TypeAnnotation>()
            }
        }
    }
    /**
     * @brief The return type of the function.
     */
    public prop retType: TypeAnnotation {
        get() {
            let propInfo = propInfos.retTypePropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
        }
    }
}

public enum PrefixTypeOpKind {
    | Quest | ...
}

class PrefixTypePosInfos {
    let operatorPos: CodePosition

    init(operatorPos: CodePosition) {
        this.operatorPos = operatorPos
    }
}

class PrefixTypePropInfos {
    let baseTypePropInfo: PropInfo

    init(baseTypePropInfo: PropInfo) {
        this.baseTypePropInfo = baseTypePropInfo
    }
}

/**
 * @brief Represents n prefix type annotation.
 */
public class PrefixType <: TypeAnnotation {
    private let startPos: CodePosition
    private let prefixTypeOpKind_: PrefixTypeOpKind
    private let posInfos: PrefixTypePosInfos
    private let propInfos: PrefixTypePropInfos

    /**
     * @brief Retrieves the position range of the operator in the code.
     *
     * @return CodePositionRange representing the start and end positions of the operator.
     */
    public func getOperatorPos(): CodePositionRange {
        let endPos = posInfos.operatorPos + match (prefixTypeOpKind) {
            case Quest => SyntaxNodeKind.QuestToken.size
            case _ => 0
        }
        return CodePositionRange(posInfos.operatorPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: PrefixTypePosInfos,
        propInfos: PrefixTypePropInfos, prefixTypeOpKind_: PrefixTypeOpKind, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
        this.prefixTypeOpKind_ = prefixTypeOpKind_
    }

    /**
     * @brief Initialize node with type prefix and type itself.
     */
    public init(base: TypeAnnotation, prefixOp: PrefixTypeOpKind, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createPrefixTypeImpl(base, prefixOp, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<PrefixType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.prefixTypeOpKind_ = prefixOp
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The base type of the prefix.
     */
    public prop base: TypeAnnotation {
        get() {
            let propInfo = propInfos.baseTypePropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
        }
    }

    /**
     * @brief The base type op kind of the prefix.
     */
    public prop prefixTypeOpKind: PrefixTypeOpKind {
        get() {
            prefixTypeOpKind_
        }
    }
}

/**
 * @brief Enumeration representing different Atomic types.
 */
public enum AtomicTypeKind {
    | BoolType
    | Float16Type
    | Float32Type
    | Float64Type
    | Int16Type
    | Int32Type
    | Int64Type
    | Int8Type
    | IntNativeType
    | NothingType
    | RuneType
    | ThisType
    | UInt16Type
    | UInt32Type
    | UInt64Type
    | UInt8Type
    | UIntNativeType
    | UnitType
    | ...
}

/**
 * @brief Class representing a Atomic type annotation.
 *
 * This class extends TypeAnnotation and encapsulates a AtomicTypeKind.
 */
public class AtomicType <: TypeAnnotation {
    private let kind_: AtomicTypeKind
    private let startPos: CodePosition

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: AtomicTypeKind,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.kind_ = kind_
    }

    /**
     * @brief Initialize node with the atomic type.
     */
    public init(kind: AtomicTypeKind, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createAtomicTypeImpl(kind, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<AtomicType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.kind_ = kind
        this.startPos = startPos
    }

    /**
     * @brief The kind of Atomic type.
     *
     * This field specifies the kind of Atomic type this instance represents.
     */
    public prop kind: AtomicTypeKind {
        get() {
            kind_
        }
    }
}

class ParenTypePosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

class ParenTypePropInfos {
    let subTypePropInfo: PropInfo

    init(subTypePropInfo: PropInfo) {
        this.subTypePropInfo = subTypePropInfo
    }
}

/**
 * @brief Represents a parenthesized type annotation.
 */
public class ParenType <: TypeAnnotation {
    private let startPos: CodePosition

    private let posInfos: ParenTypePosInfos
    private let propInfos: ParenTypePropInfos

    /**
     * @brief Retrieves the position range of the left parenthesis.
     *
     * @return The CodePositionRange representing the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        return CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Retrieves the position range of the right parenthesis.
     *
     * @return The CodePositionRange representing the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        return CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ParenTypePosInfos,
        propInfos: ParenTypePropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with sub-type.
     */
    public init(subType: TypeAnnotation, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createParenTypeImpl(subType, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ParenType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The sub-type enclosed in parentheses.
     */
    public prop subType: TypeAnnotation {
        get() {
            let propInfo = propInfos.subTypePropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
        }
    }
}

class TupleTypePosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let commasPos: Array<CodePosition>
    let labelsPos: Array<CodePosition>
    let colonsPos: Array<CodePosition>

    init(lParenPos: CodePosition, rParenPos: CodePosition, commasPos: Array<CodePosition>,
        labelsPos: Array<CodePosition>, colonsPos: Array<CodePosition>) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
        this.labelsPos = labelsPos
        this.colonsPos = colonsPos
    }
}

class TupleTypePropInfos {
    let elementsPropInfo: PropInfo

    init(elementsPropInfo: PropInfo) {
        this.elementsPropInfo = elementsPropInfo
    }
}

/**
 * @brief Represents a tuple type annotation.
 */
public class TupleType <: TypeAnnotation {
    private let labels_: Array<String>
    private let startPos: CodePosition
    private let posInfos: TupleTypePosInfos
    private let propInfos: TupleTypePropInfos

    /**
     * @brief Retrieves the position range of the left parenthesis.
     * @return A CodePositionRange object representing the position range of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        return CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Retrieves the position range of the right parenthesis.
     * @return A CodePositionRange object representing the position range of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        return CodePositionRange(posInfos.rParenPos, endPos)
    }

    /**
     * @brief Retrieves the position ranges of all commas.
     * @return An array of CodePositionRange objects representing the position ranges of commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken)
    }

    /**
     * @brief Retrieves the position ranges of all labels.
     * @return An array of CodePositionRange objects representing the position ranges of labels.
     */
    public func getLabelsPos(): Array<CodePositionRange> {
        return createTextRanges(posInfos.labelsPos, labels)
    }

    /**
     * @brief Retrieves the position ranges of all colons.
     * @return An array of CodePositionRange objects representing the position ranges of colons.
     */
    public func getColonsPos(): Array<CodePositionRange> {
        return createTokenRanges(posInfos.colonsPos, SyntaxNodeKind.ColonToken)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: TupleTypePosInfos,
        propInfos: TupleTypePropInfos, labels_: Array<String>, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
        this.labels_ = labels_
    }

    /**
     * @brief Initialize node with the elements and labels in tuple.
     */
    public init(labels: Array<String>, elements: Array<TypeAnnotation>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createTupleTypeImpl(elements, labels, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TupleType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.labels_ = labels
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The elements of the tuple.
     */
    public prop elements: Array<TypeAnnotation> {
        get() {
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.elementsPropInfo.offset,
                index: propInfos.elementsPropInfo.index)
            collectLabeledTypeAnnotations(lp, startPos, this)
        }
    }
    /**
     * @brief The type parameter names of the tuple.
     */
    public prop labels: Array<String> {
        get() {
            labels_
        }
    }
}

class VArrayTypePosInfos {
    let varrayPos: CodePosition
    let lAnglePos: CodePosition
    let rAnglePos: CodePosition
    let dollarPos: CodePosition
    let commaPos: CodePosition

    init(varrayPos: CodePosition, lAnglePos: CodePosition, rAnglePos: CodePosition, dollarPos: CodePosition,
        commaPos: CodePosition) {
        this.varrayPos = varrayPos
        this.lAnglePos = lAnglePos
        this.rAnglePos = rAnglePos
        this.dollarPos = dollarPos
        this.commaPos = commaPos
    }
}

class VArrayTypePropInfos {
    let elementPropInfo: PropInfo
    let sizePropInfo: PropInfo

    init(elementPropInfo: PropInfo, sizePropInfo: PropInfo) {
        this.elementPropInfo = elementPropInfo
        this.sizePropInfo = sizePropInfo
    }
}

/**
 * @brief Represents a variable array type annotation.
 */
public class VArrayType <: TypeAnnotation {
    private let startPos: CodePosition

    private let posInfos: VArrayTypePosInfos
    private let propInfos: VArrayTypePropInfos

    /**
     * @brief Retrieves the position range of the VArray token in the code.
     *
     * @return CodePositionRange representing the start and end positions of the VArray token.
     */
    public func getVArrayPos(): CodePositionRange {
        let endPos = posInfos.varrayPos + SyntaxNodeKind.VArrayToken.size
        return CodePositionRange(posInfos.varrayPos, endPos)
    }

    /**
     * @brief Retrieves the position range of the left angle.
     * @return A CodePositionRange object representing the position range of the left angle.
     */
    public func getLAnglePos(): CodePositionRange {
        let endPos = posInfos.lAnglePos + SyntaxNodeKind.LtToken.size
        return CodePositionRange(posInfos.lAnglePos, endPos)
    }

    /**
     * @brief Retrieves the position range of the right angle.
     * @return A CodePositionRange object representing the position range of the right angle.
     */
    public func getRAnglePos(): CodePositionRange {
        let endPos = posInfos.rAnglePos + SyntaxNodeKind.GtToken.size
        return CodePositionRange(posInfos.rAnglePos, endPos)
    }

    /**
     * @brief Retrieves the position range of the dollar.
     * @return A CodePositionRange object representing the position range of the dollar.
     */
    public func getDollarPos(): CodePositionRange {
        let endPos = posInfos.dollarPos + SyntaxNodeKind.DollarToken.size
        return CodePositionRange(posInfos.dollarPos, endPos)
    }

    /**
     * Retrieves the position range of a comma in the code.
     *
     * @return CodePositionRange representing the start and end positions of the comma.
     */
    public func getCommaPos(): CodePositionRange {
        let endPos = posInfos.commaPos + SyntaxNodeKind.CommaToken.size
        return CodePositionRange(posInfos.commaPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: VArrayTypePosInfos,
        propInfos: VArrayTypePropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with element type and size of VArray.
     */
    public init(elementType: TypeAnnotation, size: Int64, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createVArrayTypeImpl(elementType, size, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<VArrayType>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The element type of the array.
     */
    public prop elementType: TypeAnnotation {
        get() {
            let propInfo = propInfos.elementPropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this))
                .getOrThrow()
        }
    }
    /**
     * @brief The size of the array.
     */
    public prop size: Int64 {
        get() {
            let propInfo = propInfos.sizePropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            let literal = cast<LitConstExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset,
                this)).getOrThrow()
            Int64.parse(literal.rawValue)
        }
    }
}
