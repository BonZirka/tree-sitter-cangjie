/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f




class A<T>{
    public operator func !():String {return "a"}
    public operator func -():String <T>):String {return "a"}
    public operator func <(b:A<T>):String  {return "a"}
    public operator func <=(b:A<T>):String {return "a"}
    operator fu{return "a"}

    public operator func [](b:A<T>):String {return "a"}

    public operator func *(b:A<T>):String  {return "a"}
    public operator func /(b:A<T>):String  {return "a"}
    public operator func %(b:A<T>):String  {return "a"}

    public operator func +(b:A<T>):String  {return "a"}
    public operator func -(b:A<T>):String  {return "a"}
    public operator func <<(b:A<T>):String {return "a"}
    public operator func >>(b:A<T>):String {return "a"}
    public operator func <(b:A<T>):String  {return "a"}
    public operator func <=(b:A<T>):String {return "a"}
    public operator func >(b:A<T>):String  {return "a"}
    public operator func >=(b:A<T>):String {return "a"}
    public operator func ==(b:A<T>):String {return "a"}
    public operator func !=(b:A<T>):String {return "a"}
    public operator func &(b:A<T>):String  {return "a"}
    public operator func ^(b:A<T>):String  {return "a"}
    public operator func |(b:A<T>):String  {return "a"}

}

main(): Int64 {
    var a : A<String> = A<String>()
    var b : A<String> = A<String>()
    var result : (String)[] = @{b[a],b*a,b/a,b%a,b+a,b-a,b<<a,b>>a,b<a,b<=a,
    b>a,b>=a,b==a,b!=a,b&a,b^a,b|a,!b,!b,-b}
    return 0
}
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_decl
