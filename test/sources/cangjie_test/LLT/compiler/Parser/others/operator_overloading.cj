// EXEC-1: %compiler %cmp_opt %f -o %output
// ASSERT: regex-not core dumped
main()(right:Rune):Int32 {
    if (right == 'a') {
        return 1
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
