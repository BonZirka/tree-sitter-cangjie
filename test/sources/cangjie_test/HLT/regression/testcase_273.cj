/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0

// ERRCHECK: %compiler %overflow_wrapping %cmp_opt %f -o %output
// ASSERT: scan sema_static_variable_use_generic_parameter

public var var_1679321714763_65 : Int8 = Int8(Int8(-2))

public open class Class_1679321714763_30<T0, T1, T2> {
    init() { // block id: 32

    }
;
    public static mut prop var_1679321714763_35 : Int8 { // block id: 36
        get() { // block id: 38
            ();
            Int8(-58);
            var_1679321714763_104
        }

        set(Value) { // block id: 43
            ((14&127)..=(99&127):((Int64(UInt32(24))|1)));
            ((Int64(UInt16(UInt8(171)))&127)..((-114)&127):((Int64(Int64(Int16(-18)))|1)));
            ();
            var_1679321714763_104 = Value
        }

    };
    static mut prop var_1679321714763_104 : Int8 { // block id: 105
        get() { // block id: 107
            (Float32(-59.0) is Int8);
            ((Int8(Int8(-122))&127)..(Int8(-68)&127):((Int64(Int32(42))|1)));
            Int8(Int8(UInt8(UInt8(128))))
        }

        set(Value) { // block id: 122
            ((Int16(-61)&127)..(Int16(91)&127):(6|1));
            ();
            ()
        }

    }
}

main(): Int64 {
    try {
        let var_1679321714763_13 : UInt32 = UInt32(225);
        ((var_1679321714763_13 as String) ?? ["""
`$mxZ
*&.K6
""", """
%mAUW
rxK}s
""", "T?j0XbOC&D", """
Va{AUh
hYodj
""", "a{=Sa{ k9)d.", ###"L;.X|I;^i;"###, "Q4i(ja+^a{[", "u-3rYc}pqy", ###"A+ea{=_a{87c"###, ###"Z(J~Gjf-/h"###][1]);
        Class_1679321714763_30<Int16, Bool, Array<String>>.var_1679321714763_35 /= ((match (Option<String>.None) {
            case caseVar_1679321714763_62 : Range<Int8> => 
                var_1679321714763_65
            
            case caseVar_1679321714763_70 : UInt16 => 
                var var_1679321714763_74 : UInt32 = UInt32(Int32(-54));
                var_1679321714763_74 *= var_1679321714763_74;
                Int8(-73);
                Int8(76)
            
            case caseVar_1679321714763_82 : Range<UInt64> => 
                var_1679321714763_65 <<= ((var_1679321714763_65) & 7);
                var_1679321714763_13;
                Int8(-16)
            
            case caseVar_1679321714763_91 : Range<Int16> => 
                var var_1679321714763_94 : UInt16 = UInt16(Int16(-5));
                var_1679321714763_94;
                Int8(46) - var_1679321714763_65
            
            case _ => 
                var_1679321714763_65
            
        }) | 1);
        (-102)
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1679321714763_13*var_1679321714763_13), 64)
        crccheck.updateBuffer(UInt64(var_1679321714763_65*var_1679321714763_65), 64)
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
