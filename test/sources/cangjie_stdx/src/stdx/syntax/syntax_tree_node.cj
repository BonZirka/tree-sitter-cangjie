/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList
import std.deriving.*
import std.ast.ToTokens

extend Token {
    func addPosition(pos: CodePosition) {
        this.addPosition(0, pos.line, pos.column)
    }
}
/**
 * @brief Abstract sealed class representing a node in the syntax tree.
 *
 * This class serves as a base for other syntax tree node classes.
 */
sealed abstract class SyntaxTreeNode <: ToString & ToTokens & Hashable & Equatable<SyntaxTreeNode> {
    /**
     * @brief The position of this node
     *
     * CodePosition range covering the start and end positions of the node in source code
     */
    public let nodePos: CodePositionRange

    /**
     * @brief The parent node of this node.
     *
     * This optional field may contain a reference to the parent node in the syntax tree.
     */
    public let parentNode: Option<SyntaxTreeNode>

    let nodeImpl: SyntaxNodeImpl

    let commentsPropInfo: Array<PropInfo>

    /**
     * @brief Returns a string representation of the node.
     *
     * @return A string representation of the node, or an empty string if no implementation is set.
     */
    public open func toString(): String {
        nodeImpl.preWhiteSpaceString() + nodeImpl.toString()
    }

    private func nonTerminalToToken(nt: NonTerminal, startPos: CodePosition): Token {
        var strVal = ""
        var isSingleQuote = false
        var delimiterNum: UInt16 = 1
        var sz = nt.children.size
        match (nt.children[sz - 1]) {
            case rt: RepeatedTerminal =>
                delimiterNum = UInt16(rt.repeat)
                sz -= 1
            case _ => ()
        }
        // sz is the position of quote
        if (nt.children[sz - 1].kind.toString() == "'" || nt.children[sz - 1].kind.toString() == "'''") {
            isSingleQuote = true
        }
        // get token kind for literal
        let tokenKind = match (nt.kind) {
            case SyntaxNodeKind.RuneLiteral => TokenKind.RUNE_LITERAL
            case SyntaxNodeKind.LineStringLiteral =>
                if (isSingleQuote) {
                    TokenKind.SINGLE_QUOTED_STRING_LITERAL
                } else {
                    TokenKind.STRING_LITERAL
                }
            case SyntaxNodeKind.MultiLineStringLiteral => TokenKind.MULTILINE_STRING
            case SyntaxNodeKind.MultiLineRawStringLiteral => TokenKind.MULTILINE_RAW_STRING
            case _ => TokenKind.ILLEGAL
        }
        // get value for string literal
        for (child in nt.children) {
            match (child) {
                case vt: ValuedTerminal => strVal += vt.value
                case nt: NonTerminal => strVal += nt.toString()
                case _ => ()
            }
        }
        var token = Token(tokenKind, strVal).addPosition(startPos)
        token.isSingleQuote = isSingleQuote
        token.delimiterNum = delimiterNum
        return token
    }

    func repeatedTerminalToTokens(rt: RepeatedTerminal, offset: Offset, startPos: CodePosition, tokenKind: TokenKind,
        tks: ArrayList<Token>) {
        for (_ in 0..rt.repeat) {
            let tk = Token(tokenKind).addPosition(startPos + offset)
            tks.add(tk)
            offset.moveString(tk.value)
        }
    }

    public open func toTokens(): Tokens {
        let startPos = nodePos.begin
        let nodeImplFlatter = nodeImpl.flatter()
        let sz = nodeImplFlatter.size
        let tks = ArrayList<Token>()
        var offset = Offset()
        for (i in 0..sz) {
            let tk = nodeImplFlatter[i]
            var token = Token()
            match (tk) {
                // literal special handling, these are NonTerminals that can be directly converted into Tokens.
                case nt: NonTerminal => token = nonTerminalToToken(nt, startPos + offset)
                case _ =>
                    // special handling for TokenTerminal
                    let tokenKind = if (let Some(tt) <- (tk as TokenTerminal)) {
                        tt.tokenKind
                    } else {
                        tk.kind.toTokenKind()
                    }
                    // skip illegal token like space
                    if (tokenKind == TokenKind.ILLEGAL) {
                        offset.moveNode(tk)
                        continue
                    }
                    // convert Terminal to Token
                    token = match (tk) {
                        case rt: RepeatedTerminal =>
                            repeatedTerminalToTokens(rt, offset, startPos, tokenKind, tks)
                            continue
                        case vt: ValuedTerminal => Token(tokenKind, vt.value)
                        case tt: TokenTerminal => Token(tt.tokenKind, tt.value)
                        case _ => Token(tokenKind, tk.toString())
                    }
                    token = token.addPosition(startPos + offset)
            }
            tks.add(token)
            offset.moveNode(tk)
        }
        Tokens(tks)
    }

