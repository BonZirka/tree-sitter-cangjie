// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

interface invokeinterface00101m1i {
    func f3(): Int32
}

class invokeinterface00101m1c <: invokeinterface00101m1i {
    public func f3(): Int32 {
        return 3
    }
}

class invokeinterface00101m1 {
    public static var ret_flag: Int32 = 0
    public static func proc1(): Unit {
        var inf: invokeinterface00101m1i = invokeinterface00101m1c()
        if (inf.f3() != 3) {
            ret_flag = 2
        }
    }
    public static func run(): Int32 {
        proc1()
        return ret_flag
    }
}

main(): Int64 {
    if (invokeinterface00101m1.run() == 0) {
        return 0
    }
    return 1
}
