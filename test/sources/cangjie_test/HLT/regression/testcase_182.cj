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

public var var_1666020067595_31 : Bool = (((UInt32(141)&127)..(UInt32(196)&127):(((-64)|1))) is Range<UInt8>)
var var_1666020067595_91 : Int64 = Int64(Int32(Int32(Int32(-110))))
var var_1666020067595_118 : UInt64 = UInt64(195)
public enum Enum_1666020067595_7 {
    defaultValue
}

main(): Int64 {
    try {
        let var_1666020067595_26 : Array<UInt64> = [UInt64(170), UInt64(198), UInt64(59), UInt64(234), UInt64(53), UInt64(237), UInt64(254), UInt64(34), UInt64(162), UInt64(115)];
        var var_1666020067595_58 : Array<Option<Int64>> = [Option<Int64>.Some(Int64(UInt32(155))), Option<Int64>.None, (((Int8(-122)&127)..=(Int8(122)&127):((-51)|1)) as Int64), Option<Int64>.None, Option<Int64>.None, Option<Int64>.Some(Int64(Int32(UInt8(134)))), Option<Int64>.None, Option<Int64>.None, Option<Int64>.None, Option<Int64>.None];
        let var_1666020067595_78 : Option<Int64> = Option<Int64>.None;
        var var_1666020067595_110 : Int64 = 106;
        match (match ([(), (), (), (), (), (), (), (), (), ()][7]) {
            case _ => 
                var_1666020067595_26;
                ();
                if (var_1666020067595_31) { Enum_1666020067595_7.defaultValue } else { Enum_1666020067595_7.defaultValue } 
            
        }) {
            case _ => 
                Int8(-119);
                let var_1666020067595_44 : Int64 = Int64(UInt8(158));
                var_1666020067595_44 ** UInt64(246)
            
        } % (((if (var_1666020067595_31) { var_1666020067595_58 } else { [var_1666020067595_78, Option<Int64>.Some((-50)), var_1666020067595_78, Option<Int64>.None, Option<Int64>.Some(70), Option<Int64>.None, var_1666020067595_78, Option<Int64>.None, Option<Int64>.Some(var_1666020067595_91), Option<Int64>.None] } [4] ?? try { // block id: 101
            [var_1666020067595_91, var_1666020067595_91, var_1666020067595_91, var_1666020067595_91, var_1666020067595_91, var_1666020067595_91, var_1666020067595_110, 52, var_1666020067595_110, var_1666020067595_91]
        } finally { // block id: 115
            var_1666020067595_118++;
            [93, 52, 111, (-73), (-86), 111, (-40), (-121), 10, (-89)]
        }[7])) | 1)
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1666020067595_91*var_1666020067595_91), 64)
        crccheck.updateBuffer(UInt64(var_1666020067595_110*var_1666020067595_110), 64)
        crccheck.updateBuffer(UInt64(var_1666020067595_118*var_1666020067595_118), 64)
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

    func getCrcOutput(): Int32 {
        var i = 0
        var res = ""
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            res = res + hex_value.toString()
            i = i + 3
        }
        print("\n")
        if ( res == "13642257444510446650004636" ){
            return 0
        }
        return 1
    }
}
