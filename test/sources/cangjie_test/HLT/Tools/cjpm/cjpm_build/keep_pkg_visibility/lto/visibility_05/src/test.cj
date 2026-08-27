// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package b

internal import aoo.*

public func testb(): Int64 {
    print("hello world\n")
    println(pp)
    return 0
}

foreign func test01(): Unit
foreign func test02(): Unit

main() {
    unsafe { test01() }
    unsafe { test02() }
    return 0
}