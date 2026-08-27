// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

class Base12  {
    public var d: Int64 = 1
     public prop a: Int64  {
             get(){
                return this.d
            }
    }
 }
main() {
    var x  = Base12()
    x.d = 4
    print("${x.d}")
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
