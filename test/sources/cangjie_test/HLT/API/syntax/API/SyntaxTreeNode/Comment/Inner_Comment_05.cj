/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@!Anno1["aaaaaa"]
// line comment1
enum E1<T, R> where T <: ToString // line comment2
{
    | A1 // line comment3
    | B1(T, R) /*
    block comment
    */
    | C1(R) /** document comment */
    | ... // line comment4
    func foo() {}
} // line comment5