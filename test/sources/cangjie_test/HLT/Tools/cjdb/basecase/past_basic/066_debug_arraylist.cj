/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */


import std.collection.*

let arraylistInt8: ArrayList<Int8> = ArrayList<Int8>([8])
let arraylistInt16: ArrayList<Int16> = ArrayList<Int16>([161, 162])
let arraylistInt32: ArrayList<Int32> = ArrayList<Int32>([321, 322, 323])
let arraylistInt64: ArrayList<Int64> = ArrayList<Int64>([641, 642, 643, 644])
var arraylistBool: ArrayList<Bool> = ArrayList<Bool>([true, false])
let arraylistTuple = ArrayList<(Int16, Bool)>([(10, true), (20, false)])
var arraylistTuple2 = ArrayList<(Int64, UInt32, Float64, String, Bool, Rune)>([(10, 20, 30.0, "bbb", true, r'd')])
let arraylistHashMap = ArrayList<HashMap<String, Int64>>([HashMap<String, Int64>([("aa", 10), ("bb", 20)])])

func test_arraylist(a:ArrayList<UInt8>) {
    return a
}

main(): Int64 {
    sleep(Duration.millisecond*3000)
    var arraylistUInt8: ArrayList<UInt8> = ArrayList<UInt8>([11, 12, 13])
    var arraylistUInt16: ArrayList<UInt16> = ArrayList<UInt16>([21, 22, 23])
    var arraylistUInt32: ArrayList<UInt32> = ArrayList<UInt32>([31, 32, 33])
    var arraylistUInt64: ArrayList<UInt64> = ArrayList<UInt64>([41, 42, 43])
    let arraylist_lambda = {a:ArrayList<Float32> =>
        a[0] + a[1]
    }(ArrayList<Float32>([32.1, 32.2]))
    let arraylistRune: ArrayList<Rune> = ArrayList<Rune>([r'a', r'b', r'c'])
    var arraylist_lambda2 = {b:ArrayList<String> =>
        b
    }(ArrayList<String>(["aaa", "abc"]))
    var arraylistArray: ArrayList<Array<UInt64>> =  ArrayList<Array<UInt64>>([[11, 12], [21, 22]])
    let arraylist_lambda3 = {c:ArrayList<Range<Int64>> =>
        c
    }(ArrayList<Range<Int64>>([0..10, 10..0 : -1]))
    let arraylistArray2: ArrayList<Array<Int64>> = ArrayList<Array<Int64>>([[10, 20], [30, 40]])
    var arraylistHashSet: ArrayList<HashSet<Float64>> = ArrayList<HashSet<Float64>>([HashSet<Float64>([1.1, 2.2, 3.3])])
    let arraylist_lambda4 = {d:ArrayList<HashSet<Float64>> =>
        d
    }(arraylistHashSet)
    test_arraylist(arraylistUInt8)
    var arraylist_lambda5 = {e:ArrayList<Bool> =>
        e
    }(arraylistBool)
    var arraylist0 = ArrayList<ArrayList<Array<HashSet<Int64>>>>.of(ArrayList<Array<HashSet<Int64>>>([[HashSet<Int64>([10, 20])]]))

    return 0
}
