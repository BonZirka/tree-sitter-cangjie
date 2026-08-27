/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

var a : UInt8 = 0
main(){
    try {
        let b = ""
        func c<d>(f : UInt8) { 
            try { 
                b
            } finally {}
        }
        if (false) { c<Range<Int8>>(a) } else { c<Range<Int8>>(a) } } catch (e: NoneValueException) { println() }
    0}
class g {
    var buffer: Array<Int64>
    var h: Array<Int64>
    var i: Array<Int64>
    var j: Int64
    var k: Int64
    var l: Int64
    init(m: Int64) {
        k = 0
        l = 0
        i = Array()
        buffer = Array()
        j = 1
        if (m == 2) {
            h = Array()
        } else {
            h = [1]
        }
    }
}
