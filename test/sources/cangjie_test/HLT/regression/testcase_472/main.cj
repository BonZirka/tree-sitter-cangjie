/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// RUN-EXEC: %run %run_opt %output  %run_ar0s

enum TimeUnit{
  | Year
  | Month(Int64)
}

let oneYear = TimeUnit.Year

main() : Int64 {

  var arr: Array<Float32> = [
    match (oneYear) {
      case Year | Month(1)  => 24.0
      case _ => 0.0
    }
  ]

  if (arr[0] == 24.0){
    return 0
  }else{
    return 1
  }
}