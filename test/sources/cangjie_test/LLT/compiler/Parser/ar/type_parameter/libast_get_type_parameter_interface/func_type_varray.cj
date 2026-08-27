// (CJNATIVE) EXEC: %compiler %cmp_opt %f -o %output
// (CJNATIVE) RUN-EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main():Int64{
    let tks = quote(let a : (t1: VArray<Int64, \$2>)->Int64)
    let varDecl:VarDecl = (parseDecl(tks) as VarDecl).getOrThrow()
    let typeNode = varDecl.declType
    let tupleType = (typeNode as FuncType).getOrThrow()
    let fieldTypes = tupleType.types
    let subType0 = (fieldTypes[0] as VArrayType).getOrThrow().typeParameterName
    if (subType0.value != "t1" || subType0.pos.column != 30) {
        return 1
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
