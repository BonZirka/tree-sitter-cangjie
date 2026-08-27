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

public interface Interface707 {
    static func func1503() : UInt64 { // block id: 1504
        1
    }
}

public open class Class702<T0> <: Interface707 {
    public static func func1503() : UInt64 { // block id: 1504
        1
    }
}

main(): Int64 {
    Class702<Array<Bool>>()
    return 0;
}
