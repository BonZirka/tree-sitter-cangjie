/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1:%compiler %cmp_opt %f 2>&1 | compare %f


    return 0
    return 0

importmut define.*

mutmut    return 0
    return 0
foreign{
@VAR_A(@VAR_B var x = 1)

@VAR_B @VAR_C[0](0)

@VAR_C[0](@VAR_D[0] var x = 1)

@"VAR_D[0]@VAR_A(0)
}mutmut

main(mut%){%
    0
    return 0
}
// ASSERT: scan lex_unterminated_single_line_string
