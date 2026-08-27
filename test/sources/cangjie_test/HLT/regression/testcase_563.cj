/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-1: %compiler %cmp_opt %f -o %output

main(): Int64 {
    match (Option<(Option<Option<(UInt8*UInt8)>>*(UInt8*Int8))>.None) {
        case Some(num) => num
        case Err(e) => throw e
    }
    return 1
}
