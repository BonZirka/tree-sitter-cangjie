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

let a : Option<(Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool)> = 0 as (Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool)
let b = ()
let c : (Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool) = (127..98, 4, (4, ()), false, 4, true)
 class d {}
func f<o, j>() : (Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool) { 
    var g = 0 is Unit
    if (try { 
        g
    } finally {}) { try { 
        var h : Option<(Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool)> = 0 as (Range<Int32>, Int8, (Int16, Unit), Bool, Int8, Bool)
        h
    } catch (_) { 
        a
    } ?? (127..5, 0, (7, b), g, 3, true) } else { c } 
}
struct i<o, j> {
    let n : (Unit, Range<Int16>, Rune, Option<d>) = ((), 127..7701, r'L', None)
}
main(){
    try {
        func k<o>() { 
            f<UInt32, i<Int16, Range<Int32>>>
            var l : Range<UInt64> = 127..155
            try { 
                127..127
            } catch (_) { 
                var m = 0 is Float64
                if (m) { l } else { 127..196 } 
            }|>{ p : Range<UInt64> => }
        }
        k<Option<Int32>>()} catch (e: NoneValueException) {}
    }
