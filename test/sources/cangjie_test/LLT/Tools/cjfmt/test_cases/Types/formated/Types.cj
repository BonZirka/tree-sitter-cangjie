// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

type UserId = Int64

type B<T> = A<T>

main(): Int64 {
    let uniA: Rune = r' '
    let uniB: Rune = r' '
    if (uniA != r'你') {
        return 1
    }
    if (uniB != r'好') {
        return 1
    }
    print("uniA = ${uniA}\n")
    print("uniB = ${uniB}\n")
    let a: Float16 = 3.14
    let b: Float32 = 2.4e-1
    let c: Float64 = .123e2
    let d: Float16 = 0x1.1p0
    let e: Float32 = 0x1p2
    let f: Float64 = 0x.2p4
    let g: UInt8 = 0b0001_1000
    let h: UInt64 = 0o30
    let i: UInt16 = 24
    let j: UInt32 = 0x18
    let tuplePIE = (3.14, "PIE")
    let myTuple = ((1, 2), 3)
    let t1 = (1, 2.33, r'c')
    let t2 = (1, 3.33, r'c')
    let t3 = (A(), 1)
    let t4 = (B(), 1)
    var li = List<Int64>([1, 2, 3])
    li = List<Int64>(ArrayList<Int64>([666]))
    let range1 = 0..10 : 1
    let range2 = 0..=10 : 2
    let range3 = 10..0 : -2
    let range4 = 10..=0 : -1
    let range5 = 10..0 : 1
    let range6 = 0..0 : 1
    let range7 = 0..=0 : 1
    let range8 = 0..=10 : -1
    0
}
