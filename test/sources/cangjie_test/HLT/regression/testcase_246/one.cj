/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
main() {
  
    let num = 1

    let newNum = if(num == 0){let x= 1 } else { 1 } // error: Types Unit and Int64 of the two 
    branches of this 'if' expression mismatch.
    println(newNum) 
    println(newNum is String) 
}


