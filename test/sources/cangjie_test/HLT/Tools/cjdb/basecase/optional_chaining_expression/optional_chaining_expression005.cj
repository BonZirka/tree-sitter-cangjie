/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

open class C1{
    var aa = r'A'
}

class C2 <: C1{
    var item = 1.0
}

main() {
    sleep(Duration.millisecond*3000)
    var a1 = C2()
    let b1 = Option<C2>.Some(a1)
    let b2 = Option<C2>.None
    let r1 = b1?.item
    let r2 = b2?.item
    let r3 = b1?.aa
    let r4 = b2?.aa
    0
}
