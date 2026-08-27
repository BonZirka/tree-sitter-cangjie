/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
public let var_1691786195655_30 : UInt64 = UInt64(1)
let var_1691786195655_37 : UInt32 = UInt32(113)
public var var_1691786195655_69 : Int64 = Int64(-110)
const var_1691786195655_108 : Int = -47


main(): Int64 {
    try {
        var var_1691786195655_23 : ?Int32 = Option<Int32>.Some(Int32(-72));
        const var_1691786195655_34 : UInt16 = 153;
        (match (Int32(-29)) {
            case _ => 
                ();
                let var_1691786195655_17 : Int = Int64(-17);
                var var_1691786195655_20 : UInt = UInt64(37);
                var_1691786195655_17 ** var_1691786195655_20;
                var_1691786195655_23
            
        } ?? (var_1691786195655_30, (), var_1691786195655_34, var_1691786195655_37, Int32(-36), Int64(-58))[4]);
        try { // block id: 43
            UInt16(221)
        } finally { // block id: 45
            var_1691786195655_37;
            var_1691786195655_34 + var_1691786195655_34;
            UInt16(222)
        };
        let var_1691786195655_85 : Bool = (UInt8(28) is Float64);
        (Option<Int64>.Some(Int64(-122)) ?? match (Option<Int64>.None) {
            case _ : UInt8 => 
                const var_1691786195655_66 : Int32 = -8;
                Int32(22) ^ var_1691786195655_66;
                var_1691786195655_69
            
            case _ => 
                var_1691786195655_69 | var_1691786195655_69
            
            case caseVar_1691786195655_79 : UInt8 => 
                var_1691786195655_69++;
                let var_1691786195655_91 : Int32 = Int32(55);
                if (var_1691786195655_85) { var_1691786195655_23 } else { Option<Int32>.Some(var_1691786195655_91) } ;
                Int64(-100)
            
            case caseVar_1691786195655_96 => 
                var var_1691786195655_104 : Int32 = Int32(46);
                (var_1691786195655_30, (), UInt16(164), var_1691786195655_37, var_1691786195655_104, Int64(-57));
                var_1691786195655_108
            
            case _ => 
                Int64(47)
            
        })
        // CRC kheck All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1691786195655_30*var_1691786195655_30), 64)
        crccheck.updateBuffer(UInt64(var_1691786195655_34*var_1691786195655_34), 64)
        crccheck.updateBuffer(UInt64(var_1691786195655_37*var_1691786195655_37), 64)
        crccheck.updateBuffer(UInt64(var_1691786195655_69*var_1691786195655_69), 64)
        crccheck.updateBuffer(UInt64(var_1691786195655_108*var_1691786195655_108), 64)
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



