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

public var var_1663107043977_28 : UInt32 = UInt32(Int32(96))
let var_1663107043977_37 : String = ###"sAU5ba{mcDG"###
var var_1663107043977_155 : Int32 = Int32(-49)
var var_1663107043977_161 : Int64 = 68
func func_1663107043977_75<T0, T1, T2>(param_1663107043977_76 : Float32) : Unit { // block id: 77

}


main(): Int64 {
    try {
        func func_1663107043977_57(param_1663107043977_58 : UInt16, param_1663107043977_59 : String, param_1663107043977_60 : Float32, param_1663107043977_61 : Int16) : Unit { // block id: 62

        }
;
        let var_1663107043977_100 : UInt8 = UInt8(198);
        func func_1663107043977_14<T0, T1>(optionalParam_1663107043977_15 ! : Bool = ((UInt8(184) is Unit) is Float64), optionalParam_1663107043977_19 ! : Int16 = Int16(3), optionalParam_1663107043977_21 ! : Rune = r'w') : Bool { // block id: 23
            var var_1663107043977_34 : String = "Vd}2D!\"oJ\\";
            let var_1663107043977_40 : Unit = ();
            let var_1663107043977_66 : Float32 = Float32(Float32(49.0));
            let var_1663107043977_79 : (Float32) -> Unit = { lambdaParameter_1663107043977_82 : Float32 =>  };
            if (if ((var_1663107043977_28 is Unit)) { // block id: 31
                var_1663107043977_34 = var_1663107043977_37;
                var_1663107043977_40;
                optionalParam_1663107043977_15
            } else if (optionalParam_1663107043977_15) { // block id: 44
                if (true) { optionalParam_1663107043977_21 } else { optionalParam_1663107043977_21 } ;
                false || false
            } else { // block id: 52
                Float32(23.0);
                false
            }) { // block id: 55
                func_1663107043977_57(UInt16(30), var_1663107043977_37, var_1663107043977_66, optionalParam_1663107043977_19);
                if (optionalParam_1663107043977_15) { r'I' } else { r'5' } ;
                Float32(-10.0)|>var_1663107043977_79
            };
            true;
            var var_1663107043977_120 : Int8 = Int8(UInt8(153));
            (((optionalParam_1663107043977_19, UInt32(235), Option<String>.Some("Z$.${var_1663107043977_34}U9${var_1663107043977_34}OA-y3"), var_1663107043977_100, ###"|6,${var_1663107043977_34}M:${var_1663107043977_34}VXa{n${var_1663107043977_34}$${var_1663107043977_34}"###, (-28), optionalParam_1663107043977_21)[2] ?? if (true) { // block id: 108
                if (optionalParam_1663107043977_15) { var_1663107043977_34 } else { var_1663107043977_34 } 
            } else if (true) { // block id: 114
                var_1663107043977_40;
                "JmG2f^7t7_"
            } else { // block id: 117
                var_1663107043977_120 <<= ((Int8(-82)) & 7);
                if (optionalParam_1663107043977_15) { var_1663107043977_37 } else { "f%FEYULZJ+" } ;
                if (true) { var_1663107043977_34 } else { ###"M\\r}K108`X"### } 
            }) is Int64)
        }
;
        func func_1663107043977_7<T0>(namedParam_1663107043977_8 ! : Bool, namedParam_1663107043977_9 ! : UInt64, optionalParam_1663107043977_10 ! : Int32 = Int32(-82)) : Bool { // block id: 12
            let var_1663107043977_133 : Int16 = Int16(UInt16(Int16(-6)));
            func_1663107043977_14<UInt8, Bool>(optionalParam_1663107043977_19 : var_1663107043977_133)
        }
;
        let var_1663107043977_146 : Int16 = Int16(Int8(-42));
        var var_1663107043977_151 : Unit = ();
        if (func_1663107043977_7<String>(namedParam_1663107043977_8 : false, namedParam_1663107043977_9 : UInt64(117))) { // block id: 139
            let var_1663107043977_141 : Unit = ();
            var_1663107043977_141;
            ()
        } else if (func_1663107043977_14<UInt8, Bool>(optionalParam_1663107043977_19 : var_1663107043977_146)) { // block id: 149
            var_1663107043977_151;
            var_1663107043977_155 = Int32(-1)
        };
        try { // block id: 159
            var_1663107043977_161
        } finally { // block id: 163
            27 >> ((75) & 7)
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1663107043977_28*var_1663107043977_28), 64)
        crccheck.updateBuffer(UInt64(var_1663107043977_100*var_1663107043977_100), 64)
        crccheck.updateBuffer(UInt64(var_1663107043977_146*var_1663107043977_146), 64)
        crccheck.updateBuffer(UInt64(var_1663107043977_155*var_1663107043977_155), 64)
        crccheck.updateBuffer(UInt64(var_1663107043977_161*var_1663107043977_161), 64)
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
