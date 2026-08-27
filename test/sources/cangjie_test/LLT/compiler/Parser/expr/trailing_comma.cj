// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f

main() {
    let a = (3,4,)
    let b = [3,4,]

    foo<Int,>()
    bar(3,)

    let l = { a:Int, => }
    let h = H(a:18,).mem<Int,>
}

func foo<T,>() {}

func bar(a: Int,) {}

class H {
    H(let a!: Int = 3,) {}

    func mem<T,>(b: Int,) {}
}