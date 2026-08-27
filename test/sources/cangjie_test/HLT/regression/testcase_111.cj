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

public var var_1659629144911_26 : Bool = false
main(): Int64 {
    try {
        let var_1659629144911_56 : (Float32, Array<Bool>, Range<Int8>, Int16, Bool, Range<Int32>, Range<UInt16>) = (Float32(Float32(60.0)), [true, false, false, true, true, true, true, false, false, false], ((Int8(Int8(Int8(-67)))&127)..(Int8(123)&127):((Int64(Int32(Int8(68)))|1))), Int16(Int8(UInt8(Int8(31)))), false, ((Int32(4)&127)..(Int32(-4)&127):((-82)|1)), ((UInt16(UInt8(Int8(124)))&127)..(UInt16(31)&127):((Int64(Int32(UInt32(211)))|1))));
        func func_1659629144911_8<T0, T1>(param_1659629144911_9 : UInt16, namedParam_1659629144911_10 ! : Int64) : Int64 { // block id: 11
            """
Ws=<t
gZT&e
""";
            if ([var_1659629144911_26, false, var_1659629144911_26, false, var_1659629144911_26, var_1659629144911_26, true, true, var_1659629144911_26, false][8]) { // block id: 38

            } else if ((UInt8(88), param_1659629144911_9, ((Int32(86)&127)..=(Int32(13)&127):((-25)|1)), [true, false, false, false, true, false, false, false, false, false], ())[3][1]) { // block id: 50

            };
            Int64(UInt16(var_1659629144911_56[3]))
        }
;
        let var_1659629144911_87 : UInt16 = UInt16(11);
        func_1659629144911_8<Range<UInt32>, Bool>(UInt16(67), namedParam_1659629144911_10 : func_1659629144911_8<Range<UInt32>, Bool>(var_1659629144911_87, namedParam_1659629144911_10 : 89))
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1659629144911_87*var_1659629144911_87), 64)
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
