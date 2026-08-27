/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default
foreign func test_h2(ptr: CString): CString

func test32() {
    var str = unsafe { LibC.mallocCString("test") }
    try (csr = str.asResource()) {
        var cs = unsafe { test_h2(csr.value) }
        if (cs.toString() == "test") {
            return 0
        }
    }
    return 1
}
