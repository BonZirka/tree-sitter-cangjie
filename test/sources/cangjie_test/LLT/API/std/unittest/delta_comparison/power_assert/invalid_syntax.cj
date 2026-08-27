/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output %cmp_utest_opt 2>&1 | compare %f
// ASSERT: regex @PowerAssert\(x1, x2, delta:\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(, x1, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, , delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <, x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, delta2: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x3\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 == x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x2 > x1\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(, , delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x3\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, >= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <= x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 == x2, x2 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 != x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <= x2, delta: d, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 > x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 != x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <= x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 > x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 == x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 != x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 > x2, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x1 == x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 >= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 < x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 == x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, delta: d, x1 <= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 ==, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <=, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >=, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 !=, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(< x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(> x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(== x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(<= x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(>= x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(!= x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(, x2, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, delta: d\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta:\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x3\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, >= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <= x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 == x2, x2 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 != x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <= x2, delta: d, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 > x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 != x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <= x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 > x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 == x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 != x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 > x2, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, x1 == x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 >= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 < x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 == x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 < x2, delta: d, x1 <= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, >= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 < x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 == x2, x2 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 != x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 < x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 != x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 < x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 > x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 == x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 != x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 < x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 > x2, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, x1 == x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 >= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 <= x2, delta: d, x1 <= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 >= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, <= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 > x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 == x2, x2 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 != x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 > x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 != x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 >= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 < x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 == x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 != x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 >= x2, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 > x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 >= x2, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 == x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 >= x2, delta: d, x1 <= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x3\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 > x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, >= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <= x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 > x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 == x2, x2 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 != x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <= x2, delta: d, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 < x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 != x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >= x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <= x2, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 < x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 > x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 == x2, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 != x2, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 < x2, x1 > x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 >= x2, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 > x2, delta: d, x1 <= x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x3\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 < x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 == x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 == x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 >=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 <=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 >\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 ==\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, >= x2\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 >= x2, \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 <= x2, extra: e\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 == x2, x1 !=\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 != x2, x1 <\)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 >= x2, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1 == x2, delta: d, x1 <= x, delta: \)\r?\n +\| +\^
// ASSERT: regex @PowerAssert\(x1, x2, deta: d\)\r?\n +\| +\^


import std.unittest.RelativeDelta

@Test
class T {
    static let x1 = 1.0f16
    static let x2 = 1.0f16
    static let d = 1.0f16
    static let e = 1.0f16

    func ImplicitEqMissingDeltaValue() {
        @PowerAssert(x1, x2, delta:)
    }

    func ImplicitEqMissingFirstArgument() {
        @PowerAssert(, x1, delta: d)
    }

    func ImplicitEqMissingSeondArg() {
        @PowerAssert(x1, , delta: d)
    }

    func ImplicitEqExtraNamedParameterNotAllowed() {
        @PowerAssert(x1, x2, delta: d, extra: e)
    }

    func LessInvalidCmpOperator() {
        @PowerAssert(x1 <, x2, delta: d)
    }

    func ImplicitEqCommaMissingExtraParameter() {
        @PowerAssert(x1, x2, delta: d, )
    }

    func ImplicitEqSecondDeltaIsDeprecated() {
        @PowerAssert(x1, x2, delta: d, delta2: e)
    }

    func ImplicitEqExtraParameterNotAllowed() {
        @PowerAssert(x1, x2, delta: d, x3)
    }

    func ImplicitEqExtraCompareInThirdParamLess() {
        @PowerAssert(x1, x2, delta: d, x1 < x2)
    }

    func ImplicitEqTwoSameDeltaNamedParam() {
        @PowerAssert(x1, x2, delta: d, delta: d)
    }

    func ImplicitEqExtraCompareInThirdParamGreater() {
        @PowerAssert(x1, x2, delta: d, x1 > x2)
    }

    func ImplicitEqExtraCompareInThirdParamEq() {
        @PowerAssert(x1, x2, delta: d, x1 == x2)
    }

