/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

let b = 8
let c: UInt32 = 0
class d {
    var ae: (Int16,String,Unit) = (9, "", ())
}
struct f {
    var af = true
    var ai: (Range<Int64>,Option<Int32>,Range<UInt16>) = (0..0, None, 195..1071)
    func aj(ak: Int64, a!: Range<Int8> = 123..8) {
        d()
    }
    init() {
        an(
            if (try {
                2 < b
            } catch (_) {
                true
            }) {
                if (af) {
                    None
                } else {
                    Some(6)
                }
            } else {
                ai[1]
            },
            ao: aj(7).ae
        )
        var ap = 0
    }
}
func an(aq: Option<Int32>, ao! : (Int16,String,Unit)) {}
func ar(g: UInt32): Float32 {
    c |> {
        h: UInt32 => ar(
        try {
            [UInt32(8)]
        } catch (e: Exception) {
            [UInt32(8)]
        }[5]
    )
    }
}
main() {
    f()
    0
}
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_idx_out_of_bounds
