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

public class Aoo{var value = 5}

public class A{
    public var a:Aoo = Aoo()
}

main(): Int64 {
    if(A().a.value==5){
        return 0
0   }else{
        return 1
    }
}
