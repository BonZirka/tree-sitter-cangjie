/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

interface A {
    open func f1() {
        return 1
    }
    open func f2(): Int64
    static func g1() {
        return 1
    }
    static func g2(): Int64
    mut open prop a1: Int64 {
        get() {
            1
        }
        set(v) {
            v
        }
    }
    mut open prop a2: Int64
    mut static prop b1: Int64 {
        get() {
            1
        }
        set(v) {
            v
        }
    }
    mut static prop b2: Int64
}

interface B <: A {
    func f1() {
        return 0
    }
    func f2(): Int64
    static func g1() {
        return 0
    }
    static func g2(): Int64
    mut prop a1: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
    mut prop a2: Int64
    mut static prop b1: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
    mut static prop b2: Int64
}

class C <: B {
    public func f2(): Int64 {
        return 0
    }
    public static func g2(): Int64 {
        return 0
    }
    public mut prop a2: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
    public mut static prop b2: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
}

main() {
    var a = C()
    return a.f1() + C.g1() + a.f2() + C.g2() + a.a1 + a.a2 + C.b1 + C.b2
}
