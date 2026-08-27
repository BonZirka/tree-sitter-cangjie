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

public let var_1667306401851_74 : Bool = ((-104) is Range<UInt64>)
public var var_1667306401851_86 : Int32 = Int32(-91)
let var_1667306401851_117 : Range<Int8> = ((Int8(-27)&127)..=(Int8(81)&127):(87|1))
public var var_1667306401851_153 : UInt64 = UInt64(Int8(62))
public let var_1667306401851_160 : UInt64 = UInt64(55)
public interface Interface_1667306401851_22<T0, T1, T2> {

}

public interface Interface_1667306401851_25 <: Interface_1667306401851_22<Int32, Int16, Int8> {

}

public interface Interface_1667306401851_24 <: Interface_1667306401851_22<Int32, Int16, Int8> & Interface_1667306401851_25 {

}

public interface Interface_1667306401851_23 <: Interface_1667306401851_22<Int32, Int16, Int8> & Interface_1667306401851_24 {

}

public interface Interface_1667306401851_21<T0, T1, T2> <: Interface_1667306401851_22<Int32, Int16, Int8> & Interface_1667306401851_23 {

}

public interface Interface_1667306401851_20 <: Interface_1667306401851_21<UInt16, Array<UInt64>, Range<Int32>> {

}

public interface Interface_1667306401851_19 <: Interface_1667306401851_20 & Interface_1667306401851_24 {

}

public interface Interface_1667306401851_18 <: Interface_1667306401851_19 {

}

public interface Interface_1667306401851_17 <: Interface_1667306401851_18 & Interface_1667306401851_19 {

}

public interface Interface_1667306401851_16 <: Interface_1667306401851_17 {

}

public interface Interface_1667306401851_15 <: Interface_1667306401851_16 & Interface_1667306401851_18 {

}

public open class Class_1667306401851_12 <: Interface_1667306401851_15 {
    public init() { // block id: 14

    }
;
    static var var_1667306401851_56 : Bool = true
}

public enum Enum_1667306401851_112 {
    defaultValue |
    enumValue_1667306401851_137(Interface_1667306401851_23)
}
public func func_1667306401851_108(param_1667306401851_109 : Interface_1667306401851_19) : UInt64 { // block id: 110
    let var_1667306401851_130 : Enum_1667306401851_112 = Enum_1667306401851_112.defaultValue;
    let var_1667306401851_140 : Interface_1667306401851_23 = Class_1667306401851_12();
    var var_1667306401851_147 : Unit = ();
    match (try { // block id: 115
        var_1667306401851_117;
        ();
        var var_1667306401851_123 : Enum_1667306401851_112 = Enum_1667306401851_112.defaultValue;
        if (false) { var_1667306401851_123 } else { var_1667306401851_123 } 
    } catch (_) { // block id: 126
        if (true) { var_1667306401851_130 } else { var_1667306401851_130 } 
    } finally { // block id: 133
        ();
        Class_1667306401851_12();
        Enum_1667306401851_112.enumValue_1667306401851_137(var_1667306401851_140)
    }) {
        case enumValue_1667306401851_137(caseVar_1667306401851_144) => 
            var_1667306401851_147;
            Class_1667306401851_12();
            UInt64(224) ^ var_1667306401851_153
        
        case defaultValue => 
            var_1667306401851_160
        
        case _ => 
            UInt64(122)
        
    }
}

main(): Int64 {
    try {
        func func_1667306401851_7<T0>(param_1667306401851_8 : Float32) : Int64 { // block id: 9
            let var_1667306401851_68 : Interface_1667306401851_19 = Class_1667306401851_12();
            if (Class_1667306401851_12.func_1667306401851_28<Int8>(var_1667306401851_68, false)) { // block id: 71
                var var_1667306401851_80 : UInt16 = UInt16(Int16(7));
                if (var_1667306401851_74) { // block id: 77
                    var_1667306401851_80 *= var_1667306401851_80;
                    var_1667306401851_86--
                };
                var_1667306401851_80
            } else { // block id: 89
                var var_1667306401851_92 : UInt16 = UInt16(72);
                UInt16(var_1667306401851_92)
            };
            let var_1667306401851_95 : Range<Int64> = ((Int64(Int32(-77))&127)..(Int64(UInt64(Int32(36)))&127):((Int64(UInt64(Int8(126)))|1)));
            var_1667306401851_95;
            79
        }
;
        let var_1667306401851_166 : (Interface_1667306401851_19) -> UInt64 = func_1667306401851_108;
        func_1667306401851_7<UInt32>(Float32(125.0)) ** (Class_1667306401851_12()|>var_1667306401851_166)
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1667306401851_86*var_1667306401851_86), 64)
        crccheck.updateBuffer(UInt64(var_1667306401851_153*var_1667306401851_153), 64)
        crccheck.updateBuffer(UInt64(var_1667306401851_160*var_1667306401851_160), 64)
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
extend Class_1667306401851_12 {
    static func func_1667306401851_28<T0>(param_1667306401851_29 : Interface_1667306401851_19, param_1667306401851_30 : Bool) : Bool { // block id: 31
        var var_1667306401851_47 : Bool = (Class_1667306401851_12() is Float32);
        let var_1667306401851_63 : Interface_1667306401851_15 = Class_1667306401851_12();
        try { // block id: 44
            [var_1667306401851_47, false, var_1667306401851_47, var_1667306401851_47, true, var_1667306401851_47, var_1667306401851_56, true, var_1667306401851_56, var_1667306401851_47]
        } finally { // block id: 61
            var_1667306401851_63;
            [false, true, false, false, true, true, true, false, false, true]
        }[3]
    }

}

extend Enum_1667306401851_112 {

}

