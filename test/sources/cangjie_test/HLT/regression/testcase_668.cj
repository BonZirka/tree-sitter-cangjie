/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
//EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


let a :  Rune  
let c : UInt16 
func ( {
    let d : (Unit *(Rune * Int32 *(String * Float32 * Int16 *  Int64  *UInt16  * Int16 * Int16) *Int8 *  UInt16 )* Int8  *Int32  *  Rune  * UInt16) *Rune *  UInt64 
match ((, d, , c, ) 
    case (e,f,n,g,h : => a         
    case (i,((b,(n  ,j  ,(n,90.0,n ,k  ,l,3,4),9,n),n  ,o ,n,m),n,n  ),n,5,n => a
// ASSERT: scan parse_var_must_be_initialized
// ASSERT: scan parse_expected_name
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_expected_type
