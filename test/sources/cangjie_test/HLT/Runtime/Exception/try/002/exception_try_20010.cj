/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


open class A <: Exception{}

class B <: A{}

main(){
    try{throw A()}
    catch (a:_) {return 3}
    finally{}
    return 4
}
// ASSERT: scan parse_expected_type
// ASSERT: scan parse_expected_expr_or_decl_in
