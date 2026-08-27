
// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main() {
 var public = 1
 var private = 2
 // varPattern
 match (private) {
    case public => println("value = ${public}") 
  }
 // tuplePattern
 let a = (1, (), (), 3)
 var result = match (a) {
       case (private, public, protected, open) => ""
       case _ => ""
  }

}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
