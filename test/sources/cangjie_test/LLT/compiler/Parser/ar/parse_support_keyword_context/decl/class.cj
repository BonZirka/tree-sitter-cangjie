// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

 open class public {
    public var abstract : Int64 = 0
    public var redef : Int64 = 0
    public init() {}
    public public(public : Int64, private !: Int64) {
        abstract = public
        redef = private
    }
    static func open(): Int64 {
        return 1
    }
}

class A <: public {}

main() {
    var a = public(1, private:1)
    var b = a.redef
    var abstract = 1
    print("${abstract}")
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
