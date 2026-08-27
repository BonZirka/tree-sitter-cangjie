// (DEBUG_OPTION)EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output %compile_lib_opt > %redirectNull 2>&1

main():Unit{
    var a = 1
    var b = 2
    (a, b) = (2, _ = 1)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
