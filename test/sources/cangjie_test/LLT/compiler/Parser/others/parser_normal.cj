// (DEBUG_OPTION)EXEC: %frontendCompiler %dump-parse %cmp_opt %f > %redirectNull

main():Unit{
    a{}
    a(){}
    a(c){}
    a.b{}
    a.b(){}
    a.b(c){}

    a?{}
    a?(){}
    a?(c){}
    a?.b{}
    a?.b(){}
    a?.b(c){}
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
