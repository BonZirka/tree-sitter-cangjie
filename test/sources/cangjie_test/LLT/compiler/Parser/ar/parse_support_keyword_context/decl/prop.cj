// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main(): Int64 {
    A<Int64>().public
    return 0
}
class A<T> {
}


extend A<Int64> {
    public prop public:Int64{
        get(){
            return 1
        }
    }
    public prop private:Int64{
        get(){
            return 1
        }
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
