/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



main(){
    let arr =[3,1,45,12,9]
    let s = arr.size
    var i = 0
    for (e in arr where (i < 1)){
        println("i:${}")
        i++
    }
    return i--
}
// ASSERT: scan parse_empty_string_interpolation


