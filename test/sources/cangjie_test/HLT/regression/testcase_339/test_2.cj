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

public let var_1688070576885_16 : Int8 = Int8(Int8(UInt8(43)))
public var var_1688070576885_25 : UInt32 = UInt32(17)
public let var_1688070576885_29 : Bool = true
public let var_1688070576885_33 : Unit = ()
let var_1688070576885_46 : Enum_1688070576885_43 = Enum_1688070576885_43.defaultValue
public var var_1688070576885_54 : String = ###"`/dL`S?8WP"###
public var var_1688070576885_61 : Int64 = 124
public let var_1688070576885_112 : UInt64 = UInt64(UInt16(UInt16(UInt8(Int8(102)))))
public enum Enum_1688070576885_43 {
    defaultValue
}
public func func_1688070576885_7<T0, T1>(param_1688070576885_8 : Float64) : Unit { // block id: 9
    var loopTimeVar_1688070576885_85 : Int64 = 0;
    while ((try { // block id: 13
        var_1688070576885_16 / ((var_1688070576885_16) | 1);
        false;
        UInt32(80)
    } finally { // block id: 23
        var_1688070576885_25
    } > if (var_1688070576885_29) { // block id: 31
        var_1688070576885_33;
        var_1688070576885_25
    } else { // block id: 36
        ();
        ();
        var_1688070576885_25
    }) && loopTimeVar_1688070576885_85 < 100 ) {
        loopTimeVar_1688070576885_85++;
        Int32(-106);
        match (var_1688070576885_46) {
            case _ : UInt64 => 
                ();
                break;
                var_1688070576885_54
            
            case defaultValue => 
                var_1688070576885_61--;
                ();
                if (false) { var_1688070576885_54 } else { "z[`zI4]2xR" } 
            
            case defaultValue => 
                UInt32(86);
                var_1688070576885_54
            
            case defaultValue => 
                if (var_1688070576885_29) { var_1688070576885_46 } else { Enum_1688070576885_43.defaultValue } ;
                var_1688070576885_54
            
            case _ => 
                var_1688070576885_54
            
        }
    }
}

public interface Interface_1688070576885_90<T0> {

}

public interface Interface_1688070576885_91<T0, T1> <: Interface_1688070576885_90<Float64> {

}

public open class Class_1688070576885_87<T0> <: Interface_1688070576885_90<Float64> & Interface_1688070576885_91<Int16, Bool> {
    init() { // block id: 89

    }
;
    static var var_1688070576885_94 : Float64 = 111.0
}

main(): Int64 {
    try {
        func_1688070576885_7<Float32, Int16>(Class_1688070576885_87<String>.var_1688070576885_94);
        Class_1688070576885_87<String>();
        var var_1688070576885_101 : UInt64 = UInt64(Int16(UInt16(171)));
        (var_1688070576885_61 ** var_1688070576885_101) ** if (var_1688070576885_29) { // block id: 107
            Int32(-19);
            ();
            var_1688070576885_112 / ((var_1688070576885_101) | 1)
        } else if (var_1688070576885_29) { // block id: 120
            UInt64(91)
        } else { // block id: 122
            ();
            var_1688070576885_112
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1688070576885_16*var_1688070576885_16), 64)
        crccheck.updateBuffer(UInt64(var_1688070576885_25*var_1688070576885_25), 64)
        crccheck.updateBuffer(UInt64(var_1688070576885_101*var_1688070576885_101), 64)
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
