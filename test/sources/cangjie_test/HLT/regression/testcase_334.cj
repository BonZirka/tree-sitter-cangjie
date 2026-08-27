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

var var_1687897948514_27 : Bool = (Int16(-76) is Bool)
var var_1687897948514_39 : UInt16 = UInt16(110)
var var_1687897948514_86 : Option<Enum_1687897948514_10<UInt64, UInt16, Int32>> = Option<Enum_1687897948514_10<UInt64, UInt16, Int32>>.None
var var_1687897948514_127 : Int8 = Int8(UInt8(139))
public enum Enum_1687897948514_10<T0, T1, T2> {
    defaultValue |
    enumValue_1687897948514_116(() -> Bool)
}

public func func_1687897948514_6<T0>() : Bool { // block id: 7
    var var_1687897948514_18 : Option<Enum_1687897948514_10<UInt64, UInt16, Int32>> = Option<Enum_1687897948514_10<UInt64, UInt16, Int32>>.None;
    let var_1687897948514_44 : Int32 = Int32(-4);
    let var_1687897948514_48 : Rune = r'z';
    var var_1687897948514_60 : Unit = ();
    (match ((var_1687897948514_18 ?? Enum_1687897948514_10<UInt64, UInt16, Int32>.defaultValue)) {
        case defaultValue => 
            5;
            var var_1687897948514_31 : Rune = r'r';
            if (var_1687897948514_27) { var_1687897948514_31 } else { var_1687897948514_31 } 
        
        case defaultValue => 
            var_1687897948514_39 = var_1687897948514_39;
            var_1687897948514_44 * Int32(40);
            var_1687897948514_48
        
        case caseVar_1687897948514_52 : String => 
            var_1687897948514_48
        
        case caseVar_1687897948514_57 => 
            var_1687897948514_60;
            if (var_1687897948514_27) { r'k' } else { r'O' } 
        
        case _ => 
            if (var_1687897948514_27) { r'a' } else { r'b' } 
        
    } is UInt32)
}

main(): Int64 {
    try {
        func_1687897948514_6<String>();
        var_1687897948514_27;
        var var_1687897948514_94 : Array<Int64> = [Int64(UInt32(180)), (-7), (-96), Int64(UInt64(90)), 52, 28, (-67), Int64(UInt8(14)), (-12), Int64(Int8(Int8(-2)))];
        match (var_1687897948514_86) {
            case Some(defaultValue) => 
                if (true) { var_1687897948514_94 } else { [(-6), (-128), 73, (-67), (-31), (-99), (-49), 61, 83, (-115)] } 
            
            case Some(_) => 
                Enum_1687897948514_10<UInt64, UInt16, Int32>.enumValue_1687897948514_116(func_1687897948514_6<String>);
                var_1687897948514_39++;
                [(-74), 95, (-88), 68, (-17), 6, (-73), (-107), (-49), 64]
            
            case _ => 
                var_1687897948514_127 *= Int8(-100);
                ();
                [1, 15, (-14), (-77), 67, 69, 56, (-120), 41, 96]
            
        }[0]
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1687897948514_39*var_1687897948514_39), 64)
        crccheck.updateBuffer(UInt64(var_1687897948514_127*var_1687897948514_127), 64)
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
extend<T0, T1, T2> Enum_1687897948514_10<T0, T1, T2> {

}

