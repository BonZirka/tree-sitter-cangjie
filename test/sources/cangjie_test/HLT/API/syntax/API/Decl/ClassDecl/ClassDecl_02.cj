/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

public class CangjieInvoke <: JObject {
    public let a1 :Any = 1
    public var a2 = 2

    internal let b1 = 1
    internal var b2 = 2

    protected let c1 = 1
    protected var c2 = 2

    private let d1 = 1
    private var d2 = 2

    let e1 = 1
    var e2 = 2

    @Version[1] public let af1 = 1
    @Version[2] public var af2 = 2

    @Deprecated["This variable will be deprecated soon"] public let g1 = 1
    @Deprecated["This variable is deprecated", strict: true] public let g2 = 2

    let h1 = 1
    @Frozen
    public func h2() {
        h1
    }

    let x1 = 1
    private var x2 = 2

    public var a: Int64 = 0
    public prop prop1: Int64 {
        get() {
            1
        }
    }

    protected prop exported_prop1: Int64 {
        get() {
            1
        }
    }
    prop prop2: Int64 {
        get() {
            2
        }
    }

    prop prop3: Int64 {
        get() {
            3
        }
    }
    @Frozen
    public prop _prop3: Int64 {
        get () {
            prop3
        }
    }

    @Deprecated["This API will be deprecated soon"]
    public prop prop4: Int64 {
        get() {
            4
        }
    }
    @Deprecated["This API is deprecated", strict: true]
    public prop prop5: Int64 {
        get() {
            5
        }
    }
    @Frozen
    public mut prop prop6: Int64 {
        get() {
            6
        }
        set(v) {
            a = v
        }
    }

    protected prop prop7: Int64 {
        get() {
            7
        }
    }
    internal prop prop8: Int64 {
        get() {
            8
        }
    }
    private prop prop9: Int64 {
        get() {
            9
        }
    }

    public mut prop prop10: Int64 {
        get() {
            10
        }
        set(v) {
        }
    }
    public mut prop prop11: Int64 {
        get() {
            11
        }
        set(v) {
            a = v
        }
    }

    open public prop prop13: Int64 {
        get() {
            13
        }
    }

    open public mut prop prop14: Int64 {
        get() {
            14
        }
        set(v) {
            a = v
        }
    }

    public CangjieInvoke() {}

    public func f1(a!: Int64 = 1): Int64 {
        let class_01 = Init01()
        1
    }
    protected func f2(): This {
        return this
    }

    private  func f3(): Int64 {
        return 3
    }
    public  func f4(): Int64 {
        f3()
    }
    internal  func pf3(): Int64 {
        return 3
    }
    protected  func pf4(): Int64 {
        pf3()
    }

    func f5(): Int64 {
        return 5
    }
    @Frozen
    public func f6(): Int64 {
        f5()
    }
    func pf5(): Int64 {
        return 5
    }
    @Frozen
    protected func pf6(): Int64 {
        pf5()
    }

    internal func f7(): Int64 {
        return 7
    }

    @Deprecated["This API will be deprecated soon"]
    public func f8(): Int64 {
        8
    }
    @Deprecated["This API is deprecated", strict: true]
    public func f9(): Int64 {
        9
    }
    @Deprecated["This API will be deprecated soon"]
    protected func pf8(): Int64 {
        8
    }
    @Deprecated["This API is deprecated", strict: true]
    protected func pf9(): Int64 {
        9
    }

    func f10(): Int64 {
        10
    }
    internal func f11(): Int64 {
        11
    }
    private func f12(): Int64 {
        12
    }

    public unsafe func f13(): Int64 {
        return 13
    }
}
