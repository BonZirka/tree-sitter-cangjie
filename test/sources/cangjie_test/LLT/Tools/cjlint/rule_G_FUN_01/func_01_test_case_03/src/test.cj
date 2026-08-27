// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

func foo() {
    var a = 1
    var b = 1
    var c = 1
    var d = 1
    var e = 1
    var f = 1
    var g = 1
    var h = 1
    var i = 1
    var j = 1
    var k = 1
    var l = 1
    var m = 1
    var n = 1
    var o = 1
    var p = 1
    var q = 1
    var r = 1
    var s = 1
    var t = 1
    var u = 1
    var v = 1
    var w = 1
    var x = 1
    var y = 1
    var z = 1
    if (a + b + c > 2) {
        return d + e + f
    }
    if (a + b + c < 3) {
        return g + h + i
    }
    while (a == 1) {
        a -= 1
        b += 1
        c *= 2
        d /= 1
        e = a + b + c + d
        f = a + b - c - d
        g = a + b - c + d
        h = 0
        i = a * b + c - d
        j = a - b + c + d
        k = a - b - c - d
    }
    match (a) {
        case 1 => println(a + b + c + d + e + f + g + h)
        case 2 => println(i + j + k + l + m + n + o + p)
        case 3 => println(q + r + s + t + u + v + w + x)
        case _ => println(y + z)
    }
    return a + b + c + d + e + f + g + h
}