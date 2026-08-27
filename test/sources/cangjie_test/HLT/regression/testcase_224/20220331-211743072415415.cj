/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

public let var12 : Class8<Unit> = Class8<Unit>()
public var var75 : Unit = ()
public var var80 : Range<UInt64> = ((UInt64(142)&127)..(UInt64(147)&127):((-49)|1))
var var94 : Int32 = Int32(Int32(UInt16(159)))
public var var101 : Bool = (((UInt64(192)&127)..(UInt64(179)&127):(83|1)) is  (UInt64,Range<UInt32>,Array<Enum38>))
public var var131 : Range<UInt8> = ((UInt8(117)&127)..(UInt8(95)&127):((-45)|1))
public var var152 : Int16 = Int16(UInt16(Int16(UInt8(Int8(66)))))
public open class Class8<T0> {
    public init() { // block id: 10

    }
;
    let var15 : Int16 = Int16(-23);
    static let var56 : Array<Enum38> = Array<Enum38>(10){ i => Enum38.defaultValue };
    static var var109 : Range<UInt16> = ((UInt16(18)&127)..=(UInt16(179)&127):((-99)|1))
}

public enum Enum38 {
    defaultValue
}
main(): Int64 {
    try {
        var12.var15;
        func func19<T0, T1, T2>(param20 : Class8<Unit>, optionalParam21 ! : Int16 = Int16(Int8(69)), optionalParam24 ! : Float32 = Float32(89.0), namedParam26 ! : Int8) : Float32 { // block id: 27
            param20.func31<Int8>(namedParam32 : match (((UInt16(83)&127)..(UInt16(88)&127):((-7)|1))) {
                case caseVar120 : Range<Int8> => 
                    var75;
                    Int8(41) * namedParam26
                
                case caseVar128 => 
                    var131;
                    Int8(120) / ((Int8(16)) | 1)
                
                case caseVar138 => 
                    ();
                    Int8(88) / ((Int8(11)) | 1)
                
                case _ => 
                    Int8(-53)
                
            })
        }
;
        var var159 : Int8 = Int8(Int8(UInt8(UInt8(Int8(-109)))));
        Float32(func19<Range<Int64>, UInt64, Bool>(Class8<Unit>(), optionalParam21 : var152, namedParam26 : var159));
        52
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var152*var152), 64)
        crccheck.updateBuffer(UInt64(var159*var159), 64)
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
extend<T0> Class8<T0> {
    public func func31<T0>(namedParam32 ! : T0, optionalParam33 ! : Int32 = Int32(Int16(107))) : Float32 { // block id: 36
        match ((UInt64(149), ((UInt32(219)&127)..(UInt32(123)&127):((-16)|1)), var56)[2][2]) {
            case caseVar72 => 
                var75;
                if (true) { var80 } else { var80 } ;
                var75
            
            case defaultValue => 
                var75;
                ()
            
            case defaultValue => 
                var94 ^= optionalParam33;
                var101 ||= false
            
            case _ => 
                var75;
                var109;
                ()
            
        };
        [Float32(107.0), Float32(22.0), Float32(126.0), Float32(-61.0), Float32(-58.0), Float32(2.0), Float32(13.0), Float32(72.0), Float32(81.0), Float32(55.0)][5]
    }

}
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_variable


