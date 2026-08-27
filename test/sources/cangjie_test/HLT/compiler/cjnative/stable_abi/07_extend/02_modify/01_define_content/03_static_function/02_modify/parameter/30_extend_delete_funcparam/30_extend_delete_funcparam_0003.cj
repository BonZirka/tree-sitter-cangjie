/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 7.2.1.3.2.30
  @Scene: modify
  @Visibility: public; used in public @Frozen declare
  @Object: extend static func
  @Behavior: delete func param
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
// ASSERT: scan Incompatible
// ASSERT: scan-1 [API/ABI] Changed number of parameters of function visible outside the module.
// ASSERT: scan-not [API]
// ASSERT: scan-1 [ABI] The body of a const function or function marked with @Frozen changed.

package test_stable_abi

// test extend: static function
public struct TestStruct {}
extend TestStruct{
    public static func f1() {
        0
    }
    public static func foo_public(a: Int64, b!: Int64, c!: Int64 = 1){
        a+b+c
    }

    static const func foo_const(a: Int64, b!: Int64, c!: Int64 = 1){
        a+b+c
    }

    static func foo_frozen(c!: Int64 = 1){
        c
    }

    static func foo_nonpublic(a: Int64, b!: Int64, c!: Int64 = 1){
        a+b+c
    }
}
public const func foo1(){
    TestStruct.foo_const(1,b:2)
}

@Frozen 
public func foo2(){
    TestStruct.foo_frozen()
}

public struct TestStruct_unexport<T> {
    public var a: Int64 = 0
}
private interface I1 {}
extend<T> TestStruct_unexport<T> where T <: I1 {
    public static func foo_unexport(a: Int64, b!: Int64, c!: Int64 = 1){
        a+b+c
    }
}