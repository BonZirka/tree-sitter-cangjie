/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default
import default.pkga.*

class C8 <: A8 {
    public func name2() :Unit{}
}

public class D8 <: A8 {
    public static func name_2() :Unit{}
}

func test8() {
    var a = B8.name_2
    var b = A8.name_2()
    var c = C8().name2
    var d = D8.name_2()
}
