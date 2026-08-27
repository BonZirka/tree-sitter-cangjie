// ERRCHECK: %compiler %cmp_opt %f -o %output

main():Unit{
    let a = [1,2,3,4,5]
    a[..=]
}

/* SCAN
error: expected expression after ..=, found ]
 ==> closed_range_op.cj:5:10:
  | 
5 |     a[..=]
  |          ^ expected expression here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
