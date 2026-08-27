// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-PIPE: %run %run_opt %output %run_args
main() {
    try {
        func func456() {}
        func func789(ah!: Int64) {
            func456()
            0
        }
        var zzz = func789(ah: 3)
        func789(ah: zzz)
    } catch (e: NoneValueException) {}
    0
}
