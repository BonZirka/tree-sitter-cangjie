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

main() : Int64 {
    0
}

interface Interface8<T0> {
    func func641() : Unit {
        let var653 : Array<(Int64 , Int64 , Int64 , Int64)> = [(Int64(0), Int64(0), Int64(0), Int64(0))];
        var653[0][3]
    }
}

interface Interface9 <: Interface8<Array<Array<(Int64 , Int64)>>> {
}
