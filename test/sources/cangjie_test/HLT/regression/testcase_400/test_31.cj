/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



interface B<P,Y,Z> where X <: B<X,Y,Z>, Y <: B<X,Y,Z>, Z <: B<X,Y,Z>{}

open class C <: B<C,C,C>{}

main():Int64{
    return 0
}
// ASSERT: scan sema_undeclared_type_name
