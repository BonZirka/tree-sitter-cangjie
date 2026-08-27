/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

struct C1<T> {
    public static let a: Int32 = 0
    public func funcdemo1(): Unit {
        return
    }
    func funcdemo2(a: Int32, b: T): Int32 {
        var num3: T = b
        return a
    }
    protected func funcdemo3(a: T, b!: Int32 = 1): Int32 {
        var num4: T = a
        return b
    }
    public func foo(a: T): T {
        return a
    }
    public static func foo1(b: T): Int32 {
        return a
    }
}


main() {
    sleep(Duration.millisecond*3000)
    var newc1 = C1<Int64>()
    var main_num1 = newc1.funcdemo1()
    var main_num2 = C1<Int64>.foo1(2)
    var main_num3 = newc1.funcdemo2(1, 2)
    var main_num4 = newc1.funcdemo3(1, b: 6)
    var main_num5 = C1<Int64>().foo
    return 1
}
