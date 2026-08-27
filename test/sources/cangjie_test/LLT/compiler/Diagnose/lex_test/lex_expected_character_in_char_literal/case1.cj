// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASSERT: scan expected one character in rune literal
// ASSERT: scan unterminated single-line string
// ASSERT: scan expected one character in rune literal
// ASSERT: scan unterminated single-line string

main(): Int64 {

//special character
let l: Rune = r'''
let l1 = r'''

let m: Rune = r'"'
let m1 = r'"'

let n: Rune = '\u����
let n1 = 'u{1}'
let n2 = 'u{8}'

if l==l1 && l1==r''' && m==m1 && m1==r'"' && n==n1 && n1=='u{1}' && n2 == 'u{8}'{
return 0
}

return 1
}
