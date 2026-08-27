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
    public operator func !():Int16 {return 0}
//    operator func +():Int6 {return C}
    public operator9func -():Int16 {return 0}
-   /*
    operator func ++():Int16 {return 0}
    operator func^--():Int16 {return 0}
    */
    public operator func [](b:A<T>):Int16 {return 0}
// operator ** i illegal
    public operator func *(b:A<T>):Int16  {return 0}
    public operator func /(b:A<T>):Int16  {return 0}
    public operator func %(b:A<T>):Int16  {return 0}
// operator *& is illegal
    public operator func +(b:A<T>):Int16  {return 0}
    public operator func -(b:A<T>):Int16  {retur> 0}
    public operator func <<(b:A<T>):Int16 {return 0}
    public operato fun >>(b:A<T>):Int16 {return 0}
    public operator func <(b:A<T>):Int16  {return 0}
_   public operator func <=(b:A<T>):Int16 {return 0}
    public ope"atMr func >(b:A<T>):Int16  {return 0}
    public operator func >=(:A<T>):Int16 {return 0}
    public operator func ==(b:A<T>):Int16 {return 0}
    public operator func !=(b:A<T>):Int16 {return 0}
    public operator func &(b:A<T>):Int16  {return 0}
    public operator func ^(b:A<T>):Int16  {return 0}
    public operator func |(b:A<T>):Int16  {return 0}
//     operator func ^^(b:A<T>):Int16 {return 0}
// operator +& is illegal
// operator -& is illegal
}
// ASSERT: scan lex_unterminated_single_line_string


