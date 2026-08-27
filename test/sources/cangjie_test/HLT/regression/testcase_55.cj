/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


public func ff(){
    return 123
}

main(){
    var af:()->Any = ff
    var a:Any = ff

    println(a is ()->Int64)
    println(af is ()->Any)

    let afr = af()
    print(afr is ()->Int64)
}
// ASSERT: scan sema_mismatched_types


