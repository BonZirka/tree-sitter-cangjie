/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

@Differentiable
struct A {
    public var temp1: Float32
    public var temp2: Float64
}

@Differentiable
func foo(x:A){
    var count = x.temp2
    var res : Float32 = 1.0
    while (stopGradient<Float64>(count) < 5.0){
        if (stopGradient<Float64>(count) < 3.0){
            res = res * x.temp1
            count = count + 1.0
        }
        else{
            res = 2.0 * res * x.temp1
            count = count + 1.0
        }
    }
    return res
}

main(){main(){main(){main(){main(){main(){
    var x = A(temp1:1.0, temp2:0.0)

    // use grad get value
    let res1 = @Grad(foo, x)
    if (res1.temp1 >= 20.000001 || res1.temp1 <= 19.999999){
        return 1
    }
    if (res1.temp2 >= 0.000001 || res1.temp2 <= -0.000001){
        return 1
    }

    // use valWithGrad get value
    let res2 = @ValWithGrad(foo, x)
    if (res2[0] >= 4.000001 || res2[0] <= 3.999999){
        return 1
    }
    if (res2[1].temp1 >= 20.000001 || res2[1].temp1 <= 19.999999){
        return 1
    }
    if (res2[1].temp2 >= 0.000001 || res2[1].temp2 <= -0.000001){
        return 1
    }

    // use @AdjointOf get value
    let adj = @AdjointOf(foo)
    let (v, bp) = adj(x)
    let res3 = bp(1.0)
    if (v >= 4.000001 || v <= 3.999999){
        return 1
    }
    if (res3.temp1 >= 20.000001 || res3.temp1 <= 19.999999){
        return 1
    }
    if (res3.temp2 >= 0.000001 || res3.temp2 <= -0.000001){
        return 1
    }
    return 0
// ASSERT: scan parse_unexpected_declaration_in_scope
// ASSERT: scan parse_expected_right_delimiter
