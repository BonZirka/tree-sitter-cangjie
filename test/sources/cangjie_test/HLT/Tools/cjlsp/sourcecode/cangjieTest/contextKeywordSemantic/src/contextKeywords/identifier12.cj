/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.contextKeywords

enum E2{
    override12
}

enum E3<T>{
    AB(T) |redef12(T)|abstract12(T) |XY
}

func test12(){
    var d1 = E3<Int64>.abstract12(8)
    var d2 = E2.override12
    var d3 = E3<Float64>.XY
}
