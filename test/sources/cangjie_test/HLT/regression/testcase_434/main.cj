/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
const var_1691702789858_8 : Bool = true
public let var_1691702789858_18 : UInt8 = UInt8(Int8(45))
const var_1691702789858_98 : Int = 34


public const func func_1691702789858_64(param_1691702789858_65 : Float64) : Int64 { // block id: 66
    -120
}

main(): Int64 {
    try {
        var_1691702789858_8;
        let var_1691702789858_29 : UInt16 = UInt16(34);
        var loopTimeVar_1691702789858_32 : Int = 0;
        while ((if (false) { // block id: 13
            var_1691702789858_8
        } else { // block id: 15
            var_1691702789858_18 - UInt8(5);
            const var_1691702789858_25 : Bool = false;
            var_1691702789858_8 && var_1691702789858_25
        }) && loopTimeVar_1691702789858_32 < 100 ) {
            loopTimeVar_1691702789858_32++;
            var_1691702789858_29
        };
        let var_1691702789858_45 : ?Int32 = (UInt64(45) as Int32);
        func func_1691702789858_34<T0, T1>(param_1691702789858_35 : Int64) : Int64 { // block id: 36
            const var_1691702789858_61 : Unit = ();
            var var_1691702789858_73 : (UInt8, Bool, UInt16, Int32, UInt8, Int16) = (UInt8(UInt8(Int8(UInt8(172)))), (UInt64(45) is Int32), UInt16(70), Int32(64), UInt8(Int8(UInt8(Int8(77)))), Int16(-55));
            try { // block id: 38
                var_1691702789858_45.getOrThrow();
                var var_1691702789858_55 : Int64 = Int64(UInt64(UInt8(37)));
                (Option<Int64>.None ?? var_1691702789858_55)
            } catch (e: Exception) { // block id: 59
                var_1691702789858_61;
                func_1691702789858_64(Float64(-119.0))
            } finally { // block id: 69
                var_1691702789858_73[3];
                var var_1691702789858_94 : UInt32 = UInt32(46);
                var loopTimeVar_1691702789858_101 : Int64 = 0;
                do {
                    loopTimeVar_1691702789858_101++;
                    var_1691702789858_94 /= ((UInt32(159)) | 1);
                    var_1691702789858_98
                } while ((var_1691702789858_8) && loopTimeVar_1691702789858_101 < 100 ) ;
                func_1691702789858_64(Float64(-8.0))
            }
        }
;
        let var_1691702789858_107 : (UInt64, UInt64, Int64, Unit, UInt16, Rune, UInt8) = (UInt64(119), UInt64(107), Int64(2), (), UInt16(63), r'G', UInt8(129));
        func_1691702789858_34<Int8, Unit>(var_1691702789858_107[2])
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1691702789858_29*var_1691702789858_29), 64)
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



