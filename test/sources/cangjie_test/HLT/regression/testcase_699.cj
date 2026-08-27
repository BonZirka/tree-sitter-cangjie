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
var a: Array<Option<Int8>> = []
let b = Int32(2)
let c = 8
struct d {}
interface f {}
class h<i, g> {}
main() {
    try {
        func j<i, g>(k!: Option<Int8> = None, l!: Range<Int32> = 127..9, m!: d, o!: Int8 = 0): h<Int16, f> {
            h()
        }
        func n() {
            let t = ""
            try {
                func p<i>(q: Int32) {
                    a[2].getOrThrow()
                }
                p<Bool>(b)
                match {
                    case _ => ""
                }
            } catch (_) {
                [127..127, 0, c, c, 0, (Int32(0) & 127)..62, c][6]
                [127..127, 0, c, c, 0, (Int32(0) & 127)..62, c][6]
            }
            j<Int8, Int16>(m: d())
        }
        n()
        match (0) {
            case r => let s: Int64
        }
    } catch (e: NoneValueException) {}
}
