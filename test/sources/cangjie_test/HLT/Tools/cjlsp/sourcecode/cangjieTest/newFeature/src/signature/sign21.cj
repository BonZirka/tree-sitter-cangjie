/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.signature

class Pair<T1,T2> {
    var first:T1
    var second:T2
    init(a:T1,b:T2){
        first = a
        second = b
    }
    func equals1(other:T1):Bool {
        return true
    }
}

var u1 = Pair<Int64, Int64>(12,45)
var u2 =u1.equals1(65)
