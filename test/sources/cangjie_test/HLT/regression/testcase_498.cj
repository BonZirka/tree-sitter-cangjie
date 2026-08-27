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

public let var_1694565599970_19 : Bool = true
public let var_1694565599970_54 : Class_1694565599970_44<UInt8> = Class_1694565599970_44<UInt8>()
public var var_1694565599970_79 : Int16 = Int16(UInt8(160))
let var_1694565599970_87 : Int16 = Int16(-16)
public var var_1694565599970_139 : Float64 = 42.0

public interface Interface_1694565599970_49 {

}

public interface Interface_1694565599970_52 {

}

public interface Interface_1694565599970_51 <: Interface_1694565599970_52 {

}

public interface Interface_1694565599970_50<T0> <: Interface_1694565599970_49 & Interface_1694565599970_51 {

}

public interface Interface_1694565599970_48 <: Interface_1694565599970_49 & Interface_1694565599970_50<Rune> {

}

public interface Interface_1694565599970_47<T0, T1, T2> <: Interface_1694565599970_48 {
    func func_1694565599970_57(namedParam_1694565599970_58 ! : Int32, namedParam_1694565599970_59 ! : UInt64, namedParam_1694565599970_60 ! : Int16, namedParam_1694565599970_61 ! : Interface_1694565599970_51) : Int16 

}

public open class Class_1694565599970_44<T0> <: Interface_1694565599970_47<UInt8, Float64, Option<String>> & Interface_1694565599970_50<Rune> {
    public init() { // block id: 46

    }
;
    public open func func_1694565599970_57(namedParam_1694565599970_58 ! : Int32, namedParam_1694565599970_59 ! : UInt64, namedParam_1694565599970_60 ! : Int16, namedParam_1694565599970_61 ! : Interface_1694565599970_51) : Int16 { // block id: 62
        Int16(-67)
    }
;
    static let var_1694565599970_111 : (Range<UInt64>, Array<Int16>, Int64, Range<UInt64>, UInt64, Array<Int16>) = (((UInt64(UInt64(220))&127)..(UInt64(UInt64(21))&127):(125|1)), [Int16(116), Int16(-107), Int16(-23), Int16(-22), Int16(-106), Int16(-83), Int16(47), Int16(36), Int16(113), Int16(-73)], (-64), ((UInt64(UInt64(49))&127)..(UInt64(UInt64(30))&127):(111|1)), UInt64(72), [Int16(-97), Int16(-17), Int16(13), Int16(99), Int16(7), Int16(-62), Int16(-61), Int16(-43), Int16(-34), Int16(125)])
}


public func func_1694565599970_7<T0, T1>(param_1694565599970_8 : Float64) : Int16 { // block id: 9
    var var_1694565599970_23 : Unit = ();
    var var_1694565599970_27 : Bool = true;
    let var_1694565599970_36 : Option<String> = Option<String>.None;
    ((Float32(-27.0) as String) ?? if (var_1694565599970_19) { // block id: 21
        var_1694565599970_23;
        var_1694565599970_27 &&= true;
        if (false) { ###"M(-Frl^n1L"### } else { "Lcu&m|\"[wo" } 
    } else if ((var_1694565599970_36 is Float32)) { // block id: 38
        ();
        "(Vj~T7fblO"
    } else { // block id: 41
        "K} Q<&I95-"
    });
    var_1694565599970_54.func_1694565599970_57(namedParam_1694565599970_58 : Int32(44), namedParam_1694565599970_59 : UInt64(32), namedParam_1694565599970_60 : [var_1694565599970_79, var_1694565599970_79, Int16(-41), Int16(65), Int16(111), var_1694565599970_87, var_1694565599970_87, Int16(21), var_1694565599970_87, Int16(-6)][4], namedParam_1694565599970_61 : (Option<Interface_1694565599970_51>.None ?? Class_1694565599970_44<UInt8>()))
}

main(): Int64 {
    try {
        var_1694565599970_139 * var_1694565599970_139|>{ lambdaParameter_1694565599970_103 : Float64 => Class_1694565599970_44<UInt8>.var_1694565599970_111[1][4] };
        var var_1694565599970_147 : (Range<Int16>, Range<UInt16>, Range<Int8>, Range<UInt64>, Range<Int32>, Int32) = (((Int16(Int16(-35))&127)..=(Int16(Int16(-23))&127):((-72)|1)), ((UInt16(UInt16(173))&127)..=(UInt16(UInt16(Int16(15)))&127):(Int64(UInt8(169))|1)), ((Int8(Int8(-113))&127)..=(Int8(Int8(-57))&127):(11|1)), ((UInt64(UInt64(58))&127)..=(UInt64(UInt64(217))&127):(Int64(Int8(103))|1)), ((Int32(Int32(121))&127)..(Int32(Int32(26))&127):((-8)|1)), Int32(0));
        try { // block id: 145
            var_1694565599970_147
        } finally { // block id: 164
            var_1694565599970_54;
            Int32(-86);
            var_1694565599970_147
        }[2];
        try { // block id: 170
            (-53)
        } catch (e: Exception) { // block id: 172
            (-120)
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1694565599970_79*var_1694565599970_79), 64)
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

    func getCrcOutput(): Int32 {
        var i = 0
        var res = ""
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
        print("\n")
        if ( res == "3100004461620023" ){
            return 0
        }
        return 1
    }
}
extend<T0> Class_1694565599970_44<T0> {

}

