/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList

private func translateExprChild<T>(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfo: PropInfo): T where T <: SyntaxTreeNode {
    let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
    return cast<T>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, parentNode)).getOrThrow()
}

private func createExprTokenRange(pos: CodePosition, size: Int64): CodePositionRange {
    return CodePositionRange(pos, pos + size)
}

private func createExprTokenRanges(positions: Array<CodePosition>, size: Int64): Array<CodePositionRange> {
    let ret = ArrayList<CodePositionRange>()
    for (pos in positions) {
        ret.add(createExprTokenRange(pos, size))
    }
    return ret.toArray()
}

sealed abstract class Expr <: SyntaxTreeNode {
    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(nodePos, nodeImpl, parentNode, commentsPropInfo)
    }

    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
    }
}

class ArrayLiteralPosInfos {
    let lSquarePos: CodePosition
    let rSquarePos: CodePosition
    let commasPos: Array<CodePosition>

    init(lSquarePos: CodePosition, rSquarePos: CodePosition, commasPos: Array<CodePosition>) {
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.commasPos = commasPos
    }
}

class ArrayLiteralPropInfos {
    let elementsPropInfo: PropInfo

    init(elementsPropInfo: PropInfo) {
        this.elementsPropInfo = elementsPropInfo
    }
}

/**
 * @brief Represents an literal of array type.
 *
 * The ArrayLiteral class is a subclass of Expr and is used to model array expressions.
 * It contains an array of Expr objects.
 */
public class ArrayLiteral <: Expr {
    private let startPos: CodePosition

    private let posInfos: ArrayLiteralPosInfos
    private let propInfos: ArrayLiteralPropInfos

    /**
     * @brief Gets the position range of the left square bracket in the code.
     *
     * @return A CodePositionRange representing the position range of the left square bracket.
     */
    public func getLSquarePos(): CodePositionRange {
        return createExprTokenRange(posInfos.lSquarePos, SyntaxNodeKind.LSquareToken.size)
    }

    /**
     * @brief Gets the position range of the right square bracket in the code.
     *
     * @return A CodePositionRange representing the position range of the right square bracket.
     */
    public func getRSquarePos(): CodePositionRange {
        return createExprTokenRange(posInfos.rSquarePos, SyntaxNodeKind.RSquareToken.size)
    }

    /**
     * @brief Gets the position ranges of the commas in the code.
     *
     * @return An ArrayList of CodePositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createExprTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ArrayLiteralPosInfos,
        propInfos: ArrayLiteralPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new ArrayLiteral node.
     */
    public init(elements: Array<Expr>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createArrayLiteralImpl(elements, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ArrayLiteral>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Array of expressions.
     *
     * This member variable stores an array of expressions of type Expr.
     */
    public prop elements: Array<Expr> {
        get() {
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.elementsPropInfo.offset,
                index: propInfos.elementsPropInfo.index)
            let exprs = ArrayList<Expr>()
            let predictExpr = {
                kind: SyntaxNodeKind => kind.isExpr()
            }
            while (lp.look(predictExpr)) {
                if (let Some(node) <- lp.consume()) {
                    exprs.add(
                        cast<Expr>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this)).getOrThrow())
                    lp.moveOffset(node)
                }
                lp.moveOffset(lp.lookAndConsume(SyntaxNodeKind.CommaToken))
            }
            exprs.toArray()
        }
    }
}

class AsExprPropInfos {
    let srcValPropInfo: PropInfo
    let targetTypeAnnotationPropInfo: PropInfo

    init(srcValPropInfo: PropInfo, targetTypeAnnotationPropInfo: PropInfo) {
        this.srcValPropInfo = srcValPropInfo
        this.targetTypeAnnotationPropInfo = targetTypeAnnotationPropInfo
    }
}

class AsExprPosInfos {
    let asKeyWordPos: CodePosition

    init(asKeyWordPos: CodePosition) {
        this.asKeyWordPos = asKeyWordPos
    }
}

/**
 * @brief Represents an expression for type casting.
 *
 * The AsExpr class is a subclass of Expr and is used to model type casting expressions.
 * It contains a source value expression and a target type annotation.
 */
public class AsExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: AsExprPropInfos

    private let posInfos: AsExprPosInfos

    /**
     * @brief Retrieves the position range of the 'as' keyword.
     *
     * @return The position range representing the start and end positions of the 'as' keyword.
     */
    public func getAsKeyWordPos(): CodePositionRange {
        let endPos = posInfos.asKeyWordPos + SyntaxNodeKind.AsToken.size
        return CodePositionRange(posInfos.asKeyWordPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfo: AsExprPosInfos,
        propInfo: AsExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize node with source value and target type.
     */
    public init(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createAsExprImpl(srcVal, targetTypeAnnotation, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<AsExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Source expression for type casting.
     *
     * This member variable stores the source expression that needs to be type casted.
     */
    public prop srcVal: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.srcValPropInfo)
        }
    }

    /**
     * @brief Target type annotation.
     *
     * This member variable stores the target type annotation to which the source value is casted.
     */
    public prop targetTypeAnnotation: TypeAnnotation {
        get() {
            return translateExprChild<TypeAnnotation>(nodeImpl, startPos, this,
                propInfos.targetTypeAnnotationPropInfo)
        }
    }
}

/**
 * @brief Enumeration for different assignment operation kinds.
 *
 * The AssignOpKind enumeration represents various types of assignment operations
 * that can be used in expressions. Each operation kind is an identifier that
 * specifies the type of assignment to be performed.
 */
public enum AssignOpKind {
    | AddAssign
    | AndAssign
    | Assign
    | BitAndAssign
    | BitOrAssign
    | BitXorAssign
    | DivAssign
    | ExpAssign
    | LShiftAssign
    | ModAssign
    | MulAssign
    | OrAssign
    | RShiftAssign
    | SubAssign
    | ...
}

class AssignExprPropInfos {
    let lhsPropInfo: PropInfo
    let rhsPropInfo: PropInfo

    init(lhsPropInfo: PropInfo, rhsPropInfo: PropInfo) {
        this.lhsPropInfo = lhsPropInfo
        this.rhsPropInfo = rhsPropInfo
    }
}

class AssignExprPosInfos {
    let assignOpPos: CodePosition

    init(assignOpPos: CodePosition) {
        this.assignOpPos = assignOpPos
    }
}

/**
 * @brief Represents an assignment expression.
 *
 * The AssignExpr class is a subclass of Expr and is used to model assignment expressions.
 * It contains an assignment operator kind and two operands: the left-hand side (lhs)
 * and the right-hand side (rhs).
 */
public class AssignExpr <: Expr {
    private let assignOpKind_: AssignOpKind

    private let startPos: CodePosition

    private let propInfos: AssignExprPropInfos

    private let posInfos: AssignExprPosInfos

    /**
     * @brief Retrieves the position range of the assignment operator.
     *
     * @return The position range of the assignment operator as a CodePositionRange object.
     */
    public func getAssignOpPos(): CodePositionRange {
        let endPos = posInfos.assignOpPos + match (assignOpKind) {
            case AddAssign => SyntaxNodeKind.AddAssignToken.size
            case AndAssign => SyntaxNodeKind.AndAssignToken.size
            case Assign => SyntaxNodeKind.AssignToken.size
            case BitAndAssign => SyntaxNodeKind.BitAndAssignToken.size
            case BitOrAssign => SyntaxNodeKind.BitOrAssignToken.size
            case BitXorAssign => SyntaxNodeKind.BitXorAssignToken.size
            case DivAssign => SyntaxNodeKind.DivAssignToken.size
            case ExpAssign => SyntaxNodeKind.ExpAssignToken.size
            case LShiftAssign => SyntaxNodeKind.LShiftAssignToken.size
            case ModAssign => SyntaxNodeKind.ModAssignToken.size
            case MulAssign => SyntaxNodeKind.MulAssignToken.size
            case OrAssign => SyntaxNodeKind.OrAssignToken.size
            case RShiftAssign => SyntaxNodeKind.RShiftAssignToken.size
            case SubAssign => SyntaxNodeKind.SubAssignToken.size
            case _ => 0
        }
        return CodePositionRange(posInfos.assignOpPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, assignOpKind_: AssignOpKind,
        posInfos: AssignExprPosInfos, propInfos: AssignExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.assignOpKind_ = assignOpKind_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new AssignExpr node.
     */
    public init(assignOpKind: AssignOpKind, lhs: SyntaxTreeNode, rhs: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createAssignExprImpl(assignOpKind, lhs, rhs, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<AssignExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.assignOpKind_ = assignOpKind
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Type of assignment operation.
     *
     * This member variable stores the kind of assignment operation specified by the
     * AssignOpKind enumeration.
     */
    public prop assignOpKind: AssignOpKind {
        get() {
            assignOpKind_
        }
    }

    /**
     * @brief Left-hand side expression.
     *
     * This member variable stores the left-hand side expression where the value is
     * assigned.
     */
    public prop lhs: SyntaxTreeNode {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.lhsPropInfo.index]
            let offset = propInfos.lhsPropInfo.offset
            cast<SyntaxTreeNode>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief Right-hand side expression.
     *
     * This member variable stores the right-hand side expression providing the value
     * to be assigned.
     */
    public prop rhs: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.rhsPropInfo)
        }
    }
}

/**
 * @brief Enumeration for different atomic condition types.
 *
 * The AtomicCondition enumeration represents various types of atomic conditions
 * that can be used in logical expressions. Each condition type is an identifier that
 * specifies the structure and semantics of the condition, which can be a let pattern,
 * an expression, a parenthesized condition, or other forms.
 */
public enum AtomicCondition {
    | LetPatternCondition(LetPattern)
    | Expression(Expr)
    | ParenConditionConstructor(ParenCondition)
    | ...
}

/**

 * @brief Enumeration for different binary operation kinds.
 *
 * The BinaryOpKind enumeration represents various types of binary operations
 * that can be performed on expressions. Each operation kind is an identifier that
 * specifies the type of operation to be performed.
 * */
public enum BinaryOpKind {
    | Add
    | And
    | BitAnd
    | BitOr
    | BitXor
    | Coalescing
    | Composition
    | Div
    | Equal
    | Exp
    | Ge
    | Gt
    | Le
    | LShift
    | Lt
    | Mod
    | Mul
    | NotEq
    | Or
    | Pipeline
    | RShift
    | Sub
    | ...
}

class BinaryExprPropInfos {
    let lhsPropInfo: PropInfo
    let rhsPropInfo: PropInfo

    init(lhsPropInfo: PropInfo, rhsPropInfo: PropInfo) {
        this.lhsPropInfo = lhsPropInfo
        this.rhsPropInfo = rhsPropInfo
    }
}

class BinaryExprPosInfos {
    let opPos: CodePosition

    init(opPos: CodePosition) {
        this.opPos = opPos
    }
}

/**
 * @brief Represents a binary expression.
 *
 * The BinaryExpr class is a subclass of Expr and is used to model binary expressions.
 * It contains a binary operator kind and two operands: the left-hand side (lhs)
 * and the right-hand side (rhs).
 */
public class BinaryExpr <: Expr {
    private let opKInd_: BinaryOpKind

    private let startPos: CodePosition

    private let propInfos: BinaryExprPropInfos

    private let posInfos: BinaryExprPosInfos

    /**
     * @brief Retrieves the position range of the operator in the code.
     *
     * @return CodePositionRange representing the start and end positions of the operator.
     */
    public func getOperatorPos(): CodePositionRange {
        let endPos = posInfos.opPos + match (opKind) {
            case BinaryOpKind.Add => SyntaxNodeKind.AddToken.size
            case BinaryOpKind.And => SyntaxNodeKind.AndToken.size
            case BinaryOpKind.BitAnd => SyntaxNodeKind.BitAndToken.size
            case BinaryOpKind.BitOr => SyntaxNodeKind.BitOrToken.size
            case BinaryOpKind.BitXor => SyntaxNodeKind.BitXorToken.size
            case BinaryOpKind.Coalescing => SyntaxNodeKind.CoalescingToken.size
            case BinaryOpKind.Composition => SyntaxNodeKind.CompositionToken.size
            case BinaryOpKind.Div => SyntaxNodeKind.DivToken.size
            case BinaryOpKind.Equal => SyntaxNodeKind.EqualToken.size
            case BinaryOpKind.Exp => SyntaxNodeKind.ExpToken.size
            case BinaryOpKind.Ge => SyntaxNodeKind.GeToken.size
            case BinaryOpKind.Gt => SyntaxNodeKind.GtToken.size
            case BinaryOpKind.Le => SyntaxNodeKind.LeToken.size
            case BinaryOpKind.LShift => SyntaxNodeKind.LShiftToken.size
            case BinaryOpKind.Lt => SyntaxNodeKind.LtToken.size
            case BinaryOpKind.Mod => SyntaxNodeKind.ModToken.size
            case BinaryOpKind.Mul => SyntaxNodeKind.MulToken.size
            case BinaryOpKind.NotEq => SyntaxNodeKind.NotEqToken.size
            case BinaryOpKind.Or => SyntaxNodeKind.OrToken.size
            case BinaryOpKind.Pipeline => SyntaxNodeKind.PipelineToken.size
            case BinaryOpKind.RShift => SyntaxNodeKind.RShiftToken.size
            case BinaryOpKind.Sub => SyntaxNodeKind.SubToken.size
            case _ => 0
        }
        return CodePositionRange(posInfos.opPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, opKInd_: BinaryOpKind,
        posInfos: BinaryExprPosInfos, propInfos: BinaryExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.opKInd_ = opKInd_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with left expr, operator and right expr.
     */
    public init(lhs: Expr, opKind: BinaryOpKind, rhs: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createBinaryExprImpl(lhs, opKind, rhs, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<BinaryExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
        this.opKInd_ = opKind
    }

    public prop lhs: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.lhsPropInfo.index]
            let offset = propInfos.lhsPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    public prop opKind: BinaryOpKind {
        get() {
            opKInd_
        }
    }

    public prop rhs: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.rhsPropInfo)
        }
    }
}

