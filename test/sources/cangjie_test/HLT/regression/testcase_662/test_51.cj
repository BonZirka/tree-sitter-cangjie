/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f





func test<T>(i: T): Int64 {
    var a : List<List<T>> = [[i]]
    var b : List<List<T>> = List<List<T>>([[i]].toArray())
    var c : List<List<T>> = List<List<T>>(Array<List<>(1)
}
// ASSERT: scan parse_expected_type_argument
// ASSERT: scan parse_expected_right_delimiter
