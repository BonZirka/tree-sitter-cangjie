// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// ASSERT: regex-not core dump

let scoreTuple = ("Allen", 90)
var scoreResult: String = match (scoreTuple) {
  case ("Allen", 90) | ("Bob", 90) => "Allen got 90"
  case (_, _) => ""
}

main() : Int64 {
  return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
