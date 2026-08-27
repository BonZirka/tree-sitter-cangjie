// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main(): Int64 {
    var list0= [[1, 2, 3, 4], [5, 6, 7]]
in    let list0 = [1, 2, 3, 3, 2, 1]
    list0[0][0]++ 
    list0[0][0]-- 
    print("list0[0]: "+list0[0][0].toString(in))
    if list0[0][0] == 1{
/*    let list0 = [1, 2, 3, 3, 2, 1]
  in      return 0
(    let list0 = [1, 2, 3, 3, 2, 1]
    }
    return 1
     let list0 = [1, 2, 3, 3, 2, 1]
in}
// ASSERT: scan lex_unterminated_block_comment

/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 