    init(nodePos: CodePositionRange, nodeImpl: SyntaxNodeImpl, parentNode: ?SyntaxTreeNode,
        commentsPropInfo: Array<PropInfo>) {
        this.nodePos = nodePos
        this.nodeImpl = nodeImpl
        this.parentNode = parentNode
        this.commentsPropInfo = commentsPropInfo
    }

    // only support for initialize nodes with public Init Function
    init(nodeImpl: SyntaxNodeImpl, hasComment!: Bool = true) {
        let startPos = DEFAULT_START_POS
        this.nodePos = CodePositionRange(startPos, startPos + nodeImpl.offset)
        this.nodeImpl = nodeImpl
        this.parentNode = None
        if (hasComment) {
            this.commentsPropInfo = [PropInfo()]
        } else {
            this.commentsPropInfo = Array<PropInfo>()
        }
    }

    func transTokenList(node: SyntaxNodeImpl): Tokens {
        let content = ArrayList<Token>()
        if (let Some(nt) <- (node as NonTerminal)) {
            for (child in nt.children) {
                if (let Some(tk) <- (child as TokenTerminal)) {
                    content.add(Token(tk.tokenKind, tk.value))
                }
            }
        }
        Tokens(content)
    }

    /**
     * @brief Judge whether current node is equal to the other node.
     *
     * @return Boolean value representing the equality of two nodes.
     */
    public operator func ==(that: SyntaxTreeNode): Bool {
        if (this.nodePos != that.nodePos) {
            return false
        }
        nodeImpl.id == that.nodeImpl.id
    }

    /**
     * @brief Returns hashcode of the node.
     *
     * @return Integer representation of the node's hashcode.
     */
    public func hashCode(): Int64 {
        var df = DefaultHasher()
        df.write(nodePos.beginLine)
        df.write(nodePos.beginColumn)
        df.write(nodePos.endLine)
        df.write(nodePos.endColumn)
        df.write(nodePos.filePath)
        df.write(nodeImpl.id)
        df.finish()
    }

    func transCommentGroupList(node: NonTerminal, startPos: CodePosition, parent: ?SyntaxTreeNode): Array<CommentGroup> {
        let lp = LocalParser(node.children)

        let elements = ArrayList<CommentGroup>()
        while (lp.look(SyntaxNodeKind.CommentGroup)) {
            let cmtGroupNode = lp.consume().getOrThrow()
            elements.add(
                cast<CommentGroup>(
                    SyntaxNodeImplTranslator.translate((cmtGroupNode as NonTerminal).getOrThrow(), startPos + lp.offset,
                        parent)).getOrThrow())
            lp.moveOffset(cmtGroupNode)
        }
        elements.toArray()
    }

    /**
     * @brief The comments array of the SyntaxTreeNode.
     *
     * This array field contains the comments of the node.
     */
    public prop comments: Array<Comment> {
        get() {
            let cmts = ArrayList<Comment>()

            for (propInfo in commentsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                let stPos = CodePosition(nodePos.beginLine, nodePos.beginColumn,
                    FileInfos(nodePos.fileName, nodePos.filePath))
                let commentGroupList = transCommentGroupList((curNode as NonTerminal).getOrThrow(), stPos + offset, this)
                for (commentGroup in commentGroupList) {
                    cmts.add(all: commentGroup.elements)
                }
            }
            cmts.toArray()
        }
    }
}

/**
 * @brief Enumeration for different at operation kinds.
 *
 * The AtOpKind enumeration represents various types of at operations
 * that can be used in annotation. Each kind is an operator that
 * specifies the type of annotation.
 */
public enum AtOpKind {
    | At
    | AtExcl
    | ...
}

class AnnotationPropInfos {
    let argumentPropInfo: Array<PropInfo>

    init(argumentPropInfo: Array<PropInfo>) {
        this.argumentPropInfo = argumentPropInfo
    }
}

class AnnotationPosInfos {
    let atOpPos: CodePosition
    let lSquarePos: Option<CodePosition>
    let rSquarePos: Option<CodePosition>
    let identifierPos: CodePosition
    let commasPos: Array<CodePosition>

