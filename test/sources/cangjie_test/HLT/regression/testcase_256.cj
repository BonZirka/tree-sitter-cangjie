/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt  %f -o %output 2>&1 | compare %f


struct a func ( {
    let b : a var c : ((Unit * UInt32 * Range) * Bool * String * Int8 *
                    (Unit * UInt32 * Range) * Range) *
                   UInt32 * Option 
                     match (c                       case (d,e : ,f=>                      a                 case k =>                      b                 case ((g : ,false,h,9,((),7,f  ),i  ),j,f=>                      a
// ASSERT: scan parse_expected_left_brace
// ASSERT: scan parse_expected_name
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_expression


