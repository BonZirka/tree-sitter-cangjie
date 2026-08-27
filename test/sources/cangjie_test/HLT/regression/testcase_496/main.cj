/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import std.ast.*
main(): Int64{
    var tks = Tokens()
    tks = Token(TokenKind.IDENTIFIER, "foo") + Token(TokenKind.END) + Token(TokenKind.IDENTIFIER, "bar")
    var itr = tks.iterator()
    while(true) {
        match (itr.next()) {
            case None => break
            case Some(obj) => obj.dump()
            case _ => break
        }
    }
    return 0
}


