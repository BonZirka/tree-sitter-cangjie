/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class a<b, c>     {}
main(){
    try {
        let d = 29.0
        func f<b>() { 
            if (if (false) { 
                101.0 < d
            } else { 
                true
            }) {} }
        func g<b>() { 
            f<UInt64>()}
        let h = g<a<Int16, Int8>>
        f<UInt64>()
    } catch (e: NoneValueException) {}
    }
