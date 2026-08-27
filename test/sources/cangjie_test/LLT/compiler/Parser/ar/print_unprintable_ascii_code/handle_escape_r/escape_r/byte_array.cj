// DEPENDENCE: ../expect/%n.expect
// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %output > %f.out
// EXEC: %diff %n.expect %f.out

main():Unit{
    let a = "    let b = b".toArray()
	println(a)
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
