/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList

private func createMacroOptionalTokenRange(pos: Option<CodePosition>, size: Int64): Option<CodePositionRange> {
    if (let Some(v) <- pos) {
        return CodePositionRange(v, v + size)
    }
    return None
}

private func translateMacroChild<T>(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
    propInfo: PropInfo): T where T <: SyntaxTreeNode {
    let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
    return cast<T>(SyntaxNodeImplTranslator.translate(curNode, startPos + propInfo.offset, parentNode)).getOrThrow()
}

private func translateMacroTokenList(nodeImpl: SyntaxNodeImpl, parentNode: SyntaxTreeNode, propInfo: PropInfo): Tokens {
    let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
    return parentNode.transTokenList(curNode)
}

private func translateMacroInputs(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: SyntaxTreeNode,
    propInfo: PropInfo, lParenPos: Option<CodePositionRange>): MacroExpandInput {
    let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
    let offset = propInfo.offset

    if (lParenPos.isSome()) {
        return WithParens(parentNode.transTokenList(curNode))
    }
    return WithoutParens(
        cast<Decl>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, parentNode)).getOrThrow())
}

class MacroExpandDeclPropInfos {
    let calleeMacroPropInfo: PropInfo
    let macroAttrsPropInfo: PropInfo
    let macroInputsPropInfo: PropInfo

    init(calleeMacroPropInfo: PropInfo, macroAttrsPropInfo: PropInfo, macroInputsPropInfo: PropInfo) {
        this.calleeMacroPropInfo = calleeMacroPropInfo
        this.macroAttrsPropInfo = macroAttrsPropInfo
        this.macroInputsPropInfo = macroInputsPropInfo
    }
}

class MacroExpandDeclPosInfos {
    let atPos: CodePosition
    let lSquarePos: Option<CodePosition>
    let rSquarePos: Option<CodePosition>
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>

    init(atPos: CodePosition, lSquarePos: Option<CodePosition>, rSquarePos: Option<CodePosition>,
        lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>) {
        this.atPos = atPos
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a macro expansion declaration, which extends from Decl.
 */
public class MacroExpandDecl <: Decl {
    private let startPos: CodePosition

    private let propInfos: MacroExpandDeclPropInfos

    private let posInfos: MacroExpandDeclPosInfos

    /**
     * @brief Get the position range of the 'at' token.
     */
    public func getAtPos(): CodePositionRange {
        return CodePositionRange(posInfos.atPos, posInfos.atPos + SyntaxNodeKind.AtToken.size)
    }

    /**
     * @brief Get the position range of the left square bracket if present.
     */
    public func getLSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lSquarePos, SyntaxNodeKind.LSquareToken.size)
    }

