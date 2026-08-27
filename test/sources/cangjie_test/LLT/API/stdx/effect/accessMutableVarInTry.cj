/* 
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC-PIPE-1: %compiler %enableEH %core_cmp_opt  %f -o %output 2>&1 | compare %f
// ASSERT: scan 'try'-'handle' expressions cannot capture mutable variables; consider using 'let' or boxing
// ASSERT: scan 3 errors generated, 3 errors printed
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace


import stdx.effect.Command

class Eff <: Command<Unit> {}

main() {
    var x: Int64 = 1
    try {
        x += 1
    } handle (_: Eff) {
        x += 1
        resume
    } finally {
        x += 1
    }
}
