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

let var46 : Unit = ()
let var74 : Unit = ()
var var128 : Int8 = Int8(UInt8(UInt8(UInt8(Int8(-68)))))
public var var136 : Int16 = Int16(UInt16(UInt8(Int8(UInt8(232)))))
public var var176 : Int64 = Int64(Int16(117))
public interface Interface12<T0, T1, T2> {

}

public interface Interface11<T0> <: Interface12<Array<Option<Unit>>, Array<Unit>, Bool> {

}

public interface Interface10 <: Interface11<Rune> {

}

public interface Interface13 {

}

public open class Class7 <: Interface10 & Interface13 {
    public init() { // block id: 9

    }
;
    public static var var16 : Int8 = Int8(-65)
}


public struct Aggregate82 {
    public init() { // block id: 84

    }
;
    public let var89 : (Range<UInt8>, UInt8, Int16, UInt16, Class7, Range<UInt32>, Range<UInt64>, UInt64, UInt64) = (((UInt8(100)&127)..(UInt8(197)&127):((-92)|1)), UInt8(38), Int16(35), UInt16(28), Class7(), ((UInt32(63)&127)..(UInt32(248)&127):((4|1))), ((UInt64(201)&127)..(UInt64(51)&127):(3|1)), UInt64(197), UInt64(131))
}

public func func19<T0>(param20 : Int16) : Int8 { // block id: 21
    var var41 : ?Unit = (((Int8(100)&127)..(Int8(86)&127):((-34)|1)) as Unit);
    var var50 : ?Unit = Option<Unit>.Some(());
    (if (false) { [var41, Option<Unit>.Some(var46), var41, var50, var50, Option<Unit>.None, Option<Unit>.None, var50, var41, Option<Unit>.None] } else { [var50, Option<Unit>.Some(var46), var41, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, var50, Option<Unit>.None, Option<Unit>.Some(var46), Option<Unit>.Some(var74)] } [1] ?? var74);
    var var86 : Aggregate82 = Aggregate82();
    let var125 : Unit = ();
    match (var86.var89[4]) {
        case _ : Range<UInt16> => 
            79.0;
            (-65.0) / Float64((Int32((-115.0))) | 1);
            Int8(42)
        
        case _ : Range<UInt8> => 
            let var118 : Int8 = Int8(Int8(UInt8(142)));
            Int8(76) / ((var118) | 1)
        
        case _ => 
            var125;
            var128
        
    }
}

main(): Int64 {
    try {
        Class7.var16 |= (var136|>func19<Float64>);
        if (true) { [(), var74, (), (), (), var74, (), (), (), ()] } else { [var46, var46, (), (), (), (), var74, (), var46, var46] } [6];
        try { // block id: 170
            let var172 : Range<UInt64> = ((UInt64(199)&127)..(UInt64(106)&127):((-22)|1));
            var172;
            ((UInt16(162)&127)..=(UInt16(49)&127):(8|1));
            var176
        } finally { // block id: 179
            var176 |= var176;
            var var185 : UInt64 = UInt64(UInt64(UInt16(UInt8(194))));
            var185 = UInt64(128);
            var176 / ((var176) | 1)
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var128*var128), 64)
        crccheck.updateBuffer(UInt64(var136*var136), 64)
        crccheck.updateBuffer(UInt64(var176*var176), 64)
        crccheck.crcCheck()
        crccheck.getCrcOutput()
        ()
    } catch (e: NoneValueException) { println("Exception: NoneValueException") }

    return 0;
}

class CrcCheck {
    var buffer: Array<Int64>
    var poly: Array<Int64>
    var crc_output: Array<Int64>
    var poly_n: Int64
    var buffer_index: Int64
    var crc_output_n: Int64

    init(buffer_n: Int64, crc_n: Int64) {
        buffer_index = 0
        crc_output_n = 0
        crc_output = Array<Int64>(crc_output_n, { i => 0 })
        buffer = Array<Int64>(buffer_n, { i => 0 })
        poly_n = crc_n + 1
        if (crc_n == 32) {
            poly = [1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1]
        } else if (crc_n == 16) {
            poly = [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]
        } else if (crc_n == 8) {
            poly = [1, 0, 0, 0, 0, 0, 1, 1, 1]
        } else {
            poly = [1, 1, 0, 0, 1]
        }
    }

    func updateBuffer(input: UInt64, byte_n: Int64): Unit {
        var value = input
        if (byte_n == 64) {
            value = value & 0xffffffffffffffff
        } else if (byte_n == 32) {
            value = value & 0xffffffff
        } else if (byte_n == 16) {
            value = value & 0xffff
        } else {
            value = value & 0xff
        }
        var byteArray = Array<Int64>(byte_n, { i => 0 })
        var byte_c = 1
        var byte_index = 0
        while(value != 0) {
            if (value % 2 == 1) {
                byte_index = byte_n - byte_c
                byteArray[byte_index] = 1
            }
            byte_c++
            value = value >> 1
        }
        var i = 0
        while (i + byte_index < byte_n) {
            buffer[i + buffer_index] = byteArray[i + byte_index]
            i++
        }
        buffer_index = buffer_index + i
    }

    func crcCheck(): Unit {
        crc_output_n = buffer_index + poly_n - 1
        var crc_buffer = Array<Int64>(crc_output_n, { i => 0 })
        var i = 0
        while (i < buffer_index) {
            crc_buffer[i] = buffer[i]
            i++
        }
        i = 0
        while (i < buffer_index) {
            if (crc_buffer[i] == 1) {
                var j = 0
                while (j < poly_n) {
                    crc_buffer[j + i] = crc_buffer[j + i] ^ poly[j]
                    j++
                }
            }
            i++
        }
        let check_code = crc_buffer[buffer_index..]
        var byte_add = 3 - crc_output_n % 3
        crc_output_n = byte_add + crc_output_n
        crc_output = Array<Int64>(crc_output_n, { i => 0 })
        i = 0
        while (i < crc_output_n - byte_add) {
            if (i < buffer_index) {
                crc_output[i + byte_add] = buffer[i]
            } else {
                crc_output[i + byte_add] = check_code[i - buffer_index]
            }
            i++
        }
    }

    func getCrcOutput(): Unit {
        var i = 0
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
        print("\n")
    }
}
extend Class7 {

}

extend Aggregate82 {

}

