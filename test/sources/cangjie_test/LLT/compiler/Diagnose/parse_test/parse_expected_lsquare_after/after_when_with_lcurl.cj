/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output
@When{
main() {
    return 0
}

/* SCAN
error: expected '[' after '@When', found '{'
  ==> after_when_with_lcurl.cj:11:6:
   | 
11 | @When{
   | ~~~~~^ expected '[' here
   | 
   # note: when annotation must have condition

1 error generated, 1 error printed.
*/
