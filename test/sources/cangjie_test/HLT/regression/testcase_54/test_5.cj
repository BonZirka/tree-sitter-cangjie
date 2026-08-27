/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



main() {
    let n = 1

    let f1: CFunc<(CPointer<Int16>) -> Unit> = { ptr =>
        let f2 = {
            => n
        }
        0
    }

    var p: CPointer<Int16> = CPointer<Int16>()
    unsafe { f1(p) }

    return 0
}
// ASSERT: scan sema_cfunc_cannot_capture_var
