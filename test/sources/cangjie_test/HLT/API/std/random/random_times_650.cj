/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args
import std.random.*

main() {
    var r = Random()
    for (i in 0..650) {
        r.nextBool()
        r.nextUInt8()
        r.nextUInt16()
        r.nextUInt32()
        r.nextUInt64()
        r.nextInt8()
        r.nextInt16()
        r.nextInt32()
        r.nextInt64()
        r.nextFloat16()
        r.nextFloat32()
        r.nextFloat64()
        r.nextGaussianFloat16()
        r.nextGaussianFloat32()
        r.nextGaussianFloat64()
    }

    return 0
}
