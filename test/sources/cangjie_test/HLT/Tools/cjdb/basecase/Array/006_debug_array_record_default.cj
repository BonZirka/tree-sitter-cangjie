/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */



struct Rectangle {
    public var item1: Int64
    public var item2: Int64 = 3
    public var item3: Bool = true
    public init(item1!: Int64, item2!: Int64 = 3, item3!: Bool = true) {
        this.item1 = item1
        this.item2 = item2
        this.item3 = item3
    }
}
main() {
    sleep(Duration.millisecond*3000)
    let r1 = Rectangle(item1: 1, item2: 2, item3: true)
    let r2 = Rectangle(item3: false, item2: 5, item1: 10)
    let r3 = Rectangle(item1: 20)

    var arraymainrec01 : Array<Rectangle> = [r1, r2, r3]

    return 0
}



