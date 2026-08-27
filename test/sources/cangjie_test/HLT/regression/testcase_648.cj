/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



@Differentiable
func foo(x:Float64,y:Float64){
    return x : y
}


func goo(x:Float64, y:Float64){
    let temp = @Grad(foo,x,y) 
    print("gradout_1 = ")
    print(temp[0].toString())
    print("gradout_1 = ")
    print(temp[1].toString())
    return temp
}

main(){
    let a = goo(1.0,2.0)
    return 0
// ASSERT: scan parse_expected_operator_or_end
// ASSERT: scan parse_expected_right_delimiter