    init(
        atOpPos: CodePosition,
        lSquarePos: Option<CodePosition>,
        rSquarePos: Option<CodePosition>,
        identifierPos: CodePosition,
        commasPos: Array<CodePosition>
    ) {
        this.atOpPos = atOpPos
        this.lSquarePos = lSquarePos
        this.rSquarePos = rSquarePos
        this.identifierPos = identifierPos
        this.commasPos = commasPos
    }
}
/**
 * @brief Class representing an annotation in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains information about an annotation,
 * including its arguments and identifier.
 */
public class Annotation <: SyntaxTreeNode {
    private let identifier_: String

    private let opKind_: AtOpKind

    private let startPos: CodePosition

    private let propInfos: AnnotationPropInfos

    private let posInfos: AnnotationPosInfos

    /**
     * @brief Get the position of the annotation operator.
     *
     * @return CodePositionRange representing the position of the annotation at operator.
     */
    public func getAtOpPos(): CodePositionRange {
        let endPos = posInfos.atOpPos + match (opKind) {
            case At => SyntaxNodeKind.AtToken.size
            case AtExcl => SyntaxNodeKind.AtExclToken.size
            case _ => 0
        }
        return CodePositionRange(posInfos.atOpPos, endPos)
    }

    /**
     * @brief Get the positions of commas in the code.
     *
     * @return Array<CodePositionRange> containing the positions of commas.
     */
    public func getCommasPos(): Array<CodePositionRange> {
        let commasPosR = ArrayList<CodePositionRange>()
        for (comma in posInfos.commasPos) {
            commasPosR.add(CodePositionRange(comma, comma + SyntaxNodeKind.CommaToken.size))
        }
        return commasPosR.toArray()
    }

    /**
     * @brief Get the position range of the identifier.
     *
     * @return CodePositionRange representing the position range of the identifier.
     */
    public func getIdentifierPos(): CodePositionRange {
        return CodePositionRange(posInfos.identifierPos, posInfos.identifierPos + identifier.size)
    }

