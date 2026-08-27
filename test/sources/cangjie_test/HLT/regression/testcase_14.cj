// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


class A<a>{
    public func test<A>(x:A) where A <: A {x}
}


main(){
    A<Int64>().test//*ue)
    0
}
// ASSERT: scan sema_generic_func_without_type_arg

/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 