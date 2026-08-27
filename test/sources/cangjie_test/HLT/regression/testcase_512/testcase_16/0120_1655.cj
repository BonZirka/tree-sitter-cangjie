/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main():Int64 {
    if (foo1() != 1) {return 1}
    if (foo2()[2] != 1) {return 1} //失败
    return 0
}

func foo1(){
    var a = [-1,0,1]
    return a[2] // ok
}

func foo2(){
    var a = [-1,0,1]
    return a
}