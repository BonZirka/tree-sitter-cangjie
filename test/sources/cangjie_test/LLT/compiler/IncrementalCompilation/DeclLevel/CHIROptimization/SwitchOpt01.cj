// DEPENDENCE: %n.txt
// EXEC: %compiler %incrementalCompile %cmp_opt %optimization_level_2 -Woff unused %n.cj -o %output
// RUN-EXEC: %run %run_opt %output
// EXEC: %cpfile %n.txt %n.cj
// EXEC: %compiler %cmp_opt -Woff unused %optimization_level_2 %incrementalCompile %n.cj -o %output && cat .cached/*.log | compare %f
// RUN-EXEC: %run %run_opt %output
// ASSERT: scan incremental compilation triggered

enum TimeUnit{
  | Year
  | Month(Int64)
}

let oneYear = TimeUnit.Month(1)

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

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
