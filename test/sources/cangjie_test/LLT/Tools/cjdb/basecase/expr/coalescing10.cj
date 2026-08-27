/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum E1{XY|XY2}

enum E2<T> {AB(T)}

main(){
    let v1 = Option<E1>.Some(E1.XY)
    let v2 = Option<E1>.None
    let v3 = Option<E2<Int64>>.Some(E2<Int64>.AB(2))
    let v4 = Option<E2<Int64>>.None

    var r1 = v1 ?? E1.XY2
    var r2 = v2 ?? E1.XY2
    var r3 = v3 ?? E2<Int64>.AB(1) //expr v3 ?? E2<Int64>.AB(1)
    var r4 = v4 ?? E2<Int64>.AB(3) //expr v4 ?? E2<Int64>.AB(3)
    0
}