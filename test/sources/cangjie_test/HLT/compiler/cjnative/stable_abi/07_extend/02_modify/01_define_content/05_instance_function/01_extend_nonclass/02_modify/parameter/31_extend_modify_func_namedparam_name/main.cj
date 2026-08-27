/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import test_stable_abi.*
public class Son_TestClass {
    public prop exported_prop2: Int64 {
        get() {
            1
        }
    }
}
main() {
    let son_tc = Son_TestClass()
    if (
        son_tc.exported_prop2 == 1
    ) {
        return 0
    } else {
        return 1
    }
}

