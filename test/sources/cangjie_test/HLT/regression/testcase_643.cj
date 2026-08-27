/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt  %f  -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main() {
    var rs = Array<Int64>(4, {i => 0})
    rs[0] = 1732584193 // rs[0]=1732584193
    var a:Int64 = rs[0] // a =rs[0]= 1732584193
    let a1 = rs[0] + a // a1 = 3465168386
    rs[0] += a // rs[0]= 3465168386 a = 3465168386
    if ( rs[0] != 3465168386 || a1 != 3465168386 || a != 1732584193 ){
        return 1
    } 
    return 0
}