    func ImplicitEqExtraCompareInThirdParamNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 !=)
    }

    func ImplicitEqExtraCompareInThirdParamEqWithoutOperands() {
        @PowerAssert(x1, x2, delta: d, ==)
    }

    func ImplicitEqTwoCmpExtraParams() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x2 > x1)
    }

    func ImplicitEqSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1, x2, delta: d, delta: )
    }

    func ImplicitEqExtraCmpLessLastComma() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, )
    }

    func ImplicitEqWithoutFirstTwoParams() {
        @PowerAssert(, , delta: d)
    }

    func ImplicitEqExtraCmpAndUsualParam() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x3)
    }

    func ImplicitEqDuplicateDeltaWithExtraCmpParam() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, delta: d)
    }

    func ImplicitEqExtraInvalidCmpGraterOrEqParam() {
        @PowerAssert(x1, x2, delta: d, x1 >=)
    }

    func ImplicitEqExtraInvalidCmpLessOrEqParam() {
        @PowerAssert(x1, x2, delta: d, x1 <=)
    }

    func ImplicitEqExtraInvalidCmpGreaterParam() {
        @PowerAssert(x1, x2, delta: d, x1 >)
    }

    func ImplicitEqExtraInvalidCmpLessParam() {
        @PowerAssert(x1, x2, delta: d, x1 <)
    }

    func ImplicitEqExtraInvalidEqParam() {
        @PowerAssert(x1, x2, delta: d, x1 ==)
    }

    func ImplicitEqExtraInvalidGreaterOrEq() {
        @PowerAssert(x1, x2, delta: d, >= x2)
    }

    func ImplicitEqExtraInvalidGreaterOrEqComma() {
        @PowerAssert(x1, x2, delta: d, x1 >= x2, )
    }

    func ImplicitEqExtraLessOrEqExtraNamedParam() {
        @PowerAssert(x1, x2, delta: d, x1 <= x2, extra: e)
    }

    func ImplicitEqExtraLessCmpExtraIncompleteGreaterCmp() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x1 >)
    }

    func ImplicitEqExtraEqExtraIncompleteNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 == x2, x2 !=)
    }

    func ImplicitEqExtraNotEqExtraIncompleteLess() {
        @PowerAssert(x1, x2, delta: d, x1 != x2, x1 <)
    }

    func ImplicitEqExtraGreaterOrEqNamedDeltaParam() {
        @PowerAssert(x1, x2, delta: d, x1 >= x2, delta: )
    }

    func ImplicitEqExtraLessOrEqNamedDeltaComma() {
        @PowerAssert(x1, x2, delta: d, x1 <= x2, delta: d, )
    }

    func ImplicitEqExtraGreaterIncompleteLess() {
        @PowerAssert(x1, x2, delta: d, x1 > x2, x1 <)
    }

    func ImplicitEqExtraEqNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 == x2, x1 !=)
    }

    func ImplicitEqExtraNotEqIncompleteLessOrEq() {
        @PowerAssert(x1, x2, delta: d, x1 != x2, x1 <=)
    }

    func ImplicitEqExtraGreaterOrEqIncompleteLess() {
        @PowerAssert(x1, x2, delta: d, x1 >= x2, x1 <)
    }

    func ImplicitEqExtraLessOrEqIncompleteGreater() {
        @PowerAssert(x1, x2, delta: d, x1 <= x2, x1 >)
    }

    func ImplicitEqExtraLessIncompleteEq() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x1 ==)
    }

    func ImplicitEqExtraGreaterIncompleteNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 > x2, x1 !=)
    }

    func ImplicitEqExtraEqIncompleteLessOrEq() {
        @PowerAssert(x1, x2, delta: d, x1 == x2, x1 <=)
    }

    func ImplicitEqExtraNotEqIncompleteGreaterOrEq() {
        @PowerAssert(x1, x2, delta: d, x1 != x2, x1 >=)
    }

    func ImplicitEqExtraLessGreater() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x1 > x2)
    }

    func ImplicitEqExtraGreaterOrEqIncompelteEq() {
        @PowerAssert(x1, x2, delta: d, x1 >= x2, x1 ==)
    }

    func ImplicitEqExtraLessOrEqIncompelteNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 <= x2, x1 !=)
    }

    func ImplicitEqExtraGreater() {
        @PowerAssert(x1, x2, delta: d, x1 > x2, x1 < x2)
    }

    func ImplicitEqExtraLessEq() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x1 == x2)
    }

    func ImplicitEqExtraGreaterOrEqIncompleteNotEq() {
        @PowerAssert(x1, x2, delta: d, x1 >= x2, x1 !=)
    }

    func ImplicitEqExtraLessIncompleteGreaterOrEq() {
        @PowerAssert(x1, x2, delta: d, x1 < x2, x1 >=)
    }

    func ImplicitEqExtraEqIncompleteLess() {
        @PowerAssert(x1, x2, delta: d, x1 == x2, x1 <)
    }

    func ImplicitEqExtraLessOrEqIncompleteEq() {
        @PowerAssert(x1, x2, delta: d, x1 <= x2, x1 ==)
    }

    func ExplicitLessValidComparison() {
        let x1 = 1.0f16
        let x2 = 2.0f16
        @PowerAssert(x1 < x2, delta: d) // correct
    }

    func ExplicitGreaterValidComparison() {
        let x1 = 1.0f16
        let x2 = 2.0f16
        @PowerAssert(x1 > x2, delta: d) // correct
    }

    func ExplicitEqualValidComparison() {
        @PowerAssert(x1 == x2, delta: d) // correct
    }

    func ExplicitLessOrEqualValidComparison() {
        @PowerAssert(x1 <= x2, delta: d) // correct
    }

    func ExplicitGreaterOrEqualValidComparison() {
        @PowerAssert(x1 >= x2, delta: d) // correct
    }

    func ExplicitNotEqualValidComparison() {
        let x2 = 0.0f16
        @PowerAssert(x1 != x2, delta: d) // correct
    }

    func ExplicitLessMissingSecondOperand() {
        @PowerAssert(x1 <, delta: d)
    }

    func ExplicitGreaterMissingSecondOperand() {
        @PowerAssert(x1 >, delta: d)
    }

    func ExplicitEqualMissingSecondOperand() {
        @PowerAssert(x1 ==, delta: d)
    }

    func ExplicitLessOrEqualMissingSecondOperand() {
        @PowerAssert(x1 <=, delta: d)
    }

    func ExplicitGreaterOrEqualMissingSecondOperand() {
        @PowerAssert(x1 >=, delta: d)
    }

    func ExplicitNotEqualMissingSecondOperand() {
        @PowerAssert(x1 !=, delta: d)
    }

    func ExplicitLessMissingFirstOperand() {
        @PowerAssert(< x2, delta: d)
    }

    func ExplicitGreaterMissingFirstOperand() {
        @PowerAssert(> x2, delta: d)
    }

    func ExplicitGreaterMissingFirstOperand() {
        @PowerAssert(== x2, delta: d)
    }

    func ExplicitGreaterMissingFirstOperand() {
        @PowerAssert(<= x2, delta: d)
    }

    func ExplicitGreaterMissingFirstOperand() {
        @PowerAssert(>= x2, delta: d)
    }

    func ExplicitGreaterMissingFirstOperand() {
        @PowerAssert(!= x2, delta: d)
    }

    func ExplicitMissingFirstOperand() {
        @PowerAssert(, x2, delta: d)
    }

    func ExplicitMissingComparisonOperand() {
        @PowerAssert(x1, delta: d)
    }

    func ExplicitLessMissingDeltaValue() {
        @PowerAssert(x1 < x2, delta:)
    }

    func ExplicitLessExtraNamedParameterNotAllowed() {
        @PowerAssert(x1 < x2, delta: d, extra: e)
    }

    func ExplicitLessExtraParameterNotAllowed() {
        @PowerAssert(x1 < x2, delta: d, x3)
    }

    func ExplicitLessExtraComparisonInThirdParam() {
        @PowerAssert(x1 < x2, delta: d, x1 > x2)
    }

    func ExplicitLessSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1 < x2, delta: d, delta: )
    }

    func ExplicitLessExtraCmpLessLastComma() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, )
    }

    func ExplicitLessExtraLessCmpExtraIncompleteGreaterCmp() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, x1 >)
    }

    func ExplicitLessExtraInvalidCmpGreaterOrEqParam() {
        @PowerAssert(x1 < x2, delta: d, x1 >=)
    }

    func ExplicitLessExtraInvalidCmpLessOrEqParam() {
        @PowerAssert(x1 < x2, delta: d, x1 <=)
    }

    func ExplicitLessExtraInvalidCmpGreaterParam() {
        @PowerAssert(x1 < x2, delta: d, x1 >)
    }

    func ExplicitLessExtraInvalidCmpLessParam() {
        @PowerAssert(x1 < x2, delta: d, x1 <)
    }

    func ExplicitLessExtraInvalidEqParam() {
        @PowerAssert(x1 < x2, delta: d, x1 ==)
    }

    func ExplicitLessExtraInvalidGreaterOrEq() {
        @PowerAssert(x1 < x2, delta: d, >= x2)
    }

    func ExplicitLessExtraInvalidGreaterOrEqComma() {
        @PowerAssert(x1 < x2, delta: d, x1 >= x2, )
    }

    func ExplicitLessExtraLessOrEqExtraNamedParam() {
        @PowerAssert(x1 < x2, delta: d, x1 <= x2, extra: e)
    }

    func ExplicitLessExtraEqExtraIncompleteNotEq() {
        @PowerAssert(x1 < x2, delta: d, x1 == x2, x2 !=)
    }

    func ExplicitLessExtraNotEqExtraIncompleteLess() {
        @PowerAssert(x1 < x2, delta: d, x1 != x2, x1 <)
    }

    func ExplicitLessExtraGreaterOrEqNamedDeltaParam() {
        @PowerAssert(x1 < x2, delta: d, x1 >= x2, delta: )
    }

    func ExplicitLessExtraLessOrEqNamedDeltaComma() {
        @PowerAssert(x1 < x2, delta: d, x1 <= x2, delta: d, )
    }

    func ExplicitLessExtraGreaterIncompleteLess() {
        @PowerAssert(x1 < x2, delta: d, x1 > x2, x1 <)
    }

    func ExplicitLessExtraEqNotEq() {
        @PowerAssert(x1 < x2, delta: d, x1 == x2, x1 !=)
    }

    func ExplicitLessExtraNotEqIncompleteLessOrEq() {
        @PowerAssert(x1 < x2, delta: d, x1 != x2, x1 <=)
    }

    func ExplicitLessExtraGreaterOrEqIncompleteLess() {
        @PowerAssert(x1 < x2, delta: d, x1 >= x2, x1 <)
    }

    func ExplicitLessExtraLessOrEqIncompleteGreater() {
        @PowerAssert(x1 < x2, delta: d, x1 <= x2, x1 >)
    }

    func ExplicitLessExtraLessIncompleteEq() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, x1 ==)
    }

    func ExplicitLessExtra() {
        @PowerAssert(x1 < x2, delta: d, x1 > x2, x1 !=)
    }

    func ExplicitLessExtraEqIncompleteLessOrEq() {
        @PowerAssert(x1 < x2, delta: d, x1 == x2, x1 <=)
    }

    func ExplicitLessExtraNotEqIncompleteGreaterOrEq() {
        @PowerAssert(x1 < x2, delta: d, x1 != x2, x1 >=)
    }

    func ExplicitLessExtraLessGreater() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, x1 > x2)
    }

    func ExplicitLessExtraGreaterOrEqIncompleteEq() {
        @PowerAssert(x1 < x2, delta: d, x1 >= x2, x1 ==)
    }

    func ExplicitLessExtraLessOrEqIncompleteNotEq() {
        @PowerAssert(x1 < x2, delta: d, x1 <= x2, x1 !=)
    }

    func ExplicitLessExtraGreater() {
        @PowerAssert(x1 < x2, delta: d, x1 > x2, x1 < x2)
    }

    func ExplicitLessExtraLessEq() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, x1 == x2)
    }

    func ExplicitLessExtraGreaterOrEqIncompleteNotEq() {
        @PowerAssert(x1 < x2, delta: d, x1 >= x2, x1 !=)
    }

    func ExplicitLessExtraLessIncompleteGreaterOrEq() {
        @PowerAssert(x1 < x2, delta: d, x1 < x2, x1 >=)
    }

    func ExplicitLessExtraEqIncompleteLess() {
        @PowerAssert(x1 < x2, delta: d, x1 == x2, x1 <)
    }

    func ExplicitLessExtraLessOrEqIncompleteEq() {
        @PowerAssert(x1 < x2, delta: d, x1 <= x2, x1 ==)
    }

    func ExplicitLessOrEqSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1 <= x2, delta: d, delta: )
    }

    func ExplicitLessOrEqExtraCmpLessOrEqLastComma() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, )
    }

    func ExplicitLessOrEqExtraLessOrEqCmpExtraIncompleteGreaterCmp() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, x1 >)
    }

    func ExplicitLessOrEqExtraInvalidCmpGreaterOrEqParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 >=)
    }

    func ExplicitLessOrEqExtraInvalidCmpLessParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 <)
    }

    func ExplicitLessOrEqExtraInvalidCmpGreaterParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 >)
    }

    func ExplicitLessOrEqExtraInvalidEqParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 ==)
    }

    func ExplicitLessOrEqExtraInvalidGreaterOrEq() {
        @PowerAssert(x1 <= x2, delta: d, >= x2)
    }

    func ExplicitLessOrEqExtraInvalidGreaterOrEqComma() {
        @PowerAssert(x1 <= x2, delta: d, x1 >= x2, )
    }

    func ExplicitLessOrEqExtraLessExtraNamedParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 < x2, extra: e)
    }

    func ExplicitLessOrEqExtraEqExtraIncompleteNotEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 == x2, x2 !=)
    }

    func ExplicitLessOrEqExtraNotEqExtraIncompleteLess() {
        @PowerAssert(x1 <= x2, delta: d, x1 != x2, x1 <)
    }

    func ExplicitLessOrEqExtraGreaterOrEqNamedDeltaParam() {
        @PowerAssert(x1 <= x2, delta: d, x1 >= x2, delta: )
    }

    func ExplicitLessOrEqExtraLessIncompleteGreater() {
        @PowerAssert(x1 <= x2, delta: d, x1 < x2, x1 >)
    }

    func ExplicitLessOrEqExtraEqNotEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 == x2, x1 !=)
    }

    func ExplicitLessOrEqExtraNotEqIncompleteLessOrEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 != x2, x1 <=)
    }

    func ExplicitLessOrEqExtraGreaterOrEqIncompleteLess() {
        @PowerAssert(x1 <= x2, delta: d, x1 >= x2, x1 <)
    }

    func ExplicitLessOrEqExtraLessIncompleteEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 < x2, x1 ==)
    }

    func ExplicitLessOrEqExtra() {
        @PowerAssert(x1 <= x2, delta: d, x1 > x2, x1 !=)
    }

    func ExplicitLessOrEqExtraEqIncompleteLess() {
        @PowerAssert(x1 <= x2, delta: d, x1 == x2, x1 <)
    }

    func ExplicitLessOrEqExtraNotEqIncompleteGreaterOrEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 != x2, x1 >=)
    }

    func ExplicitLessOrEqExtraLessGreater() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, x1 > x2)
    }

    func ExplicitLessOrEqExtraGreaterOrEqIncompleteEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 >= x2, x1 ==)
    }

    func ExplicitLessOrEqExtraLessIncompleteNotEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 < x2, x1 !=)
    }

    func ExplicitLessOrEqExtraGreater() {
        @PowerAssert(x1 <= x2, delta: d, x1 > x2, x1 < x2)
    }

    func ExplicitLessOrEqExtraLessEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, x1 == x2)
    }

    func ExplicitLessOrEqExtraGreaterOrEqIncompleteNotEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 >= x2, x1 !=)
    }

    func ExplicitLessOrEqExtraLessIncompleteGreaterOrEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, x1 >=)
    }

    func ExplicitLessOrEqExtraLessOrEqIncompleteEq() {
        @PowerAssert(x1 <= x2, delta: d, x1 <= x2, x1 ==)
    }

    func ExplicitGreaterOrEqSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1 >= x2, delta: d, delta: )
    }

    func ExplicitGreaterOrEqExtraCmpGreaterOrEqLastComma() {
        @PowerAssert(x1 >= x2, delta: d, x1 >= x2, )
    }

    func ExplicitGreaterOrEqExtraGreaterOrEqCmpExtraIncompleteLessCmp() {
        @PowerAssert(x1 >= x2, delta: d, x1 >= x2, x1 <)
    }

    func ExplicitGreaterOrEqExtraInvalidCmpLessOrEqParamMissingSecondOperand() {
        @PowerAssert(x1 >= x2, delta: d, x1 <=)
    }

    func ExplicitGreaterOrEqExtraInvalidCmpLessParam() {
        @PowerAssert(x1 >= x2, delta: d, x1 <)
    }

    func ExplicitGreaterOrEqExtraCmpLessOrEqParam() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2)
    }

    func ExplicitGreaterOrEqExtraInvalidEqParam() {
        @PowerAssert(x1 >= x2, delta: d, x1 ==)
    }

    func ExplicitGreaterOrEqExtraInvalidLessOrEq() {
        @PowerAssert(x1 >= x2, delta: d, <= x2)
    }

    func ExplicitGreaterOrEqExtraInvalidLessOrEqComma() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2, )
    }

    func ExplicitGreaterOrEqExtraGreaterExtraNamedParam() {
        @PowerAssert(x1 >= x2, delta: d, x1 > x2, extra: e)
    }

    func ExplicitGreaterOrEqExtraEqExtraIncompleteNotEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 == x2, x2 !=)
    }

    func ExplicitGreaterOrEqExtraNotEqExtraIncompleteGreater() {
        @PowerAssert(x1 >= x2, delta: d, x1 != x2, x1 >)
    }

    func ExplicitGreaterOrEqExtraLessOrEqNamedDeltaParam() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2, delta: )
    }

    func ExplicitGreaterOrEqExtraGreaterIncompleteLess() {
        @PowerAssert(x1 >= x2, delta: d, x1 > x2, x1 <)
    }

    func ExplicitGreaterOrEqExtraEqNotEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 == x2, x1 !=)
    }

    func ExplicitGreaterOrEqExtraNotEqIncompleteGreaterOrEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 != x2, x1 >=)
    }

    func ExplicitGreaterOrEqExtraLessOrEqIncompleteLess() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2, x1 <)
    }

    func ExplicitGreaterOrEqExtraGreaterOrEqIncompleteEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 >= x2, x1 ==)
    }

    func ExplicitGreaterOrEqExtra() {
        @PowerAssert(x1 >= x2, delta: d, x1 < x2, x1 !=)
    }

    func ExplicitGreaterOrEqExtraEqIncompleteGreater() {
        @PowerAssert(x1 >= x2, delta: d, x1 == x2, x1 >)
    }

    func ExplicitGreaterOrEqExtraNotEqIncompleteLessOrEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 != x2, x1 <=)
    }

    func ExplicitGreaterOrEqExtraGreaterLess() {
        @PowerAssert(x1 >= x2, delta: d, x1 >= x2, x1 < x2)
    }

    func ExplicitGreaterOrEqExtraLessOrEqIncompleteEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2, x1 ==)
    }

    func ExplicitGreaterOrEqExtraGreaterIncompleteGreaterOrEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 > x2, x1 >=)
    }

    func ExplicitGreaterOrEqExtraGreaterOrEqLess() {
        @PowerAssert(x1 >= x2, delta: d, x1 >= x2, x1 < x2)
    }

    func ExplicitGreaterOrEqExtraEqIncompleteLess() {
        @PowerAssert(x1 >= x2, delta: d, x1 == x2, x1 <)
    }

    func ExplicitGreaterOrEqExtraLessOrEqIncompleteNotEq() {
        @PowerAssert(x1 >= x2, delta: d, x1 <= x2, x1 !=)
    }

    func ExplicitGreaterExtraNamedParameterNotAllowed() {
        @PowerAssert(x1 > x2, delta: d, extra: e)
    }

    func ExplicitGreaterExtraParameterNotAllowed() {
        @PowerAssert(x1 > x2, delta: d, x3)
    }

    func ExplicitGreaterExtraComparisonInThirdParam() {
        @PowerAssert(x1 > x2, delta: d, x1 < x2)
    }

    func ExplicitGreaterSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1 > x2, delta: d, delta: )
    }

    func ExplicitGreaterExtraCmpGreaterLastComma() {
        @PowerAssert(x1 > x2, delta: d, x1 > x2, )
    }

    func ExplicitGreaterExtraInvalidCmpGreaterOrEqParam() {
        @PowerAssert(x1 > x2, delta: d, x1 >=)
    }

    func ExplicitGreaterExtraInvalidCmpLessOrEqParam() {
        @PowerAssert(x1 > x2, delta: d, x1 <=)
    }

    func ExplicitGreaterExtraInvalidCmpGreaterParam() {
        @PowerAssert(x1 > x2, delta: d, x1 >)
    }

    func ExplicitGreaterExtraInvalidCmpLessParam() {
        @PowerAssert(x1 > x2, delta: d, x1 <)
    }

    func ExplicitGreaterExtraInvalidEqParam() {
        @PowerAssert(x1 > x2, delta: d, x1 ==)
    }

    func ExplicitGreaterExtraInvalidGreaterOrEq() {
        @PowerAssert(x1 > x2, delta: d, >= x2)
    }

    func ExplicitGreaterExtraInvalidGreaterOrEqComma() {
        @PowerAssert(x1 > x2, delta: d, x1 >= x2, )
    }

    func ExplicitGreaterExtraLessOrEqExtraNamedParam() {
        @PowerAssert(x1 > x2, delta: d, x1 <= x2, extra: e)
    }

    func ExplicitGreaterExtraGreaterCmpExtraIncompleteLessCmp() {
        @PowerAssert(x1 > x2, delta: d, x1 > x2, x1 <)
    }

    func ExplicitGreaterExtraEqExtraIncompleteNotEq() {
        @PowerAssert(x1 > x2, delta: d, x1 == x2, x2 !=)
    }

    func ExplicitGreaterExtraNotEqExtraIncompleteLess() {
        @PowerAssert(x1 > x2, delta: d, x1 != x2, x1 <)
    }

    func ExplicitGreaterExtraGreaterOrEqNamedDeltaParam() {
        @PowerAssert(x1 > x2, delta: d, x1 >= x2, delta: )
    }

    func ExplicitGreaterExtraLessOrEqNamedDeltaComma() {
        @PowerAssert(x1 > x2, delta: d, x1 <= x2, delta: d, )
    }

    func ExplicitGreaterExtraLessCmpExtraIncompleteGreaterCmp() {
        @PowerAssert(x1 > x2, delta: d, x1 < x2, x1 >)
    }

    func ExplicitGreaterExtraEqNotEq() {
        @PowerAssert(x1 > x2, delta: d, x1 == x2, x1 !=)
    }

    func ExplicitGreaterExtraNotEqIncompleteLessOrEq() {
        @PowerAssert(x1 > x2, delta: d, x1 != x2, x1 <=)
    }

    func ExplicitGreaterExtraGreaterOrEqIncompleteLess() {
        @PowerAssert(x1 > x2, delta: d, x1 >= x2, x1 <)
    }

    func ExplicitGreaterExtraLessOrEqIncompleteGreater() {
        @PowerAssert(x1 > x2, delta: d, x1 <= x2, x1 >)
    }

    func ExplicitGreaterExtraLessIncompleteEq() {
        @PowerAssert(x1 > x2, delta: d, x1 < x2, x1 ==)
    }

    func ExplicitGreaterExtraGreaterIncompleteNotEq() {
        @PowerAssert(x1 > x2, delta: d, x1 > x2, x1 !=)
    }

    func ExplicitGreaterExtraEqIncompleteLessOrEq() {
        @PowerAssert(x1 > x2, delta: d, x1 == x2, x1 <=)
    }

    func ExplicitGreaterExtraNotEqIncompleteGreaterOrEq() {
        @PowerAssert(x1 > x2, delta: d, x1 != x2, x1 >=)
    }

    func ExplicitGreaterExtraLessGreater() {
        @PowerAssert(x1 > x2, delta: d, x1 < x2, x1 > x2)
    }

    func ExplicitGreaterExtraGreaterOrEqIncompleteEq() {
        @PowerAssert(x1 > x2, delta: d, x1 >= x2, x1 ==)
    }

    func ExplicitGreaterExtraLessOrEqIncompleteNotEq() {
        @PowerAssert(x1 > x2, delta: d, x1 <= x2, x1 !=)
    }

    func ExplicitEqualExtraNamedParameterNotAllowed() {
        @PowerAssert(x1 == x2, delta: d, extra: e)
    }

    func ExplicitEqualExtraParameterNotAllowed() {
        @PowerAssert(x1 == x2, delta: d, x3)
    }

    func ExplicitEqualExtraComparisonInThirdParam() {
        @PowerAssert(x1 == x2, delta: d, x1 < x2)
    }

    func ExplicitEqualSecondNamedDeltaWithoutValue() {
        @PowerAssert(x1 == x2, delta: d, delta: )
    }

    func ExplicitEqualExtraCmpEqualLastComma() {
        @PowerAssert(x1 == x2, delta: d, x1 == x2, )
    }

    func ExplicitEqualExtraEqualCmpExtraIncompleteLessCmp() {
        @PowerAssert(x1 == x2, delta: d, x1 == x2, x1 <)
    }

    func ExplicitEqualExtraInvalidCmpGreaterOrEqParam() {
        @PowerAssert(x1 == x2, delta: d, x1 >=)
    }

    func ExplicitEqualExtraInvalidCmpLessOrEqParam() {
        @PowerAssert(x1 == x2, delta: d, x1 <=)
    }

    func ExplicitEqualExtraInvalidCmpGreaterParam() {
        @PowerAssert(x1 == x2, delta: d, x1 >)
    }

    func ExplicitEqualExtraInvalidCmpLessParam() {
        @PowerAssert(x1 == x2, delta: d, x1 <)
    }

    func ExplicitEqualExtraInvalidEqParam() {
        @PowerAssert(x1 == x2, delta: d, x1 ==)
    }

    func ExplicitEqualExtraInvalidGreaterOrEq() {
        @PowerAssert(x1 == x2, delta: d, >= x2)
    }

    func ExplicitEqualExtraInvalidGreaterOrEqComma() {
        @PowerAssert(x1 == x2, delta: d, x1 >= x2, )
    }

    func ExplicitEqualExtraLessOrEqExtraNamedParam() {
        @PowerAssert(x1 == x2, delta: d, x1 <= x2, extra: e)
    }

    func ExplicitEqualExtraEqualNotEq() {
        @PowerAssert(x1 == x2, delta: d, x1 == x2, x1 !=)
    }

    func ExplicitEqualExtraNotEqExtraIncompleteLess() {
        @PowerAssert(x1 == x2, delta: d, x1 != x2, x1 <)
    }

    func ExplicitEqualExtraGreaterOrEqNamedDeltaParam() {
        @PowerAssert(x1 == x2, delta: d, x1 >= x2, delta: )
    }

    func ExplicitEqualExtraLessOrEqNamedDeltaParam() {
        @PowerAssert(x1 == x2, delta: d, x1 <= x, delta: )
    }

    func ImplicitEqualInvalidDeltaNamedArg() {
        @PowerAssert(x1, x2, deta: d)
    }
}
