/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package mp

public specific class A {
    private specific func f(): Int64 { 0 }
    public specific var a: Int64 = 1
    public static specific var b: Int64 = 2
}

protected specific class A2 {
    protected specific func f(): Int64 { 1 }
    static private specific func f2(): Int64 { 3 }
}

public func test_plat() { A().f(0) }
