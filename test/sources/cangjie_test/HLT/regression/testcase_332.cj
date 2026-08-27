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

var var_1687632517876_16 : Enum_1687632517876_7 = Enum_1687632517876_7.defaultValue
public var var_1687632517876_29 : UInt64 = UInt64(Int16(103))
let var_1687632517876_40 : ?Enum_1687632517876_7 = Option<Enum_1687632517876_7>.None
public var var_1687632517876_43 : Enum_1687632517876_7 = Enum_1687632517876_7.defaultValue
public let var_1687632517876_67 : UInt32 = UInt32(Int16(-55))
public var var_1687632517876_140 : UInt16 = UInt16(27)
public enum Enum_1687632517876_7 {
    defaultValue |
    enumValue_1687632517876_129
}

public open class Class_1687632517876_93 {
    Class_1687632517876_93() { // block id: 95

    }
;
    public static let var_1687632517876_98 : Int64 = 80
}

public func func_1687632517876_79(optionalParam_1687632517876_80 ! : Float64 = Float64((-59.0)), namedParam_1687632517876_83 ! : Bool, namedParam_1687632517876_84 ! : UInt16, optionalParam_1687632517876_85 ! : UInt32 = UInt32(Int8(24))) : Int64 { // block id: 88
    ();
    ((Class_1687632517876_93.var_1687632517876_98) & (Class_1687632517876_93.var_1687632517876_98)) ** try { // block id: 104
        var_1687632517876_29
    } catch (_) { // block id: 106
        Int16(-87);
        UInt64(123)
    }
}

main(): Int64 {
    try {
        var var_1687632517876_34 : Int64 = 65;
        match ((match (Option<Enum_1687632517876_7>.None) {
            case Some(num) => num
            case None => var_1687632517876_16
        })) {
            case _ : Enum_1687632517876_7 => 
                ()
            
            case _ : UInt64 => 
                ()
            
            case _ => 
                var_1687632517876_29;
                var_1687632517876_34 = var_1687632517876_34 % ((103) | 1)
            
        };
        var var_1687632517876_50 : Int8 = Int8(UInt8(227));
        var var_1687632517876_59 : Unit = ();
        match ((match (var_1687632517876_40) {
            case Some(num) => num
            case None => var_1687632517876_43
        })) {
            case _ : Float64 => 
                var_1687632517876_50 = var_1687632517876_50 + 1
            
            case defaultValue => 
                "?qAxL[08k]";
                ();
                var_1687632517876_59
            
            case caseVar_1687632517876_63 : Enum_1687632517876_7 => 
                var_1687632517876_59;
                var_1687632517876_67;
                var var_1687632517876_72 : UInt16 = UInt16(55);
                var_1687632517876_72 = var_1687632517876_72 - (UInt16(15))
            
            case _ => 
                ()
            
        };
        let var_1687632517876_117 : UInt16 = UInt16(49);
        func_1687632517876_79(optionalParam_1687632517876_80 : (-123.0), namedParam_1687632517876_83 : UInt32(233) != UInt32(234), namedParam_1687632517876_84 : try { // block id: 114
            ();
            var_1687632517876_117
        } catch (_) { // block id: 119
            94.0;
            var_1687632517876_59;
            UInt16(214)
        }, optionalParam_1687632517876_85 : match (var_1687632517876_43) {
            case defaultValue => 
                Enum_1687632517876_7.enumValue_1687632517876_129;
                ();
                UInt32(234) >> ((var_1687632517876_67) & 7)
            
            case defaultValue => 
                (-17);
                var_1687632517876_140 = var_1687632517876_140 * (UInt16(9));
                var_1687632517876_67
            
            case caseVar_1687632517876_146 => 
                (-104.0);
                var_1687632517876_67
            
            case _ => 
                ();
                ();
                UInt32(181)
            
        })
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1687632517876_29*var_1687632517876_29), 64)
        crccheck.updateBuffer(UInt64(var_1687632517876_34*var_1687632517876_34), 64)
        crccheck.updateBuffer(UInt64(var_1687632517876_50*var_1687632517876_50), 64)
        crccheck.updateBuffer(UInt64(var_1687632517876_117*var_1687632517876_117), 64)
        crccheck.updateBuffer(UInt64(var_1687632517876_140*var_1687632517876_140), 64)
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
extend Enum_1687632517876_7 {

}

extend Class_1687632517876_93 {

}

