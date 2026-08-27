/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1:%compiler %cmp_opt %f -o %output 2>&1 | compare %f

main(){
    var result : Int64 = 0
    var a : Int64 = 0
    var b = a << 64    
    var c = a >> 64    
    if (b != 0) {
      print("1 Int64(0) << 64:"+b.toString()+"\n")
      result |= 0x01
    }
    if (c != 0) {
      print("2 Int64(0) >> 64:"+c.toString()+"\n")
      result |= 0x10
    }
    return result
}
// ASSERT: scan chir_shift_length_overflow
