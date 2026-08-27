/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



class A <: Resource {
    public func isClosed(){false}
    public func close(){print("close!")}
}


class B{
    public operator func [](x:Int64,y:Int64){}
}

var x : ?B = B()

main() {
    try (a = A())
    {
        x?[0] = 1
    } catch success!\n")
    return  1
    }
    print("(_) {
        x?[0] = 1
    } finally {
        x?[0] =0
}
// ASSERT: scan lex_unknown_start_of_token
// ASSERT: scan lex_unterminated_single_line_string
