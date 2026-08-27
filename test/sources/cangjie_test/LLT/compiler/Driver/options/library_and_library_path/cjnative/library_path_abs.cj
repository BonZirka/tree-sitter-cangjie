// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (Linux and CJNATIVE) EXEC: mkdir -p level1/level2
// (Windows and CJNATIVE) EXEC: mkdir level1\level2
// EXEC:%compiler %f -Llevel1/level2/../../ %verbose_opt > out.txt
// (Linux and CJNATIVE) EXEC: cat out.txt | grep -- -L$(pwd)
// (Linux and CJNATIVE) EXEC-1: cat out.txt | grep -E /ld\'.*level1/level2
// (Windows and CJNATIVE) EXEC: findstr /I "\-L%pwd" out.txt
// (Windows and CJNATIVE) EXEC-1: findstr /I /R "ld.*level1/level2" out.txt

main() {
    return 0
}
