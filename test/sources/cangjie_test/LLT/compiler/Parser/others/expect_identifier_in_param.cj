// ERRCHECK: %compiler %cmp_opt %f -o %output

main(@M a$:Int64){
    
}

/* SCAN
error: expected ':', found '$'
 ==> expect_identifier_in_param.cj:3:10:
  | 
3 | main(@M a$:Int64){
  |          ^ expected ':' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
