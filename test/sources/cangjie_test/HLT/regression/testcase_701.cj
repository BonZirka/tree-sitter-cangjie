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

public let var_1658837677421_14 : String = """
tRcP\\
I33Sj
"""
public let var_1658837677421_24 : Int32 = Int32(Int32(Int8(-33)))
public var var_1658837677421_37 : UInt32 = UInt32(UInt8(163))
public let var_1658837677421_79 : UInt16 = UInt16(Int16(UInt8(207)))

public interface Interface_1658837677421_56<T0, T1, T2> {

}

public interface Interface_1658837677421_55<T0> <: Interface_1658837677421_56<UInt16, Float32, Bool> {

}

public interface Interface_1658837677421_54<T0, T1> <: Interface_1658837677421_55<Float64> {

}

public open class Class_1658837677421_51 <: Interface_1658837677421_54<UInt64, Unit> {
    public init() { // block id: 53

    }
;
    public let var_1658837677421_88 : Unit = ();
    public var var_1658837677421_96 : Int64 = 86
}

main(): Int64 {
    try {
        ((var_1658837677421_14 as Int32) ?? match (###"mvr=o8a:BR"###) {
            case caseVar_1658837677421_20 => 
                var_1658837677421_24 << ((Int32(-56)) & 7)
            
            case """
!Nl$q
}@Y.z
""" | ###"E+1p2DDQ&a{"### => 
                var var_1658837677421_34 : UInt32 = UInt32(114);
                var_1658837677421_34 &= var_1658837677421_37;
                var_1658837677421_24
            
            case """
W-eZA
!#lHQ
""" => 
                var_1658837677421_24
            
            case _ => 
                var_1658837677421_24 / ((var_1658837677421_24) | 1)
            
        });
        let var_1658837677421_68 : (Class_1658837677421_51, Bool, String, UInt32) = (Class_1658837677421_51(), false, """
< IPm
'F<vt
""", UInt32(UInt8(Int8(Int8(-66)))));
        func func_1658837677421_58<T0, T1>(param_1658837677421_59 : UInt16, param_1658837677421_60 : Rune, param_1658837677421_61 : Int8, optionalParam_1658837677421_62 ! : Unit = ()) : Class_1658837677421_51 { // block id: 64
            var_1658837677421_68[0]
        }
;
        var var_1658837677421_84 : Rune = r'X';
        func_1658837677421_58<Unit, Int64>(var_1658837677421_79, var_1658837677421_84, Int8(-103)).var_1658837677421_88;
        func_1658837677421_58<Unit, Int64>(UInt16(53), r'S', Int8(32)).var_1658837677421_96
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
extend Class_1658837677421_51 {

}

