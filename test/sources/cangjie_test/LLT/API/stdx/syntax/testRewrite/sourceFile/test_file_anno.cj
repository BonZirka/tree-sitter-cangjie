/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@When[cjc_version < "0.18.6"]
func foo() {
    println("cjc_version is less than 0.18.6")
}
@When[cjc_version >= "0.18.6"]
func foo() {
    println("cjc_version is greater than or equal to 0.18.6")
}

main() { // block
    foo()
}