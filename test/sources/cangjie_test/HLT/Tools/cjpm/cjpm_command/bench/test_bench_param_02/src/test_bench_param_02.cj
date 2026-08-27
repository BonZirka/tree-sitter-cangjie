/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a

import std.time.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

@Strategy
func generateTestingData(): ArrayList<Int64> {
    return ArrayList<Int64>()
}

@Test
@Configure[minDuration: Duration.millisecond * 100]
@Configure[warmup: Duration.millisecond * 100]
public class Bench_Param_02 {
    @Bench[x in generateTestingData]
    func benchmark_01(x: ArrayList<Int64>): Unit {
        x.add(1)
    }
}

main() {}
