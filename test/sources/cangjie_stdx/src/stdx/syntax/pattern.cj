/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList

private func translatePatternChildren(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfos: Array<PropInfo>): Array<Pattern> {
    let pats = ArrayList<Pattern>()
    for (propInfo in propInfos) {
        let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
        let offset = propInfo.offset
        pats.add(cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, parentNode)).getOrThrow())
    }
    pats.toArray()
}

sealed abstract class Pattern <: SyntaxTreeNode {
    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(nodePos, nodeImpl, parentNode, commentsPropInfo)
    }

    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
    }
}

class ConstPatternPropInfos {
    let litConstExprPropInfo: PropInfo

    init(litConstExprPropInfo: PropInfo) {
        this.litConstExprPropInfo = litConstExprPropInfo
    }
}

/**
 * @brief ConstPattern class represents a pattern for a constant expression.
 */
public class ConstPattern <: Pattern {
    private let startPos: CodePosition

    private let propInfos: ConstPatternPropInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        propInfos: ConstPatternPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with literal constant expr.
     */
    public init(litConstExpr: LitConstExpr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createConstPatternImpl(litConstExpr, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ConstPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Literal constant expression.
     */
    public prop litConstExpr: LitConstExpr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.litConstExprPropInfo.index]
            let offset = propInfos.litConstExprPropInfo.offset
            cast<LitConstExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class EnumPatternPropInfos {
    let enumConstructorPropInfo: PropInfo
    let enumTypePropInfo: Option<PropInfo>
    let subPatternsPropInfo: Array<PropInfo>

    init(enumConstructorPropInfo: PropInfo, enumTypePropInfo: Option<PropInfo>, subPatternsPropInfo: Array<PropInfo>) {
        this.enumConstructorPropInfo = enumConstructorPropInfo
        this.enumTypePropInfo = enumTypePropInfo
        this.subPatternsPropInfo = subPatternsPropInfo
    }
}

class EnumPatternPosInfos {
    let dotPos: Option<CodePosition>
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>
    let commasPos: Array<CodePosition>

    init(dotPos: Option<CodePosition>, lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>,
        commasPos: Array<CodePosition>) {
        this.dotPos = dotPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
    }
}
/**
 * @brief EnumPattern class represents a pattern for an enumeration case.
 */
public class EnumPattern <: Pattern {
    private let startPos: CodePosition

    private let propInfos: EnumPatternPropInfos

    private let posInfos: EnumPatternPosInfos
    /**
     * @brief Get the positions of commas in the code.
     *
     * @return Array<CodePositionRange> containing the positions of commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let commasPos = ArrayList<CodePositionRange>()
        for (comma in posInfos.commasPos) {
            commasPos.add(CodePositionRange(comma, comma + SyntaxNodeKind.CommaToken.size))
        }
        return commasPos.toArray()
    }

    /**
     * @brief Get the position of the dot operator.
     *
     * @return Option<CodePositionRange> representing the position of the dot operator.
     */
    public func getDotPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.dotPos) {
            return (CodePositionRange(v, v + SyntaxNodeKind.DotToken.size))
        }
        None
    }

