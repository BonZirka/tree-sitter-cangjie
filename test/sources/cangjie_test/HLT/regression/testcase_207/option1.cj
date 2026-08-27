/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan value = 1
// ASSERT: scan-not It was None

class X {
    public var value = 1
}

func createX(): ?X {
    X()
}

func test(x: ?X): Unit {
    print("start of test\n")
    match(x) {
        case Some(v) => print("value = " + v.value.toString() + "\n")
        case None => print("It was None\n")
    }
    print("end of test\n")
}

main(): Int64 {
    print("before test\n")
    var x : ?X = X()
    test(x)
    test(createX())
    print("after test\n")
    return 0
}
