/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



struct A {
// A(){}
    public a(){}    
}

class B {
// B(){}
    public a(){}    
}

struct C {
    public C(){}
    public a(){}    
}

struct D {
    public r3(){}    
}

struct E {
    public E(){}    
}

main() {
    return 1
}
// ASSERT: scan parse_expected_decl
