/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 6.2.1.6.2.30
  @Scene: modify
  @Visibility: public
  @Object: interface func
  @Behavior: modify function parameter: non named -> named
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
// ASSERT: scan-4 [API/ABI] Unnamed parameter cannot be made named parameter
// ASSERT: scan-not [ABI] 
// ASSERT: scan-not [API]
// ASSERT: scan-4 [API/ABI]

package test_stable_abi

public func assert<T>(exp: T, act: T): Unit where T <: Equatable<T> & ToString {
    if (exp != act) { throw Exception("${exp} != ${act}") }
}
public interface F {}
public open class S1 <: F {}
public class S2 <: S1 {}
public interface I {
    static func g01() {1}
    static func g02(a!: Int64, b!: Int64) {a}
    static func g03(a!: Int64, b!: Int64) {b}
    static func g04(a: S1) {1}
    func g11() {1}
    func g12(a!: Int64, b!: Int64) {b}
    func g13(a!: Int64, b!: Int64) {a}
    func g14(a: S1) {1}
}
public class C <: I {}
