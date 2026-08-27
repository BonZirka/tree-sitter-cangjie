/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package pkgs

public class classImport01<T1> where T1 <: I1 & I2 {
    public func test(): Int64 {
        1
    }
}

public interface I1 {}

public interface I2 {}

public class A <: I1 & I2 {}
