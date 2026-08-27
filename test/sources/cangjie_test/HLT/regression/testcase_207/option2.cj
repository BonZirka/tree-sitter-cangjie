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
// ASSERT: scan 1
// ASSERT: scan-not exception

class X {
    public var value = 1
}

func createX(): ?X {
    X()
}

main(): Int64 {
    print(createX().getOrThrow().value.toString() + "\n")
    return 0
}
