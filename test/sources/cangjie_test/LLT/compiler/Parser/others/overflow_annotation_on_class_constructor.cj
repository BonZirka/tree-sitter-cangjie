// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.math.*
class MyObject{
    @OverflowWrapping
    MyObject(){
        let a: Int8 = Int8.Max + 1
    }
}

main():Unit{
    let a = MyObject()
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
