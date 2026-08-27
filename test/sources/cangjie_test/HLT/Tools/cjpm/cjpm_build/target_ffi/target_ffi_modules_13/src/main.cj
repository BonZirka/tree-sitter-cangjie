/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package demo

foreign func test01(): Unit

foreign func test02(): Unit

main(): Int64 {
    unsafe { test01() }
    unsafe { test02() }
    print("hello world\n")
    return 0
}
