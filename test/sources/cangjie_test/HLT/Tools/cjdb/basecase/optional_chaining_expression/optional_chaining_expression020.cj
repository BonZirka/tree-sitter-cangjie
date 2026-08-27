/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.collection.*

class CB{
    let a1 = ArrayList<Int64>([0, 1, 2])
    let item1 = ArrayList<Int64>(a1)
    let b1 = HashSet<Int64>([0, 1, 2])
    let item2 = HashSet<Int64>(b1)
    let c1 = HashMap<String, Int64>([("a", 0), ("b", 1), ("c", 2)])
    let item3 = HashMap<String, Int64>(c1)
}

main() {
    sleep(Duration.millisecond*3000)
    var aa = Option<CB>.Some(CB())
    var bb = Option<CB>.None
    let r1 = aa?.item1
    let r2 = bb?.item1
    let r3 = aa?.item2
    let r4 = bb?.item2
    let r5 = aa?.item3
    let r6 = bb?.item3
    0
}
