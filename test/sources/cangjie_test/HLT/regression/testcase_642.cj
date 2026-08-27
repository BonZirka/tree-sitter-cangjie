/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
//ASSERT: scan Exception

var a : Option<Unit> = None
main(){
    func b<c, d, e>() {
        try {
            a.getOrThrow()
        } finally {}
    }
    b<UInt8, String, UInt64>()
}