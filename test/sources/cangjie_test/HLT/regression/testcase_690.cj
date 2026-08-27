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

var var833 : Int32 = Int32(49)
public var var838 : Float32 = Float32(-94.0)
var var850 : Rune = 'X'

public open class Class457 <: Resource {
    public init() {}
    public func isClosed(): Bool { return true }
    public func close(): Unit {}
}

func func525(param526 : Int32) : (Float32, Rune, Int64, Range<Int32>, Class457, UInt16) {
    let var612 : Int64 = Int64(UInt32(Int32(UInt8(149))));
    var var655 : Rune = 'j';
    let var651 : Float32 = Float32(Float32(-12.0));
    (var651, var655, var612, ((Int32(23)&127)..(Int32(36)&127):(((-30)|1))), Class457(), UInt16(201))
}

public func func468(namedParam469 ! : Float64, namedParam470 ! : Range<Int16>, optionalParam471 ! : Option<Int32> = (UInt32(26) as Int32)) : (Float32, Rune, Int64, Range<Int32>, Class457, UInt16) {
    try { 
        Int32(1)|>func525
    } catch (e: Exception) {
        try (resource = Class457()) { 
            var833 <<= ((var833) & 7);
            // var838 %= Float32((Int32(Float32(-83.0))) | 1)
        } catch (e: Exception) {
            var var844 : Int64 = (-83);
            var844 |= (-83)
        };
        var var858 : Class457 = Class457();
        (var838, var850, 75, ((var833&127)..(var833&127):(((-114)|1))), var858, UInt16(154))
    } finally {
    }
}

main(): Int64 {
    return 0;
}
