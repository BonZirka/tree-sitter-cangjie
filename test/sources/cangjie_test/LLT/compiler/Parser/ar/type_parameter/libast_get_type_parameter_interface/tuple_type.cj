// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main():Int64{
    let tks = quote(let a : (t1: abc,  t2: Int64, t3: (Int64), t4: a.b, t5: ?Int64, t6: (Float32, Float64), t7: (Int64, Int64)->Int32))
    let varDecl:VarDecl =  (parseDecl(tks) as VarDecl).getOrThrow()
    let typeNode = varDecl.declType
    let tupleType = (typeNode as TupleType).getOrThrow()
    let fieldTypes = tupleType.types
    let subType0 = (fieldTypes[0] as RefType).getOrThrow().typeParameterName
    if (subType0.value != "t1" || subType0.pos.column != 30) {
        return 1
    }
    let subType1 = (fieldTypes[1] as PrimitiveType).getOrThrow().typeParameterName
    if (subType1.value != "t2" || subType1.pos.column != 40) {
        return 1
    }
    let subType2 = (fieldTypes[2] as ParenType).getOrThrow().typeParameterName
    if (subType2.value != "t3" || subType2.pos.column != 51) {
        return 1
    }
    let subType3 = (fieldTypes[3] as QualifiedType).getOrThrow().typeParameterName
    if (subType3.value != "t4" || subType3.pos.column != 64) {
        return 1
    }
    let subType4 = (fieldTypes[4] as PrefixType).getOrThrow().typeParameterName
    if (subType4.value != "t5" || subType4.pos.column != 73) {
        return 1
    }
    let subType5 = (fieldTypes[5] as TupleType).getOrThrow().typeParameterName
    if (subType5.value != "t6" || subType5.pos.column != 85) {
        return 1
    }
    let subType6 = (fieldTypes[6] as FuncType).getOrThrow().typeParameterName
    if (subType6.value != "t7" || subType6.pos.column != 109) {
        return 1
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
