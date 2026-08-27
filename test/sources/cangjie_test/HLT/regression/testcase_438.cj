/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



// random seed:1629072781515

// All global variable need to be defined before use!
public var var10 : (UInt16*UInt16*Unit*Int64) = (UInt16(81), UInt16(182), (), (-43))
 let var23 : Enum20<Interface64, Float32> = Enum20<Interface64, Float32>.defaultValue
 let var56 : Bool = false
 let var98 : UInt8 = UInt8(182)
public let var104 : UInt16 = UInt16(51)
public let var144 : ((UInt16*UInt16*Unit*Int64)*Bool*Bool) = ((UInt16(76), UInt16(122), (), 0), ((true is UInt8) is (UInt16*UInt16*Unit*Int64)), (false is Interface63<Class62>))
public var var157 : Option<((UInt16*UInt16*Unit*Int64)*Bool*Bool)> = Option<((UInt16*UInt16*Unit*Int64)*Bool*Bool)>.Some(var144)
public var var220 : UInt32 = UInt32(124)
 let var237 : Rune = 'm'
 let var246 : (Int8*Int8*(Rune*Float64)) = (Int8(42), Int8(-49), ('z', 76.0))
public var var274 : Interface64 = Class62()
 let var280 : Unit = ()
main(): Int64 {
    if (true) { var10 } else { var10 } [1];
    var var29 : Unit = ();
    var var45 : UInt16 = UInt16(52);
    (match (var23) {
        case defaultValue => 
            var29;
            false
        
        case caseVar34 : Int8 => 
            ();
            var29;
            true
        
        case caseVar41 : Int32 => 
            (var45, UInt16(67), (), 5);
            Int16(86);
            false
        
        case defaultValue => 
            var56
        
        case _ => 
            var56
        
    } is Rune);
    var var68 : Class62 = Class62();
    var68.func71(namedParam72 : Int16(48))
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var45), 64)
    crccheck.updateBuffer(UInt64(var98), 64)
    crccheck.updateBuffer(UInt64(var104), 64)
    crccheck.updateBuffer(UInt64(var220), 64)
    crccheck.crcCheck()
    crccheck.getCrcOutput()

    return 0;
}

class CrcCheck {
    public var buffer: Array<Int64>
    public var poly: Array<Int64>
    public var crc_output: Array<Int64>
    public var poly_n: Int64
    public var buffer_index: Int64
    public var crc_output_n: Int64

    public init(buffer_n: Int64, crc_n: Int64) {
        buffer_index = 0
        crc_output_n = 0
        crc_output = Array<Int64> (crc_output_n, 0)
        buffer = Array<Int64> (buffer_n, 0)
        poly_n = crc_n + 1
        poly = Array<Int64> (poly_n, 0)
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

    public func updateBuffer(input: UInt64, byte_n: Int64): Unit {
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
        var byteArray = Array<Int64> (byte_n, 0)
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

    public func crcCheck(): Unit {
        crc_output_n = buffer_index + poly_n - 1
        var crc_buffer = Array<Int64> (crc_output_n, 0)
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
        crc_output = Array<Int64> (crc_output_n, 0)
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

    public func getCrcOutput(): Unit {
        var i = 0
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
    }
}
 enum Enum20<T1, T2> {
    defaultValue
}
open class Class62 <: Interface63<Class62> & Interface64 {
    public init() { // block id: 66

    }
;
    public var var185 : Int64 = 119;
    public static let var191 : Rune = 'u';
    public let var207 : Unit = ();
    public static var var234 : Unit = ()
}

interface Interface63<T1> {
    static func func78(param79 : UInt32, namedParam80 ! : Float64, namedParam81 ! : (UInt16*UInt16*Unit*Int64), namedParam82 ! : UInt32) : Bool { // block id: 83
        func87()[0];
        ((var157 ?? var144)[2] is Class62)
    }
;
    func func178(namedParam179 ! : Int64, namedParam180 ! : UInt64, namedParam181 ! : Rune) : Float64 { // block id: 182
        37.0
    }

}

interface Interface64 {
    func func277() : UInt8 { // block id: 278
        var280;
        var98
    }

}

 func func87() : (Rune*Float64) { // block id: 88
    let var111 : Int32 = Int32(-91);
    var var118 : Rune = '8';
    let var126 : Unit = ();
    var var132 : Float64 = 122.0;
    match (match (Int32(-41)) {
            case caseVar94 => 
                caseVar94;
                var98;
                Int32(34)
            
            case _ => 
                var104;
                Int32(51);
                Int32(-28)
            
        }) {
        case var111 => 
            ();
            ();
            var var121 : Float64 = (-92.0);
            (var118, var121)
        
        case _ => 
            var126;
            var126;
            ('b', var132)
        
    }
}



func func225(namedParam226 ! : Bool, namedParam227 ! : UInt32, namedParam228 ! : (Rune*Float64)) : Rune { // block id: 229
    var144;
    Class62.var234;
    var237
}


extend<T1, T2> Enum20<T1, T2> {

}

extend<T1, T2> Enum20<T1, T2> {

}

extend Class62 {
    public func func71(namedParam72 ! : Int16, optionalParam73 ! : UInt32 = UInt32(140)) : Int64 { // block id: 75
        var var188 : UInt64 = UInt64(172);
        if (func78(if (var56) { optionalParam73 } else { UInt32(223) } , namedParam80 : func178(namedParam179 : var185, namedParam180 : var188, namedParam181 : var191), namedParam81 : match {
            case var56 => 
            ();
            Int32(34);
            let var202 : Unit = ();
            (var104, UInt16(117), var202, (-22))
            case _ => 
            var207;
            (var104, var104, var207, (-110))
        }, namedParam82 : (Option<UInt32>.None ?? UInt32(133)))) { func225(namedParam226 : var144[1], namedParam227 : UInt32(251), namedParam228 : var246[2]) } else { match (if (var56) { // block id: 257
                var157
            } else { // block id: 259
                Int32(-81);
                Option<((UInt16*UInt16*Unit*Int64)*Bool*Bool)>.None
            }) {
            case _ => 
                var237
            
        } } ;
        (Option<UInt8>.Some(var98) ?? var274.func277());
        (-74)
    }

}

extend Class62 {

}


/*
return code: 139
*/
// ASSERT: scan parse_expected_right_delimiter
