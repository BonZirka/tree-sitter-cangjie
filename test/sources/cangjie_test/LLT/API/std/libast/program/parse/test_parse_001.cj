// DEPENDENCE: ./test_parse_dump_005_dep.cj
// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*
internal import std.fs.*
internal import std.io.*

main() {
    let path: String = "./test_parse_dump_005_dep.cj"
    let file: File = File(path, Read)
    let reader: StringReader<File> = StringReader(file)
    let code: String = reader.readToEnd()

    let tokens: Tokens = cangjieLex(code)
    let program = parseProgram(tokens)
    var pkgHeader = program.packageHeader
    var key1 = pkgHeader.keywordM
    var key2 = pkgHeader.keywordP
    var packageIdentifier = pkgHeader.packageIdentifier
    if (key2.value != "package") {
        return 1
    }
    if (packageIdentifier.value != "p") {
        return 2
    }
    packageIdentifier = Token(TokenKind.IDENTIFIER, "change")
    if (packageIdentifier.value != "change") {
        return 3
    }
    var importLists = program.importLists
    if (importLists.size != 1) {
        return 4
    }

    var decls = program.decls
    if (decls.size != 3) {
        return 5
    }
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
