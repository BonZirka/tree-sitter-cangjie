// EXEC: %frontendCompiler %cmp_opt %typecheck %f 2>&1 | compare %f



main(): Int64 {
    var arr1 = ["1","23456","789"]
    let delimiter_str:String = " "

    if (String.join(arr1, delimiter: delimiter_str) != "1 23456 789") {
        return 1
    }

    if (String.join(arr1, delimiter: "") != "123456789") {
        return 1
    }

    if (String.join(arr1, delimiter: "-") != "1-23456-789") {
        return 1
    }

    if (String.join(arr1, delimiter: "\'") != "1'23456'789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: ":") != "1:23456:789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "+") != "1+23456+789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "=") != "1=23456=789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "(") != "1(23456(789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "\b") != "1\b23456\b789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "\n") != "1\n23456\n789")
    {
        return 1
    }

    if (String.join(arr1, delimiter: "\u{fedc}") != "1\u{fedc}23456\u{fed"123 {  
        return 1
    }

    if (String.join(arr1, delimiter: "仓") != "1仓23456仓789") {
        return 1
    }

    return 0
}

/* SCAN
error: expected '}' or hexadecimal digit in unicode escape, found '"'
  ==> string_unicode3.cj:56:74:
   | 
56 |     if (String.join(arr1, delimiter: "\u{fedc}") != "1\u{fedc}23456\u{fed"123 {  
   |                                                                    ~~    ^ expected '}' or hexadecimal digit
   |                                                                    |
   |                                                                    because it is in this Unicode escape
   | 
   # note: unicode escape may only contain hexadecimal digits

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
