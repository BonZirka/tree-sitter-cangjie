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
    if (foo1() != 2) {return 1}
    return 0
}

func foo(){
    let a = 2
    var b = 1
    if (false){
        1
    }else{
        var res: Int64 = match {
            case _ => 2
        }
        b = res
        return b
    }
}

// 不包含match表达式是OK的
func foo1(){
    let a = 2
    var b = 1
    if (false){
        1
    }else{
        b = 2
        return b
    }
}

func foo2(){
    let a = 2
    var b = 1
    if (false){
        1
    }else{
        var res: Int64 = match {
            case _ => 2
        }
        b = res
        return b
    }
    b // if-else后加返回b，是OK的
}

func foo3(){
    let a = 2
    var b = 1
    if (false){
        1
    }else{
        var res: Int64 = match (a) { // 有selector的match是OK的
            case _ => 2
        }
        b = res
        return b
    }
}
