/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %overflow_wrapping %cmp_opt %f -o %output

let a = false
let b = Int8(2)
let d: (Unit,Range<Int8>,Array<Float32>,Range<UInt8>) = ((), 127..12, [], 127..52)
let g: Array<Option<Bool>> = []
var h: Int8 = 0
interface i {}
interface k {}
struct j {
    func ag<ah, ai, aj>(ak: (Unit,Range<Int8>,Array<Float32>,Range<UInt8>), al!: (i) -> Option<Bool>, am!: Int16) {}
    init() {
        let ar = l
        func at() {
            func au() {
                ag<UInt16, k, Option<i>>(
                    try {
                        d
                    } finally {},
                    al: ar,
                    am: 0
                )
            }
            au
        }
        func av() {
            at
        }
        av
    }
}
func l(c: i) {
    g[4]
}
func bg(): Option<Int8> {
    if (try {
        var bi = false
        bi
    } catch (e: Exception) {
        false
    }) {
        h
    } else {
        match ({=>}) {
            case f => if (a) {
                    None
                } else {
                    b
                }
        }
    }
}
main() {}
// ASSERT: scan sema_illegal_capture_this