    /**
     * @brief Get the position range of the right square bracket if present.
     */
    public func getRSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rSquarePos, SyntaxNodeKind.RSquareToken.size)
    }

    /**
     * @brief Get the position range of the left parenthesis if present.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position range of the right parenthesis if present.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rParenPos, SyntaxNodeKind.RParenToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: MacroExpandDeclPosInfos, propInfos: MacroExpandDeclPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MacroExpandDecl node.
     */
    public init(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createMacroExpandDeclImpl(calleeMacro, macroAttrs, macroInputs,
                annotations: annotations, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MacroExpandDecl>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The expression of the macro being called.
     */
    public prop calleeMacro: Expr {
        get() {
            return translateMacroChild<Expr>(nodeImpl, startPos, this, propInfos.calleeMacroPropInfo)
        }
    }

    /**
     * @brief The attributes of the macro.
     */
    public prop macroAttrs: Tokens {
        get() {
            return translateMacroTokenList(nodeImpl, this, propInfos.macroAttrsPropInfo)
        }
    }

    /**
     * @brief The input declaration or tokens to the macro.
     */
    public prop macroInputs: MacroExpandInput {
        get() {
            return translateMacroInputs(nodeImpl, startPos, this, propInfos.macroInputsPropInfo, getLParenPos())
        }
    }
}

class MacroExpandExprPropInfos {
    let calleeMacroPropInfo: PropInfo
    let macroAttrsPropInfo: PropInfo
    let macroInputsPropInfo: PropInfo

    init(calleeMacroPropInfo: PropInfo, macroAttrsPropInfo: PropInfo, macroInputsPropInfo: PropInfo) {
        this.calleeMacroPropInfo = calleeMacroPropInfo
        this.macroAttrsPropInfo = macroAttrsPropInfo
        this.macroInputsPropInfo = macroInputsPropInfo
    }
}

class MacroExpandExprPosInfos {
    let atPos: CodePosition
    let lSquarePos: Option<CodePosition>
    let rSquarePos: Option<CodePosition>
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>

    init(atPos: CodePosition, lSquarePos: Option<CodePosition>, rSquarePos: Option<CodePosition>,
        lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>) {
        this.atPos = atPos
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a macro expansion expression, which extends from Expr.
 */
public class MacroExpandExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: MacroExpandExprPropInfos

    private let posInfos: MacroExpandExprPosInfos

    /**
     * @brief Get the position range of the 'at' token.
     */
    public func getAtPos(): CodePositionRange {
        return CodePositionRange(posInfos.atPos, posInfos.atPos + SyntaxNodeKind.AtToken.size)
    }

    /**
     * @brief Get the position range of the left square bracket if present.
     */
    public func getLSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lSquarePos, SyntaxNodeKind.LSquareToken.size)
    }

    /**
     * @brief Get the position range of the right square bracket if present.
     */
    public func getRSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rSquarePos, SyntaxNodeKind.RSquareToken.size)
    }

    /**
     * @brief Get the position range of the left parenthesis if present.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position range of the right parenthesis if present.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rParenPos, SyntaxNodeKind.RParenToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: MacroExpandExprPosInfos, propInfos: MacroExpandExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with callee, attributes and inputs.
     */
    public init(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, comments!: Array<Comment> = []) {
        super(
            unsafe { SyntaxNodeImplCreator.createMacroExpandExprImpl(calleeMacro, macroAttrs, macroInputs,
                comments: comments) })
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MacroExpandExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The expression of the macro being called.
     */
    public prop calleeMacro: Expr {
        get() {
            return translateMacroChild<Expr>(nodeImpl, startPos, this, propInfos.calleeMacroPropInfo)
        }
    }

    /**
     * @brief The attributes of the macro.
     */
    public prop macroAttrs: Tokens {
        get() {
            return translateMacroTokenList(nodeImpl, this, propInfos.macroAttrsPropInfo)
        }
    }

    /**
     * @brief The input declaration or tokens to the macro.
     */
    public prop macroInputs: MacroExpandInput {
        get() {
            return translateMacroInputs(nodeImpl, startPos, this, propInfos.macroInputsPropInfo, getLParenPos())
        }
    }
}

/**
 * @brief Enumerates the possible input forms for macro expansions.
 */
/**
 * @brief Enumerates the possible input forms for macro expansions.
 */
public enum MacroExpandInput {
    | WithoutParens(Decl)
    | WithParens(Tokens)
    | ...
}

class MacroExpandParamPropInfos {
    let calleeMacroPropInfo: PropInfo
    let macroAttrsPropInfo: PropInfo
    let macroInputsPropInfo: PropInfo

    init(calleeMacroPropInfo: PropInfo, macroAttrsPropInfo: PropInfo, macroInputsPropInfo: PropInfo) {
        this.calleeMacroPropInfo = calleeMacroPropInfo
        this.macroAttrsPropInfo = macroAttrsPropInfo
        this.macroInputsPropInfo = macroInputsPropInfo
    }
}

class MacroExpandParamPosInfos {
    let atPos: CodePosition
    let lSquarePos: Option<CodePosition>
    let rSquarePos: Option<CodePosition>
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>

