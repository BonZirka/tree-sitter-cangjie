// ERRCHECK: %compiler %noColor %f -o %output

// error: const cannot be defined in extend
extend C {
    const e = 0 
}

/* SCAN
error: unexpected variable declaration in extend body
 ==> const_variable8.cj:5:5:
  | 
4 | extend C {
  | ~~~~~~ in extend
5 |     const e = 0 
  |     ^^^^^ unexpected variable declaration
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
