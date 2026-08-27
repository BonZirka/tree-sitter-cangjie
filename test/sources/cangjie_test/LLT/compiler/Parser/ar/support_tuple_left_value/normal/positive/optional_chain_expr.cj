// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output > %redirectNull 2>&1

main():Unit{
    var a = Some([0, 0])
    (a?[0], a?[1]) = (1, 2)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
