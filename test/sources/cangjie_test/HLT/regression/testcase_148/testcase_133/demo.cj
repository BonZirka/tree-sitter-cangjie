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

public open class Class313 <: Interface314<Option<UInt64>> & Interface315 {
        public func func419() : Unit { // block id: 420
        }
}

public interface Interface314<T0> {
    func func419() : Unit
}

public interface Interface315 <: Interface314<Option<UInt64>> {
}

main(): Int64 {
    return 0;
}
