/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 3.2.1.13.2.22
  @Scene: modify
  @Visibility: used in public @Frozen declare
  @Object: struct primary init
  @Behavior: modify function parameter type:sub type -> non parent type
  @Expect: api incompatible & abi incompatible
*/
// LEVEL: 1
// DEPENDENCE: main.cj, template.cj
// EXEC: %compiler %cmp_opt %compile_dylib_opt template.cj -o libstable_abi.%dylib_suffix
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// EXEC: %rm libstable_abi.*
// EXEC: %mv test_stable_abi.cjo old.cjo
// EXEC: %compiler %cmp_opt %compile_dylib_opt %f -o libstable_abi.%dylib_suffix

// TEST CJCPL
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare %f
// ASSERT: scan Incompatible!
// ASSERT: scan-2 [API/ABI] Changed parameter type of function visible outside the module. The new param type is not a parent type of the old param type.
// ASSERT: scan-1 [ABI] The body of a const function or function marked with @Frozen changed.
// ASSERT: scan-not [API]

//the primary init used in public const declare
package test_stable_abi
public open class B{
    public const init(){}
}
public class A <: B{
    public init(){}
    public const init(a:Int64){
        B()
        const x = "a"
    }
}
public class C{
    public const init(c1:Float64){}
}

public struct S1_public{
    public var a = 1
    public let width = 10
    public init(){}

    public S1_public(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }

    public func getWidth(): Int64 {
        return width
    }
}

public struct S1_frozen{
    public var a = 1

    S1_frozen(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
    @Frozen
    public func foo(){
        let x = S1_frozen(1, A(), 3, a4:4, a5:A(), a6:1)
    }
}

public struct S1_const{
    public var a = 1

    const S1_const(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }

    public const func foo(){
        const x = S1_const(1, A(1), 3, a4:4, a5:A(1), a6:1)
    }
}

public struct S1_notpublic{
    public var a = 1

    S1_notpublic(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
}

struct S2_public{
    public var a = 1
    public init(){}
    public S2_public(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 

struct S2_frozen{
    public var a = 1
    public init(){}
    S2_frozen(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S2_frozen(){
    let x = S2_frozen(1, A(), 3, a4:4, a5:A(), a6:1)
}

struct S2_const{
    public var a = 1
    public init(){}
    const S2_const(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
public const func foo_S2_const_struct(){
    let x = S2_const(1, A(1), 3, a4:4, a5:A(1), a6:1)
}

struct S2_notpublic{
    public var a = 1
    public init(){}
    S2_notpublic(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
public struct S2_struct{
    let x1:S2_public = S2_public()
    let x2:S2_frozen = S2_frozen()
    let x3:S2_const = S2_const()
    let x4:S2_notpublic = S2_notpublic()
}
public class S2_class{
    let x1:S2_public = S2_public()
    let x2:S2_frozen = S2_frozen()
    let x3:S2_const = S2_const()
    let x4:S2_notpublic = S2_notpublic()
}

struct S3_public{
    public var a = 1
    public const init(){}
    public S3_public(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 

struct S3_frozen{
    public var a = 1
    public const init(){}
    S3_frozen(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S3_frozen(){
    let x = S3_frozen(1, A(), 3, a4:4, a5:A(), a6:1)
}

struct S3_const{
    public var a = 1
    public const init(){}
    const S3_const(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
public const func foo_S3_const_struct(){
    let x = S3_const(1, A(1), 3, a4:4, a5:A(1), a6:1)
}

struct S3_notpublic{
    public var a = 1
    public const init(){}
    S3_notpublic(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
public const func foo_S3(){
    const x1 = S3_public()
    const x2 = S3_frozen()
    const x3 = S3_const()
    const x4 = S3_notpublic()
}

struct S4_public{
    public var a = 1
    public init(){}
    public S4_public(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 

struct S4_frozen{
    public var a = 1
    public init(){}
    S4_frozen(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S4_frozen(){
    let x = S4_frozen(1, A(), 3, a4:4, a5:A(), a6:1)
}

struct S4_const{
    public var a = 1
    public init(){}
    const S4_const(a1: Int64, a2:C, a3:Int64, a4!: Int64, a5!:C, a6!:Int64) {
        a = a1
    }
} 
public const func foo_S4_const_struct(){
    let x = S4_const(1, C(1.0), 3, a4:4, a5:C(1.0), a6:1)
}

struct S4_notpublic{
    public var a = 1
    public init(){}
    S4_notpublic(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 
@Frozen
public func foo_S4(){
    let x1 = S4_public()
    let x2 = S4_frozen()
    let x3 = S4_const()
    let x4 = S4_notpublic()
}

struct S5{
    public var a = 1
    public S5(a1: Int64, a2:A, a3:Int64, a4!: Int64, a5!:A, a6!:Int64) {
        a = a1
    }
} 