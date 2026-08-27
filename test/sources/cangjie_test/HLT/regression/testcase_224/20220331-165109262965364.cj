/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args


public var var15 : Option<Bool> = Option<Bool>.None
public var var62 :  (UInt32,Float64,UInt64,Unit,String) = (UInt32(125), (-75.0), UInt64(125), (), "!-Y+6._e$H")
var var82 : UInt64 = UInt64(UInt16(UInt8(Int8(104))))
public let var88 : Unit = ()
public let var91 : String = """
Khh6l
T}Q^c
"""

public interface Interface41<T0> {

}

public interface Interface42<T0, T1> <: Interface41<Rune> {

}

public open class Class38<T0> <: Interface41<Rune> & Interface42<Interface41<Rune>, Int8> {
    init() { // block id: 40

    }
;
    public static let var120 : Array< (UInt8,Int16,Bool,Bool,Int64)> = [(UInt8(202), Int16(-19), false, false, (-53)), (UInt8(208), Int16(-43), true, true, 125), (UInt8(202), Int16(-25), true, true, 96), (UInt8(0), Int16(-65), true, true, (-11)), (UInt8(224), Int16(-33), false, false, 94), (UInt8(199), Int16(41), false, true, (-119)), (UInt8(17), Int16(-69), false, true, 117), (UInt8(168), Int16(-98), false, false, 89), (UInt8(168), Int16(14), true, true, (-31)), (UInt8(223), Int16(30), true, true, 97)]
}

main(): Int64 {
    try {
        (if (false) { var15 } else { var15 }  ?? (Option<Bool>.None is UInt64));
        var var31 : Int64 = Int64(UInt64(32));
        var loopTimeVar36 : Int64 = 0;
        while ((match (var15) {
            case _ => 
                var var26 : Bool = false;
                var26
            
        }) && loopTimeVar36 < 100 ) {
            loopTimeVar36++;
            var31++;
            ()
        };
        var var186 : Rune = '9';
        Class38<Range<Int16>>.func45<Interface41<Rune>>(namedParam46 : var186, namedParam47 : Int32(-91), namedParam48 : var15)
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var31*var31), 64)
        crccheck.updateBuffer(UInt64(var82*var82), 64)
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
extend<T0> Class38<T0> {
    public static func func45<T0>(namedParam46 ! : Rune, namedParam47 ! : Int32, namedParam48 ! : Option<Bool>) : Int64 where T0 <: Interface41<Rune> { // block id: 49
        var var73 : Float64 = Float64(Float32(86.0));
        try { // block id: 53
            if (true) { namedParam46 } else { namedParam46 } ;
            false;
            if (true) { var62 } else { var62 } 
        } finally { // block id: 70
            11.0;
            var73;
            if (true) { (UInt32(220), (-68.0), var82, var88, var91) } else { var62 } 
        }[3];
        let var113 : UInt16 = UInt16(UInt8(89));
        ((-102), ((var113&127)..(UInt16(65)&127):(((-21)|1))), Int32(41), var120)[3][0][4]
    }

}

