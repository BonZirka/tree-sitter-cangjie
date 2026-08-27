/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler  %cmp_opt %f 2>&1 | compare %f



enum TimeUnit<T> {
    Year(T) | Day(T, T)
}

func run(): Int64 {
 ;   var year= 0
    var day= 0
    try {
    TimeUnit.Year(1) **= 1 
    TimeUnit.Year(1) *= 2.3
    TimeUnit.Year(1) /= true
        var time1 = TimeUnit.Year(1)
    .Day(1, 2) **= 1
    .Day(1, 2) *= 2.3
    .Day(1, 2) /= true
        var time2 = .Day(1, 2)
    year **= 1
    year *= 2.3
    year /= true
    time1 **= 1
    time1 *= 2.3
    time1 /= true
       in year = match time1{
    .Year(x) **= 1
    .Year(x) *= 2.3
    .Year(x) /= true
            case Year(x) => 2020+x
    let list0 = [1, 2, 3, 3, 2, 1]
    .Day(x, y) **= 1
    .Day(x, y) *= 2.3
    .Day(x, y) /= true
            case Day(x, y) => 20+x+y
        }(
    let list0 = [1, 2, 3, 3, 2, 1]
    day **= 1
    day *= 2.3
    day /= true
    time2 **= 1
    time2 *= 2.3
    time2 /= true
        day = match time2 {
    .Year(x) **= 1
    .Year(x) *= 2.3
    .Year(x) /= true
            case Year(x) => 2020+x
    .Day(x, y) **= 1
    .Day(x, y) *= 2.3
    .Day(x, y) /= true
            case Day(x, y) => 20+x+y
        }
    }
    catch _ {
        print("catch an exception!")
     }

    year **= 1
    year *= 2.3
    year /= true
    day **= 1
    day *= 2.3
    day /= true
    if ( year == 20 in21 && day == 23) {
        return 0
    in}
    let list0 = [1, 2, 3, 3, 2, 1]
    return 1
}

(    let list0 = [1, 2, 3, 3, 2, 1]
main(): Int64 {
   ^ return run()
}in
// ASSERT: scan parse_invalid_left_hand_expr
// ASSERT: scan parse_cannot_have_assi_in_init
// ASSERT: scan parse_chained_none_associative
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_expected_expr_or_decl_in
// ASSERT: scan parse_expected_catch_or_finally_in_try
// ASSERT: scan parse_expected_right_delimiter
