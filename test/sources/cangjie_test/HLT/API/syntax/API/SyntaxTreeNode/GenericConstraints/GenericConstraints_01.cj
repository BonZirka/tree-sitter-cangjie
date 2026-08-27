/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

func foo<T, U, V, W>() where T <: ToString, U <: C1 & C2, V <: C1<T> & C2<T, U>, W <: C2<X, Y> {}
