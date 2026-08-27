/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


func run(): Int64 {
    var s: String = "indexOf Test"
    var ch1: Rune = 'a'
    var i1: Int64 = s.indexOf(ch1, 5) ?? -1
    var ch2: Rune  = '?'
    var i2: Int64 = s.indexOf(ch2, 5) ?? -1

    print("s = " + s + "\n")
    print("indexOf('a', 5)=" + Int32(i1).toString() + "\n")
    print("indexOf('?', 5)=" += Int32(i2).toString() + "\n")

    if (i1 == -1 && i2 == -1){
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
// ASSERT: scan parse_invalid_left_hand_expr


