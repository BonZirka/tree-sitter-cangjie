/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// ASSERT: scan Compatible!\n
package test_stable_abi

public struct S1{
    public var a = 1
    public S1(a1: Int64) {
        a = a1
    }
}

public struct S1_public{
    public var a = 1
    public S1_public(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
}

public struct S1_frozen{
    public var a = 1
    S1_frozen(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = 1
    }
    @Frozen
    public func foo(){
        let x = S1_frozen(1, a2:2, a3:3, a4:4, a5:5, a6:1)
    }
}

public struct S1_const{
    public var a = 1
    const S1_const(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }

    public const func foo(){
        const x = S1_const(1, a2:2, a3:3, a4:4, a5:5, a6:1)
    }
}

public struct S1_notpublic{
    public var a = 1
    S1_notpublic(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
}

struct S2_public{
    public var a = 1
    public S2_public(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

struct S2_frozen{
    public var a = 1
    S2_frozen(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S2_frozen(){
    let x = S2_frozen(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S2_const{
    public var a = 1
    const S2_const(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
public const func foo_S2_const_struct(){
    let x = S2_const(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S2_notpublic{
    public var a = 1
    S2_notpublic(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
public struct S2_struct{
    S2_struct(let x1:S2_public, let x2:S2_frozen, let x3:S2_const, let x4:S2_notpublic){}
}
public class S2_class{
    S2_class(let x1:S2_public, let x2:S2_frozen, let x3:S2_const, let x4:S2_notpublic){}
}

struct S3_public{
    public var a = 1
    public static const b = 1
    public const S3_public(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

struct S3_frozen{
    public var a = 1
    public static const b = 1
    const S3_frozen(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S3_frozen(){
    const x = S3_frozen(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S3_const{
    public var a = 1
    public static const b = 1
    const S3_const(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

struct S3_notpublic{
    public var a = 1
    public static const b = 1
    const S3_notpublic(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

public const func foo_S3(x1!:Int64 = S3_public.b, x2!:Int64 = S3_frozen.b, x3!:Int64 = S3_const.b, x4!:Int64 = S3_notpublic.b){
    const x = S3_const(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S4_public{
    public var a = 1
    public static const b = 1
    public S4_public(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

struct S4_frozen{
    public var a = 1
    public static const b = 1
    S4_frozen(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

struct S4_const{
    public var a = 1
    public static const b = 1
    const S4_const(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
public const func foo_S4_const_struct(){
    let x = S4_const(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S4_notpublic{
    public var a = 1
    public static const b = 1
    S4_notpublic(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S4(x1!:Int64 = S4_public.b, x2!:Int64 = S4_frozen.b, x3!:Int64 = S4_const.b, x4!:Int64 = S4_notpublic.b){
    let x = S4_frozen(1, a2:2, a3:3, a4:4, a5:5, a6:1)
}

struct S5{
    public var a = 1
    public S5(a1: Int64, let a2!:Int64, let a3!:Int64, public let a4!:Int64, public let a5!:Int64, public let a6!:Int64) {
        a = a1
    }
} 

