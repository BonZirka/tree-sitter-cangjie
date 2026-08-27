// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE and Linux) EXEC-PIPE-1: %compiler %f --pgo-instr-use= 2>&1 | compare %f
// (CJNATIVE and Linux) ASSERT: scan option '--pgo-instr-use' requires some values, format: option=value or option="v1, v2..."
// (CJNATIVE and Linux) ASSERT: scan No such file or directory: ''.

main() {
    return 0
}
