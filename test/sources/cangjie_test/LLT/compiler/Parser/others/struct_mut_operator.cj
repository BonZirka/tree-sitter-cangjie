// EXEC: %compiler %cmp_opt %n.cj

struct MyStruct {
    var x: Int64 = 0
    public init (a: Int64){
        x = a
    }
    mut public operator func -(): MyStruct {
        MyStruct(-x)
    }
}

main():Unit{

}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
