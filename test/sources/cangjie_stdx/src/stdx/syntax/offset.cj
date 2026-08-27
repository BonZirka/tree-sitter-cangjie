/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

class Offset {
    var line: Int32 = 0
    var column: Int32 = 0
    init() {}
    init(line: Int32, column: Int32) {
        this.line = line
        this.column = column
    }
    func move(aa: Option<Offset>) {
        if (let Some(a) <- aa) {
            if (a.line > 0) {
                this.line = this.line + a.line
                this.column = a.column
            } else {
                this.column = this.column + a.column
            }
        } else {
            throw Exception("expect offset, found none")
        }
    }
    func moveString(str: String) {
        let strSplit = str.replace("\r\n", "\n").split("\n")
        if (strSplit.size > 1) {
            this.line += Int32(strSplit.size) - 1
            this.column = Int32(strSplit[strSplit.size - 1].toRuneArray().size + 1)
        } else {
            this.column += Int32(str.toRuneArray().size)
        }
    }
    func moveNode(node: ?SyntaxNodeImpl) {
        if (let Some(v) <- node) {
            match (v) {
                case vt: ValuedTerminal => moveString(vt.value)
                case rt: RepeatedTerminal => match (rt.kind) {
                    case SyntaxNodeKind.SpaceToken | SyntaxNodeKind.HashToken => this.column += Int32(rt.repeat)
                    case SyntaxNodeKind.NewlineToken =>
                        this.line += Int32(rt.repeat)
                        this.column = 1
                    case _ => throw Exception("moveNode failed!")
                }
                case t: Terminal => moveString(t.toString())
                case nt: NonTerminal => move(nt.offset)
                case _ => throw Exception("moveNode for Offset failed!")
            }
        }
    }
}
