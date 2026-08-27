/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



// random seed:1628970245634

// All global variable need to be defined before use!
 let var11 : Class7 = Class7()
public var var32 : Aggregate28<UInt64> = Aggregate28<UInt64>()
public var var59 : Bool = false
public let var94 : Option<Bool> = Option<Bool>.None
 let var97 : Option<Option<Bool>> = (Option<Option<Bool>>.Some(var94) as Option<Bool>)
public let var115 : (Float32*UInt64*UInt16) = (Float32(50.0), UInt64(97), UInt16(57))
public var var177 : UInt32 = UInt32(12)
public var var247 : Unit = ()
public let var266 : Bool = (true is Rune)
 let var290 : Float64 = (-112.0)
 let var325 : Option<Bool> = ((Option<Bool>.Some(var59) as Bool) as Bool)
public var var330 : Option<Bool> = (Option<Bool>.Some(var59) as Bool)
public var var334 : ((Bool*Unit)*UInt16*Float32*Bool) = ((((false is (Float32*UInt64*UInt16)) is Unit), ()), UInt16(166), Float32(97.0), (false is UInt8))
public var var357 : Option<Unit> = (Option<Unit>.Some(var247) as Unit)
public var var369 : Int64 = 10
main(): Int64 {
    var11.func15(namedParam16 : var177)
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var369), 64)
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
 open class Class7 {
    public init() { // block id: 9

    }
;
    public var var309 : Option<Option<Bool>> = Option<Option<Bool>>.Some(var94);
    public open func func15(namedParam16 ! : UInt32) : Int64 { // block id: 17
        let var313 : (Bool*Unit) = ((true is Class126), ());
        let var320 : Float32 = Float32(-103.0);
        func19(var32.func35(optionalParam38 : var290), namedParam21 : if (var266) { // block id: 296
            let var303 : Float32 = Float32(87.0);
            ((true, ()), UInt16(177), var303, var59)
        } else if (var59) { // block id: 307
            var309;
            (var313, UInt16(43), var320, var59)
        } else { // block id: 323
            var325;
            var330;
            var334
        }[2]);
        (match {
            case (var266 is Option<UInt32>) => 
            var357
            case _ => 
            Option<Unit>.None
        } ?? (false, var247)[1]);
        var369
    }

}

public func func19(param20 : UInt32, namedParam21 ! : Float32, optionalParam22 ! : UInt64 = UInt64(135), optionalParam24 ! : Rune = 'w') : Unit { // block id: 26

}

public struct Aggregate28<T1> {
    public init() { // block id: 30

    }
;
    public var var121 : Option<(Float32*UInt64*UInt16)> = Option<(Float32*UInt64*UInt16)>.None;
    public let var217 : Bool = (false is (Float32*UInt64*UInt16));
    public let var283 : Int16 = Int16(-42);
    public mut func func35(optionalParam36 ! : Int32 = Int32(-116), optionalParam38 ! : Float64 = (-44.0)) : UInt32 { // block id: 40
        (-72);
        var var253 : Int64 = 3;
        func43(namedParam44 : if ((Option<Bool>.None ?? true)) { // block id: 244
            (-97.0);
            var247;
            (-115)
        } else { // block id: 250
            var247;
            var253
        }, optionalParam45 : var253, namedParam47 : if (match {
            case true => 
            var247;
            ();
            false
            case true => 
            var266
            case _ => 
            ();
            false
        }) { // block id: 272
            '6';
            var247;
            Int16(66)
        } else if (if (var266) { true } else { var217 } ) { // block id: 280
            ();
            var283
        } else { // block id: 285
            var247;
            var115;
            var283
        })
    }

}






public open class Class126 <: Interface127 & Interface128<Float32> {
    public init() { // block id: 130

    }
;
    public static let var133 : Bool = false
}

public interface Interface127 {

}

 interface Interface128<T1> <: Interface127 {

}




extend Class126 {

}

extend<T1> Aggregate28<T1> {
    public func func43(namedParam44 ! : Int64, optionalParam45 ! : Int64 = (-117), namedParam47 ! : Int16, optionalParam48 ! : Float64 = 14.0) : UInt32 { // block id: 50
        var var62 : Option<Bool> = Option<Bool>.Some(var59);
        var loopTimeVar170 : Int64 = 0;
        while (if ((var62 ?? var59)) { (Option<Bool>.None ?? false) } else { func76(optionalParam77 : UInt8(201)) }  && loopTimeVar170 < 100 ) {
            loopTimeVar170++;
            ();
            var var154 : Unit = ();
            match (25.0) {
                case caseVar142 => 
                    var var145 : Unit = ();
                    var145
                
                case 51.0 | optionalParam48 | 41.0 => 
                    '9';
                    UInt8(245);
                    var154
                
                case -31.0 => 
                    var154
                
                case 57.0 | -11.0 | 114.0 | optionalParam48 => 
                    var154
                
                case _ => 
                    var154;
                    ()
                
            }
        };
        let var212 : Rune = 'b';
        func func182(optionalParam183 ! : Unit = (), namedParam185 ! : Int32) : Rune { // block id: 186
            var loopTimeVar204 : Int64 = 0;
            while (if ((if (var59) { var59 } else { var59 } )) { (false, ())[0] } else { (true is Option<UInt32>) }  && loopTimeVar204 < 100 ) {
                loopTimeVar204++;
                ()
            };
            match (false) {
                case _ => 
                    Int32(-9);
                    var212
                
                case var217 | true => 
                    ();
                    var212
                
                case _ => 
                    false;
                    var212
                
            };
            var212
        }
;
        let var229 : Unit = ();
        (Option<UInt32>.None ?? match (func182(optionalParam183 : var229, namedParam185 : Int32(-27))) {
            case _ => 
                var177
            
        })
    }
;
    public func func76(optionalParam77 ! : UInt8 = UInt8(181)) : Bool { // block id: 79
        UInt16(181);
        if (((var97 ?? Option<Bool>.Some(var59)) ?? if (true) { var59 } else { var59 } )) { UInt16(189) } else { (var121 ?? var115)[2] } ;
        Class126.var133
    }

}

extend Class126 {

}


/*
return code: 139
*/
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_expected_decl
