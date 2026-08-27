/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



class A<T>{}

interface I<T> where T<:A<T> {}

main(){
var i :?I<A>
return 0
}
// ASSERT: scan sema_generic_type_without_type_argument


