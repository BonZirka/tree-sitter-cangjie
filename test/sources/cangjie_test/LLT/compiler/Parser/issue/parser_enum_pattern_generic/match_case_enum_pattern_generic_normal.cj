// (DEBUG_OPTION)EXEC: %frontendCompiler %dump-parse %cmp_opt %f 2>&1 > %redirectNull 

main():Unit{
    match(x){
        case a<a>.c(c) => 1
        case a<a>.c(a,b,c) => 2
        case a.b<b>.c(a,b,c) => 2
        case _ => 3
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
