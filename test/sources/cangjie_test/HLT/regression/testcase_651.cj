/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

public var var11 : Float64 = Float64(Float64(Float64(Float64(79.0))))

main(): Int64 {
    var loopTimeVar19 : Range<UInt64> = (UInt64(UInt64(153))..=UInt64(Int16(Int8(-27))):(Int64(UInt8(223))|1));
    for (i in loopTimeVar19 where true) {
        var11 **= Float64(Int32(var11) & 3);
        ()
    };
    return 0;
}
// ASSERT: scan chir_typecast_overflow

