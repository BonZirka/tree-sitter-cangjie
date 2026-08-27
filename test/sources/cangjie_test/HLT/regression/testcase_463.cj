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


// ASSERT: regex 236122436401651

// random seed:1628876403907

// All global variable need to be defined before use!
public let var30 : Class16 = Class16()
public var var33 : UInt32 = UInt32(50)
public let var37 : Interface18<Bool> = Class16()
public let var60 : Bool = true
public var var63 : Option<Bool> = ((Option<Bool>.None as Bool) as Bool)
public let var75 : (UInt32,UInt64) = (UInt32(127), UInt64(117))
 let var82 : (Bool,UInt64,Bool,(UInt32,UInt64)) = ((((false is UInt32) is Float32) is Bool), UInt64(96), false, (UInt32(58), UInt64(4)))
public var var122 : Int32 = Int32(53)
public let var128 : Int8 = Int8(-78)
 let var141 : Option<UInt32> = Option<UInt32>.None
public var var145 : UInt64 = UInt64(19)
public var var177 : Bool = (false is (UInt32,UInt64))
public let var209 : Rune = r'g'
public let var221 : Option<Bool> = Option<Bool>.None
public var var244 : Bool = (true is UInt64)
public var var259 : Unit = ()
public var var262 : Option<Unit> = (Option<Unit>.None as Unit)
public var var270 : Int64 = 98
public var var336 : Interface17<Rune, Unit> = Class16()
public var var359 : Float64 = 76.0
public var var382 : Option<Int64> = Option<Int64>.None
main(): Int64 {
    func8(namedParam9 : match (var336) {
        case _ => 
            var259;
            var270
        
        case caseVar345 : ((UInt32,UInt64),Bool,Unit,UInt32) =>
            var259;
            (-120)
        
        case _ => 
            var259;
            (-7)
        
    }, namedParam10 : (Option<Float64>.Some(var359) ?? 2.0), namedParam13 : UInt8(99));
    (if (var244) { Option<Int64>.None } else { Option<Int64>.Some(var270) }  ?? (var382 ?? 18))
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var145), 64)
    crccheck.updateBuffer(UInt64(var270), 64)
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
        crc_output = Array<Int64> (crc_output_n, repeat:0)
        buffer = Array<Int64> (buffer_n, repeat:0)
        poly_n = crc_n + 1
        poly = Array<Int64> (poly_n, repeat:0)
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
        var byteArray = Array<Int64> (byte_n, repeat:0)
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
        var crc_buffer = Array<Int64> (crc_output_n, repeat:0)
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
        crc_output = Array<Int64> (crc_output_n, repeat:0)
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
 func func8(namedParam9 ! : Int64, namedParam10 ! : Float64, optionalParam11 ! : UInt16 = UInt16(41), namedParam13 ! : UInt8) : Unit { // block id: 14
    func22(namedParam23 : var33, optionalParam24 : var37.func40(var145, false)).func149(if (true) { // block id: 321
        var270;
        (-59.0)
    } else if (true) { // block id: 325
        18.0
    } else { // block id: 327
        (-50.0)
    }, optionalParam153 : Class16.var332)
}

public open class Class16 <: Interface17<Rune, Unit> & Interface18<Bool> {
    public init() { // block id: 20

    }
;
    public static var var332 : Unit = ()
}

public interface Interface17<T1, T2> {

}

public interface Interface18<T1> <: Interface17<Rune, Unit> {
    func func48(namedParam49 ! : UInt64) : UInt32 { // block id: 50
        var var68 : Bool = (true is Int16);
        if ((var63 ?? var68)) { // block id: 71
            UInt8(80);
            ();
            var75
        } else if (var82[2]) { // block id: 94
            var30;
            (UInt32(159), UInt64(9))
        } else { // block id: 99
            (UInt32(104), namedParam49)
        }[0]
    }
;
    func func40(param41 : UInt64, param42 : Bool) : Interface17<Rune, Unit> { // block id: 43
        let var108 : UInt32 = UInt32(120);
        match (var37.func48(namedParam49 : UInt64(201))) {
            case 120 => 
                ();
                param42
            
            case 59 => 
                param42
            
            case 247 | 153 | 120 => 
                var122;
                var60
            
            case _ => 
                var128;
                var30;
                true
            
        };
        func22(namedParam23 : ((var141 as UInt32) ?? var33))
    }
;
    static func func157(namedParam158 ! : Rune, namedParam159 ! : Option<Bool>, namedParam160 ! : (UInt32,UInt64)) : Unit { // block id: 161

    }
;
    func func165(namedParam166 ! : Int8, namedParam167 ! : Float64, namedParam168 ! : Int64) : Rune { // block id: 169
        let var226 : ((UInt32,UInt64),Bool,Unit,UInt32) = ((UInt32(31), UInt64(8)), false, (), UInt32(198));
        match {
            case (match (Option<UInt32>.None) {
                case _ : Class16 => 
                    UInt8(88);
                    Option<Bool>.Some(var177)
                
                case caseVar190 : Int8 => 
                    var30;
                    Option<Bool>.Some(var177)
                
                case _ => 
                    var82;
                    Option<Bool>.Some(var177)
                
            } ?? if (false) { var60 } else { false } ) => 
            (Option<Rune>.None ?? var209)
            case ((var221 as Bool) ?? var226[1]) => 
            var loopTimeVar241 : Int64 = 0;
            do {
                loopTimeVar241++;
                ()
            } while (var177 && loopTimeVar241 < 100 ) ;
            var loopTimeVar250 : Int64 = 0;
            while (var244 && loopTimeVar250 < 100 ) {
                loopTimeVar250++;
                ()
            };
            r'G'
            case _ => 
            (var262 ?? ());
            r'v'
        }
    }

}

public func func22(namedParam23 ! : UInt32, optionalParam24 ! : Interface17<Rune, Unit> = Class16(), optionalParam26 ! : UInt32 = UInt32(66)) : Class16 { // block id: 28
    var30
}










extend Class16 {
    public func func149(param150 : Float64, optionalParam151 ! : Int8 = Int8(-85), optionalParam153 ! : Unit = ()) : Unit { // block id: 155
        func157(namedParam158 : Class16().func165(namedParam166 : Int8(54), namedParam167 : param150, namedParam168 : var270), namedParam159 : var63, namedParam160 : if (match (Class16()) {
            case caseVar278 : Float32 => 
                (var33, UInt64(109));
                var259;
                false
            
            case _ => 
                var60
            
        }) { match {
            case true => 
            ();
            var75
            case var177 => 
            (true, UInt64(241), false, var75);
            10.0;
            (var33, var145)
            case _ => 
            (-42.0);
            ();
            (var33, UInt64(87))
        } } else { (var33, UInt64(133)) } );
        var loopTimeVar318 : Int64 = 0;
        do {
            loopTimeVar318++;
            ()
        } while (false && loopTimeVar318 < 100 ) 
    }

}

extend Class16 {

}


/*
return code: 139
*/
