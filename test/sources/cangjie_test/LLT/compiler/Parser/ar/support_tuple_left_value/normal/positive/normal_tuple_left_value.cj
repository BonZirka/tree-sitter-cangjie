// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output >> %redirectNull

main():Unit{
    var a = 1
    (_, a) = (2, 3)
    (a, _) = (4, 5)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