    /**
     * @brief Get the position of the left square bracket.
     *
     * @return CodePositionRange representing the position of the left square bracket.
     */
    public func getLSquarePos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.lSquarePos) {
            return CodePositionRange(v, v + SyntaxNodeKind.LSquareToken.size)
        }
        return None
    }

    /**
     * @brief Get the position of the right square bracket.
     *
     * @return CodePositionRange representing the position of the right square bracket.
     */
    public func getRSquarePos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.rSquarePos) {
            return CodePositionRange(v, v + SyntaxNodeKind.RSquareToken.size)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, identifier_: String,
        opKind_: AtOpKind, posInfos: AnnotationPosInfos, propInfos: AnnotationPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.identifier_ = identifier_
        this.opKind_ = opKind_
        this.propInfos = propInfos
        this.posInfos = posInfos
    }

    /**
     * @brief Initialize a new Annotation node.
     */
    public init(arguments: Array<Argument>, identifier: String, opKind: AtOpKind, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createAnnotationImpl(arguments, identifier, opKind, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Annotation>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.identifier_ = identifier
        this.opKind_ = opKind
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The arguments of the annotation.
     *
     * This array field contains the arguments of the annotation.
     */
    public prop arguments: Array<Argument> {
        get() {
            let argus = ArrayList<Argument>()
            for (propInfo in propInfos.argumentPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                argus.add(
                    cast<Argument>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            argus.toArray()
        }
    }

    /**
     * @brief The identifier of the annotation.
     *
     * This string field holds the identifier of the annotation.
     */
    public prop identifier: String {
        get() {
            identifier_
        }
    }

    public prop opKind: AtOpKind {
        get() {
            opKind_
        }
    }
}

class ArgumentPropInfos {
    let valuePropInfo: PropInfo

    init(valuePropInfo: PropInfo) {
        this.valuePropInfo = valuePropInfo
    }
}

class ArgumentPosInfos {
    let inoutKeyWordPos: Option<CodePosition>
    let identifierPos: Option<CodePosition>
    let colonPos: Option<CodePosition>

    init(inoutKeyWordPos: Option<CodePosition>, identifierPos: Option<CodePosition>, colonPos: Option<CodePosition>) {
        this.inoutKeyWordPos = inoutKeyWordPos
        this.identifierPos = identifierPos
        this.colonPos = colonPos
    }
}

/**
 * @brief Class representing an argument in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains information about an argument,
 * including its identifier, whether it is in-out, and its value expression.
 */
public class Argument <: SyntaxTreeNode {
    private let identifier_: Option<String>

    private let isInOut_: Bool

    private let isNamed_: Bool

    private let startPos: CodePosition

    private let propInfos: ArgumentPropInfos

    private let posInfos: ArgumentPosInfos

    /**
     * @brief Gets the position range of the 'inout' keyword in the parameter declaration.
     *
     * @return An Option of CodePositionRange representing the position range of the 'inout' keyword, if present.
     */
    public func getInoutKeyWordPos(): Option<CodePositionRange> {
        if (let Some(inoutKeyWordPos) <- posInfos.inoutKeyWordPos) {
            let endPos = inoutKeyWordPos + SyntaxNodeKind.InoutToken.size
            return CodePositionRange(inoutKeyWordPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the identifier in the parameter declaration.
     *
     * @return An Option of CodePositionRange representing the position range of the identifier, if present.
     */
    public func getIdentifierPos(): Option<CodePositionRange> {
        if (let Some(identifierPos) <- posInfos.identifierPos && let Some(id) <- identifier) {
            let endPos = identifierPos + id.size
            return CodePositionRange(identifierPos, endPos)
        }
        return None
    }

    /**
     * @brief Gets the position range of the colon in the parameter declaration.
     *
     * @return An Option of CodePositionRange representing the position range of the colon, if present.
     */
    public func getColonPos(): Option<CodePositionRange> {
        if (let Some(colonPos) <- posInfos.colonPos) {
            let endPos = colonPos + SyntaxNodeKind.ColonToken.size
            return CodePositionRange(colonPos, endPos)
        }
        return None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, identifier_: Option<String>,
        isInOut_: Bool, isNamed_: Bool, posInfos: ArgumentPosInfos, propInfos: ArgumentPropInfos,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.identifier_ = identifier_
        this.isInOut_ = isInOut_
        this.isNamed_ = isNamed_
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new Argument node.
     */
    public init(identifier: Option<String>, isInOut: Bool, value: Expr, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createArgumentImpl(identifier, isInOut, value, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Argument>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.identifier_ = identifier
        this.isInOut_ = isInOut
        this.isNamed_ = redNode.isNamed
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The identifier of the argument.
     *
     * This optional field may contain the identifier of the argument as a string.
     */
    public prop identifier: Option<String> {
        get() {
            identifier_
        }
    }

    /**
     * @brief Indicates if the argument is in-out.
     *
     * This boolean field specifies whether the argument is an in-out argument.
     */
    public prop isInOut: Bool {
        get() {
            isInOut_
        }
    }

    /**
     * @brief Check if the entity is named.
     *
     * This boolean field specifies indicating whether the entity is named.
     */
    public prop isNamed: Bool {
        get() {
            isNamed_
        }
    }

    /**
     * @brief The value expression of the argument.
     *
     * This field contains the expression representing the value of the argument.
     */
    public prop value: Expr {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.valuePropInfo.index]
            let offset = propInfos.valuePropInfo.offset
            cast<Expr>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }
}

class BlockPropInfos {
    let nodesPropInfo: Option<PropInfo>

    init(nodesPropInfo: Option<PropInfo>) {
        this.nodesPropInfo = nodesPropInfo
    }
}

class BlockPosInfos {
    let lCurlPos: CodePosition
    let rCurlPos: CodePosition

    init(lCurlPos: CodePosition, rCurlPos: CodePosition) {
        this.lCurlPos = lCurlPos
        this.rCurlPos = rCurlPos
    }
}

/**
 * @brief Class representing a block in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains a collection of child nodes.
 */
public class Block <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: BlockPropInfos

    private let posInfos: BlockPosInfos

    /**
     * @brief Get the position of the left curly brace.
     *
     * @return CodePositionRange representing the position of the left curly brace.
     */
    public func getLCurlPos(): CodePositionRange {
        return CodePositionRange(posInfos.lCurlPos, posInfos.lCurlPos + SyntaxNodeKind.LCurlToken.size)
    }

    /**
     * @brief Get the position of the right curly brace.
     *
     * @return CodePositionRange representing the position of the right curly brace.
     */
    public func getRCurlPos(): CodePositionRange {
        return CodePositionRange(posInfos.rCurlPos, posInfos.rCurlPos + SyntaxNodeKind.RCurlToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: BlockPosInfos,
        propInfos: BlockPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize a new Block node.
     */
    public init(nodes: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createBlockImpl(nodes, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Block>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()

        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The nodes within the block.
     *
     * This array field contains the child nodes that make up the block.
     */
    public prop nodes: Array<SyntaxTreeNode> {
        get() {
            let nodeList = ArrayList<SyntaxTreeNode>()
            if (let Some(propInfo) <- propInfos.nodesPropInfo) {
                let lp = LocalParser((nodeImpl as NonTerminal).getOrThrow().children, propInfo.offset,
                    index: propInfo.index)
                while (!lp.look(SyntaxNodeKind.RCurlToken)) {
                    var impl = lp.consume().getOrThrow()
                    nodeList.add(
                        cast<SyntaxTreeNode>(SyntaxNodeImplTranslator.translate(impl, startPos + lp.offset, this))
                            .getOrThrow())
                    lp.offset.move(impl.offset)
                }
            }
            nodeList.toArray()
        }
    }
}

class EnumBodyPosInfos {
    let bitOrsPos: Array<CodePosition>
    let ellipsisPos: Option<CodePosition>

    init(bitOrsPos: Array<CodePosition>, ellipsisPos: Option<CodePosition>) {
        this.bitOrsPos = bitOrsPos
        this.ellipsisPos = ellipsisPos
    }
}

class BodyPropInfos {
    let memberDeclsPropInfo: Array<PropInfo>

    init(memberDeclsPropInfo: Array<PropInfo>) {
        this.memberDeclsPropInfo = memberDeclsPropInfo
    }
}

class BodyPosInfos {
    let lCurlPos: CodePosition
    let rCurlPos: CodePosition

    init(lCurlPos: CodePosition, rCurlPos: CodePosition) {
        this.lCurlPos = lCurlPos
        this.rCurlPos = rCurlPos
    }
}

/**
 * @brief Represents the body of a custom decl
 *
 * This class is used to represent the body of a custom declaration.
 * It serves as a container for member declarations.
 */
public class Body <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: BodyPropInfos

    private let posInfos: BodyPosInfos

    let enumBodyPosInfos: EnumBodyPosInfos

    /**
     * @brief Get the position range of the left curly brace.
     */
    public func getLCurlPos(): CodePositionRange {
        let endPos = posInfos.lCurlPos + SyntaxNodeKind.LCurlToken.size
        CodePositionRange(posInfos.lCurlPos, endPos)
    }

    /**
     * @brief Get the position range of the right curly brace.
     */
    public func getRCurlPos(): CodePositionRange {
        let endPos = posInfos.rCurlPos + SyntaxNodeKind.RCurlToken.size
        CodePositionRange(posInfos.rCurlPos, endPos)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: BodyPosInfos,
        enumBodyPosInfos: EnumBodyPosInfos, propInfos: BodyPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.propInfos = propInfos
        this.posInfos = posInfos
        this.enumBodyPosInfos = enumBodyPosInfos
    }

    /**
     * @brief Initialize a new Body node.
     */
    public init(memberDecls: Array<Decl>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createBodyImpl(memberDecls, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Body>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
        this.enumBodyPosInfos = redNode.enumBodyPosInfos
    }

    /**
     * @brief The array of member declarations in the body.
     *
     * This variable holds an array of member declarations
     */
    public prop memberDecls: Array<Decl> {
        get() {
            let decls = ArrayList<Decl>()
            for (propInfo in propInfos.memberDeclsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                decls.add(cast<Decl>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            decls.toArray()
        }
    }
}

/**
 * @brief Enumeration representing different comment kinds.
 */
public enum CommentKind {
    | Block
    | Document
    | Line
    | ...
}

/**
 * @brief Represents the comment of a SyntaxTreeNode
 *
 * This class is used to represent the comment of a SyntaxTreeNode.
 * It records the comment content and kind.
 */
public class Comment <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let kind_: CommentKind

    private let content_: String

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: CommentKind,
        content_: String) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, Array<PropInfo>())
        this.startPos = startPos
        this.kind_ = kind_
        this.content_ = content_
    }

    /**
     * @brief Initialize a new Comment node.
     */
    public init(content: String) {
        super(SyntaxNodeImplCreator.createCommentImpl(content), hasComment: false)
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<Comment>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.kind_ = redNode.kind
        this.content_ = content
    }

    /**
     * @brief The kind of the comment.
     *
     * This variable represents the kind of the comment.
     */
    public prop kind: CommentKind {
        get() {
            kind_
        }
    }

    /**
     * @brief The content of the comment.
     *
     * This variable holds the content of the comment.
     */
    public prop content: String {
        get() {
            content_
        }
    }
}

class CommentGroupPropInfos {
    let elementsPropInfo: Array<PropInfo>

    init(elementsPropInfo: Array<PropInfo>) {
        this.elementsPropInfo = elementsPropInfo
    }
}

class CommentGroup <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: CommentGroupPropInfos

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, propInfos: CommentGroupPropInfos) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, Array<PropInfo>())
        this.startPos = startPos
        this.propInfos = propInfos
    }

    prop elements: Array<Comment> {
        get() {
            let eles = ArrayList<Comment>()
            for (propInfo in propInfos.elementsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                eles.add(
                    cast<Comment>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, parentNode))
                        .getOrThrow())
            }
            eles.toArray()
        }
    }
}

class GenericConstraintPropInfos {
    let typeArgumentPropInfo: PropInfo
    let upperBoundsPropInfo: Array<PropInfo>

    init(typeArgumentPropInfo: PropInfo, upperBoundsPropInfo: Array<PropInfo>) {
        this.typeArgumentPropInfo = typeArgumentPropInfo
        this.upperBoundsPropInfo = upperBoundsPropInfo
    }
}

class GenericConstraintPosInfos {
    let upperBoundPos: CodePosition
    let bitAndsPos: Array<CodePosition>

    init(upperBoundPos: CodePosition, bitAndsPos: Array<CodePosition>) {
        this.upperBoundPos = upperBoundPos
        this.bitAndsPos = bitAndsPos
    }
}

/**
 * @brief Class representing a generic constraint in the syntax tree.
 *
 * This class extends SyntaxTreeNode and encapsulates a type argument and its upper bounds.
 */
public class GenericConstraint <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: GenericConstraintPropInfos

    private let posInfos: GenericConstraintPosInfos
    /**
     * @brief Get the positions of bitwise 'and' operators in the code.
     *
     * @return Array<CodePositionRange> containing the positions of bitwise 'and' operators.
     */
    public func getBitAndsPos(): Array<CodePositionRange> {
        let bitAndPos = ArrayList<CodePositionRange>()
        for (bitAnd in posInfos.bitAndsPos) {
            bitAndPos.add(CodePositionRange(bitAnd, bitAnd + SyntaxNodeKind.BitAndToken.size))
        }
        return bitAndPos.toArray()
    }

    /**
     * @brief Get the position of the upper bound in the code.
     *
     * @return CodePositionRange representing the position of the upper bound.
     */
    public func getUpperBoundPos(): CodePositionRange {
        return CodePositionRange(posInfos.upperBoundPos, posInfos.upperBoundPos + SyntaxNodeKind.UpperBoundToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: GenericConstraintPosInfos, propInfos: GenericConstraintPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.propInfos = propInfos
        this.posInfos = posInfos
    }

    /**
     * @brief Initialize a new GenericConstraint node.
     */
    public init(typeArgument: TypeAnnotation, upperBounds: Array<TypeAnnotation>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createGenericConstraintImpl(typeArgument, upperBounds, comments: comments))
        let startPos = DEFAULT_START_POS

        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<GenericConstraint>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The type argument of the constraint.
     *
     * This field specifies the type argument of the constraint.
     */
    public prop typeArgument: TypeAnnotation {
        get() {
            let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfos.typeArgumentPropInfo.index]
            let offset = propInfos.typeArgumentPropInfo.offset
            cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
        }
    }

    /**
     * @brief The upper bounds of the type argument.
     *
     * This array field contains the upper bounds that the type argument must satisfy.
     */
    public prop upperBounds: Array<TypeAnnotation> {
        get() {
            let argus = ArrayList<TypeAnnotation>()
            for (propInfo in propInfos.upperBoundsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                argus.add(
                    cast<TypeAnnotation>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                        .getOrThrow())
            }
            argus.toArray()
        }
    }
}

class GenericConstraintsPropInfos {
    let constraintsPropInfo: Array<PropInfo>

    init(constraintsPropInfo: Array<PropInfo>) {
        this.constraintsPropInfo = constraintsPropInfo
    }
}

class GenericConstraintsPosInfos {
    let whereKeyWordPos: CodePosition
    let commasPos: Array<CodePosition>

    init(whereKeyWordPos: CodePosition, commasPos: Array<CodePosition>) {
        this.whereKeyWordPos = whereKeyWordPos
        this.commasPos = commasPos
    }
}

/**
 * @brief Class representing multiple generic constraints in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains a collection of GenericConstraint instances.
 */
public class GenericConstraints <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: GenericConstraintsPropInfos

    private let posInfos: GenericConstraintsPosInfos
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
     * @brief Get the position of the 'where' keyword.
     *
     * @return CodePositionRange representing the position of the 'where' keyword.
     */
    public func getWhereKeyWordPos(): CodePositionRange {
        return CodePositionRange(posInfos.whereKeyWordPos, posInfos.whereKeyWordPos + SyntaxNodeKind.WhereToken.size)
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode,
        posInfos: GenericConstraintsPosInfos, propInfos: GenericConstraintsPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.propInfos = propInfos
        this.posInfos = posInfos
    }

    /**
     * @brief Initialize a new GenericConstraints node.
     */
    public init(constraints: Array<GenericConstraint>, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createGenericConstraintsImpl(constraints, comments: comments))
        let startPos = DEFAULT_START_POS

        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<GenericConstraints>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief The collection of generic constraints.
     *
     * This array field contains multiple GenericConstraint instances.
     */
    public prop constraints: Array<GenericConstraint> {
        get() {
            let cons = ArrayList<GenericConstraint>()
            for (propInfo in propInfos.constraintsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cons.add(
                    cast<GenericConstraint>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                        .getOrThrow())
            }
            cons.toArray()
        }
    }
}

/**
 * @brief Enumeration representing different modifier kinds.
 */
@Derive[Equatable]
public enum ModifierKind {
    | Abstract
    | Internal
    | Mut
    | Open
    | Operator
    | Override
    | Private
    | Protected
    | Public
    | Redef
    | Sealed
    | Static
    | Unsafe
    | Const
    | ...
}

/**
 * @brief Class representing a modifier in the syntax tree.
 *
 * This class extends SyntaxTreeNode and encapsulates a ModifierKind.
 */
public class Modifier <: SyntaxTreeNode {
    private let kind_: ModifierKind

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, kind_: ModifierKind,
        commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.kind_ = kind_
    }

    /**
     * @brief Initialize a new Modifier node.
     */
    public init(kind: ModifierKind, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createModifierImpl(kind, comments: comments))
        this.kind_ = kind
    }

    /**
     * @brief The kind of modifier.
     *
     * This field specifies the kind of modifier this instance represents.
     */
    public prop kind: ModifierKind {
        get() {
            kind_
        }
    }
}

