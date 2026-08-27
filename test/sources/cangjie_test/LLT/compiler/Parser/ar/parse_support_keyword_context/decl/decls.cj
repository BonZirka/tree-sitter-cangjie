
// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

class public {
    var redef: Int64 = 0
    public mut prop private: Int64 {
        get() {
            return redef
        }
        set(value) {
            redef = value
        }
    }
}

interface protected{}

func private() {
    
}

public enum abstract{
            Year
            | Month
        }


struct override {
    var count =  0
    var res = ""
    init(res: String, count: Int64) {
        this.res = res
        this.count = count
    }
}

func f2(a: Int64, public: Array<Int64>) {}

main() {
    let open = [1, 2, 3]
    f2(1, open)
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
