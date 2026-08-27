/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



interface I{
func foo(){
  return 1
}
}

enum TimeUnit{
Month |
Year
}

extend TimeUnit <: I{
func foo){
  return 1
}

    func Day() {
        return foo()
    }
}

main(): Int64 {
let a = TimeUnit.Month
let b = TimeUnit.Year
    return a.Day() - 1
}
// ASSERT: scan parse_expected_lt_paren
