/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %use_ast %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_args

import std.ast.*

var input: Tokens = quote(import org_1::{a1, a.b1.*, a.c1 as c2})

@Test
class Test_01 {
    @TestCase[importList in [ 
 parseProgram(input).importLists [ 0 ], 
 ImportList(input) 
 ] 
]
    func test_importList(importList: ImportList) {
        @Assert(importList.modifier.value, "")
        @Assert(importList.keywordI.value, "import")
        @Assert(importList.isImportMulti(), true)
        @Assert(importList.content.toTokens().toString(), "org_1 :: { a1, a.b1.*, a.c1 as c2 }")
        match (importList.content.importKind) {
            case ImportKind.Multi => ()
            case _ => @Assert(false)
        }
        @Expect(importList.content.prefixPaths.toString(), "")
        @Assert(importList.content.prefixDots.toString(), "")
        @Assert(importList.content.identifier.value, "")
        @Assert(importList.content.importAlias.toString(), "")
        @Assert(importList.content.lBrace.value, "{")
        @Assert(importList.content.rBrace.value, "}")
        @Assert(importList.content.items.size, 3)
        @Assert(importList.content.items[0].toTokens().toString(), "a1")
        @Assert(importList.content.items[1].toTokens().toString(), "a.b1.*")
        @Assert(importList.content.items[2].toTokens().toString(), "a.c1 as c2")
        @Assert(importList.content.commas.toString(), ",,")
        @Assert(importList.content.isImportAlias(), false)
        @Assert(importList.content.isImportAll(), false)
        @Assert(importList.content.isImportMulti(), true)
        @Assert(importList.content.isImportSingle(), false)
        @Assert(importList.content.orgName.value, "org_1")
        @Assert(importList.content.orgSeparator.value, "::")
    }
}
