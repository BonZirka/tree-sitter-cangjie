// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

import define.*

main() {
    sleep(Duration.millisecond*3000)
    @M8(
    let a = 1
    let b = 2
    let c = a + b
    )
    println("Hello World")
}
