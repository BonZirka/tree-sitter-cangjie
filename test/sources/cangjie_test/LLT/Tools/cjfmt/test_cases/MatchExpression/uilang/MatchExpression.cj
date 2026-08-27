// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main(): Int64 {
  let score: Int64 = 90
  let PASS = 60
  let FULL = 100
  var scoreResult: String = match (score) {
    case 0 => "zero"
    case 10 | 20 | 30 | 40 | 50 => "fail"
    case PASS => "pass"
    case 70 | 80 => "good"
    case 90 | FULL => "excellent"
    case _ => "not a valid score"
  }
  let x = TimeUnit.Day
  let s: String = match (x) {
    case Year => "Year"
    case Month | Day => "Month"
    case Hour => "Hour"
    case _ => "xxx"
  }
  x = TimeUnit.Hour(2021, 1, 1, 1)
  let dateString = match (x) {
    case Year(y) => "${y}/0/0"
    case Month(y, m) => "${y}/${m}/0"
    case Day(y, m, d) | Hour(y, m, d, _) => "${y}/${m}/${d}"
  }
  dateString = match (x) {
    case Year(y) | Month(y, m) => y
    case Year(y) | Month(_, m) => y
    case Year(y) | Month(y, _) => y
    case Year(a) | Hour(_, _, _, a) => a
    case _ => 0
  }
  var str: String = match {
    case i > 0 => "matches the first case"
    case i <= 0 => "matches the second case"
    case _ => "matches the third case"
  }
  match (i + 1) {
    case 0 => "matches the first case"
    case 1 => "matches the second case"
    case _ => "matches the third case"
  }
  let scoreResult: String = match (infoTuple) {
    case ("Bob", 90) => "Bob got 90"
    case ("Alice", score) => "Alice got ${score}"
    case (_, 100) => "someone got 100"
    case (_, _) => "none"
  }
  var son = Son()
  var res = match (son) {
    case father: Father => father.age
    case _ => 1
  }
  match (score) {
    case 60 => "pass"
    case 70 | 80 => "good"
    case 90 | 100 => "excellent"
    case failScore => "other"
  }

  match (score) {
    case 60 => "pass"
    case 10 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 110 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 110 | 20 | 30 | 40 | 50 | 60 | 70 | 80 | 110 => "good"
    case 90 | 100 => "excellent"
    case failScore => "other"
  }
  0
}