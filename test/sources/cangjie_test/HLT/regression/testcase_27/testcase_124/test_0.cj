/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt %f -o %output 

class VVV<T>{
    public VVV(a:T,b:String,c!:Int32 =1,var d!:Int64){}
}
main() {
    var aa =VVV(1, "b: String", c: 1, d: 1)
    0
}
