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

public let var_1710864851744_21 : UInt32 = UInt32(Int16(18))
let var_1710864851744_25 : Bool = (Struct_1710864851744_8<Float64>() is Rune)
public const var_1710864851744_34 : Unit = ()
public const var_1710864851744_53 : UInt16 = 74
var var_1710864851744_97 : Int64 = Int64(-71)
public var var_1710864851744_108 : UInt = UInt64(UInt32(Int8(104)))
public var var_1710864851744_130 : Int32 = Int32(-127)
public let var_1710864851744_134 : VArray<Int64, $2> = [Int64(Int64(UInt64(Int8(117)))), Int64(UInt16(Int8(42)))]
var var_1710864851744_166 : Float32 = Float32(1.0)
public let var_1710864851744_170 : VArray<Int64, $2> = [Int64(Int32(UInt8(Int8(99)))), Int64(UInt8(UInt8(Int8(77))))]
public struct Struct_1710864851744_8<T0> {
    public init() { // block id: 10

    }
;
    static var var_1710864851744_13 : Bool = true
}

const func func_1710864851744_49<T0, T1, T2>() : UInt16 { // block id: 50
    var_1710864851744_53 + 163
}

public const func func_1710864851744_30(param_1710864851744_31 : Bool) : Int32 { // block id: 32
    var_1710864851744_34;
    const var_1710864851744_37 : Byte = 1;
    var_1710864851744_37;
    const var_1710864851744_46 : Int32 = -48;
    const func func_1710864851744_40<T0>(namedParam_1710864851744_41 ! : UInt16, optionalParam_1710864851744_42 ! : UInt32 = 116) : Int32 { // block id: 44
        var_1710864851744_46
    }
;
    func_1710864851744_40<Float32>(namedParam_1710864851744_41 : func_1710864851744_49<Int64, UInt64, Int64>())
}

public enum Enum_1710864851744_91<T0, T1> {
    defaultValue |
    enumValue_1710864851744_94(Int64)
}
main(): Int64 {
    try {
        var loopTimeVar_1710864851744_68 : Range<UInt64> = ((UInt64(UInt64(38))&127)..=(UInt64(UInt64(UInt16(UInt8(UInt8(101)))))&127):(Int64(UInt32(Int8(0)))|1));
        for (i in loopTimeVar_1710864851744_68 where if (Struct_1710864851744_8<Float64>.var_1710864851744_13) { // block id: 15
            true
        } else { // block id: 17
            UInt32(167) << ((var_1710864851744_21) & 7);
            var_1710864851744_25
        }) {
            true|>func_1710864851744_30;
            match (UInt16(173)) {
                case _ => 
                    ();
                    Int16(-93);
                    Int64(59) ^ Int64(-5)
                
            }
        };
        match (match (Enum_1710864851744_91<Int16, Range<Int32>>.enumValue_1710864851744_94(var_1710864851744_97)) {
            case enumValue_1710864851744_94(_) => 
                UInt32(0);
                let var_1710864851744_104 : Enum_1710864851744_91<Int16, Range<Int32>> = Enum_1710864851744_91<Int16, Range<Int32>>.enumValue_1710864851744_94(Int64(73));
                var_1710864851744_104;
                var_1710864851744_108
            
            case enumValue_1710864851744_94(_) => 
                var_1710864851744_108 & UInt64(233)
            
            case _ => 
                var_1710864851744_108 << ((var_1710864851744_108) & 7)
            
        }) {
            case _ => 
                ();
                var_1710864851744_130 >>= ((Int32(81)) & 7);
                var_1710864851744_134
            
            case _ => 
                var_1710864851744_34;
                VArray<Int64, $2>(repeat: var_1710864851744_97)
            
            case caseVar_1710864851744_152 : Bool => 
                VArray<Int64, $2>(repeat: var_1710864851744_97)
            
            case _ => 
                ((UInt16(var_1710864851744_53)&127)..(UInt16(UInt16(142))&127):(Int64(65)|1));
                var_1710864851744_166 = Float32(28.0);
                var_1710864851744_170
            
        }[0]
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1710864851744_97*var_1710864851744_97), 64)
        crcCheck.updateBuffer(UInt64(var_1710864851744_108*var_1710864851744_108), 64)
        crcCheck.crcCheck()
        crcCheck.getCrcOutput()
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
            buffer[(i + buffer_index) % buffer.size] = byteArray[i + byte_index]
            i++
        }
        buffer_index = (buffer_index + i) % buffer.size
    }

    func updateBuffer(input: Bool, byte_n: Int64): Unit {
        if (input == true) {
            updateBuffer(1, byte_n)
        } else {
            updateBuffer(0, byte_n)
        }
    }

    func updateBuffer(input: Rune, byte_n: Int64): Unit {
        updateBuffer(UInt64(UInt32(input)), byte_n)
    }

    func updateBuffer(input: String, byte_n: Int64): Unit {
        for (c in input) {
            updateBuffer(c, byte_n)
        }
    }

    func updateBuffer(input: Unit, byte_n: Int64): Unit {
        updateBuffer(input.toString(), byte_n)
    }

    func updateBuffer(input: Any, byte_n: Int64) : Unit {
        if (input is Hashable) {
            match(input as Hashable) {
                case Some(v) => updateBuffer(UInt64(v.hashCode()), byte_n)
                case _=> updateBuffer(1, byte_n)
            }
            
        } else if (input is ToString) {
            match(input as ToString) {
                case Some(v) => updateBuffer(v.toString(), byte_n)
                case _=> updateBuffer(1, byte_n)
            }
        } else {
            updateBuffer(1, byte_n)
        }
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

extend<T0, T1> Enum_1710864851744_91<T0, T1> {

}

