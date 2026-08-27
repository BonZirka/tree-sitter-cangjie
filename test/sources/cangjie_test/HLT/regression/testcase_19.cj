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
    var s1: String = "hello Rune lang "
    var s2 = ""
    var s3 = " "

    var s4: String = s1.repeat(1)
    var s5: String = s1.repeat(2)
    var s6: String = s2.repeat(1)
    var s7: String = s2.repeat(2)
    var s8: String = s3.repeat(1)
    var s9: String = s3.repeat(2)
    var s10: String = "a".repeat(3)

    print("s1 = " + s1 + "\n")
    print("s1.repeat(1) = " + s4 + "\n")
    print(" lang "  && s5 == "hello Rune lang hello Rune leat(1) = [" + s6 + "]" + "\n")
    print("s2.repeat(2) = [" + s7 + "]" + "\n")
    print("s3.repeat(1) = [" + s8 + "]" + "\n")
    print("s4.repeat(2) = [" + s9 + "]" + "\n")
    print("\"a\".repeat(3) = [" + s10 + "]" + "\n")

    if (s4 == "hello Rune lang "  && s5 == "hello Rune lang hello Rune lang " && s6 == "" && s7 == "" && s8 == " " && s9== "  "  && s10 == "aaa"){
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}
// ASSERT: scan sema_not_member_of
// ASSERT: scan sema_invalid_binary_expr


