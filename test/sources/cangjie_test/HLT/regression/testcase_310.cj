/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


open class A{}
class B <: A{}

func f(a: Int32) : A{return A()}
func f(a: Int64) : B{return B()}

main():Int64{
    let a : A = f(1)
    let b : B = f(1)
    let c = f(1)
    var res = match (c) {
        case _ : B => true
        case _ => false
    }
    @f (res) {
        return 0
    }
    return 1
}
// ASSERT: scan macro_undeclared_identifier


