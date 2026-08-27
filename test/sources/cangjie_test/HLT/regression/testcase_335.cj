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

public let var_1687903361591_10 : Unit = ()
public let var_1687903361591_32 : Bool = (() is Bool)
public var var_1687903361591_49 : Bool = ('t' is Float64)
public let var_1687903361591_55 : Int16 = Int16(Int16(Int16(UInt8(Int8(74)))))
public var var_1687903361591_78 : UInt16 = UInt16(UInt8(Int8(48)))
var var_1687903361591_116 : Option<Int64> = Option<Int64>.None
public var var_1687903361591_123 : UInt64 = UInt64(240)
public var var_1687903361591_131 : Float32 = Float32(Float32(-97.0))

func func_1687903361591_138(param_1687903361591_139 : Int16) : Int64 { // block id: 140
    83 ** try { // block id: 144
        ();
        UInt8(173);
        var_1687903361591_123
    } catch (e: Exception) { // block id: 148
        UInt64(16)
    }
}

public func func_1687903361591_26() : Int64 { // block id: 27
    let var_1687903361591_39 : Rune = '2';
    var var_1687903361591_70 : Int8 = Int8(70);
    var loopTimeVar_1687903361591_91 : Int64 = 0;
    while (((if (var_1687903361591_32) { // block id: 35
        if (var_1687903361591_32) { var_1687903361591_39 } else { var_1687903361591_39 } ;
        let var_1687903361591_43 : Int16 = Int16(103);
        var_1687903361591_43
    } else if (var_1687903361591_32) { // block id: 46
        var_1687903361591_49 ||= true;
        var_1687903361591_55 >> ((Int16(-124)) & 7)
    } else { // block id: 62
        var_1687903361591_55
    } is UInt8)) && loopTimeVar_1687903361591_91 < 100 ) {
        loopTimeVar_1687903361591_91++;
        if (true) { // block id: 67
            var_1687903361591_70 = var_1687903361591_70;
            var_1687903361591_39
        } else if (var_1687903361591_49) { // block id: 75
            var_1687903361591_78 *= UInt16(212);
            'd'
        } else { // block id: 84
            UInt16(103) ^ var_1687903361591_78;
            var_1687903361591_10;
            var_1687903361591_39
        }
    };
    try { // block id: 93
        var_1687903361591_10;
        let var_1687903361591_101 : Option<Int64> = (UInt64(UInt64(13)) as Int64);
        var_1687903361591_101.getOrThrow()
    } finally { // block id: 105
        try { // block id: 107

        } finally { // block id: 108
            var_1687903361591_70 <<= ((Int8(-124)) & 7);
            ();
            ()
        };
        match (var_1687903361591_116) {
            case _ => 
                var_1687903361591_123 <<= ((var_1687903361591_123) & 7)
            
            case _ => 
                Float32(-115.0) * var_1687903361591_131;
                var_1687903361591_49 ||= false
            
        };
        Int16(6)|>func_1687903361591_138
    }
}

main(): Int64 {
    try {
        try { // block id: 7

        } catch (e: Exception) { // block id: 8
            var_1687903361591_10;
            var var_1687903361591_14 : UInt8 = UInt8(176);
            var_1687903361591_14 &= var_1687903361591_14;
            ()
        } finally { // block id: 18
            var var_1687903361591_21 : Int64 = (-78);
            var_1687903361591_21 ^= var_1687903361591_21;
            ()
        };
        func_1687903361591_26()
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1687903361591_123*var_1687903361591_123), 64)
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
