/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

func foo() {
    // @throws NegativeArraySizeException
    func goo() {
        while (true) {
            try {
                throw NegativeArraySizeException("NegativeArraySizeException")
            } catch (e: NegativeArraySizeException) {
                println("Exception info: ${e}.")
                return 1
            } finally {
                continue;
            }
        }
    }
    0
}

