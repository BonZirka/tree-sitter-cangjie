/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 

var var_1679169997488_33 : Bool = false
func func_1679169997488_7<T0, T1, T2>(param_1679169997488_8 : Rune) : Bool { // block id: 9
    try { // block id: 24
        let var_1679169997488_28 : String = ###"[V2@]r-0X-"###;
        if (false) { var_1679169997488_28 } else { """
J@${var_1679169997488_28}w${var_1679169997488_28}}d
}a{a{NK
""" } ;
        var_1679169997488_33 ||= var_1679169997488_33;
        [[true, false, false, true, true, false, true, true, true, true], [false, true, true, false, true, false, true, false, false, false], [true, true, false, false, true, false, false, false, false, false], [true, false, true, false, true, true, true, true, false, false], [true, false, true, true, false, false, true, false, false, true], [true, false, true, true, false, true, false, false, false, false], [false, false, false, true, true, true, false, false, true, true], [true, true, false, true, false, true, false, true, false, false], [false, false, true, false, true, true, false, false, true, true], [true, true, false, true, false, false, false, false, false, true]]
    } catch (e: Exception) { // block id: 37
        ((UInt8(170)&127)..=(UInt8(133)&127):((-90)|1));
        [[false, true, false, false, true, false, true, true, true, false], [false, true, false, true, false, true, false, false, true, false], [false, false, true, false, false, true, true, false, true, true], [true, false, true, true, false, false, false, true, false, false], [false, false, true, false, false, true, true, true, true, true], [true, true, true, true, true, true, false, true, true, true], [true, false, true, true, true, false, false, false, true, true], [false, true, false, false, false, false, true, false, true, false], [true, false, true, false, false, false, false, true, true, true], [true, false, false, true, true, true, false, false, false, false]]
    } finally { // block id: 40
        let var_1679169997488_42 : Array<Array<Bool>> = [[false, true, false, false, false, false, true, false, true, true], [true, true, true, true, false, false, false, false, false, true], [false, true, false, true, false, false, false, true, true, false], [true, false, true, true, true, false, false, true, false, true], [false, true, false, true, true, true, true, true, true, false], [false, false, true, true, true, false, true, false, false, false], [false, true, true, false, false, false, true, false, false, false], [false, false, false, false, true, false, true, true, true, true], [false, false, false, true, true, false, true, false, true, false], [true, true, true, true, true, false, false, true, false, true]];
        var_1679169997488_42
    }[8][9]
}


main(): Int64 {
    try {
        let var_1679169997488_48 : Rune = 'o';
        var loopTimeVar_1679169997488_60 : Int64 = 0;
        do {
            loopTimeVar_1679169997488_60++;
            var var_1679169997488_53 : UInt32 = UInt32(Int16(UInt8(UInt8(126))));
            var_1679169997488_53 ^= var_1679169997488_53
        } while (((var_1679169997488_48|>func_1679169997488_7<Int64, String, Array<Array<Bool>>>)) && loopTimeVar_1679169997488_60 < 100 ) ;
        ((UInt8(114)&127)..=(UInt8(131)&127):((-102)|1));
        var var_1679169997488_69 : Option<Int64> = Option<Int64>.None;
        let var_1679169997488_98 : (UInt32, UInt16, Int64, Array<Bool>) = (UInt32(Int8(UInt8(125))), UInt16(202), (-128), [true, (() is UInt16), false, false, (((UInt8(118)&127)..(UInt8(102)&127):((94|1))) is Range<UInt32>), true, ([[false, false, true, true, false, false, false, true, true, true], [false, true, false, true, false, false, false, false, true, true], [false, true, false, false, true, true, true, true, false, false], [true, false, false, false, false, true, false, false, true, false], [false, false, false, true, false, true, true, false, true, false], [false, true, false, true, true, true, false, true, false, true], [false, false, true, false, true, true, true, true, false, true], [true, false, false, false, true, true, false, true, true, true], [true, false, false, false, true, true, true, true, false, false], [false, false, true, true, false, false, false, true, false, false]] is Range<Int8>), false, false, (Int8(91) is Float32)]);
        (match (var_1679169997488_69) {
            case _ : Int64 => 
                if (false) { Option<Int64>.None } else { var_1679169997488_69 } 
            
            case _ => 
                var var_1679169997488_82 : Int32 = Int32(-60);
                var_1679169997488_82 -= Int32(51);
                let var_1679169997488_91 : Int64 = Int64(UInt8(UInt8(229)));
                if (true) { Option<Int64>.Some((-119)) } else { Option<Int64>.Some(var_1679169997488_91) } 
            
        } ?? var_1679169997488_98[2])
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
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