/**
 * @brief Represents a break expression used to exit loops.
 */
public class BreakExpr <: Expr {
    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
    }

    /**
     * @brief Initialize node.
     */
    public init(comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createBreakExprImpl(comments: comments))
    }
}

class CallExprPropInfos {
    let calleePropInfo: PropInfo
    let argumentPropInfo: Array<PropInfo>

    init(calleePropInfo: PropInfo, argumentPropInfo: Array<PropInfo>) {
        this.calleePropInfo = calleePropInfo
        this.argumentPropInfo = argumentPropInfo
    }
}

class CallExprPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let commasPos: Array<CodePosition>

    init(lParenPos: CodePosition, rParenPos: CodePosition, commasPos: Array<CodePosition>) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
    }
}

/**
 * @brief Represents a function call expression.
 *
 * The CallExpr class is a subclass of Expr and is used to model function call expressions.
 * It contains an array of arguments and a callee expression representing the function
 * to be called.
 */
public class CallExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: CallExprPropInfos

    private let posInfos: CallExprPosInfos

    /**
     * @brief Gets the position range of the left parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.lParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Gets the position range of the right parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.rParenPos, SyntaxNodeKind.RParenToken.size)
    }

    /**
     * @brief Gets the position ranges of the commas in the arguments.
     *
     * @return An Array of PositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createExprTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: CallExprPosInfos,
        propInfos: CallExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with callee and arguments.
     */
    public init(callee: Expr, arguments: Array<Argument>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createCallExprImpl(callee, arguments, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<CallExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    public prop arguments: Array<Argument> {
        get() {
            let arguments = ArrayList<Argument>()
            for (propInfo in propInfos.argumentPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                arguments.add(
                    cast<Argument>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            arguments.toArray()
        }
    }

    public prop callee: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.calleePropInfo.index]
            let offset = propInfos.calleePropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class CatchPatternPropInfos {
    let exceptionTypePropInfo: Array<PropInfo>
    let patternPropInfo: PropInfo

    init(exceptionTypePropInfo: Array<PropInfo>, patternPropInfo: PropInfo) {
        this.exceptionTypePropInfo = exceptionTypePropInfo
        this.patternPropInfo = patternPropInfo
    }
}

class CatchPatternPosInfos {
    let colonPos: Option<CodePosition>
    let bitOrsPos: Array<CodePosition>
    init(colonPos: Option<CodePosition>, bitOrsPos: Array<CodePosition>) {
        this.colonPos = colonPos
        this.bitOrsPos = bitOrsPos
    }
}
/**
 * @brief Represents a catch pattern in a try-catch expression.
 *        It defines the exception types and pattern used for matching.
 */
public class CatchPattern <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: CatchPatternPropInfos

    private let posInfos: CatchPatternPosInfos

    /**
     * @brief Get the position of the colon.
     *
     * @return Option<CodePositionRange> representing the position of the colon.
     */
    public func getColonPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.colonPos) {
            return (CodePositionRange(v, v + SyntaxNodeKind.ColonToken.size))
        }
        None
    }

    /**
     * @brief Get the positions of bitwise 'or' operators in the code.
     *
     * @return Array<CodePositionRange> containing the positions of bitwise 'or' operators.
     */
    public func getBitOrsPos(): Array<CodePositionRange> {
        let bitOrsPos = ArrayList<CodePositionRange>()
        for (bitOr in posInfos.bitOrsPos) {
            bitOrsPos.add(CodePositionRange(bitOr, bitOr + SyntaxNodeKind.BitOrToken.size))
        }
        return bitOrsPos.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: CatchPatternPosInfos,
        propInfos: CatchPatternPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with exception types and pattern.
     */
    public init(pattern: Pattern, exceptionType: Array<TypeAnnotation>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createCatchPatternImpl(pattern, exceptionType, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<CatchPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The array of exception types that this catch pattern handles.
     */
    public prop exceptionType: Array<TypeAnnotation> {
        get() {
            let types = ArrayList<TypeAnnotation>()
            for (propInfo in propInfos.exceptionTypePropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                types.add(
                    cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                        .getOrThrow())
            }
            types.toArray()
        }
    }

    /**
     * @brief The pattern used for matching exceptions.
     */
    public prop pattern: Pattern {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.patternPropInfo.index]
            let offset = propInfos.patternPropInfo.offset
            cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class ConjunctionConditionPropInfos {
    let condPropInfo: Array<PropInfo>

    init(condPropInfo: Array<PropInfo>) {
        this.condPropInfo = condPropInfo
    }
}

class ConjunctionConditionPosInfos {
    let andsPos: Array<CodePosition>

    init(andsPos: Array<CodePosition>) {
        this.andsPos = andsPos
    }
}

/**
 * @brief Represents a logical conjunction (AND) of atomic conditions.
 *
 * This class aggregates multiple atomic conditions that must all evaluate to true
 * for the conjunction to be satisfied. It models a logical AND operation between
 * its constituent atomic conditions.
 */
public class ConjunctionCondition <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: ConjunctionConditionPropInfos

    private let posInfos: ConjunctionConditionPosInfos

    /**
     * @brief Retrieves the positions of 'AND' operators in the conjunction.
     * @return An array of CodePositionRange objects for each 'AND' operator.
     */
    public func getAndsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.andsPos.size) {
            let endPos = posInfos.andsPos[i] + SyntaxNodeKind.AndToken.size
            ret.add(CodePositionRange(posInfos.andsPos[i], endPos))
        }
        ret.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: ConjunctionConditionPosInfos, propInfos: ConjunctionConditionPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with conditions.
     */
    public init(cond: Array<AtomicCondition>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createConjunctionConditionImpl(cond, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ConjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos, None))
            .getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The array of atomic conditions in this conjunction.
     *
     * This member holds the list of AtomicConditions that are AND'ed together.
     * For the entire conjunction to evaluate to true, all of these atomic conditions
     * must individually evaluate to true.
     *
     * The array is immutable once initialized, ensuring the logical structure
     * remains constant during evaluation. An empty array will result in the
     * conjunction evaluating to true (vacuous truth).
     */
    public prop cond: Array<AtomicCondition> {
        get() {
            let conds = ArrayList<AtomicCondition>()
            for (propInfo in propInfos.condPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                let translateNode = SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)
                if (let Some(target) <- cast<LetPattern>(translateNode)) {
                    conds.add(LetPatternCondition(target))
                } else if (let Some(target) <- cast<ParenCondition>(translateNode)) {
                    conds.add(ParenConditionConstructor(target))
                } else if (let Some(target) <- cast<Expr>(translateNode)) {
                    conds.add(Expression(target))
                }
            }
            conds.toArray()
        }
    }
}

/**
 * @brief Represents a continue expression used to skip to the next iteration of a loop.
 */
public class ContinueExpr <: Expr {
    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
    }

    /**
     * @brief Initialize node.
     */
    public init(comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createContinueExprImpl(comments: comments))
    }
}

class DisjunctionConditionPropInfos {
    let condPropInfo: Array<PropInfo>

    init(condPropInfo: Array<PropInfo>) {
        this.condPropInfo = condPropInfo
    }
}

class DisjunctionConditionPosInfos {
    let orsPos: Array<CodePosition>

    init(orsPos: Array<CodePosition>) {
        this.orsPos = orsPos
    }
}

/**
 * @brief Represents a logical disjunction (OR) of conjunction conditions.
 *
 * This class aggregates multiple conjunction conditions where at least one must evaluate
 * to true for the disjunction to be satisfied. It models a logical OR operation between
 * its constituent conjunctions, forming a logical expression in disjunctive normal form (DNF).
 */
public class DisjunctionCondition <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: DisjunctionConditionPropInfos

    private let posInfos: DisjunctionConditionPosInfos

    /**
     * @brief Get position ranges of all '||' (or) tokens.
     * @return Array of ranges covering each '||' token in source order.
     */
    public func getOrsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.orsPos.size) {
            let endPos = posInfos.orsPos[i] + SyntaxNodeKind.OrToken.size
            ret.add(CodePositionRange(posInfos.orsPos[i], endPos))
        }
        ret.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: DisjunctionConditionPosInfos, propInfos: DisjunctionConditionPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with conditions.
     */
    public init(cond: Array<ConjunctionCondition>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createDisjunctionConditionImpl(cond, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<DisjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos, None))
            .getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The array of conjunction conditions in this disjunction.
     *
     * This member holds the list of ConjunctionConditions that are OR'ed together.
     * For the entire disjunction to evaluate to true, at least one of these
     * conjunction conditions must evaluate to true.
     *
     * The array is immutable once initialized, ensuring the logical structure
     * remains constant during evaluation.
     */
    public prop cond: Array<ConjunctionCondition> {
        get() {
            let conds = ArrayList<ConjunctionCondition>()
            for (propInfo in propInfos.condPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                conds.add(
                    cast<ConjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                        .getOrThrow())
            }
            conds.toArray()
        }
    }
}

class DoWhileExprPosInfos {
    let condLParenPos: CodePosition
    let condRParenPos: CodePosition
    let doKeyWordPos: CodePosition
    let whileKeyWordPos: CodePosition

    init(condLParenPos: CodePosition, condRParenPos: CodePosition, doKeyWordPos: CodePosition,
        whileKeyWordPos: CodePosition) {
        this.condLParenPos = condLParenPos
        this.condRParenPos = condRParenPos
        this.doKeyWordPos = doKeyWordPos
        this.whileKeyWordPos = whileKeyWordPos
    }
}

class DoWhileExprPropInfos {
    let bodyPropInfo: PropInfo
    let conditionPropInfo: PropInfo

    init(bodyPropInfo: PropInfo, conditionPropInfo: PropInfo) {
        this.bodyPropInfo = bodyPropInfo
        this.conditionPropInfo = conditionPropInfo
    }
}

/**
 * @brief Represents a do-while loop expression.
 *        It consists of a loop body and a continuation condition.
 */
