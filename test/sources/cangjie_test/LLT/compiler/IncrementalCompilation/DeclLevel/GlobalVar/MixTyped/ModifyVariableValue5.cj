// DEPENDENCE: %n.txt
// EXEC: %compiler %incrementalCompile %n.cj -o %output
// EXEC: %run %run_opt %output %run_args
// EXEC: %cpfile %n.txt %n.cj
// EXEC: %compiler %incrementalCompile %n.cj -o %output 2>&1 && cat .cached/*.log | compare %f
// ASSERT: scan incremental compilation triggered
// ASSERT: scan the changed decl after Spreading is:c in file ModifyVariableValue5.cj in line 17 in column 5
// EXEC-1: %run %run_opt %output %run_args

func foo(a:Int64):(Int64, Int64){
    return (a, a)
}
func fuzz(a:Int64):(Int64, Int64, Int64){
    return (a, a, a)
}
var c:Int64 = foo(0)[0] + foo(0)[1]
main():Int64{
    return c
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
