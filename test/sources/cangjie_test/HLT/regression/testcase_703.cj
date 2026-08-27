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

public var var_1658861502751_57 : (UInt16, String, Float32) = (UInt16(UInt16(69)), """
R0#i>
XS?2/
""", Float32(Float32(-110.0)))
var var_1658861502751_66 : UInt8 = UInt8(40)
public var var_1658861502751_73 : Array<Int64> = [34, 19, (-79), 73, (-25), (-6), 63, 70, (-77), (-30)]

main(): Int64 {
    try {
        let var_1658861502751_29 : UInt64 = UInt64(UInt32(156));
        let var_1658861502751_33 : Array<Array<Unit>> = [[(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()], [(), (), (), (), (), (), (), (), (), ()]];
        let var_1658861502751_41 : String = """
^TrUD
frRK>
""";
        func func_1658861502751_10<T0>(param_1658861502751_11 : UInt8) : String { // block id: 12
            (var_1658861502751_29, var_1658861502751_33)[1][4][9];
            try { // block id: 39
                var_1658861502751_41
            } finally { // block id: 43
                (Option<String>.None ?? var_1658861502751_41);
                UInt32(36) - UInt32(99);
                var_1658861502751_57[1]
            }
        }
;
        if (false) { func_1658861502751_10<Range<Int8>>(var_1658861502751_66) } else { func_1658861502751_10<Range<Int8>>(var_1658861502751_66) } ;
        var_1658861502751_73[3]
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1658861502751_29*var_1658861502751_29), 64)
        crccheck.updateBuffer(UInt64(var_1658861502751_66*var_1658861502751_66), 64)
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
