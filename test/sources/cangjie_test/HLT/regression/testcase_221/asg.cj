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
// ASSERT: scan cccbbb

class C {
    public var c : Int64 = 1
    public init() {
        print("ccc")
    }
}


class B {
    public var b : Int64 = 1
    public init(){
        print("bbb")
    }
}


main() {
    B().b = C().c
    return 0
}