    init(atPos: CodePosition, lSquarePos: Option<CodePosition>, rSquarePos: Option<CodePosition>,
        lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>) {
        this.atPos = atPos
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

/**
 * @brief Represents a function parameter that involves macro expansion.
 *        Used for parameters that are processed by macros during compilation.
 */
/**
 * @brief Represents a function parameter that involves macro expansion.
 *        Used for parameters that are processed by macros during compilation.
 */
public class MacroExpandParam <: Parameter {
    private let startPos: CodePosition

    private let propInfos: MacroExpandParamPropInfos

    private let posInfos: MacroExpandParamPosInfos

    /**
     * @brief Get the position range of the 'at' token.
     */
    public func getAtPos(): CodePositionRange {
        return CodePositionRange(posInfos.atPos, posInfos.atPos + SyntaxNodeKind.AtToken.size)
    }

    /**
     * @brief Get the position range of the left square bracket if present.
     */
    public func getLSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lSquarePos, SyntaxNodeKind.LSquareToken.size)
    }

    /**
     * @brief Get the position range of the right square bracket if present.
     */
    public func getRSquarePos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rSquarePos, SyntaxNodeKind.RSquareToken.size)
    }

    /**
     * @brief Get the position range of the left parenthesis if present.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.lParenPos, SyntaxNodeKind.LParenToken.size)
    }

    /**
     * @brief Get the position range of the right parenthesis if present.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        return createMacroOptionalTokenRange(posInfos.rParenPos, SyntaxNodeKind.RParenToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: MacroExpandParamPosInfos, propInfos: MacroExpandParamPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new MacroExpandParam node.
     */
    public init(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createMacroExpandParamImpl(calleeMacro, macroAttrs, macroInputs,
                annotations: annotations, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<MacroExpandParam>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The expression of the macro being called.
     */
    public prop calleeMacro: Expr {
        get() {
            return translateMacroChild<Expr>(nodeImpl, startPos, this, propInfos.calleeMacroPropInfo)
        }
    }

    /**
     * @brief The attributes of the macro.
     */
    public prop macroAttrs: Tokens {
        get() {
            return translateMacroTokenList(nodeImpl, this, propInfos.macroAttrsPropInfo)
        }
    }

    /**
     * @brief The input declaration or tokens to the macro.
     */
    public prop macroInputs: MacroExpandInput {
        get() {
            return translateMacroInputs(nodeImpl, startPos, this, propInfos.macroInputsPropInfo, getLParenPos())
        }
    }
}

class QuoteInterpolationExprPosInfos {
    let dollarPos: CodePosition
    let lParenPos: Option<CodePosition>
    let rParenPos: Option<CodePosition>

    init(dollarPos: CodePosition, lParenPos: Option<CodePosition>, rParenPos: Option<CodePosition>) {
        this.dollarPos = dollarPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

class QuoteInterpolationExprPropInfos {
    let exprPropInfo: PropInfo

    init(exprPropInfo: PropInfo) {
        this.exprPropInfo = exprPropInfo
    }
}

/**
 * @brief Represents a quote interpolation expression, which extends from Expr, e.g. $(A.a) or $a.
 */
public class QuoteInterpolationExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: QuoteInterpolationExprPropInfos

    private let posInfos: QuoteInterpolationExprPosInfos

    /**
     * @brief Gets the position range of the dollar sign in the code.
     *
     * @return A CodePositionRange representing the position range of the dollar sign.
     */
    public func getDollarPos(): CodePositionRange {
        let endPos = posInfos.dollarPos + SyntaxNodeKind.DollarToken.size
        return CodePositionRange(posInfos.dollarPos, endPos)
    }

    /**
     * @brief Gets the position range of the left parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the left parenthesis.
     */
    public func getLParenPos(): Option<CodePositionRange> {
        if (let Some(lParenPos) <- posInfos.lParenPos) {
            let endPos = lParenPos + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(lParenPos, endPos)
        } else {
            return None
        }
    }

    /**
     * @brief Gets the position range of the right parenthesis in the code.
     *
     * @return A CodePositionRange representing the position range of the right parenthesis.
     */
    public func getRParenPos(): Option<CodePositionRange> {
        if (let Some(rParenPos) <- posInfos.rParenPos) {
            let endPos = rParenPos + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(rParenPos, endPos)
        } else {
            return None
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: QuoteInterpolationExprPosInfos, propInfos: QuoteInterpolationExprPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with quoted expr.
     */
    public init(expr: Expr, hasParen!: Bool = false, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createQuoteInterpolationExprImpl(expr, hasParen: hasParen, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<QuoteInterpolationExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None))
            .getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The expression to be interpolated.
     */
    public prop expr: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.exprPropInfo.index]
            let offset = propInfos.exprPropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class QuoteTokenPropInfos {
    let contentPropInfo: PropInfo

    init(contentPropInfo: PropInfo) {
        this.contentPropInfo = contentPropInfo
    }
}

/**
 * @brief Represents a quote token, which extends from SyntaxTreeNode.
 */
public class QuoteToken <: SyntaxTreeNode {
    private let startPos: CodePosition

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
    }

    /**
     * @brief Initialize node with quoted tokens.
     */
    public init(content: Tokens, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createQuoteTokenImpl(content, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<QuoteToken>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
    }

    /**
     * @brief The content of the quote token.
     */
    public prop content: Tokens {
        get() {
            let content = ArrayList<Token>()
            for (child in (nodeImpl as NonTerminal).getOrThrow().children) {
                match (child.kind) {
                    case SyntaxNodeKind.Token =>
                        if (let Some(tk) <- (child as TokenTerminal)) {
                            content.add(Token(tk.tokenKind, tk.value))
                        }
                    case _ => ()
                }
            }
            Tokens(content)
        }
    }
}

class QuoteExprPosInfos {
    let quoteKeyWordPos: CodePosition
    let lParenPos: CodePosition
    let rParenPos: CodePosition

    init(quoteKeyWordPos: CodePosition, lParenPos: CodePosition, rParenPos: CodePosition) {
        this.quoteKeyWordPos = quoteKeyWordPos
        this.lParenPos = lParenPos
        this.rParenPos = rParenPos
    }
}

class QuoteExprPropInfos {
    let tokensOrRefExprPropInfo: Array<PropInfo>

    init(tokensOrRefExprPropInfo: Array<PropInfo>) {
        this.tokensOrRefExprPropInfo = tokensOrRefExprPropInfo
    }
}

/**
 * @brief Represents a quote expression, which extends from Expr.
 * quote(
 *     arr = $(intList)
 *     x = $(float)
 * )
 */
public class QuoteExpr <: Expr {
    private let startPos: CodePosition

    private let propInfos: QuoteExprPropInfos

    private let posInfos: QuoteExprPosInfos

    /**
     * @brief Gets the position range of the 'quote' keyword in the code.
     *
     * @return A CodePositionRange representing the position range of the 'quote' keyword.
     */
    public func getQuoteKeyWordPos(): CodePositionRange {
        let endPos = posInfos.quoteKeyWordPos + SyntaxNodeKind.QuoteToken.size
        return CodePositionRange(posInfos.quoteKeyWordPos, endPos)
    }
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

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: QuoteExprPosInfos,
        propInfos: QuoteExprPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with array of quoted content.
     */
    public init(tokensOrRefExpr: Array<QuoteExprContent>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createQuoteExprImpl(tokensOrRefExpr, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<QuoteExpr>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.posInfos = redNode.posInfos
        this.propInfos = redNode.propInfos
        this.startPos = startPos
    }

    /**
     * @brief An array containing the tokens or reference expressions.
     */
    public prop tokensOrRefExpr: Array<QuoteExprContent> {
        get() {
            let tokensOrRefExprs = ArrayList<QuoteExprContent>()

            for (propInfo in propInfos.tokensOrRefExprPropInfo) {
                let node = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                match (node.kind) {
                    case SyntaxNodeKind.QuoteTokenExpr => tokensOrRefExprs.add(
                        TokenPart(
                            cast<QuoteToken>(SyntaxNodeImplTranslator.translate(node, startPos + offset, this))
                                .getOrThrow()))
                    case _ => tokensOrRefExprs.add(
                        QuoteInterpolation(
                            cast<QuoteInterpolationExpr>(SyntaxNodeImplTranslator.translate(node, startPos + offset,
                                this)).getOrThrow()))
                }
            }

            tokensOrRefExprs.toArray()
        }
    }
}

/**
 * @brief Represents the content of a quote expression.
 */
public enum QuoteExprContent {
    | TokenPart(QuoteToken)
    | QuoteInterpolation(QuoteInterpolationExpr)
    | ...
}
