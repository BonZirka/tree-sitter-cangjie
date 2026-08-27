/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %overflow_wrapping %cmp_opt %f -o %output


 
interface I<T> {}
 
class A<T> where T <: I<T> {
    init() {}
}
 
func test<T>() where T <: I<T> {
    return A()
}
 
extend Int64 <: I<Int64> {}
 
main() {
    test<Int64>()
    return 0
}
// ASSERT: scan sema_unable_to_infer_generic_func


