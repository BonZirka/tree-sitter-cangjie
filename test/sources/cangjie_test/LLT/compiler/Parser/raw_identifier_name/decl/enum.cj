// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

enum `RGBColor` {
    | Red | Green | Blue
}
enum RGBColor {
    | Red | Green | Blue
}

main() {
    0
}

/* SCAN
error: redefinition of declaration 'RGBColor'
 ==> enum.cj:6:6:
  | 
6 | enum RGBColor {
  |      ^^^^^^^^ 
  | 
note: 'RGBColor' is previously declared here
 ==> enum.cj:3:7:
  | 
3 | enum `RGBColor` {
  |       ^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
