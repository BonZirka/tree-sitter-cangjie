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

public let var_1659200126705_32 : Bool = (Option<Unit>.None is Float32)
public let var_1659200126705_49 : UInt16 = UInt16(UInt8(UInt8(86)))
public var var_1659200126705_117 : Float64 = 61.0
public let var_1659200126705_127 : ?Unit = Option<Unit>.None

public interface Interface_1659200126705_71<T0> {

}

public interface Interface_1659200126705_72<T0, T1> {

}

public interface Interface_1659200126705_70<T0> <: Interface_1659200126705_71<Int8> & Interface_1659200126705_72<Enum_1659200126705_81, Option<Unit>> {

}

public open class Class_1659200126705_67<T0> <: Interface_1659200126705_70<Enum_1659200126705_81> {
    public init() { // block id: 69

    }
;
    public var var_1659200126705_77 : Int8 = Int8(-6)
}

public enum Enum_1659200126705_81 {
    defaultValue
}
main(): Int64 {
    try {
        let var_1659200126705_38 : Unit = ();
        func func_1659200126705_8<T0>(namedParam_1659200126705_9 ! : UInt16, optionalParam_1659200126705_10 ! : Int8 = Int8(Int8(96))) : Unit { // block id: 13
            var var_1659200126705_22 : ?Unit = Option<Unit>.Some(());
            var var_1659200126705_28 : Int16 = Int16(-48);
            var loopTimeVar_1659200126705_47 : Int64 = 0;
            (try { // block id: 20
                var_1659200126705_22
            } finally { // block id: 25
                var_1659200126705_28--;
                if (var_1659200126705_32) { var_1659200126705_22 } else { Option<Unit>.Some(var_1659200126705_38) } 
            } ?? while (((-46.0) == (-23.0)) && loopTimeVar_1659200126705_47 < 100 ) {
                loopTimeVar_1659200126705_47++;
                UInt8(137)
            })
        }
;
        var var_1659200126705_57 : UInt16 = UInt16(UInt16(Int8(UInt8(UInt8(172)))));
        match (func_1659200126705_8<UInt16>(namedParam_1659200126705_9 : var_1659200126705_49)) {
            case _ => 
                var_1659200126705_57 >>= ((var_1659200126705_49) & 7)
            
        };
        let var_1659200126705_74 : Class_1659200126705_67<Int8> = Class_1659200126705_67<Int8>();
        func_1659200126705_8<UInt16>(namedParam_1659200126705_9 : var_1659200126705_57, optionalParam_1659200126705_10 : var_1659200126705_74.var_1659200126705_77);
        let var_1659200126705_84 : Enum_1659200126705_81 = Enum_1659200126705_81.defaultValue;
        let var_1659200126705_104 : Int64 = (-120);
        var var_1659200126705_121 : UInt64 = UInt64(UInt8(123));
        if (match (var_1659200126705_84) {
            case defaultValue => 
                var var_1659200126705_91 : Int16 = Int16(UInt16(UInt16(155)));
                var_1659200126705_91 |= var_1659200126705_91;
                false
            
            case _ => 
                ();
                33 > var_1659200126705_104
            
            case defaultValue => 
                var_1659200126705_38;
                var_1659200126705_38;
                false
            
            case _ => 
                5.0 * var_1659200126705_117;
                var_1659200126705_121 > var_1659200126705_121
            
        }) { // block id: 125
            var_1659200126705_127;
            (-39)
        } else { // block id: 130
            (-122) << ((var_1659200126705_104) & 7)
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1659200126705_49*var_1659200126705_49), 64)
        crccheck.updateBuffer(UInt64(var_1659200126705_57*var_1659200126705_57), 64)
        crccheck.updateBuffer(UInt64(var_1659200126705_104*var_1659200126705_104), 64)
        crccheck.updateBuffer(UInt64(var_1659200126705_121*var_1659200126705_121), 64)
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
