/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

package packageTest

public class A{var value = 35}

public struct B{
    var value = 35
    public init() {}
}

public  var a: (A,B) =(A(),B())

main(): Int64 {

    if(a[0].value==a[1].value){
        return 0
  1 }else{
        return 1
    }
}
