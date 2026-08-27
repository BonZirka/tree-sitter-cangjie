/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.{ArrayList, ArrayStack}
import std.sync.AtomicUInt64

private let SyntaxNodeImplID = AtomicUInt64(0)

// The base of NonTerminal (Non-Leaf node) and Terminal (Leaf node)
abstract class SyntaxNodeImpl {
    let kind: SyntaxNodeKind
    let preWhiteSpace: Array<SyntaxNodeImpl>
    let virtualParent: Option<SyntaxNodeImpl> = None
    let id: UInt64

    init(kind: SyntaxNodeKind, preWhiteSpace: Array<SyntaxNodeImpl>) {
        this.kind = kind
        this.preWhiteSpace = preWhiteSpace
        this.id = SyntaxNodeImplID.load()
        SyntaxNodeImplID.fetchAdd(1)
    }

    prop offset: Offset {
        get() {
            return getOffset()
        }
    }

    protected func toString(): String

    protected func getOffset(): Offset

    protected func preWhiteSpaceString(): String {
        var res = ""
        for (node in preWhiteSpace) {
            res += node.toString()
        }
        res
    }

    protected func flatter(): Array<SyntaxNodeImpl>
}

// NonTerminal: Non-Leaf node
class NonTerminal <: SyntaxNodeImpl {
    let children: Array<SyntaxNodeImpl>

    init(kind: SyntaxNodeKind, children: Array<SyntaxNodeImpl>, preWhiteSpace!: Array<SyntaxNodeImpl> = []) {
        super(kind, preWhiteSpace)
        this.children = children
    }

    protected func toString(): String {
        let stack = ArrayStack<SyntaxNodeImpl>()
        stack.add(this)
        let sb = StringBuilder()
        while (let Some(node) <- stack.remove()) {
            match (node) {
                case nt: NonTerminal =>
                    let size = nt.children.size
                    for (i in (size - 1)..=0 : -1) {
                        stack.add(nt.children[i])
                    }
                case t: Terminal => sb.append(t.toString())
                case _ => "Unknown"
            }
        }
        sb.toString()
    }

    protected func getOffset(): Offset {
        let offset = Offset()
        for (child in children) {
            offset.moveNode(child)
        }
        return offset
    }

    protected func flatter(): Array<SyntaxNodeImpl> {
        match (kind) {
            // Handle NonTerminal node that converts to a single Token
            case SyntaxNodeKind.RuneLiteral | SyntaxNodeKind.LineStringLiteral | SyntaxNodeKind.MultiLineStringLiteral
                | SyntaxNodeKind.MultiLineRawStringLiteral => return [this]
            case _ => ()
        }
        let res = ArrayList<SyntaxNodeImpl>()
        for (child in children) {
            res.add(all: child.flatter())
        }
        return res.toArray()
    }
}

// Terminal: Leaf node
open class Terminal <: SyntaxNodeImpl {
    init(kind: SyntaxNodeKind, preWhiteSpace!: Array<SyntaxNodeImpl> = []) {
        super(kind, preWhiteSpace)
    }

    protected open func toString(): String {
        kind.toString()
    }

    protected open func getOffset(): Offset {
        return Offset(0, Int32(toString().size))
    }

    protected open func flatter(): Array<SyntaxNodeImpl> {
        [this]
    }
}

@When[os != "Windows"]
const NEWLINE = "\n"
@When[os == "Windows"]
const NEWLINE = "\r\n"
@When[os != "Windows"]
const SEPARATOR = "/"
@When[os == "Windows"]
const SEPARATOR = "\\"

// Including space, newline, tab, # token with repeat times
class RepeatedTerminal <: Terminal {
    let repeat: Int64

    init(kind: SyntaxNodeKind, repeat: Int64) {
        super(kind)
        this.repeat = repeat
    }

    protected func toString(): String {
        match (this.kind) {
            case SyntaxNodeKind.SpaceToken => " " * repeat
            case SyntaxNodeKind.NewlineToken => NEWLINE * repeat
            case SyntaxNodeKind.HashToken => "#" * repeat
            case _ => ""
        }
    }

    protected func getOffset(): Offset {
        match (this.kind) {
            case SyntaxNodeKind.NewlineToken => return Offset(Int32(repeat), 1)
            case _ => return Offset(0, Int32(repeat))
        }
    }
}

class ValuedTerminal <: Terminal {
    let value: String

    init(kind: SyntaxNodeKind, value: String, preWhiteSpace!: Array<SyntaxNodeImpl> = []) {
        super(kind, preWhiteSpace: preWhiteSpace)
        this.value = value
    }

    protected func toString(): String {
        value
    }

    protected func getOffset(): Offset {
        var offset = Offset()
        var strSplit = value.replace("\r\n", "\n").split("\n")
        if (strSplit.size > 1) {
            offset.line += Int32(strSplit.size) - 1
            offset.column = Int32(strSplit[strSplit.size - 1].toRuneArray().size + 1)
        } else {
            offset.column += Int32(value.toRuneArray().size)
        }
        return offset
    }
}

class TokenTerminal <: Terminal {
    let tokenKind: TokenKind
    let value: String
    let hasEscape: Bool

    init(tokenKind: TokenKind, value: String, hasEscape!: Bool = false) {
        super(SyntaxNodeKind.Token)
        this.tokenKind = tokenKind
        this.value = value
        this.hasEscape = hasEscape
    }

    protected func toString(): String {
        if (hasEscape) {
            "\\" + value
        } else {
            value
        }
    }
}

// Optimization Points only create one Terminal when create same class
// The builder of SyntaxNodeImpl node
/**
 * The builder of SyntaxNodeImpl node.
 *
 * Optimization Points:
 *     1. Cache some terminals
 */
class SyntaxNodeBuilder {
    private static let invalid = Terminal(SyntaxNodeKind.Invalid)

    func buildBasicTerminal(kind: SyntaxNodeKind): Terminal {
        Terminal(kind)
    }

    func buildInvalidTerminal(): Terminal {
        SyntaxNodeBuilder.invalid
    }

    func buildNewline(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.NewlineToken, repeat)
    }

    func buildSpace(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.SpaceToken, repeat)
    }

    func buildHash(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.HashToken, repeat)
    }

    func buildValuedTerminal(kind: SyntaxNodeKind, value: String, preChildren!: Array<SyntaxNodeImpl> = []): ValuedTerminal {
        ValuedTerminal(kind, value, preWhiteSpace: preChildren)
    }

    func buildTokenTerminal(kind: TokenKind, value: String, hasEscape!: Bool = false): TokenTerminal {
        TokenTerminal(kind, value, hasEscape: hasEscape)
    }

    func buildNonTerminal(kind: SyntaxNodeKind, children: Array<SyntaxNodeImpl>,
        preChildren!: Array<SyntaxNodeImpl> = []): NonTerminal {
        NonTerminal(kind, children, preWhiteSpace: preChildren)
    }

    func buildQuote(isSingle: Bool): Terminal {
        if (isSingle) {
            buildBasicTerminal(SyntaxNodeKind.SingleQuoteToken)
        } else {
            buildBasicTerminal(SyntaxNodeKind.DoubleQuoteToken)
        }
    }

    func buildTripleQuote(isSingle: Bool): Terminal {
        if (isSingle) {
            buildBasicTerminal(SyntaxNodeKind.TripleSingleQuoteToken)
        } else {
            buildBasicTerminal(SyntaxNodeKind.TripleDoubleQuoteToken)
        }
    }
}
