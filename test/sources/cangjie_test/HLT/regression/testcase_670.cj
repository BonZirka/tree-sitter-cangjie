/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

var b = true
let c = 53.0
 enum d {
    e
}
 class f<g, h> {
    static var j   = 89.0
    init(k  : UInt8) { 
        var l : Option<Array<Unit>> = None
        var m : Array<Unit> = Array<Unit>(0){ i => }
        try { 
            if (b) { l } else { l } 
        } finally {} ?? m}
}
func a() { 
    try { 
        f<Option<Option<d>>, Range<Int16>>.j
    } finally {}
}
func n() : Range<UInt32> { 
    if (match  {
        case _ => 
            22.0 > c
    }) { [UInt32(1)..223112141][9] } else { 38..38 } 
}
main(){}
