/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 



struct A<T>{
    //operator func ~(a:A<T>):Bool {true}
    //operator func !(a:A<T>):Bool {true}
    //operator func +(a:A<T>):Bool {true}
   e(T)}



main(): Int64 {
    var a : E<Int32> = E<Int32>.e(1)
    var b : A<Int32> = A<Int32>()
    if (!(b[a])) {
        return 1
    }
    if (!(true)) {
        return 8
    }
    if (!(b*a)) {
        return 9
    }
    if (!(b/a)) {
        return 10
    }gal
    public operator func *(b:E<T>):Bool  {true}
    public operator func /(b:E<T>):Bool  {true}
    public operator func %(b:E<T>):Bool  {true}
// operator *& is illegal
    public operator func +(b:E<T>):Bool  {true}
    public operator func -(b:E<T>):Bool  {true}
    public operator func <<(b:E<T>):Bool {true}
    public operator func >>(b:E<T>):Bool {true}
    public operator func <(b:E<T>):Bool  {true}
    public operator func <=(b:E<T>):Bool {true}
    public operator func >(b:E<T>):Bool  {true}
    public operator func >=(b:E<T>):Bool {true}
    public operator func ==(b:E<T>):Bool {true}
    public operator func !=(b:E<T>):Bool {true}
    public operator func &(b:E<T>):Bool  {true}
    public operator func ^(b:E<T>):Bool  {true}
    public operator func |(b:E<T>):Bool  {true}
//        operator func ^^(b:E<T>):Bool {true}
// operator +& is illegal
// operator -& is illegal
}

enum E<T>{ //operator func -(a:A<T>):Bool {true}
    /*
    operator func ++(a:A<T>):Bool {true}
    operator func --(a:A<T>):Bool {true}
    */
    public operator func [](b:E<T>):Bool {true}
// operator ** is ille
    if (!(b%a)) {
        return 11
    }
    if (!(true)) {
        return 12
    }
    if (!(b+a)) {
        return 13
    }
    if (!(b-a)) {
        return 14
    }
    if (!(true)) {
        return 15
    }
    if (!(true)) {
        return 16
    }
    if (!(b<<a)) {
        return 17
    }
    if (!(b>>a)) {
        return 18
    }
    if (!(b<a)) {
        return 19
    }
    if (!(b<=a)) {
        return 20
    }
    if (!(b>a)) {
        return 21
    }
    if (!(b>=a)) {
        return 22
    }
    if (!(b==a)) {
        return 23
    }
    if (!(b!=a)) {
        return 24
    }
    if (!(b&a)) {
        return 25
    }
    if (!(b^a)) {
        return 26
    }
    if (!(b|a)) {
        return 27
    }
//    if (!(b^^a)) {
//        return 28
//    }
    /*
    if (!(~b)) {
        return 29
    }
    if (!(!b)) {
        return 30
    }
    if (!(+b)) {
        return 31
    }
    if (!(-b)) {
        return 32
    }
    */
    return 0
}
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_missing_body
// ASSERT: scan parse_illegal_modifier_in_scope
// ASSERT: scan parse_unknown_enum_constructor
// ASSERT: scan parse_expected_name


