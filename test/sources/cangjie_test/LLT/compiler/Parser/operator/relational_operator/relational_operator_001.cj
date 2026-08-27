// EXEC: %compiler %cmp_opt %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix %run_args

let var22 : Class6 = Class6();
let var42 : Int32 = Int32(63);
class Class6 {
    public let var32 : Int32 = Int32(12);
}
main():Int64 {
    let a:Int32 = 2
    var22.var32 < ({=>a}())
    return 0;
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
