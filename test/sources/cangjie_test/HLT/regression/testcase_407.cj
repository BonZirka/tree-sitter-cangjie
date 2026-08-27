/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt  %f  -o %output 2>&1 | compare %f

class B{
    var x = 1
}

class A{
    func test(){return B()}
}

main(){
    var x =  [A()]
    x[return  0]
    .
    test()
    .
    x
    =
    0
   0
}
// ASSERT: scan parse_nl_warning
// ASSERT: scan sema_invalid_subscript_expr
