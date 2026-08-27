/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

package A

public class ClassWithLongNameA {}

class ClassWithLongNameB {}

public type classA = ClassWithLongNameA // ok

type classAInter = ClassWithLongNameA // ok

main() {
    let myClassA: classA = ClassWithLongNameA()
    return 0
}
