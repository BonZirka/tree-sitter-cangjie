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

func b(): Array<Range<UInt16>> {
    let c: (Array<Bool>,Bool) = ([], 0 is Unit)
    []
}
public func d() {
    var f: (Array<Bool>,Bool) = ([], true)
    try {
        try {
            Some(f)
        } catch (_) {
            var g: Option<(Array<Bool>,Bool)> = Option.Some(([], 0 is Option<Option<Option<Unit>>>))
            g
        }
        var a = 0
    } catch (e: Exception) {}
}

main():Int64{
    d()
    0
}