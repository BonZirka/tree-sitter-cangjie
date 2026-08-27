/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


erentiable
f
@Diffunc foo(x:Float64){
    return x
}

main(){
    let a = 1.0
    if (@ValWithGrad(foo,a) > 1.0){ 
        print("true")
    } else{
        print("false")
    }
    return 0
}
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_illegal_macro_expand_input_args_without_paren


