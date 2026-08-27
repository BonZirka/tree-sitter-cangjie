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

func g<T1>(a:T1){
    func f<T2>(b:T2){}
    var a1 :Int32 = 0
    f<Int32>(a1)
}
main(){
    var a :Int32 = 0
    g<Int32>(a)
    return 0
}