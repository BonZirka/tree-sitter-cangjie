// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: expect.escape_r_n.out
// EXEC-1: %compiler %cmp_opt %f -o %output 2>%f.out
// EXEC: %diff expect.escape_r_n.out %f.out

main():Unit{
    var a = 1 /*
    a = 2
    println(a)
}
