/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// ASSERT: scan Compatible!
package test_stable_abi

public func assert<T>(exp: T, act: T): Unit where T <: Equatable<T> & ToString {
    if (exp != act) { throw Exception("${exp} != ${act}") }
}
public interface I1 {
    static func g1() {1}
    func g2() {1}
    @Frozen
    static func g3() {1}
    @Frozen
    func g4() {1}
}
public interface I2 {
    static func g1(): Int64
    func g2(): Int64
    @Frozen
    static func g3(): Int64
    @Frozen
    func g4(): Int64
}
public class C1 <: I1 {}
public class C2 <: I2 {
    public static func g1() {1}
    public func g2() {1}
    @Frozen
    public static func g3() {1}
    @Frozen
    public func g4() {1}
}
