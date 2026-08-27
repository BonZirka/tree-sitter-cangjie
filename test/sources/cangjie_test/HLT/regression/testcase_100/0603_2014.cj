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

package pkg

var b = match (Data.T) {
    case _:T => 1
    case x:Data => 0
    case _ => 2
}


class T {}

enum Data{
    T | V
}

main(): Int64 {
    if ( b != 0 ){
        return 1
    }
    return 0
}