class ParameterListPropInfos {
    let paramsPropInfo: Array<PropInfo>

    init(paramsPropInfo: Array<PropInfo>) {
        this.paramsPropInfo = paramsPropInfo
    }
}

class ParameterListPosInfos {
    let paramsLParenPos: Option<CodePosition>
    let paramsCommasPos: Array<CodePosition>
    let paramsRParenPos: Option<CodePosition>

    init(paramsLParenPos: Option<CodePosition>, paramsCommasPos: Array<CodePosition>,
        paramsRParenPos: Option<CodePosition>) {
        this.paramsLParenPos = paramsLParenPos
        this.paramsCommasPos = paramsCommasPos
        this.paramsRParenPos = paramsRParenPos
    }
}

public class ParameterList <: SyntaxTreeNode {
    private let startPos: CodePosition

    private let propInfos: ParameterListPropInfos

    private let posInfos: ParameterListPosInfos

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
     * @brief Get the position range of the left parenthesis in the parameter list.
     */
    public func getParamsLParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.paramsLParenPos) {
            let endPos = v + SyntaxNodeKind.LParenToken.size
            return CodePositionRange(v, endPos)
        }
        None
    }

    /**
     * @brief Get the position range of the right parenthesis in the parameter list.
     */
    public func getParamsRParenPos(): Option<CodePositionRange> {
        if (let Some(v) <- posInfos.paramsRParenPos) {
            let endPos = v + SyntaxNodeKind.RParenToken.size
            return CodePositionRange(v, endPos)
        }
        None
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, posInfos: ParameterListPosInfos,
        propInfos: ParameterListPropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.startPos = startPos
        this.posInfos = posInfos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with parameters.
     */
    public init(parameters: Array<Parameter>, hasParen!: Bool = true, comments!: Array<Comment> = []) {
        super(SyntaxNodeImplCreator.createParameterListImpl(parameters, hasParen: hasParen, comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<ParameterList>(SyntaxNodeImplTranslator.translate(curNode, startPos, None)).getOrThrow()
        this.startPos = startPos
        this.propInfos = redNode.propInfos
        this.posInfos = redNode.posInfos
    }

    /**
     * @brief Get the params in the parameter list.
     */
    public prop params: Array<Parameter> {
        get() {
            let params = ArrayList<Parameter>()
            for (propInfo in propInfos.paramsPropInfo) {
                var curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                var offset = propInfo.offset
                var currentPos = startPos + offset
                params.add(
                    cast<Parameter>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            params.toArray()
        }
    }
}

class SourceFilePropInfos {
    let importListsPropInfo: Array<PropInfo>

    let pkgHeaderPropInfo: Option<PropInfo>

    let topLevelDeclsPropInfo: Array<PropInfo>

    let ftrDirectivePropInfo: Option<PropInfo>

    init(importListsPropInfo: Array<PropInfo>, pkgHeaderPropInfo: Option<PropInfo>,
        topLevelDeclsPropInfo: Array<PropInfo>, ftrDirectivePropInfo: Option<PropInfo>) {
        this.importListsPropInfo = importListsPropInfo
        this.pkgHeaderPropInfo = pkgHeaderPropInfo
        this.topLevelDeclsPropInfo = topLevelDeclsPropInfo
        this.ftrDirectivePropInfo = ftrDirectivePropInfo
    }
}

/**
 * @brief Class representing a source file in the syntax tree.
 *
 * This class extends SyntaxTreeNode and contains information about a source file,
 * including its name, path, package header, import lists, and top-level declarations.
 */
public class SourceFile <: SyntaxTreeNode {
    private let name_: String

    private let path_: String

    private let startPos: CodePosition

    private let propInfos: SourceFilePropInfos

    prop isMacroPackage: Bool {
        get() {
            pkgHeader?.isMacroPkg ?? false
        }
    }

    init(nodeImpl: SyntaxNodeImpl, startPos: CodePosition, parentNode: ?SyntaxTreeNode, name_: String, path_: String,
        propInfos: SourceFilePropInfos, commentsPropInfo: Array<PropInfo>) {
        super(CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, parentNode, commentsPropInfo)
        this.name_ = name_
        this.path_ = path_
        this.startPos = startPos
        this.propInfos = propInfos
    }

    /**
     * @brief Initialize node with import list, file name, file path, package header, top level declrations and features directive.
     */
    public init(importLists: Array<ImportList>, name: String, path: String, pkgHeader: Option<PackageHeader>,
        topLevelDecls: Array<Decl>, ftrDirective!: Option<FeaturesDirective> = None, comments!: Array<Comment> = []) {
        super(
            SyntaxNodeImplCreator.createSourceFileImpl(importLists, pkgHeader, topLevelDecls, ftrDirective: ftrDirective,
                comments: comments))
        let startPos = DEFAULT_START_POS
        let curNode = (this.nodeImpl as NonTerminal).getOrThrow()
        let redNode = cast<SourceFile>(SyntaxNodeImplTranslator.translateFile(curNode, path, parent: None)).getOrThrow()
        this.name_ = name
        this.path_ = path
        this.startPos = startPos
        this.propInfos = redNode.propInfos
    }

    /**
     * @brief The import lists of the source file.
     *
     * This array field contains the import lists of the source file.
     */
    public prop importLists: Array<ImportList> {
        get() {
            let imports = ArrayList<ImportList>()
            for (propInfo in propInfos.importListsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                imports.add(
                    cast<ImportList>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            imports.toArray()
        }
    }

    /**
     * @brief The name of the source file.
     *
     * This string field holds the name of the source file.
     */
    public prop name: String {
        get() {
            name_
        }
    }

    /**
     * @brief The path of the source file.
     *
     * This string field holds the path of the source file.
     */
    public prop path: String {
        get() {
            path_
        }
    }

    /**
     * @brief The package header of the source file.
     *
     * This optional field may contain the package header of the source file.
     */
    public prop pkgHeader: Option<PackageHeader> {
        get() {
            if (let Some(propInfo) <- propInfos.pkgHeaderPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<PackageHeader>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow()
            } else {
                None
            }
        }
    }

    /**
     * @brief The top-level declarations in the source file.
     *
     * This array field contains the top-level declarations in the source file.
     */
    public prop topLevelDecls: Array<Decl> {
        get() {
            let decls = ArrayList<Decl>()
            for (propInfo in propInfos.topLevelDeclsPropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                decls.add(cast<Decl>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this)).getOrThrow())
            }
            decls.toArray()
        }
    }

    /**
     * @brief The features directive of the source file.
     *
     * This optional field may contain the features directive of the source file.
     */
    public prop ftrDirective: Option<FeaturesDirective> {
        get() {
            if (let Some(propInfo) <- propInfos.ftrDirectivePropInfo) {
                let curNode = (nodeImpl as NonTerminal).getOrThrow().children[propInfo.index]
                let offset = propInfo.offset
                cast<FeaturesDirective>(SyntaxNodeImplTranslator.translate(curNode, startPos + offset, this))
                    .getOrThrow()
            } else {
                None
            }
        }
    }
}
