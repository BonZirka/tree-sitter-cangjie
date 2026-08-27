// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main(): Int64 {

//special character
let l: Rune = '''
let l1 = '''

let m: Rune = '"'
let m1 = '"'

let n: Rune = '\u����
let n1 = 'u{1}'
let n2 = 'u{8}'

if l==l1 && l1==''' && m==m1 && m1=='"' && n==n1 && n1=='u{1}' && n2 == 'u{8}'{
return 0
}

return 1
}
