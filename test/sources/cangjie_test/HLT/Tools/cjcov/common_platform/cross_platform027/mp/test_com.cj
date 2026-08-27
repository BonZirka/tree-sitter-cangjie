/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package mp

public common enum A<T,R> {
    | M
    public common func f1(a: T,b: R): T
    public static func f2(a: T,b: R) {
        var c1 = a
        var c2 = b
    }
}
