/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 3.2.1.6.2.18
  @Scene: modify
  @Visibility: non public
  @Object: struct static var
  @Behavior: modify static var type
  @Expect: api compatible & abi compatible
*/
// LEVEL: 1
// DEPENDENCE: main.cj, template.cj
// EXEC: %compiler %cmp_opt %compile_dylib_opt template.cj -o libstable_abi.%dylib_suffix
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// EXEC: %rm libstable_abi.%dylib_suffix
// EXEC: %mv test_stable_abi.cjo old.cjo
// EXEC: %compiler %cmp_opt %compile_dylib_opt %f -o libstable_abi.%dylib_suffix

// TEST CJCPL
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare template.cj
// TEST ABI Compatibility
// RUN-EXEC: %run %run_opt %output %run_args
// TEST API Compatibility
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args

// test struct: modify type
// B是A的子类型，且A和B均为class或interface类型
package test_stable_abi


public interface I {
    func f(): Int64
}

public interface Addable <: I {
    func add(other: Int64): Int64
}

public open class Subtractable <: Addable {

    public open func add(other: Int64): Int64 {
        return 0
    }

    public open func sub(other: Int64): Int64 {
        return 0
    }

    public open func f(): Int64 {
        return 0
    }

    const init() {}
}

public struct Multiplicable <: Addable {

    public func add(other: Int64): Int64 {
        return 0
    }

    public func sub(other: Int64): Int64 {
        return 0
    }

    public func mul(other: Int64): Int64 {
        return 0
    }

    public func f(): Int64 {
        return 0
    }
    
    const init() {}
}

struct S1 {
    public static let a1 : Addable = Subtractable()

    static const a2 : Addable = Subtractable()
    public static const func f2(){
        a2
    }
    
    static let a3 : Addable = Subtractable()
    @Frozen
    public static func f3(){
        a3
    }
    
    static let a4 : Subtractable = Subtractable()

    public static let a5 : Addable = Multiplicable()

    static const a6 : Addable = Multiplicable()
    public static const func f6(){
        a6
    }
    
    static let a7 : Addable = Multiplicable()
    @Frozen
    public static func f7(){
        a7
    }
    
    static let a8 : Addable = Multiplicable()

    static let width = 10
    public func getWidth(): Int64{
        return width
    }
}

public struct S {
    @Frozen
    public func f1(){
        let s1 = S1()
    }
    static let heigh = 20
    public func getHeigh(): Int64{
        return heigh
    }
}

public func assert<T>(expected:T, actual:T) : Unit where T <: Equatable<T> & ToString{
    if(expected == actual){
    }else{
        throw Exception("${expected} != ${actual}")
    }
}

public func check(){
    let s1 = S1()
    assert(S1.a1 is Addable, true)
    assert(S1.a2 is Addable, true)
    assert(S1.a3 is Addable, true)
    assert(S1.a4 is Subtractable, true)
    assert(S1.a5 is Addable, true)
    assert(S1.a6 is Addable, true)
    assert(S1.a7 is Addable, true)
    assert(S1.a8 is Addable, true)
}