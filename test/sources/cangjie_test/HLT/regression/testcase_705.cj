/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output




main(): Int64 {
    var a = C<Int32>() 
    return 0
}

interface B<T> {
    func foo(x:Int32){return 1}
}

class C<T> <: B<T>{
    public func foo(x:T){return .2}
}
// ASSERT: scan sema_generic_instantiation_causes_ambiguous_functions


