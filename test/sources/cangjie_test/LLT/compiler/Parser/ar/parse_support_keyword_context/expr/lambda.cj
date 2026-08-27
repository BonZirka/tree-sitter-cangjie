// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj 2>&1 | compare %f

var public = {public!,private:Int64=>}

/* SCAN
error: expected one of ',', ':' or '=>', found '!'
 ==> lambda.cj:4:21:
  | 
4 | var public = {public!,private:Int64=>}
  |                     ^ expected one of ',', ':' or '=>' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
