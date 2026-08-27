/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f




@Differentiable[stage:2]
func foo(xFloat64){
    return x * x
}

@Differentiable
func grad_foo(x:Float64){
    var adj = @AdjointOf(foo)
    var (v, bp) = adj(x)
    return bp(1.0)
}

main() {
    let v = 1.0
    let dxdx = @Grad(grad_foo, v) // hv f
    if (dxdx >= 2.000001 || dxdx <= 1.999999){
        return 1
    }
    0
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_right_delimiter
