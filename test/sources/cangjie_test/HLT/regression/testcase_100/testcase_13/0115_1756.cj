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
    foo1()
    return 0
}

func foo1(){
    let score = 80
    // BUG,在match的左花括号之后加个备注就报错
    var result: String = match { // xxx
        case score < 60 => "fail"
        case score >= 60 => "fail"
        case _ => "NoDefine"
    }
}
