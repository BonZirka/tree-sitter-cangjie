// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE and not Windows) DEPENDENCE: i_should_not_appear_in_command.txt
// (CJNATIVE and not Windows) EXEC: mkdir \'': ls'
// (CJNATIVE and not Windows) EXEC: cp -rf $CANGJIE_HOME/* \'': ls'
// (CJNATIVE and not Windows) EXEC-PIPE-1: CANGJIE_HOME=\'': ls' \'': ls/bin/cjc' %f %verbose_opt 2>&1 | compare %f
// (CJNATIVE and not Windows) ASSERT: scan-not i_should_not_appear_in_command
// (CJNATIVE and not Windows) ASSERT: regex error.* Invalid cjc installation path
// (CJNATIVE and not Windows) ASSERT: regex info.* Do not install `cjc` under a path that contains the following characters: :;

main() {
    return 0
}
