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

var a = "^XiGSC&5AX" is Rune
let b = false
var c = 5
var d = 64.0 is Rune
var e: ?f = None
var g: Option<Unit> = None
var h = ()
var i: Array<Range<UInt64>> = []
interface f {}
func j() {
    match {
        case _ => c <= 2
    }
}
func k(): Option<Option<f>> {
    var l = 0 as f
    if (j()) {
        try {
            if (false) {
                e
            } else {
                None
            }
        } catch (_) {
            l
        }
    } else {
        match {
            case _ => if (d) {
                    None
                } else {
                    None
                }
        }
    }
}
func m() {
    match {
        case _ => i
    }[5]
    try {
        if (b) {
            g
        } else {
            Option<Unit>.None
        }
    } catch (_) {
        try {
            Some(h)
        } finally {}
    }
}
main() {}
