/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
//EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


func train(input: Float32, label: Float32): Float32
{
    return input + label
}

func test(fun: (Float32, Float32) -> Float32, input: Float32, label: Float32): Float32
{
    return fun(input, input2, label)
}

main()
{
    let input: Float32 = 1.0
    let label: Float32 = 1.0
    let out = test(train, input, label)
    print([out])
    0
}
// ASSERT: scan sema_wrong_number_of_arguments
