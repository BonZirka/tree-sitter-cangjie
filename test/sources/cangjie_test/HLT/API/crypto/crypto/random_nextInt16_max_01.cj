/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %stdx-package  %f -o %output
// RUN-EXEC: %run_stdx %output %run_args
import stdx.crypto.crypto.*
import std.collection.*
import std.math.*

main() {
    var r1: SecureRandom = SecureRandom()
    var r2: SecureRandom = SecureRandom(priv: true)
    var count = 0
    try {
        r1.nextInt16(0)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    try {
        r2.nextInt16(0)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    try {
        r1.nextInt16(-25)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    try {
        r2.nextInt16(-25)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    try {
        r1.nextInt16(Int16.Min)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    try {
        r2.nextInt16(Int16.Min)
    } catch (e: IllegalArgumentException) {
        count += 1
    }
    if (count != 6) {
        return 1
    }
    return 0
}
