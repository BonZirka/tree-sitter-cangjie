// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main() {
 var public = 1
 var private = public  + 1
 if (public == 2) {
   return 1
 }
 if (private == 2) {
   private++
 }
 for (open in 0..10) {
   public += 1 
 }
 return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
