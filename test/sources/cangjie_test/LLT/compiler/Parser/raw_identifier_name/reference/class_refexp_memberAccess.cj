// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

open class `Class1`{
    var var1 = 10;
    public `Class1`(a: Int64) {
        this.var1 = a // this
    }
    func `cc`(){
        println("cc")
    }
    func dd(){
        println(var1) // this
    }
}

class `Class2` <: `Class1`{
    public init(a: Int64) {
        super(a) // super
    }
    func ee(){
        super.dd() // super
    }
}

main() {
    let class1 = Class1(10)
    let class1_1 = `Class1`(10)
    class1.cc()
    `class1`.cc()
    class1.`cc`()
    `class1`.`cc`()

    class1.dd()
    class1_1.dd()
    let class2 = Class2(30)
    class2.dd()
    class2.ee()
    return 0
}

/* SCAN
cc
cc
cc
cc
10
10
30
30
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
