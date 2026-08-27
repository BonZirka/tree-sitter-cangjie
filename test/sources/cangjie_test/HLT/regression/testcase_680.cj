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
    let b = "\\u{uaoe}".toArray()
    var arr : Array<UInt8> = [92, 117, 123, 117, 97, 111, 101, 125]
    if  (b != arr ){
        return 1
    }
    return 0
}
