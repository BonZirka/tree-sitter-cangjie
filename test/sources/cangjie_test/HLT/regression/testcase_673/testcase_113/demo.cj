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

public interface Interface82 {
    func func3762(): Int64 {
        return 0
    }

    func func3708(): Int64 {
        func func3711<T>() : Int64 {
            this.func3762()
        }

        func3711<Int64>()
    }
}

public class C <: Interface82 {}

main() {
    let obj = C()
    return obj.func3708()
}