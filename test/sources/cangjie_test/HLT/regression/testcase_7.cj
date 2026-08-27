/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// (not O2)RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan StackOverflowError
// ASSERT: regex-not Cangjie::CHIR::AST2CHIR::walk

main():Int64 {
    var b = Boo()
    b.m = 1
    return b.m
}

class Boo{
    public mut prop m: Int64 {
        get(){
             return m
        }
        set(input){
            func test(){return 0}
            m/= test()
        }
    }
}