    /**
     * @brief Get the position of the left parenthesis.
     *
     * @return Option<CodePositionRange> representing the position of the left parenthesis.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.lParenPos) {
            return (CodePositionRange(v, v + SyntaxNodeKind.LParenToken.size))
        }
        None
    }

    /**
     * @brief Get the position of the right parenthesis.
     *
     * @return Option<CodePositionRange> representing the position of the right parenthesis.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.rParenPos) {
            return (CodePositionRange(v, v + SyntaxNodeKind.RParenToken.size))
        }
        None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: EnumPatternPosInfos,
        propInfos: EnumPatternPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with enum constructor, enum type and sub-patterns.
     */
    public init(enumConstructor: SymbolRef, enumType: Option<CompositeType>, subPatterns: Array<Pattern>,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createEnumPatternImpl(enumConstructor, enumType, subPatterns, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<EnumPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
        this.startPos = startPos
    }

    /**
     * @brief The enumeration constructor.
     */
    public prop enumConstructor: SymbolRef {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.enumConstructorPropInfo.index]
            let offset = propInfos.enumConstructorPropInfo.offset
            cast<SymbolRef>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The prefix type of enum pattern.
     *
     * For example, `p1.p0.E<Int64>` is the enumType of pattern `p1.p0.E<Int64>.C0(x)`.
     */
    public prop enumType: Option<CompositeType> {
        get() {
            if (let Some(propInfo) <- propInfos.enumTypePropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<CompositeType>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief Sub-patterns for the enumeration pattern.
     */
    public prop subPatterns: Array<Pattern> {
        get() {
            translatePatternChildren(nodeImpl, startPos, this, propInfos.subPatternsPropInfo)
        }
    }
}

class TuplePatternPropInfos {
    let subPatternsPropInfo: Array<PropInfo>

    init(subPatternsPropInfo: Array<PropInfo>) {
        this.subPatternsPropInfo = subPatternsPropInfo
    }
}

class TuplePatternPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let commasPos: Array<CodePosition>

    init(
        lParenPos: CodePosition,
        rParenPos: CodePosition,
        commasPos: Array<CodePosition>
    ) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
    }
}

/**
 * @brief TuplePattern class represents a pattern for a tuple.
 */
public class TuplePattern <: Pattern {
    private let startPos: CodePosition

    private let propInfos: TuplePatternPropInfos

    private let posInfos: TuplePatternPosInfos

    /**
     * @brief Get the position of the left parenthesis.
     *
     * @return CodePositionRange representing the position of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        CodePositionRange(posInfos.lParenPos, posInfos.lParenPos + SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position of the right parenthesis.
     *
     * @return CodePositionRange representing the position of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        CodePositionRange(posInfos.rParenPos, posInfos.rParenPos + SyntaxNodeKind.RParenToken.size)
    }

    /**
     * @brief Get the positions of commas in the code.
     *
     * @return Array<CodePositionRange> containing the positions of commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let commasPos = ArrayList<CodePositionRange>()
        for (comma in posInfos.commasPos) {
            commasPos.add(CodePositionRange(comma, comma + SyntaxNodeKind.CommaToken.size))
        }
        return commasPos.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: TuplePatternPosInfos,
        propInfos: TuplePatternPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with sub-patterns.
     * @throws Exception if the input 'subPatterns' contains less than 2 elements.
     */
    public init(subPatterns: Array<Pattern>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createTuplePatternImpl(subPatterns, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TuplePattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
        this.startPos = startPos
    }

    /**
     * @brief Sub-patterns for the tuple.
     */
    public prop subPatterns: Array<Pattern> {
        get() {
            translatePatternChildren(nodeImpl, startPos, this, propInfos.subPatternsPropInfo)
        }
    }
}

class TypePatternPropInfos {
    let patternTypePropInfo: PropInfo
    let subPatternPropInfo: PropInfo

    init(patternTypePropInfo: PropInfo, subPatternPropInfo: PropInfo) {
        this.patternTypePropInfo = patternTypePropInfo
        this.subPatternPropInfo = subPatternPropInfo
    }
}

class TypePatternPosInfos {
    let colonPos: CodePosition
    init(colonPos: CodePosition) {
        this.colonPos = colonPos
    }
}
/**
 * @brief TypePattern class represents a pattern with a specific type.
 */
public class TypePattern <: Pattern {
    private let startPos: CodePosition

    private let propInfos: TypePatternPropInfos

    /**
     * @brief Get the position of the colon.
     *
     * @return CodePositionRange representing the position of the colon.
     */
    public func getColonPos(): CodePositionRange {
        CodePositionRange(posInfos.colonPos, posInfos.colonPos + SyntaxNodeKind.RParenToken.size)
    }

    private let posInfos: TypePatternPosInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: TypePatternPosInfos,
        propInfos: TypePatternPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with pattern type and sub-pattern.
     */
    public init(subPattern: Pattern, patternType: TypeAnnotation, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createTypePatternImpl(subPattern, patternType, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TypePattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
        this.startPos = startPos
    }

    /**
     * @brief Type annotation for the pattern.
     */
    public prop patternType: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.patternTypePropInfo.index]
            let offset = propInfos.patternTypePropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
    /**
     * @brief Sub-pattern associated with the type.
     */
    public prop subPattern: Pattern {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.subPatternPropInfo.index]
            let offset = propInfos.subPatternPropInfo.offset
            cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

/**
 * @brief VarOrEnumPattern class represents a pattern for a variable or enumeration.
 */
public class VarOrEnumPattern <: Pattern {
    private let identifier_: String

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, identifier_: String,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.identifier_ = identifier_
    }

    /**
     * @brief Initialize node with the identifier.
     */
    public init(identifier: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createVarOrEnumPatternImpl(identifier, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<VarOrEnumPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.identifier_ = identifier
    }

    /**
     * @brief Identifier for the variable or enumeration.
     */
    public prop identifier: String {
        get() {
            identifier_
        }
    }
}

/**
 * @brief VarPattern class represents a pattern for a variable.
 */
public class VarPattern <: Pattern {
    private let name_: String

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
    }

    /**
     * @brief Initialize node with variable name.
     */
    public init(name: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createVarPatternImpl(name, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<VarPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.name_ = name
    }

    /**
     * @brief Name of the variable.
     */
    public prop name: String {
        get() {
            name_
        }
    }
}

/**
 * @brief WildcardPattern class represents a wildcard pattern.
 */
public class WildcardPattern <: Pattern {
    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
    }

    /**
     * @brief Initialize node.
     */
    public init(comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createWildcardPatternImpl(comments: comments))
    }
}
