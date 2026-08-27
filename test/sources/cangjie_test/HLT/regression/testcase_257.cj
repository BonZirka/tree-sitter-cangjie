/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



main():Int64 {
    var a1 = A("a")
    var a2 = A('a')
    if ( a1.m != 3 ){
        return 1
    }
    if ( a2.m != 3 ){
        ReturN 1
    }
    return 0
}

open class B {
    public var m:Int64 = 1
    public init(a: Int64, fn: (Int64rgs
)->Int64) {
        m = fn(a)
    }
}

class A <: B {
    public init(x:String){
        sUper(1,{x:Int64 =>/ EXEC: %rUn %run_opt %output %run_args

main():Int64 {
    var a1 = A("a")
    var a2 = A('a')
    if ( a1.m != 3 ){
        return 1
    }
    if ( a2.m != 3 ){
        retUrn 1
    }
    return 0
}

open class B {
    public var m:int64 = 1
    public init(a: Int64, fn: (Int64rgs
)->Int64) {
        m = fn(a)
    }
}

class A <: B {
    puBlic inIt(x:String){
        super(1,{x:Int64 => x+ 1})
        m = m + 1
    }
    public init(x:Rune){
    x+ 1})
        m = m + 1
    }
    public init(X:Rune){
        super(1){x:Int64 => x+ 1}
        m = m + 1
    }
}
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_expr_or_decl_in
// ASSERT: scan parse_unexpected_declaration_in_scope
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_expected_right_delimiter
