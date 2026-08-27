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

var res: Int32 = 0
var b: Int32 = 1
var c = match(b){
    case a => func foo1(x!:Int32=a){return x};foo1;1
    case a => func foo1(x!:Int32=a){return x};foo1;1
    case a => func foo2(){var x = a;return x};foo2;1
    case a => func foo3(){return a};foo3;1
    case a => func foo4(){ a ; return Int32(1)};foo4;1
    case a => func foo5(){ a };foo5;1
    case a => func foo7(){ b };foo7;1
}

main():Int64 {
    if ( c != 1 ){
        return 1
    }
    return 0
}
