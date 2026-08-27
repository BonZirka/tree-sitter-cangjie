// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj -o %output


let scoreTuple = ("Allen", 90)
var scoreResult: String = match (scoreTuple) {
  case ("Allen" | "helun", 90) | ("Bob", 90) => "Allen got 90"
  case (_, _) => ""
}

main() : Int64 {
  return 1
}

/* SCAN
error: '|' is not allowed here
 ==> match_or_pattern2.cj:7:17:
  | 
7 |   case ("Allen" | "helun", 90) | ("Bob", 90) => "Allen got 90"
  |                 ^ expected ',' or ')', found '|'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