public class DoWhileExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: DoWhileExprPropInfos

    private let posInfos: DoWhileExprPosInfos

    /**
     * @brief Get the position range of the 'do' keyword.
     */
    public func getDoKeyWordPos(): CodePositionRange {
        let endPos = posInfos.doKeyWordPos + SyntaxNodeKind.DoToken.size
        CodePositionRange(posInfos.doKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the 'while' keyword.
     */
    public func getWhileKeyWordPos(): CodePositionRange {
        return createExprTokenRange(posInfos.whileKeyWordPos, SyntaxNodeKind.WhileToken.size)
    }

    /**
     * @brief Get the position range of the left parenthesis in the condition.
     */
    public func getCondLParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.condLParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position range of the right parenthesis in the condition.
     */
    public func getCondRParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.condRParenPos, SyntaxNodeKind.RParenToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: DoWhileExprPosInfos,
        propInfos: DoWhileExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new DoWhileExpr node.
     */
    public init(body: Block, condition: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createDoWhileExprImpl(body, condition, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<DoWhileExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the loop as a block of code.
     */
    public prop body: Block {
        get() {
            return translateExprChild<Block>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The loop continuation condition as an expression.
     */
    public prop condition: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.conditionPropInfo.index]
            let offset = propInfos.conditionPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class ForInExprPosInfos {
    let forKeyWordPos: CodePosition
    let inKeyWordPos: CodePosition
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let whereKeyWordPos: Option<CodePosition>

    init(forKeyWordPos: CodePosition, inKeyWordPos: CodePosition, lParenPos: CodePosition, rParenPos: CodePosition,
        whereKeyWordPos: Option<CodePosition>) {
        this.forKeyWordPos = forKeyWordPos
        this.inKeyWordPos = inKeyWordPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.whereKeyWordPos = whereKeyWordPos
    }
}

class ForInExprPropInfos {
    let bodyPropInfo: PropInfo
    let exprPropInfo: PropInfo
    let patternPropInfo: PropInfo
    let patternGuardPropInfo: Option<PropInfo>

    init(bodyPropInfo: PropInfo, exprPropInfo: PropInfo, patternPropInfo: PropInfo,
        patternGuardPropInfo: Option<PropInfo>) {
        this.bodyPropInfo = bodyPropInfo
        this.exprPropInfo = exprPropInfo
        this.patternPropInfo = patternPropInfo
        this.patternGuardPropInfo = patternGuardPropInfo
    }
}

/**
 * @brief Represents a for-in loop expression.
 *        It iterates over a collection using a specified pattern.
 */
public class ForInExpr <: Expr {
    private let startPos: CodePosition

    private let posInfos: ForInExprPosInfos

    private let propInfos: ForInExprPropInfos

    /**
     * @brief Get the position range of the 'for' keyword.
     */
    public func getForKeyWordPos(): CodePositionRange {
        let endPos = posInfos.forKeyWordPos + SyntaxNodeKind.ForToken.size
        CodePositionRange(posInfos.forKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the 'in' keyword.
     */
    public func getInKeyWordPos(): CodePositionRange {
        let endPos = posInfos.inKeyWordPos + SyntaxNodeKind.InToken.size
        CodePositionRange(posInfos.inKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the 'where' keyword if present.
     */
    public func getWhereKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.whereKeyWordPos) {
            let endPos = v + SyntaxNodeKind.WhereToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Get the position range of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ForInExprPosInfos,
        propInfos: ForInExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with loop body, range expr, iterator pattern and condition expr.
     */
    public init(body: Block, expr: Expr, pattern: Pattern, patternGuard: Option<Expr>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createForInExprImpl(body, expr, pattern, patternGuard, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ForInExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The body of the loop as a block of code.
     */
    public prop body: Block {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.bodyPropInfo.index]
            let offset = propInfos.bodyPropInfo.offset
            cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The expression representing the collection to iterate over.
     */
    public prop expr: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.exprPropInfo.index]
            let offset = propInfos.exprPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The pattern used for destructuring the iterated values.
     */
    public prop pattern: Pattern {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.patternPropInfo.index]
            let offset = propInfos.patternPropInfo.offset
            cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief An optional guard expression for the pattern.
     */
    public prop patternGuard: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.patternGuardPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}

class IfExprPosInfos {
    let ifKeyWordPos: CodePosition
    let condLParenPos: CodePosition
    let condRParenPos: CodePosition
    let elseKeyWordPos: Option<CodePosition>

    init(ifKeyWordPos: CodePosition, condLParenPos: CodePosition, condRParenPos: CodePosition,
        elseKeyWordPos: Option<CodePosition>) {
        this.ifKeyWordPos = ifKeyWordPos
        this.condLParenPos = condLParenPos
        this.condRParenPos = condRParenPos
        this.elseKeyWordPos = elseKeyWordPos
    }
}

class IfExprPropInfos {
    let conditionPropInfo: PropInfo
    let elseBlockPropInfo: Option<PropInfo>
    let elseIfPropInfo: Option<PropInfo>
    let ifBlockPropInfo: PropInfo

    init(conditionPropInfo: PropInfo, elseBlockPropInfo: Option<PropInfo>, elseIfPropInfo: Option<PropInfo>,
        ifBlockPropInfo: PropInfo) {
        this.conditionPropInfo = conditionPropInfo
        this.elseBlockPropInfo = elseBlockPropInfo
        this.elseIfPropInfo = elseIfPropInfo
        this.ifBlockPropInfo = ifBlockPropInfo
    }
}

/**
 * @brief Represents an if expression.
 *        It consists of a condition, optional else-if, and else blocks.
 */
public class IfExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: IfExprPropInfos

    private let posInfos: IfExprPosInfos

    /**
     * @brief Get position range of 'if' keyword.
     * @return Range covering the 'if' token.
     */
    public func getIfKeyWordPos(): CodePositionRange {
        let endPos = posInfos.ifKeyWordPos + SyntaxNodeKind.IfToken.size
        CodePositionRange(posInfos.ifKeyWordPos, endPos)
    }

    /**
     * @brief Get position range of left parenthesis for condition.
     * @return Range covering the condition's left parenthesis.
     */
    public func getCondLParenPos(): CodePositionRange {
        let endPos = posInfos.condLParenPos + SyntaxNodeKind.LParenToken.size
        CodePositionRange(posInfos.condLParenPos, endPos)
    }

    /**
     * @brief Get position range of right parenthesis for condition.
     * @return Range covering the condition's right parenthesis.
     */
    public func getCondRParenPos(): CodePositionRange {
        let endPos = posInfos.condRParenPos + SyntaxNodeKind.RParenToken.size
        CodePositionRange(posInfos.condRParenPos, endPos)
    }

    /**
     * @brief Get position range of 'else' keyword if present.
     * @return Optional range covering the 'else' token.
     */
    public func getElseKeyWordPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.elseKeyWordPos) {
            let endPos = v + SyntaxNodeKind.ElseToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: IfExprPosInfos,
        propInfos: IfExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new IfExpr node.
     */
    public init(condition: DisjunctionCondition, elseBlock: Option<Block>, elseIf: Option<IfExpr>, ifBlock: Block,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createIfExprImpl(condition, elseBlock, elseIf, ifBlock, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<IfExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The condition of the if statement.
     */
    public prop condition: DisjunctionCondition {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.conditionPropInfo.index]
            let offset = propInfos.conditionPropInfo.offset
            cast<DisjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                .getOrThrow()
        }
    }

    /**
     * @brief The optional else block.
     */
    public prop elseBlock: Option<Block> {
        get() {
            if (let Some(propInfo) <- propInfos.elseBlockPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The optional else-if expression.
     */
    public prop elseIf: Option<IfExpr> {
        get() {
            if (let Some(propInfo) <- propInfos.elseIfPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<IfExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The block of code executed if the condition is true.
     */
    public prop ifBlock: Block {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.ifBlockPropInfo.index]
            let offset = propInfos.ifBlockPropInfo.offset
            cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

/**
 * @brief Enumeration for increment or decrement operation kinds.
 *
 * The IncOrDecOpKind enumeration represents two types of operations:
 * decrement (Decr) and increment (Incr).
 */
public enum IncOrDecOpKind {
    | Decr
    | Incr
    | ...
}

class IncOrDecExprPropInfos {
    let operandPropInfo: PropInfo

    init(operandPropInfo: PropInfo) {
        this.operandPropInfo = operandPropInfo
    }
}

class IncOrDecExprPosInfos {
    let opPos: CodePosition

    init(opPos: CodePosition) {
        this.opPos = opPos
    }
}

/**
 * @brief Represents an increment or decrement expression.
 *
 * The IncOrDecExpr class is a subclass of Expr and is used to model increment or
 * decrement expressions. It contains an operation kind (kind) and an operand
 * expression (operand).
 */
public class IncOrDecExpr <: Expr {
    private let kind_: IncOrDecOpKind

    private let startPos: CodePosition

    private let propInfos: IncOrDecExprPropInfos

    private let posInfos: IncOrDecExprPosInfos

    /**
     * @brief Retrieves the position range of the operator in the code.
     *
     * @return The position range of the operator.
     */
    public func getOperatorPos(): CodePositionRange {
        let endPos = posInfos.opPos + SyntaxNodeKind.IncrToken.size
        return CodePositionRange(posInfos.opPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: IncOrDecOpKind,
        posInfos: IncOrDecExprPosInfos, propInfos: IncOrDecExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.kind_ = kind_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with operand and operator.
     */
    public init(kind: IncOrDecOpKind, operand: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createIncOrDecExprImpl(kind, operand, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<IncOrDecExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
        this.kind_ = kind
    }

    /**
     * @brief Type of increment or decrement operation.
     *
     * This member variable stores the kind of operation specified by the
     * IncOrDecOpKind enumeration, which can be either Decr (decrement) or Incr (increment).
     */
    public prop kind: IncOrDecOpKind {
        get() {
            kind_
        }
    }

    /**
     * @brief Expression to be incremented or decremented.
     *
     * This member variable stores the operand expression that will be affected by
     * the increment or decrement operation.
     */
    public prop operand: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.operandPropInfo)
        }
    }
}

class IsExprPropInfos {
    let srcValPropInfo: PropInfo
    let targetTypeAnnotationPropInfo: PropInfo

    init(srcValPropInfo: PropInfo, targetTypeAnnotationPropInfo: PropInfo) {
        this.srcValPropInfo = srcValPropInfo
        this.targetTypeAnnotationPropInfo = targetTypeAnnotationPropInfo
    }
}

class IsExprPosInfos {
    let isKeyWordPos: CodePosition

    init(isKeyWordPos: CodePosition) {
        this.isKeyWordPos = isKeyWordPos
    }
}

/**
 * @brief Represents an 'is' expression.
 *
 * The IsExpr class is a subclass of Expr and is used to model 'is' expressions.
 * It contains a source value expression (srcVal) and a target type annotation
 * (targetTypeAnnotation) to check the type of the source value.
 */
public class IsExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: IsExprPropInfos

    private let posInfos: IsExprPosInfos

    /**
     * @brief Retrieves the position range of the 'is' keyword.
     *
     * @return The position range representing the start and end positions of the 'is' keyword.
     */
    public func getIsKeyWordPos(): CodePositionRange {
        let endPos = posInfos.isKeyWordPos + SyntaxNodeKind.IsToken.size
        return CodePositionRange(posInfos.isKeyWordPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfo: IsExprPosInfos,
        propInfo: IsExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize node with source value and target type.
     */
    public init(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createIsExprImpl(srcVal, targetTypeAnnotation, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<IsExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Source value expression.
     *
     * This member variable stores the expression representing the source value that
     * will be checked against the target type.
     */
    public prop srcVal: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.srcValPropInfo)
        }
    }

    /**
     * @brief Target type annotation.
     *
     * This member variable stores the type annotation representing the target type
     * that the source value will be checked against.
     */
    public prop targetTypeAnnotation: TypeAnnotation {
        get() {
            return translateExprChild<TypeAnnotation>(nodeImpl, startPos, this,
                propInfos.targetTypeAnnotationPropInfo)
        }
    }
}

class LambdaPropInfos {
    let bodyPropInfo: Option<PropInfo>
    let paramsPropInfo: PropInfo

    init(bodyPropInfo: Option<PropInfo>, paramsPropInfo: PropInfo) {
        this.bodyPropInfo = bodyPropInfo
        this.paramsPropInfo = paramsPropInfo
    }
}

class LambdaPosInfos {
    let lCurlPos: CodePosition
    let rCurlPos: CodePosition
    let doubleArrowPos: Option<CodePosition>

    init(lCurlPos: CodePosition, rCurlPos: CodePosition, doubleArrowPos: Option<CodePosition>) {
        this.lCurlPos = lCurlPos
        this.rCurlPos = rCurlPos
        this.doubleArrowPos = doubleArrowPos
    }
}

/**
 * @brief Represents a lambda function expression.
 *        It consists of a body and parameters.
 */
public class Lambda <: Expr {
    private let startPos: CodePosition

    private let propInfos: LambdaPropInfos

    private let posInfos: LambdaPosInfos

    /**
     * @brief Gets the position range of the left curly brace in the lambda.
     *
     * @return A CodePositionRange representing the position range of the left curly brace.
     */
    public func getLCurlPos(): CodePositionRange {
        let endPos = posInfos.lCurlPos + SyntaxNodeKind.LCurlToken.size
        return CodePositionRange(posInfos.lCurlPos, endPos)
    }

    /**
     * @brief Gets the position range of the right curly brace in the lambda.
     *
     * @return A CodePositionRange representing the position range of the right curly brace.
     */
    public func getRCurlPos(): CodePositionRange {
        let endPos = posInfos.rCurlPos + SyntaxNodeKind.RCurlToken.size
        return CodePositionRange(posInfos.rCurlPos, endPos)
    }

    /**
     * @brief Gets the position range of the double arrow in thelambda.
     *
     * @return An Option of CodePositionRange representing the position range of the double arrow, if present.
     */
    public func getDoubleArrowPos(): Option<CodePositionRange> {
        if (let Some(doubleArrowPos) <- posInfos.doubleArrowPos) {
            let endPos = doubleArrowPos + SyntaxNodeKind.DoubleArrowToken.size
            return CodePositionRange(doubleArrowPos, endPos)
        } else {
            return None
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: LambdaPosInfos,
        propInfos: LambdaPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new Lambda node.
     */
    public init(body: Array<SyntaxTreeNode>, params: ParameterList, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createLambdaImpl(body, params, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Lambda>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the lambda as an array of syntax tree nodes.
     */
    public prop body: Array<SyntaxTreeNode> {
        get() {
            let body = ArrayList<SyntaxTreeNode>()
            if (let Some(propInfo) <- propInfos.bodyPropInfo) {
                let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfo.offset,
                    index: propInfo.index)
                let predictExprOrDecl = {
                    kind: SyntaxNodeKind => kind.isExpr() || kind.isDecl()
                }

                while (lp.look(predictExprOrDecl)) {
                    if (let Some(node) <- lp.consume()) {
                        body.add(
                            cast<SyntaxTreeNode>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                                .getOrThrow())
                        lp.moveOffset(node)
                    }
                }
            }

            body.toArray()
        }
    }

    /**
     * @brief The parameters of the lambda as an array of function parameters.
     */
    public prop params: ParameterList {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.paramsPropInfo.index]
            let offset = propInfos.paramsPropInfo.offset
            cast<ParameterList>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class LetPatternPropInfo {
    let exprPropInfo: PropInfo
    let patternsPropInfo: Array<PropInfo>

    init(exprPropInfo: PropInfo, patternsPropInfo: Array<PropInfo>) {
        this.exprPropInfo = exprPropInfo
        this.patternsPropInfo = patternsPropInfo
    }
}

class LetPatternPosInfo {
    let letKeyWordPos: CodePosition
    let bitOrsPos: Array<CodePosition>
    let backArrowPos: CodePosition

    init(letKeyWordPos: CodePosition, bitOrsPos: Array<CodePosition>, backArrowPos: CodePosition) {
        this.letKeyWordPos = letKeyWordPos
        this.bitOrsPos = bitOrsPos
        this.backArrowPos = backArrowPos
    }
}

/**
 * @brief Represents a let pattern binding expression.
 *        It binds a value (expr) to a pattern for destructuring.
 */
public class LetPattern <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: LetPatternPropInfo

    private let posInfos: LetPatternPosInfo

    /**
     * @brief Retrieves the position of the 'LET' token.
     * @return A CodePositionRange object representing the 'LET' token's position.
     */
    public func getLetKeyWordPos(): CodePositionRange {
        let endPos = posInfos.letKeyWordPos + SyntaxNodeKind.LetToken.size
        CodePositionRange(posInfos.letKeyWordPos, endPos)
    }

    /**
     * @brief Retrieves the positions of all 'BIT_OR' tokens.
     * @return An array of CodePositionRange objects for each 'BIT_OR' token.
     */
    public func getBitOrsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.bitOrsPos.size) {
            let endPos = posInfos.bitOrsPos[i] + SyntaxNodeKind.BitOrToken.size
            ret.add(CodePositionRange(posInfos.bitOrsPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Retrieves the position of the 'BACK_ARROW' token.
     * @return A CodePositionRange object representing the 'BACK_ARROW' token's position.
     */
    public func getBackArrowPos(): CodePositionRange {
        let endPos = posInfos.backArrowPos + SyntaxNodeKind.BackArrowToken.size
        CodePositionRange(posInfos.backArrowPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: LetPatternPosInfo,
        propInfos: LetPatternPropInfo, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with source expr and patterns.
     */
    public init(expr: Expr, patterns: Array<Pattern>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createLetPatternImpl(expr, patterns, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<LetPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The expression whose value is to be bound to the pattern.
     */
    public prop expr: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.exprPropInfo.index]
            let offset = propInfos.exprPropInfo.offset
            // might be SymbolRef or MemberAccess
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The patterns to which the expression's value is bound.
     */
    public prop patterns: Array<Pattern> {
        get() {
            let pats = ArrayList<Pattern>()
            for (propInfo in propInfos.patternsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                pats.add(cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                    .getOrThrow())
            }
            pats.toArray()
        }
    }
}

/**
 * @brief Enumeration for different kinds of literal constants.
 *
 * The LitConstKind enumeration defines various types of literal constants used
 * in expressions. Each kind specifies a particular type of literal value.
 */
public enum LitConstKind {
    | BoolLiteral
    | FloatLiteral
    | IntergerLiteral
    | RuneLiteral
    | StringLiteral
    | UnitLiteral
    | ...
}

/**
 * @brief Represents a literal constant expression.
 *
 * The LitConstExpr class is a subclass of Expr and is used to model literal
 * constant expressions. It contains a kind specifying the type of literal
 * constant and a raw value storing the actual value as a string.
 */
public open class LitConstExpr <: Expr {
    private let startPos: CodePosition
    private let kind_: LitConstKind
    private let rawValue_: String

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: LitConstKind,
        rawValue_: String, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.kind_ = kind_
        this.rawValue_ = rawValue_
    }

    init(nodeImpl: SyntaxNodeImpl, kind_: LitConstKind, rawValue_: String, hasComment!: Bool = true) {
        super(nodeImpl, hasComment: hasComment)
        this.startPos = DEFAULT_START_POS
        this.kind_ = kind_
        this.rawValue_ = rawValue_
    }

    /**
     * @brief Initialize a new LitConstExpr node.
     */
    public init(kind: LitConstKind, rawValue: String, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createLitConstExprImpl(kind, rawValue, comments: comments))
        let startPos = DEFAULT_START_POS

        this.startPos = startPos
        this.kind_ = kind
        this.rawValue_ = rawValue
    }

    /**
     * @brief Type of literal constant.
     *
     * This member variable stores the kind of literal constant specified by the
     * LitConstKind enumeration.
     */
    public prop kind: LitConstKind {
        get() {
            kind_
        }
    }

    /**
     * @brief Actual value of the literal constant.
     *
     * This member variable stores the actual value of the literal constant as a string.
     */
    public prop rawValue: String {
        get() {
            rawValue_
        }
    }
}

/**
 * @brief Represents a literal constant rune expression.
 *
 * The LitConstRuneExpr class is a subclass of Expr and is used to model literal
 * constant rune expressions. It contains information about whether the literal
 * is enclosed in single quotes, a kind specifying the type of literal constant
 * rune, and a raw value storing the actual value as a string.
 */
public class LitConstRuneExpr <: LitConstExpr {
    private let startPos: CodePosition
    private let isSingleQuote_: Bool

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, rawValue_: String,
        isSingleQuote_: Bool, commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, LitConstKind.RuneLiteral, rawValue_, commentsPropInfo)
        this.startPos = startPos
        this.isSingleQuote_ = isSingleQuote_
    }

    /**
     * @brief Initialize a new LitConstRuneExpr node.
     */
    public init(kind: LitConstKind, rawValue: String, isSingleQuote: Bool, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createLitConstRuneExprImpl(kind, rawValue, isSingleQuote, comments: comments), kind,
            rawValue)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<LitConstRuneExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.isSingleQuote_ = isSingleQuote
    }

    /**
     * @brief Indicates whether the literal is enclosed in single quotes.
     *
     * This member variable stores a boolean value indicating whether the literal
     * constant rune is enclosed in single quotes.
     */
    public prop isSingleQuote: Bool {
        get() {
            isSingleQuote_
        }
    }
}

/**
 * @brief Enumeration for different kinds of literal constant strings.
 *
 * The LitConstStrKind enumeration defines various types of literal constant
 * strings used in expressions. Each kind specifies a particular type of string
 * literal value.
 */
public enum LitConstStrKind {
    | JStringLiteral
    | MultiLineString
    | MultiLineRawString
    | StringLiteral
    | ...
}

/**
 * @brief Enumeration for different parts of a string literal.
 *
 * The StrLiteralPart enumeration defines the components that can make up a
 * string literal. Each part can either be a literal constant part
 * (LitConstPart) or an interpolation part (StrInterpolation).
 */
public enum StrLiteralPart {
    | LitConstPart(LitConstExpr)
    | StrInterpolation(StrInterpolationContent)
    | ...
}

class LitConstStrExprPropInfos {
    let strPartExprsPropInfo: PropInfo

    init(strPartExprsPropInfo: PropInfo) {
        this.strPartExprsPropInfo = strPartExprsPropInfo
    }
}

/**
 * @brief Represents a literal constant string expression.
 *
 * The LitConstStrExpr class is a subclass of Expr and is used to model literal
 * constant string expressions. It contains information about the number of
 * delimiters, whether the string is enclosed in single quotes, a kind
 * specifying the type of literal constant string, a raw value storing the
 * actual value as a string, and an array of string literal parts that make up
 * the string.
 */
public class LitConstStrExpr <: LitConstExpr {
    private let startPos: CodePosition
    private let delimiterNum_: Int64
    private let isSingleQuote_: Bool
    private let strKind_: LitConstStrKind
    private let propInfos: LitConstStrExprPropInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, delimiterNum_: Int64,
        isSingleQuote_: Bool, rawValue_: String, strKind_: LitConstStrKind, propInfos: LitConstStrExprPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(nodeImpl, startPos, parentNode, LitConstKind.StringLiteral, rawValue_, commentsPropInfo)
        this.startPos = startPos
        this.delimiterNum_ = delimiterNum_
        this.isSingleQuote_ = isSingleQuote_
        this.strKind_ = strKind_
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new LitConstStrExpr node.
     */
    public init(kind: LitConstKind, rawValue: String, delimiterNum: Int64, isSingleQuote: Bool,
        strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>, comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createLitConstStrExprImpl(kind, rawValue, delimiterNum, isSingleQuote, strKind,
                strPartExprs, comments: comments), kind, rawValue)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<LitConstStrExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.delimiterNum_ = delimiterNum
        this.isSingleQuote_ = isSingleQuote
        this.strKind_ = strKind
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief Determines whether the object contains interpolation.
     *
     * @return true if the object contains interpolation, false otherwise.
     */
    public func hasInterpolation(): Bool {
        let strPartExpr = strPartExprs
        for (i in 0..strPartExpr.size) {
            match (strPartExpr[i]) {
                case StrInterpolation(_) => return true
                case _ => ()
            }
        }
        return false
    }

    /**
     * @brief Number of delimiters in the string.
     * This member variable stores the number of delimiters used in the string
     * literal constant.
     */
    public prop delimiterNum: Int64 {
        get() {
            delimiterNum_
        }
    }

    /**
     * @brief Indicates whether the string is enclosed in single quotes.
     * This member variable stores a boolean value indicating whether the string
     * literal constant is enclosed in single quotes.
     */
    public prop isSingleQuote: Bool {
        get() {
            isSingleQuote_
        }
    }

    /**
     * @brief Type of literal constant string.
     * This member variable stores the kind of literal constant string specified by
     * the LitConstStrKind enumeration.
     */
    public prop strKind: LitConstStrKind {
        get() {
            strKind_
        }
    }

    /**
     * @brief Array of string literal parts.
     * This member variable stores an array of StrLiteralPart objects that make up
     * the string literal constant.
     */
    public prop strPartExprs: Array<StrLiteralPart> {
        get() {
            let strPartExprs_ = ArrayList<StrLiteralPart>()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.strPartExprsPropInfo.offset,
                index: propInfos.strPartExprsPropInfo.index)
            while (!lp.isEnd()) {
                var impl = lp.consume().getOrThrow()
                var currentPos = startPos + lp.offset

                match (impl.kind) {
                    case SyntaxNodeKind.InterpolationExpr =>
                        if (let Some(interpol) <- cast<StrInterpolationContent>(
                            SyntaxNodeImplTranslator.translate(impl, startPos + lp.offset, this))) {
                            strPartExprs_.add(StrInterpolation(interpol))
                        }
                    case SyntaxNodeKind.LineStringLiteral | SyntaxNodeKind.MultiLineStringLiteral
                        | SyntaxNodeKind.MultiLineRawStringLiteral =>
                        if (let Some(litConst) <- cast<LitConstExpr>(
                            SyntaxNodeImplTranslator.translate(impl, startPos + lp.offset, this))) {
                            strPartExprs_.add(LitConstPart(litConst))
                        }
                    case _ => break
                }
                lp.offset.move(impl.offset)
            }
            strPartExprs_.toArray()
        }
    }
}

class MatchCasePropInfos {
    let bodyPropInfo: PropInfo
    let caseCondPropInfo: Option<PropInfo>
    let patternGuardCondPropInfo: Option<PropInfo>
    let patternsPropInfo: Array<PropInfo>

    init(bodyPropInfo: PropInfo, caseCondPropInfo: Option<PropInfo>, patternGuardCondPropInfo: Option<PropInfo>,
        patternsPropInfo: Array<PropInfo>) {
        this.bodyPropInfo = bodyPropInfo
        this.caseCondPropInfo = caseCondPropInfo
        this.patternGuardCondPropInfo = patternGuardCondPropInfo
        this.patternsPropInfo = patternsPropInfo
    }
}

class MatchCasePosInfos {
    let casePos: CodePosition
    let bitOrsPos: Array<CodePosition>
    let wherePos: Option<CodePosition>
    let doubleArrowPos: CodePosition

    init(casePos: CodePosition, bitOrsPos: Array<CodePosition>, wherePos: Option<CodePosition>,
        doubleArrowPos: CodePosition) {
        this.casePos = casePos
        this.bitOrsPos = bitOrsPos
        this.wherePos = wherePos
        this.doubleArrowPos = doubleArrowPos
    }
}

/**
 * @brief Represents a match case in a match expression.
 *        It defines the patterns, conditions, and body for a match case.
 */
public class MatchCase <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: MatchCasePropInfos

    private let posInfos: MatchCasePosInfos

    /**
     * @brief Gets the position range of the 'case' keyword in the code.
     *
     * @return A CodePositionRange representing the position range of the 'case' keyword.
     */
    public func getCasePos(): CodePositionRange {
        let endPos = posInfos.casePos + SyntaxNodeKind.CaseToken.size
        return CodePositionRange(posInfos.casePos, endPos)
    }

    /**
     * @brief Gets the position ranges of the bitwise OR operators in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the bitwise OR operators.
     */
    public func getBitOrsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.bitOrsPos.size) {
            let endPos = posInfos.bitOrsPos[i] + SyntaxNodeKind.BitOrToken.size
            ret.add(CodePositionRange(posInfos.bitOrsPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position range of the 'where' keyword in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the 'where' keyword, if present.
     */
    public func getWherePos(): Option<CodePositionRange> {
        if (let Some(wherePos) <- posInfos.wherePos) {
            let endPos = wherePos + SyntaxNodeKind.WhereToken.size
            return CodePositionRange(wherePos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the double arrow (=>) in the code.
     *
     * @return A CodePositionRange representing the position range of the double arrow (=>).
     */
    public func getDoubleArrowPos(): CodePositionRange {
        let endPos = posInfos.doubleArrowPos + SyntaxNodeKind.DoubleArrowToken.size
        return CodePositionRange(posInfos.doubleArrowPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: MatchCasePosInfos,
        propInfos: MatchCasePropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with body, case condition, pattern guard condition and pattern.
     */
    public init(patterns: Array<Pattern>, patternGuardCond: Option<Expr>, caseCond: Option<Expr>,
        body: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createMatchCaseImpl(patterns, patternGuardCond, caseCond, body, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MatchCase>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The body of the match case as an array of syntax tree nodes.
     */
    public prop body: Array<SyntaxTreeNode> {
        get() {
            let bodys = ArrayList<SyntaxTreeNode>()

            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.bodyPropInfo.index]
            let offset = propInfos.bodyPropInfo.offset
            let lp = LocalParser((curNode as NonTerminal).getOrThrow().children, offset)

            while (!lp.isEnd()) {
                if (let Some(node) <- lp.tryConsume()) {
                    bodys.add(
                        cast<SyntaxTreeNode>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.moveOffset(node)
                }
            }
            bodys.toArray()
        }
    }

    /**
     * @brief The optional condition for the match case.
     */
    public prop caseCond: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.caseCondPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The optional pattern guard condition.
     */
    public prop patternGuardCond: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.patternGuardCondPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The array of patterns for the match case.
     */
    public prop patterns: Array<Pattern> {
        get() {
            let arguments = ArrayList<Pattern>()
            for (propInfo in propInfos.patternsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                arguments.add(
                    cast<Pattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            arguments.toArray()
        }
    }
}

class MatchExprPropInfos {
    let matchCasesPropInfo: Array<PropInfo>
    let selectorPropInfo: Option<PropInfo>

    init(matchCasesPropInfo: Array<PropInfo>, selectorPropInfo: Option<PropInfo>) {
        this.matchCasesPropInfo = matchCasesPropInfo
        this.selectorPropInfo = selectorPropInfo
    }
}

class MatchExprPosInfos {
    let matchKeyWordPos: CodePosition
    let selectorLParenPos: Option<CodePosition>
    let selectorRParenPos: Option<CodePosition>
    let matchCasesLCurlPos: CodePosition
    let matchCasesRCurlPos: CodePosition

    init(matchKeyWordPos: CodePosition, selectorLParenPos: Option<CodePosition>,
        selectorRParenPos: Option<CodePosition>, matchCasesLCurlPos: CodePosition, matchCasesRCurlPos: CodePosition) {
        this.matchKeyWordPos = matchKeyWordPos
        this.selectorLParenPos = selectorLParenPos
        this.selectorRParenPos = selectorRParenPos
        this.matchCasesLCurlPos = matchCasesLCurlPos
        this.matchCasesRCurlPos = matchCasesRCurlPos
    }
}

/**
 * @brief Represents a match expression.
 *        It matches a selector against multiple patterns.
 */
public class MatchExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: MatchExprPropInfos

    private let posInfos: MatchExprPosInfos

    /**
     * @brief Gets the position range of the 'match' keyword in the code.
     *
     * @return A CodePositionRange representing the position range of the 'match' keyword.
     */
    public func getMatchKeyWordPos(): CodePositionRange {
        let endPos = posInfos.matchKeyWordPos + SyntaxNodeKind.MatchToken.size
        return CodePositionRange(posInfos.matchKeyWordPos, endPos)
    }

    /**
     * @brief Gets the position range of the left parenthesis in the selector in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the left parenthesis in the selector, if present.
     */
    public func getSelectorLParenPos(): Option<CodePositionRange> {
        if (let Some(selectorLParenPos) <- posInfos.selectorLParenPos) {
            let endPos = selectorLParenPos + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(selectorLParenPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the right parenthesis in the selector in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the right parenthesis in the selector, if present.
     */
    public func getSelectorRParenPos(): Option<CodePositionRange> {
        if (let Some(selectorRParenPos) <- posInfos.selectorRParenPos) {
            let endPos = selectorRParenPos + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(selectorRParenPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the left curly brace in the match cases in the code.
     *
     * @return A CodePositionRange representing the position range of the left curly brace in the match cases.
     */
    public func getMatchCasesLCurlPos(): CodePositionRange {
        let endPos = posInfos.matchCasesLCurlPos + SyntaxNodeKind.LCurlToken.size
        return CodePositionRange(posInfos.matchCasesLCurlPos, endPos)
    }

    /**
     * @brief Gets the position range of the right curly brace in the match cases in the code.
     *
     * @return A CodePositionRange representing the position range of the right curly brace in the match cases.
     */
    public func getMatchCasesRCurlPos(): CodePositionRange {
        let endPos = posInfos.matchCasesRCurlPos + SyntaxNodeKind.RCurlToken.size
        return CodePositionRange(posInfos.matchCasesRCurlPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: MatchExprPosInfos,
        propInfos: MatchExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MatchExpr node.
     */
    public init(matchCases: Array<MatchCase>, selector: Option<Expr>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createMatchExprImpl(matchCases, selector, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MatchExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The cases of the match expression.
     */
    public prop matchCases: Array<MatchCase> {
        get() {
            let matchCases = ArrayList<MatchCase>()
            for (propInfo in propInfos.matchCasesPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                matchCases.add(
                    cast<MatchCase>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            matchCases.toArray()
        }
    }

    /**
     * @brief The optional selector expression.
     */
    public prop selector: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.selectorPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}

class MemberAccessPropInfos {
    let basePropInfo: PropInfo
    let fieldPropInfo: PropInfo

    init(basePropInfo: PropInfo, fieldPropInfo: PropInfo) {
        this.basePropInfo = basePropInfo
        this.fieldPropInfo = fieldPropInfo
    }
}

class MemberAccessPosInfos {
    let dotPos: CodePosition

    init(dotPos: CodePosition) {
        this.dotPos = dotPos
    }
}

/**
 * @brief Represents a member access expression.
 *        It accesses a field of a base expression.
 */
public class MemberAccess <: Expr {
    private let startPos: CodePosition

    private let propInfos: MemberAccessPropInfos

    private let posInfos: MemberAccessPosInfos

    /**
     * @brief Gets the position range of the dot in the code.
     *
     * @return A CodePositionRange representing the position range of the dot.
     */
    public func getDotPos(): CodePositionRange {
        let endPos = posInfos.dotPos + SyntaxNodeKind.DotToken.size
        return CodePositionRange(posInfos.dotPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: MemberAccessPosInfos,
        propInfos: MemberAccessPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MemberAccess node.
     */
    public init(base: SyntaxTreeNode, field: SymbolRef, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createMemberAccessImpl(base, field, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MemberAccess>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The base expression.
     */
    public prop base: SyntaxTreeNode {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.basePropInfo.index]
            let offset = propInfos.basePropInfo.offset
            cast<SyntaxTreeNode>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The field being accessed as a reference expression.
     */
    public prop field: SymbolRef {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.fieldPropInfo.index]
            let offset = propInfos.fieldPropInfo.offset
            cast<SymbolRef>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class OptionalExprPropInfos {
    let basePropInfo: PropInfo

    init(basePropInfo: PropInfo) {
        this.basePropInfo = basePropInfo
    }
}

class OptionalExprPosInfos {
    let questionPos: CodePosition

    init(questonPos: CodePosition) {
        this.questionPos = questonPos
    }
}

/**
 * @brief Represents an optional expression.
 * The OptionalExpr class is a subclass of Expr and is used to model optional
 * expressions. It contains a base expression that may be optional.
 */
public class OptionalExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: OptionalExprPropInfos
    private let posInfos: OptionalExprPosInfos

    /**
     * @brief Retrieves the position range of the question mark in the code.
     *
     * @return The position range of the question mark.
     */
    public func getQuestionPos(): CodePositionRange {
        let endPos = posInfos.questionPos + SyntaxNodeKind.QuestToken.size
        return CodePositionRange(posInfos.questionPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: OptionalExprPosInfos,
        propInfos: OptionalExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new OptionalExpr node.
     */
    public init(base: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createOptionalExprImpl(base, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<OptionalExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Base expression that may be optional.
     * This member variable stores the base expression which can be made optional
     * by this OptionalExpr.
     */
    public prop base: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.basePropInfo)
        }
    }
}

class ParenConditionPropInfo {
    let condPropInfo: PropInfo

    init(condPropInfo: PropInfo) {
        this.condPropInfo = condPropInfo
    }
}

class ParenConditionPosInfo {
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a parenthesized logical condition in an expression.
 *
 * This class encapsulates a disjunction condition within parentheses,
 * which can be used to override the default precedence of logical operators
 * and enforce a specific evaluation order in boolean expressions.
 */
public class ParenCondition <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: ParenConditionPropInfo

    private let posInfos: ParenConditionPosInfo

    /**
     * @brief Get position range of left parenthesis.
     * @return Range covering the left parenthesis token.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Get position range of right parenthesis.
     * @return Range covering the right parenthesis token.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ParenConditionPosInfo,
        propInfos: ParenConditionPropInfo, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with conditions.
     */
    public init(cond: DisjunctionCondition, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createParenConditionImpl(cond, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ParenCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The disjunction condition enclosed in parentheses.
     *
     * This member holds the logical disjunction (OR) condition that is
     * wrapped in parentheses. The parentheses indicate that this condition
     * should be evaluated as a single unit before being combined with other
     * logical expressions.
     */
    public prop cond: DisjunctionCondition {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.condPropInfo.index]
            let offset = propInfos.condPropInfo.offset
            cast<DisjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                .getOrThrow()
        }
    }
}

class ParenExprPropInfos {
    let subExprPropInfo: PropInfo

    init(subExprPropInfo: PropInfo) {
        this.subExprPropInfo = subExprPropInfo
    }
}

class ParenExprPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents an expression enclosed in parentheses.
 *
 * The ParenExpr class is a subclass of Expr and is used to model expressions
 * that are enclosed in parentheses. It contains a value representing the
 * expression inside the parentheses.
 */
public class ParenExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: ParenExprPropInfos

    private let posInfos: ParenExprPosInfos

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

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfo: ParenExprPosInfos,
        propInfo: ParenExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize node with expr in the parentheses.
     */
    public init(subExpr: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createParenExprImpl(subExpr, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ParenExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Expression enclosed within parentheses.
     *
     * This member variable stores the expression that is enclosed within
     * parentheses.
     */
    public prop subExpr: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.subExprPropInfo.index]
            let offset = propInfos.subExprPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

/**
 * @brief Enumeration for different kinds of ranges.
 *
 * The RangeKind enumeration defines various types of ranges used in
 * expressions. Each kind specifies a particular type of range, such as
 * exclusive or inclusive.
 */
public enum RangeKind {
    | ClosedRangeOp
    | RangeOp
    | ...
}

class RangeExprPropInfos {
    let startPropInfo: Option<PropInfo>
    let stepPropInfo: Option<PropInfo>
    let endPropInfo: Option<PropInfo>

    init(startPropInfo: Option<PropInfo>, stepPropInfo: Option<PropInfo>, endPropInfo: Option<PropInfo>) {
        this.startPropInfo = startPropInfo
        this.stepPropInfo = stepPropInfo
        this.endPropInfo = endPropInfo
    }
}

class RangeExprPosInfos {
    let rangeOpPos: CodePosition
    let colonPos: Option<CodePosition>

    init(rangeOpPos: CodePosition, colonPos: Option<CodePosition>) {
        this.rangeOpPos = rangeOpPos
        this.colonPos = colonPos
    }
}

/**
 * @brief Represents a range expression.
 *
 * The RangeExpr class is a subclass of Expr and is used to model range
 * expressions. It contains a start expression, an end expression, a step
 * expression, and a kind specifying the type of range (e.g., exclusive or
 * inclusive).
 */
public class RangeExpr <: Expr {
    private let kind_: RangeKind

    private let startPos: CodePosition

    private let propInfos: RangeExprPropInfos

    private let posInfos: RangeExprPosInfos

    /**
     * @brief Retrieves the position range of the range operator.
     *
     * @return A CodePositionRange representing the start and end positions of the range operator.
     */
    public func getRangeOpPos(): CodePositionRange {
        let endPos = posInfos.rangeOpPos + match (kind) {
            case RangeKind.ClosedRangeOp => SyntaxNodeKind.ClosedRangeOpToken.size
            case RangeKind.RangeOp => SyntaxNodeKind.RangeOpToken.size
            case _ => 0
        }
        return CodePositionRange(posInfos.rangeOpPos, endPos)
    }

    /**
     * @brief Retrieves the position of the colon, if it exists.
     *
     * @return An Option containing a CodePositionRange of the colon's position, or None if not present.
     */
    public func getColonPos(): Option<CodePositionRange> {
        match (posInfos.colonPos) {
            case Some(v) =>
                let endPos = v + SyntaxNodeKind.ColonToken.size
                CodePositionRange(v, endPos)
            case _ => None
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: RangeKind,
        posInfo: RangeExprPosInfos, propInfo: RangeExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.kind_ = kind_
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize node with range start, kind, end and range step.
     */
    public init(start: Option<Expr>, kind: RangeKind, end: Option<Expr>, step: Option<Expr>,
        comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createRangeExprImpl(start, kind, end, step, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<RangeExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
        this.kind_ = kind
    }

    /**
     * @brief Optional end expression of the range.
     *
     * This member variable stores the optional end expression of the range.
     * If the end is not specified, this will be None.
     */
    public prop end: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.endPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief Type of range (e.g., exclusive or inclusive).
     *
     * This member variable stores the kind of range specified by the RangeKind
     * enumeration.
     */
    public prop kind: RangeKind {
        get() {
            kind_
        }
    }

    /**
     * @brief Optional start expression of the range.
     *
     * This member variable stores the optional start expression of the range.
     * If the start is not specified, this will be None.
     */
    public prop start: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.startPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief Optional step expression for the range.
     *
     * This member variable stores the optional step expression for the range.
     * If the step is not specified, this will be None.
     */
    public prop step: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.stepPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}

class ReturnExprPropInfos {
    let retValPropInfo: Option<PropInfo>

    init(retValPropInfo: Option<PropInfo>) {
        this.retValPropInfo = retValPropInfo
    }
}

class ReturnExprPosInfos {
    let returnKeyWordPos: CodePosition

    init(returnKeyWordPos: CodePosition) {
        this.returnKeyWordPos = returnKeyWordPos
    }
}

/**
 * @brief Represents a return expression.
 *        It returns a value from a function.
 */
public class ReturnExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: ReturnExprPropInfos

    private let posInfos: ReturnExprPosInfos

    /**
     * @brief Retrieves the position range of the return keyword in the code.
     *
     * @return CodePositionRange representing the start and end positions of the return keyword.
     */
    public func getReturnKeyWordPos(): CodePositionRange {
        let endPos = posInfos.returnKeyWordPos + SyntaxNodeKind.ReturnToken.size
        return CodePositionRange(posInfos.returnKeyWordPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ReturnExprPosInfos,
        propInfos: ReturnExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with the returned value.
     */
    public init(retVal: Option<Expr>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createReturnExprImpl(retVal, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ReturnExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief The expression being returned, optional.
     */
    public prop retVal: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.retValPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }
}

class SpawnExprPosInfos {
    let spawnKeyWordPos: CodePosition
    let threadContextLParenPos: Option<CodePosition>
    let threadContextRParenPos: Option<CodePosition>

    init(spawnKeyWordPos: CodePosition, threadContextLParenPos: Option<CodePosition>,
        threadContextRParenPos: Option<CodePosition>) {
        this.spawnKeyWordPos = spawnKeyWordPos
        this.threadContextLParenPos = threadContextLParenPos
        this.threadContextRParenPos = threadContextRParenPos
    }
}

class SpawnExprPropInfos {
    let threadContextPropInfo: Option<PropInfo>
    let trailingLambdaExprPropInfo: PropInfo

    init(threadContextPropInfo: Option<PropInfo>, trailingLambdaExprPropInfo: PropInfo) {
        this.threadContextPropInfo = threadContextPropInfo
        this.trailingLambdaExprPropInfo = trailingLambdaExprPropInfo
    }
}

/**
 * @brief Represents a spawn expression for creating threads.
 *        It consists of a thread context and a lambda expression.
 */
public class SpawnExpr <: Expr {
    private let startPos: CodePosition

    private let posInfos: SpawnExprPosInfos

    private let propInfos: SpawnExprPropInfos

    /**
     * @brief Get the position range of the 'spawn' keyword.
     */
    public func getSpawnKeyWordPos(): CodePositionRange {
        let endPos = posInfos.spawnKeyWordPos + SyntaxNodeKind.SpawnToken.size
        CodePositionRange(posInfos.spawnKeyWordPos, endPos)
    }

    /**
     * @brief Get the position range of the left parenthesis for thread context.
     */
    public func getThreadContextLParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.threadContextLParenPos) {
            let endPos = v + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    /**
     * @brief Get the position range of the right parenthesis for thread context.
     */
    public func getThreadContextRParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.threadContextRParenPos) {
            let endPos = v + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(v, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: SpawnExprPosInfos,
        propInfos: SpawnExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new SpawnExpr node.
     */
    public init(threadContext: Option<Expr>, trailingLambdaExpr: Lambda, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createSpawnExprImpl(threadContext, trailingLambdaExpr, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<SpawnExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The optional thread context expression.
     */
    public prop threadContext: Option<Expr> {
        get() {
            if (let Some(propInfo) <- propInfos.threadContextPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The lambda expression representing the thread's code.
     */
    public prop trailingLambdaExpr: Lambda {
        get() {
            return translateExprChild<Lambda>(nodeImpl, startPos, this, propInfos.trailingLambdaExprPropInfo)
        }
    }
}

class StrInterpolationContentPosInfos {
    let dollarPos: CodePosition

    init(dollarPos: CodePosition) {
        this.dollarPos = dollarPos
    }
}

class StrInterpolationContentPropInfos {
    let interpolationBlockPropInfo: PropInfo

    init(interpolationBlockPropInfo: PropInfo) {
        this.interpolationBlockPropInfo = interpolationBlockPropInfo
    }
}

/**
 * @brief Represents the content of a string interpolation block.
 *
 * The StrInterpolationContent class is a subclass of SyntaxTreeNode and is
 * used to model the content of a string interpolation block. It contains an
 * interpolation block which is a piece of code executed within the string
 * interpolation.
 */
public class StrInterpolationContent <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let posInfos: StrInterpolationContentPosInfos
    private let propInfos: StrInterpolationContentPropInfos

    public func getDollarPos(): CodePositionRange {
        let endPos = posInfos.dollarPos + SyntaxNodeKind.DollarToken.size
        return CodePositionRange(posInfos.dollarPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: StrInterpolationContentPosInfos, propInfos: StrInterpolationContentPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with interpolation block.
     */
    public init(interpolationBlock: Block, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createStrInterpolationContentImpl(interpolationBlock, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<StrInterpolationContent>(SyntaxNodeImplTranslator.translate(curNode, startPos, None))
            .getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Block of code within the string interpolation.
     * This member variable stores the block of code that is executed as part of
     * the string interpolation.
     */
    public prop interpolationBlock: Block {
        get() {
            let propInfo = propInfos.interpolationBlockPropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this)).getOrThrow()
        }
    }
}

class SubscriptExprPropInfos {
    let basePropInfo: PropInfo
    let indexsPropInfo: PropInfo

    init(basePropInfo: PropInfo, indexsPropInfo: PropInfo) {
        this.basePropInfo = basePropInfo
        this.indexsPropInfo = indexsPropInfo
    }
}

class SubscriptExprPosInfos {
    let lSquarePos: CodePosition
    let rSquarePos: CodePosition
    let commasPos: Array<CodePosition>

    init(lSquarePos: CodePosition, rSquarePos: CodePosition, commasPos: Array<CodePosition>) {
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.commasPos = commasPos
    }
}

/**
 * @brief Represents a subscript expression for accessing array elements.
 *        It consists of a base expression and index expressions.
 */
public class SubscriptExpr <: Expr {
    private let startPos: CodePosition

    private let posInfos: SubscriptExprPosInfos

    private let propInfos: SubscriptExprPropInfos

    /**
     * @brief Gets the position range of the left square bracket in the SubacriptExpr.
     *
     * @return A CodePositionRange representing the position range of the left square bracket.
     */
    public func getLSquarePos(): CodePositionRange {
        return createExprTokenRange(posInfos.lSquarePos, SyntaxNodeKind.LSquareToken.size)
    }

    /**
     * @brief Gets the position range of the right square bracket in the SubacriptExpr.
     *
     * @return A CodePositionRange representing the position range of the right square bracket.
     */
    public func getRSquarePos(): CodePositionRange {
        return createExprTokenRange(posInfos.rSquarePos, SyntaxNodeKind.RSquareToken.size)
    }

    /**
     * @brief Gets the position ranges of the commas in the SubacriptExpr.
     *
     * @return An Array of PositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createExprTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: SubscriptExprPosInfos,
        propInfos: SubscriptExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new SubscriptExpr node.
     */
    public init(base: Expr, indexs: Array<Expr>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createSubscriptExprImpl(base, indexs, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<SubscriptExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The base expression.
     */
    public prop base: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.basePropInfo)
        }
    }

    /**
     * @brief The array of index expressions.
     */
    public prop indexs: Array<Expr> {
        get() {
            let indexs = ArrayList<Expr>()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.indexsPropInfo.offset,
                index: propInfos.indexsPropInfo.index)
            let predictExpr = {
                kind: SyntaxNodeKind => kind.isExpr()
            }

            while (lp.look(predictExpr)) {
                if (let Some(node) <- lp.consume()) {
                    indexs.add(
                        cast<Expr>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this)).getOrThrow())
                    lp.moveOffset(node)
                }
                if (lp.look(SyntaxNodeKind.CommaToken)) {
                    lp.moveOffset(lp.consume())
                }
            }

            indexs.toArray()
        }
    }
}

class SymbolRefPropInfos {
    let typeArgumentsPropInfo: Option<PropInfo>

    init(typeArgumentsPropInfo: Option<PropInfo>) {
        this.typeArgumentsPropInfo = typeArgumentsPropInfo
    }
}

class SymbolRefPosInfos {
    let identifierPos: CodePosition
    let lAnglePos: Option<CodePosition>
    let rAnglePos: Option<CodePosition>
    let commasPos: Array<CodePosition>

    init(identifierPos: CodePosition, lAnglePos: Option<CodePosition>, rAnglePos: Option<CodePosition>,
        commasPos: Array<CodePosition>) {
        this.identifierPos = identifierPos
        this.lAnglePos = lAnglePos
        this.rAnglePos = rAnglePos
        this.commasPos = commasPos
    }
}

/**
 * @brief Represents a reference to a symbol.
 *
 * The SymbolRef class is a subclass of Expr and is used to model references to
 * symbols. It contains a name representing the symbol being referenced and an
 * array of type annotations for the symbol reference.
 */
public class SymbolRef <: Expr {
    private let name_: String

    private let startPos: CodePosition

    private let propInfos: SymbolRefPropInfos

    private let posInfos: SymbolRefPosInfos

    /**
     * @brief Gets the position range of the identifier in the code.
     *
     * @return A CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        let endPos = posInfos.identifierPos + name.size
        return CodePositionRange(posInfos.identifierPos, endPos)
    }

    /**
     * @brief Gets the position range of the left angle bracket in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the left angle bracket, if present.
     */
    public func getLAnglePos(): Option<CodePositionRange> {
        if (let Some(lAnglePos) <- posInfos.lAnglePos) {
            let endPos = lAnglePos + SyntaxNodeKind.LtToken.size
            return CodePositionRange(lAnglePos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the right angle bracket in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the right angle bracket, if present.
     */
    public func getRAnglePos(): Option<CodePositionRange> {
        if (let Some(rAnglePos) <- posInfos.rAnglePos) {
            let endPos = rAnglePos + SyntaxNodeKind.GtToken.size
            return CodePositionRange(rAnglePos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position ranges of the commas in the code.
     *
     * @return An Array of PositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.commasPos.size) {
            let endPos = posInfos.commasPos[i] + SyntaxNodeKind.CommaToken.size
            ret.add(CodePositionRange(posInfos.commasPos[i], endPos))
        }
        ret.toArray()
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String,
        posInfos: SymbolRefPosInfos, propInfos: SymbolRefPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new SymbolRef node.
     */
    public init(name: String, typeArguments: Array<TypeAnnotation>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createSymbolRefImpl(name, typeArguments, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<SymbolRef>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.name_ = name
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Name of the symbol being referenced.
     *
     * This member variable stores the name of the symbol that is being referenced.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief Type annotations for the SymbolRef reference.
     *
     * This member variable stores an array of TypeAnnotation objects that specify
     * the types associated with the SymbolRef reference.
     */
    public prop typeArguments: Array<TypeAnnotation> {
        get() {
            let typeArguments = ArrayList<TypeAnnotation>()

            if (let Some(propInfo) <- propInfos.typeArgumentsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                let lp = LocalParser((curNode as NonTerminal).getOrThrow().children, offset)

                if (lp.look(SyntaxNodeKind.LtToken)) {
                    lp.offset.move(lp.consume()?.offset)
                }

                let predictType = {
                    kind: SyntaxNodeKind => kind.isTypeAnnotation()
                }
                while (lp.look(predictType)) {
                    var node = lp.consume().getOrThrow()
                    typeArguments.add(
                        cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.offset.move(node.offset)
                    if (lp.look(SyntaxNodeKind.CommaToken)) {
                        lp.offset.move(lp.consume()?.offset)
                    }
                }
            }
            typeArguments.toArray()
        }
    }
}

class SynchronizedExprPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let synchronizedKeyWordPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition, synchronizedKeyWordPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.synchronizedKeyWordPos = synchronizedKeyWordPos
    }
}

class SynchronizedExprPropInfos {
    let blockPropInfo: PropInfo
    let structuredMutexPropInfo: PropInfo

    init(blockPropInfo: PropInfo, structuredMutexPropInfo: PropInfo) {
        this.blockPropInfo = blockPropInfo
        this.structuredMutexPropInfo = structuredMutexPropInfo
    }
}

/**
 * @brief Represents a synchronized expression for thread synchronization.
 *        It consists of a block of code and a mutex expression.
 */
public class SynchronizedExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: SynchronizedExprPropInfos

    private let posInfos: SynchronizedExprPosInfos

    /**
     * @brief Get position range of 'synchronized' keyword.
     * @return Range covering the 'synchronized' token.
     */
    public func getSynchronizedKeyWordPos(): CodePositionRange {
        let endPos = posInfos.synchronizedKeyWordPos + SyntaxNodeKind.SynchronizedToken.size
        CodePositionRange(posInfos.synchronizedKeyWordPos, endPos)
    }

    /**
     * @brief Get position range of left parenthesis.
     * @return Range covering the left parenthesis token.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Get position range of right parenthesis.
     * @return Range covering the right parenthesis token.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: SynchronizedExprPosInfos, propInfos: SynchronizedExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new SynchronizedExpr node.
     */
    public init(block: Block, structuredMutex: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createSynchronizedExprImpl(block, structuredMutex, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<SynchronizedExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block of code to be synchronized.
     */
    public prop block: Block {
        get() {
            return translateExprChild<Block>(nodeImpl, startPos, this, propInfos.blockPropInfo)
        }
    }

    /**
     * @brief The expression representing the mutex.
     */
    public prop structuredMutex: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.structuredMutexPropInfo.index]
            let offset = propInfos.structuredMutexPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class ThrowExprPropInfos {
    let throwValPropInfo: PropInfo

    init(throwValPropInfo: PropInfo) {
        this.throwValPropInfo = throwValPropInfo
    }
}

class ThrowExprPosInfos {
    let throwKeyWordPos: CodePosition

    init(throwKeyWordPos: CodePosition) {
        this.throwKeyWordPos = throwKeyWordPos
    }
}

/**
 * @brief Represents a throw expression for throwing exceptions.
 *        It consists of a value to throw.
 */
public class ThrowExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: ThrowExprPropInfos

    private let posInfos: ThrowExprPosInfos

    /**
     * @brief Gets the position range of the 'throw' keyword in the code.
     *
     * @return A PositionRange representing the position range of the 'throw' keyword.
     */
    public func getThrowKeyWordPos(): CodePositionRange {
        let endPos = posInfos.throwKeyWordPos + SyntaxNodeKind.ThrowToken.size
        return CodePositionRange(posInfos.throwKeyWordPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ThrowExprPosInfos,
        propInfos: ThrowExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new ThrowExpr node.
     */
    public init(throwVal: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createThrowExprImpl(throwVal, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ThrowExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The expression representing the value to throw.
     */
    public prop throwVal: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.throwValPropInfo.index]
            let offset = propInfos.throwValPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class TrailingClosureExprPosInfos {
    let commasPos: Array<CodePosition>
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>

    init(commasPos: Array<CodePosition>, lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>) {
        this.commasPos = commasPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

class TrailingClosureExprPropInfos {
    let argumentsPropInfo: PropInfo
    let calleePropInfo: PropInfo
    let trailingLambdaExprPropInfo: PropInfo

    init(argumentsPropInfo: PropInfo, calleePropInfo: PropInfo, trailingLambdaExprPropInfo: PropInfo) {
        this.argumentsPropInfo = argumentsPropInfo
        this.calleePropInfo = calleePropInfo
        this.trailingLambdaExprPropInfo = trailingLambdaExprPropInfo
    }
}

/**
 * @brief Represents a trailing closure expression.
 *       It consists of a prefix expression which is MemberAccess or SymbolRef,
 *        arguments, and a trailing lambda expression.
 */
public class TrailingClosureExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: TrailingClosureExprPropInfos

    private let posInfos: TrailingClosureExprPosInfos

    /**
     * @brief Gets the position ranges of the commas in the arguments in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the commas in the arguments.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.commasPos.size) {
            let endPos = posInfos.commasPos[i] + SyntaxNodeKind.CommaToken.size
            ret.add(CodePositionRange(posInfos.commasPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position range of the left parenthesis in the code if present.
     *
     * @return Option<CodePositionRange> representing the position range of the left parenthesis.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        if (let Some(lParenPos) <- posInfos.lParenPos) {
            let endPos = lParenPos + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(lParenPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the right parenthesis in the code if present.
     *
     * @return Option<CodePositionRange> representing the position range of the right parenthesis.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        if (let Some(rParenPos) <- posInfos.rParenPos) {
            let endPos = rParenPos + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(rParenPos, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: TrailingClosureExprPosInfos, propInfos: TrailingClosureExprPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with callee, arguments and trailing lambda expr.
     */
    public init(callee: Expr, arguments: Array<Argument>, trailingLambdaExpr: Lambda, comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createTrailingClosureExprImpl(callee, arguments, trailingLambdaExpr,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TrailingClosureExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None))
            .getOrThrow()
        this.startPos = startPos
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The list of arguments passed to the expression.
     */
    public prop arguments: Array<Argument> {
        get() {
            let args = ArrayList<Argument>()
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.argumentsPropInfo.offset,
                index: propInfos.argumentsPropInfo.index)

            while (lp.look(SyntaxNodeKind.Argument)) {
                if (let Some(node) <- lp.consume()) {
                    args.add(
                        cast<Argument>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.moveOffset(node)
                }
                if (lp.look(SyntaxNodeKind.CommaToken)) {
                    lp.moveOffset(lp.consume())
                }
            }

            args.toArray()
        }
    }

    /**
     * @brief The callee that the trailing closure is associated with.
     */
    public prop callee: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.calleePropInfo.index]
            let offset = propInfos.calleePropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The lambda expression that acts as the trailing closure.
     */
    public prop trailingLambdaExpr: Lambda {
        get() {
            return translateExprChild<Lambda>(nodeImpl, startPos, this, propInfos.trailingLambdaExprPropInfo)
        }
    }
}

class TryExprPosInfos {
    let tryKeyWordPos: CodePosition
    let resourceSpecLParenPos: Option<CodePosition>
    let resourceSpecCommasPos: Array<CodePosition>
    let resourceSpecRParenPos: Option<CodePosition>

    let catchKeyWordsPos: Array<CodePosition>
    let catchLParensPos: Array<CodePosition>
    let catchRParensPos: Array<CodePosition>
    let finallyKeyWordPos: Option<CodePosition>

    init(tryKeyWordPos: CodePosition, resourceSpecLParenPos: Option<CodePosition>,
        resourceSpecCommasPos: Array<CodePosition>, resourceSpecRParenPos: Option<CodePosition>,
        catchKeyWordsPos: Array<CodePosition>, catchLParensPos: Array<CodePosition>,
        catchRParensPos: Array<CodePosition>, finallyKeyWordPos: Option<CodePosition>) {
        this.tryKeyWordPos = tryKeyWordPos
        this.resourceSpecLParenPos = resourceSpecLParenPos
        this.resourceSpecCommasPos = resourceSpecCommasPos
        this.resourceSpecRParenPos = resourceSpecRParenPos
        this.catchKeyWordsPos = catchKeyWordsPos
        this.catchLParensPos = catchLParensPos
        this.catchRParensPos = catchRParensPos
        this.finallyKeyWordPos = finallyKeyWordPos
    }
}

class TryExprPropInfos {
    let catchBlocksPropInfo: Array<PropInfo>
    let catchPatternsPropInfo: Array<PropInfo>
    let finallyBlockPropInfo: Option<PropInfo>
    let resourceSpecPropInfo: Option<PropInfo>
    let tryBlockPropInfo: PropInfo

    init(catchBlocksPropInfo: Array<PropInfo>, catchPatternsPropInfo: Array<PropInfo>,
        finallyBlockPropInfo: Option<PropInfo>, resourceSpecPropInfo: Option<PropInfo>, tryBlockPropInfo: PropInfo) {
        this.catchBlocksPropInfo = catchBlocksPropInfo
        this.catchPatternsPropInfo = catchPatternsPropInfo
        this.finallyBlockPropInfo = finallyBlockPropInfo
        this.resourceSpecPropInfo = resourceSpecPropInfo
        this.tryBlockPropInfo = tryBlockPropInfo
    }
}

/**
 * @brief Represents a try-catch expression for exception handling.
 *        It consists of try, catch, and finally blocks.
 */
public class TryCatch <: Expr {
    private let startPos: CodePosition

    private let propInfos: TryExprPropInfos

    private let posInfos: TryExprPosInfos

    /**
     * @brief Gets the position range of the 'try' keyword in the code.
     *
     * @return A CodePositionRange representing the position range of the 'try' keyword.
     */
    public func getTryKeyWordPos(): CodePositionRange {
        let endPos = posInfos.tryKeyWordPos + SyntaxNodeKind.TryToken.size
        return CodePositionRange(posInfos.tryKeyWordPos, endPos)
    }

    /**
     * @brief Gets the position range of the left parenthesis in the resource specification in the code.
     *
     * @return A CodePositionRange representing the position range of the left parenthesis in the resource specification.
     */
    public func getResourceSpecLParenPos(): Option<CodePositionRange> {
        if (let Some(lParenPos) <- posInfos.resourceSpecLParenPos) {
            let endPos = lParenPos + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(lParenPos, endPos)
        } else {
            return None
        }
    }

    /**
     * @brief Gets the position ranges of the commas in the resource specification in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the commas in the resource specification.
     */
    public func getResourceSpecCommasPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.resourceSpecCommasPos.size) {
            let endPos = posInfos.resourceSpecCommasPos[i] + SyntaxNodeKind.CommaToken.size
            ret.add(CodePositionRange(posInfos.resourceSpecCommasPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position range of the right parenthesis in the resource specification in the code.
     *
     * @return A CodePositionRange representing the position range of the right parenthesis in the resource specification.
     */
    public func getResourceSpecRParenPos(): Option<CodePositionRange> {
        if (let Some(rParenPos) <- posInfos.resourceSpecRParenPos) {
            let endPos = rParenPos + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(rParenPos, endPos)
        } else {
            return None
        }
    }

    /**
     * @brief Gets the position ranges of the 'catch' keywords in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the 'catch' keywords.
     */
    public func getCatchKeyWordsPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.catchKeyWordsPos.size) {
            let endPos = posInfos.catchKeyWordsPos[i] + SyntaxNodeKind.CatchToken.size
            ret.add(CodePositionRange(posInfos.catchKeyWordsPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position ranges of the left parentheses in the 'catch' blocks in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the left parentheses in the 'catch' blocks.
     */
    public func getCatchLParensPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.catchLParensPos.size) {
            let endPos = posInfos.catchLParensPos[i] + SyntaxNodeKind.LParenToken.size
            ret.add(CodePositionRange(posInfos.catchLParensPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position ranges of the right parentheses in the 'catch' blocks in the code.
     *
     * @return An Array of CodePositionRange representing the position ranges of the right parentheses in the 'catch' blocks.
     */
    public func getCatchRParensPos(): Array<CodePositionRange> {
        let ret = ArrayList<CodePositionRange>()
        for (i in 0..posInfos.catchRParensPos.size) {
            let endPos = posInfos.catchRParensPos[i] + SyntaxNodeKind.RParenToken.size
            ret.add(CodePositionRange(posInfos.catchRParensPos[i], endPos))
        }
        ret.toArray()
    }

    /**
     * @brief Gets the position range of the 'finally' keyword in the code.
     *
     * @return An Option of CodePositionRange representing the position range of the 'finally' keyword, if present.
     */
    public func getFinallyKeyWordPos(): Option<CodePositionRange> {
        if (let Some(finallyKeyWordPos) <- posInfos.finallyKeyWordPos) {
            let endPos = finallyKeyWordPos + SyntaxNodeKind.FinallyToken.size
            return CodePositionRange(finallyKeyWordPos, endPos)
        } else {
            return None
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: TryExprPosInfos,
        propInfos: TryExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new TryCatch node.
     */
    public init(catchBlocks: Array<Block>, catchPatterns: Array<CatchPattern>, finallyBlock: Option<Block>,
        resourceSpec: Array<VarDecl>, tryBlock: Block, comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createTryCatchImpl(catchBlocks, catchPatterns, finallyBlock, resourceSpec, tryBlock,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TryCatch>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The array of catch blocks.
     */
    public prop catchBlocks: Array<Block> {
        get() {
            let catchBlocks = ArrayList<Block>()
            for (propInfo in propInfos.catchBlocksPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                catchBlocks.add(
                    cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            catchBlocks.toArray()
        }
    }

    /**
     * @brief The array of catch patterns.
     */
    public prop catchPatterns: Array<CatchPattern> {
        get() {
            let catchPatterns = ArrayList<CatchPattern>()
            for (propInfo in propInfos.catchPatternsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                catchPatterns.add(
                    cast<CatchPattern>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                        .getOrThrow())
            }
            catchPatterns.toArray()
        }
    }

    /**
     * @brief The optional finally block.
     */
    public prop finallyBlock: Option<Block> {
        get() {
            if (let Some(propInfo) <- propInfos.finallyBlockPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The array of resource specifications.
     */
    public prop resourceSpec: Array<VarDecl> {
        get() {
            let resourceSpec = ArrayList<VarDecl>()
            if (let Some(propInfo) <- propInfos.resourceSpecPropInfo) {
                let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfo.offset,
                    index: propInfo.index)

                while (lp.look(SyntaxNodeKind.VarDecl)) {
                    if (let Some(node) <- lp.consume()) {
                        resourceSpec.add(
                            cast<VarDecl>(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this))
                                .getOrThrow())
                        lp.moveOffset(node)
                    }
                    if (lp.look(SyntaxNodeKind.CommaToken)) {
                        lp.moveOffset(lp.consume())
                    }
                }
            }

            resourceSpec.toArray()
        }
    }

    /**
     * @brief The try block.
     */
    public prop tryBlock: Block {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.tryBlockPropInfo.index]
            let offset = propInfos.tryBlockPropInfo.offset
            cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class TupleLiteralPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition
    let commasPos: Array<CodePosition>

    init(lParenPos: CodePosition, rParenPos: CodePosition, commasPos: Array<CodePosition>) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
        this.commasPos = commasPos
    }
}

class TupleLiteralPropInfos {
    let elementsPropInfo: PropInfo

    init(elementsPropInfo: PropInfo) {
        this.elementsPropInfo = elementsPropInfo
    }
}

/**
 * @brief Represents a tuple literal.
 *
 * The TupleLiteral class is a subclass of Expr and is used to model tuple
 * literals. It contains an array of expressions that make up the tuple.
 */
public class TupleLiteral <: Expr {
    private let startPos: CodePosition
    private let posInfos: TupleLiteralPosInfos
    private let propInfos: TupleLiteralPropInfos

    /**
     * @brief Gets the position range of the left bracket in the code.
     *
     * @return A CodePositionRange representing the position range of the left bracket.
     */
    public func getLParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.lParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Gets the position range of the right bracket in the code.
     *
     * @return A CodePositionRange representing the position range of the right bracket.
     */
    public func getRParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.rParenPos, SyntaxNodeKind.RParenToken.size)
    }

    /**
     * @brief Gets the position ranges of the commas in the code.
     *
     * @return An ArrayList of CodePositionRange representing the position ranges of the commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        return createExprTokenRanges(posInfos.commasPos, SyntaxNodeKind.CommaToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: TupleLiteralPosInfos,
        propInfos: TupleLiteralPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new TupleLiteral node.
     */
    public init(elements: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createTupleLiteralImpl(elements, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TupleLiteral>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Array of expressions.
     *
     * This member variable stores an array of expressions of type Expr.
     */
    public prop elements: Array<SyntaxTreeNode> {
        get() {
            let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfos.elementsPropInfo.offset,
                index: propInfos.elementsPropInfo.index)
            let nodes = ArrayList<SyntaxTreeNode>()
            let predictExpr = {
                kind: SyntaxNodeKind => kind.isExpr()
            }
            while (lp.look(predictExpr) || lp.look(SyntaxNodeKind.WildcardPattern)) {
                if (let Some(node) <- lp.consume()) {
                    nodes.add(SyntaxNodeImplTranslator.translate(node, startPos + lp.offset, this).getOrThrow())
                    lp.moveOffset(node)
                }
                lp.moveOffset(lp.lookAndConsume(SyntaxNodeKind.CommaToken))
            }
            nodes.toArray()
        }
    }
}

class TypeConvExprPropInfos {
    let srcValPropInfo: PropInfo
    let targetTypeAnnotationPropInfo: PropInfo

    init(srcValPropInfo: PropInfo, targetTypeAnnotationPropInfo: PropInfo) {
        this.srcValPropInfo = srcValPropInfo
        this.targetTypeAnnotationPropInfo = targetTypeAnnotationPropInfo
    }
}

class TypeConvExprPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a type conversion expression.
 *
 * The TypeConvExpr class is a subclass of Expr and is used to model type
 * conversion expressions. It contains a source value expression and a target
 * type annotation specifying the type to which the source value should be
 * converted.
 */
public class TypeConvExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: TypeConvExprPropInfos

    private let posInfos: TypeConvExprPosInfos

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

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfo: TypeConvExprPosInfos,
        propInfo: TypeConvExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfo
        this.propInfos = propInfo
    }

    /**
     * @brief Initialize node with source value and target type.
     */
    public init(srcVal: Expr, targetTypeAnnotation: AtomicType, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createTypeConvExprImpl(targetTypeAnnotation, srcVal, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<TypeConvExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Expression representing the source value to be converted.
     *
     * This member variable stores the expression that represents the source value
     * to be converted.
     */
    public prop srcVal: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.srcValPropInfo)
        }
    }

    /**
     * @brief Target type for the conversion.
     *
     * This member variable stores the type annotation that specifies the target
     * type for the conversion.
     */
    public prop targetTypeAnnotation: AtomicType {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.targetTypeAnnotationPropInfo.index]
            let offset = propInfos.targetTypeAnnotationPropInfo.offset
            cast<AtomicType>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

/**
 * @brief Enumeration for different kinds of unary operations.
 *
 * The UnaryOpKind enumeration defines various types of unary operations used
 * in expressions. Each kind specifies a particular type of operation, such as
 * subtraction or logical negation.
 */
public enum UnaryOpKind {
    | Not
    | Sub
    | ...
}

class UnaryExprPropInfos {
    let operandPropInfo: PropInfo

    init(operandPropInfo: PropInfo) {
        this.operandPropInfo = operandPropInfo
    }
}

class UnaryExprPosInfos {
    let opPos: CodePosition

    init(opPos: CodePosition) {
        this.opPos = opPos
    }
}

/**
 * @brief Represents a unary expression.
 *
 * The UnaryExpr class is a subclass of Expr and is used to model unary
 * expressions. It contains an operator kind specifying the type of operation
 * (e.g., subtraction or negation) and an operand expression on which the
 * operation is applied.
 */
public class UnaryExpr <: Expr {
    private let opKind_: UnaryOpKind

    private let startPos: CodePosition

    private let propInfos: UnaryExprPropInfos

    private let posInfos: UnaryExprPosInfos

    /**
     * @brief Retrieves the position range of the operator in the code.
     *
     * @return CodePositionRange representing the start and end positions of the operator.
     */
    public func getOperatorPos(): CodePositionRange {
        let endPos = posInfos.opPos + SyntaxNodeKind.NotToken.size
        return CodePositionRange(posInfos.opPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, opKind_: UnaryOpKind,
        posInfos: UnaryExprPosInfos, propInfos: UnaryExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.opKind_ = opKind_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with operand and op kind.
     */
    public init(opKind: UnaryOpKind, operand: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createUnaryExprImpl(opKind, operand, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<UnaryExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
        this.opKind_ = opKind
    }

    /**
     * @brief Type of unary operation (e.g., subtraction or negation).
     *
     * This member variable stores the kind of unary operation specified by the
     * UnaryOpKind enumeration.
     */
    public prop opKind: UnaryOpKind {
        get() {
            opKind_
        }
    }

    /**
     * @brief Expression on which the unary operation is applied.
     *
     * This member variable stores the expression that is the operand of the unary
     * operation.
     */
    public prop operand: Expr {
        get() {
            return translateExprChild<Expr>(nodeImpl, startPos, this, propInfos.operandPropInfo)
        }
    }
}

class UnsafeExprPosInfos {
    let unsafePos: CodePosition

    init(unsafePos: CodePosition) {
        this.unsafePos = unsafePos
    }
}

class UnsafeExprPropInfos {
    let blockPropInfo: PropInfo

    init(blockPropInfo: PropInfo) {
        this.blockPropInfo = blockPropInfo
    }
}

/**
 * @brief Represents a block of code that can execute unsafe operations.
 *
 * The UnsafeExpr class is a subclass of Expr and is used to encapsulate a block of code
 * that may contain unsafe operations. It is designed to handle scenarios where direct
 * manipulation of memory or other low-level operations are required, which are typically
 * not allowed in safe code contexts.
 *
 * This class contains a single block of code which is executed in an environment where
 * certain safety checks are relaxed. Care must be taken when using this class, as improper
 * use can lead to memory leaks, undefined behavior, or security vulnerabilities.
 */
public class UnsafeExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: UnsafeExprPropInfos

    private let posInfos: UnsafeExprPosInfos

    public func getUnsafePos(): CodePositionRange {
        let endPos = posInfos.unsafePos + SyntaxNodeKind.UnsafeToken.size
        return CodePositionRange(posInfos.unsafePos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: UnsafeExprPosInfos,
        propInfos: UnsafeExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new UnsafeExpr node.
     */
    public init(block: Block, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createUnsafeExprImpl(block, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<UnsafeExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The block of code containing unsafe operations.
     *
     * This member variable stores the block of code that will be executed in an unsafe context.
     * The block may contain operations such as raw pointer manipulation, direct memory access,
     * or other low-level operations that bypass the language's usual safety mechanisms.
     */
    public prop block: Block {
        get() {
            let propInfo = propInfos.blockPropInfo
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
            cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, this)).getOrThrow()
        }
    }
}

class VArrayExprPosInfos {
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(lParenPos: CodePosition, rParenPos: CodePosition) {
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

class VArrayExprPropInfos {
    let argumentPropInfo: PropInfo
    let vArrayTypePropInfo: PropInfo

    init(argumentPropInfo: PropInfo, vArrayTypePropInfo: PropInfo) {
        this.argumentPropInfo = argumentPropInfo
        this.vArrayTypePropInfo = vArrayTypePropInfo
    }
}

/**
 * @brief VArray expression class, inheriting from Expr.
 */
public class VArrayExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: VArrayExprPropInfos

    private let posInfos: VArrayExprPosInfos

    /**
     * @brief Gets the position range of the left parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the left parenthesis.
     */
    public func getLParenPos(): CodePositionRange {
        let endPos = posInfos.lParenPos + SyntaxNodeKind.LParenToken.size
        return CodePositionRange(posInfos.lParenPos, endPos)
    }

    /**
     * @brief Gets the position range of the right parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the right parenthesis.
     */
    public func getRParenPos(): CodePositionRange {
        let endPos = posInfos.rParenPos + SyntaxNodeKind.RParenToken.size
        return CodePositionRange(posInfos.rParenPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: VArrayExprPosInfos,
        propInfos: VArrayExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with augument and type of varray.
     */
    public init(argument: Argument, vArrayType: VArrayType, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createVArrayExprImpl(argument, vArrayType, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<VArrayExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief Array of arguments for the VArray expression.
     */
    public prop argument: Argument {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.argumentPropInfo.index]
            let offset = propInfos.argumentPropInfo.offset
            cast<Argument>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief Type of the VArray expression.
     */
    public prop vArrayType: VArrayType {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.vArrayTypePropInfo.index]
            let offset = propInfos.vArrayTypePropInfo.offset
            cast<VArrayType>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class WhileExprPosInfos {
    let condLParenPos: CodePosition
    let condRParenPos: CodePosition
    let whileKeyWordPos: CodePosition

    init(condLParenPos: CodePosition, condRParenPos: CodePosition, whileKeyWordPos: CodePosition) {
        this.condLParenPos = condLParenPos
        this.condRParenPos = condRParenPos
        this.whileKeyWordPos = whileKeyWordPos
    }
}

class WhileExprPropInfos {
    let bodyPropInfo: PropInfo
    let conditionPropInfo: PropInfo

    init(bodyPropInfo: PropInfo, conditionPropInfo: PropInfo) {
        this.bodyPropInfo = bodyPropInfo
        this.conditionPropInfo = conditionPropInfo
    }
}

/**
 * @brief Represents a while loop expression.
 *        It consists of a loop body and a continuation condition.
 */
public class WhileExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: WhileExprPropInfos

    private let posInfos: WhileExprPosInfos

    /**
     * @brief Get the position range of the 'while' keyword.
     */
    public func getWhileKeyWordPos(): CodePositionRange {
        return createExprTokenRange(posInfos.whileKeyWordPos, SyntaxNodeKind.WhileToken.size)
    }

    /**
     * @brief Get the position range of the left parenthesis in the condition.
     */
    public func getCondLParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.condLParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position range of the right parenthesis in the condition.
     */
    public func getCondRParenPos(): CodePositionRange {
        return createExprTokenRange(posInfos.condRParenPos, SyntaxNodeKind.RParenToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: WhileExprPosInfos,
        propInfos: WhileExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new WhileExpr node.
     */
    public init(body: Block, condition: DisjunctionCondition, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createWhileExprImpl(body, condition, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<WhileExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The body of the loop as a block of code.
     */
    public prop body: Block {
        get() {
            return translateExprChild<Block>(nodeImpl, startPos, this, propInfos.bodyPropInfo)
        }
    }

    /**
     * @brief The loop continuation condition.
     */
    public prop condition: DisjunctionCondition {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.conditionPropInfo.index]
            let offset = propInfos.conditionPropInfo.offset
            cast<DisjunctionCondition>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                .getOrThrow()
        }
    }
}
