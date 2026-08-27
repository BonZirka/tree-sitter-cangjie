/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

public var var13 : String = ":HXMbLbO7?"
public let var17 : UInt8 = UInt8(18)
public let var51 :  (Aggregate20,Int32,Int16,Float64) = (Aggregate20(), Int32(UInt16(UInt32((-8.0)))), Int16(UInt64(160)), (-110.0))
public var var69 : Int16 = Int16(-31)
public var var105 :  (Int8,Int32,Bool) = (Int8(Float32(UInt32(201))), Int32(-52), ((Int8(-86), Int32(UInt8(194)), false) is Int32))
public let var139 : Unit = ()
public let var142 : Option<Unit> = Option<Unit>.Some(var139)
public let var235 : Float64 = Float64(Float64(40.0))
 var var381 : Bool = ((Int8(UInt32(109)), Int32(97), (Int8(73) is Option<Unit>)) is  (Int32,Int64,UInt64,Float64,Bool,UInt64,UInt16,Rune))
 let var404 : Int8 = Int8(51)
 let var477 : Aggregate473<Aggregate192, Int16, Range<UInt32>> = Aggregate473<Aggregate192, Int16, Range<UInt32>>()
public let var485 : Array<Bool> = [true, false, false, false, false, true, false, false, true, true]
public let var502 : Int32 = Int32(71)
main(): Int64 {
    ((var17 as String) ?? Aggregate20.var25);
    let var80 : Class76<Int64, Range<UInt32>> = Class76<Int64, Range<UInt32>>(Int32(Int16(UInt8(16.0))), namedParam86 : Float32(58.0));
    let var506 : Int64 = (-110);
    let var526 : Rune = r'o';
    let var534 : (Int32, (Int8,Int32,Bool),Float64,(UInt64, (Unit,Float32,Int16,Int64),Range<UInt32>),Int8,Range<Int8>,Unit,Float64,UInt16) = (Int32(UInt8(Int16(UInt64(189)))), (Int8(-97), Int32(109.0), ((((UInt32(124))..(UInt32(110)):((48|1))), UInt8(115), (-47.0), (Int32(69), (-36), UInt64(26), (-37.0), true, UInt64(43), UInt16(62), r'K'), (), UInt32(56)) is Rune)), Float64(UInt8(249)), (UInt64(127), ((), Float32(Int32(-95)), Int16(-47), (-73)), ((UInt32(166))..(UInt32(229)):((-109)|1))), Int8(50), ((Int8(-94))..=(Int8(95)):((-76)|1)), (), Float64(UInt16(42)), UInt16(UInt32(Float32(-36.0))));
    func28(var80.var496, match (((var502)..(Int32(-78)):((var506|1)))) {
        case caseVar510 => 
            ((Int8(-103))..(Int8(53)):((11|1)));
            r'z'
        
        case caseVar519 : Range<Int8> => 
            r'b'
        
        case _ : Aggregate192 => 
            var526
        
        case _ => 
            r'x'
        
    }, var534[4])
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var506), 64)
    crccheck.updateBuffer(UInt64(var17), 64)
    crccheck.updateBuffer(UInt64(var404), 64)
    crccheck.updateBuffer(UInt64(var502), 64)
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

    public func crcCheck(): Unit {
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

    public func getCrcOutput(): Unit {
        var i = 0
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
        print("\n")
    }
}

public struct Aggregate20 {
    public init() { // block id: 22

    }
;
    public static let var25 : String = "!q=$\\>PeJG";
    public init(namedParam42 ! : Float32, optionalParam43 ! : Option<String> = (Int32(63) as String), namedParam46 ! : UInt8) { // block id: 47
        var51[0]
    }

}

public func func28(param29 : Int8, param30 : Rune, param31 : Int8) : Int64 { // block id: 32
    let var72 : Int64 = Int64(UInt8(158));
    match (match (Float32(UInt64(63))) {
            case _ => 
                UInt32(57);
                Aggregate20(namedParam42 : Float32(30.0), namedParam46 : UInt8(145));
                var17
            
        }) {
        case _ => 
            (-4);
            var69;
            var72
        
    }
}

public class Class76<T0, T1> {
    public init() { // block id: 78

    }
;
    public static var var118 : Option< (Int8,Int32,Bool)> = Option< (Int8,Int32,Bool)>.Some(var105);
    public static var var395 : Range<Int8> = ((Int8(-50))..=(Int8(15)):(37|1));
    public static func func91<T0, T1>(param92 : UInt64, optionalParam93 ! : Int64 = 28) : UInt64 { // block id: 95
        if ((var118 ?? var105)[2]) { // block id: 132
            (var142 ?? ());
            match (var142) {
                case _ => 
                    optionalParam93;
                    var139
                
            };
            var139
        };
        var var160 : Float32 = Float32(82.0);
        try { // block id: 154
            ((), var160, Int16(-65), 126)[0];
            if (true) { param92 } else { param92 } 
        } finally { // block id: 169
            func func171<T0>(optionalParam172 ! : Aggregate20 = Aggregate20()) : Bool { // block id: 174
                match (var142) {
                    case caseVar179 => 
                        ";BNP\\YGoxc"
                    
                    case _ => 
                        ();
                        var13
                    
                };
                func28(try { // block id: 362
                    Float32(-61.0);
                    ();
                    var69
                } catch (_) { // block id: 366
                    ();
                    ();
                    var69
                } finally { // block id: 370
                    ();
                    var139;
                    var69
                }, UInt64(34));
                ((if (var381) { // block id: 392
                    var118;
                    var395
                } else if (var381) { // block id: 398
                    var139;
                    var139;
                    ((Int8(-95))..(var404):((optionalParam93|1)))
                } else { // block id: 407
                    ((Int8(107))..=(Int8(-21)):((-110)|1))
                } as Bool) ?? if (Aggregate411<UInt16, Aggregate192, Range<UInt32>>.var416) { // block id: 418
                    true
                } else if (try { // block id: 421
                    UInt8(146);
                    false
                } catch (_) { // block id: 424
                    ((Int32(62))..=(Int32(-127)):(111|1));
                    var381
                } finally { // block id: 427
                    Int8(-63);
                    ();
                    false
                }) { // block id: 431
                    var381
                } else { // block id: 433
                    Aggregate20();
                    false
                })
            }
;
            func171<Range<UInt16>>();
            if (true) { // block id: 438
                UInt64(201)
            } else { // block id: 440
                UInt64(226)
            }
        }
    }
;
    private static mut prop var447 : (UInt64, (Unit,Float32,Int16,Int64),Range<UInt32>) { // block id: 448
        get() { // block id: 450
            ();
            ();
            (UInt64(55), ((), Float32(3.0), Int16(-53), (-61)), ((UInt32(168))..(UInt32(195)):((-58)|1)));
            var583
        }

        set(Value) { // block id: 463
            Option< (Int8,Int32,Bool)>.Some(var105);
            ();
            var583 = Value
        }

    };
    public static func func470<T0, T1>() : Bool where T0 <: Class76<Int64, Range<UInt32>> { // block id: 471
        var477.var480;
        var485[9]
    }
;
    public init(param83 : Int32, optionalParam84 ! : Bool = true, namedParam86 ! : Float32, optionalParam87 ! : Int8 = Int8(82)) { // block id: 89
        func91<Int64, UInt32>(Class76<Int64, Range<UInt32>>.var447[0], optionalParam93 : (-92));
        if (func470<Class76<Int64, Range<UInt32>>, Option< (Int8,Int32,Bool)>>()) { this } else { this }
    }
;
    public var var496 : Int8 = Int8(UInt64(219));
    public static var var583 : (UInt64, (Unit,Float32,Int16,Int64),Range<UInt32>) = (UInt64(UInt8(UInt64(229))), ((), Float32(Int16(Float32(-58.0))), Int16(-25), 23), ((UInt32(20))..(UInt32(21)):((-40)|1)))
}



 func func28(param188 : Int16, param189 : UInt64) : Option<String> { // block id: 190
    let var196 : Aggregate192 = Aggregate192();
    var196.var199;
    func func217<T0, T1>(namedParam218 ! : Unit, namedParam219 ! :  (Unit,Float32,Int16,Int64), optionalParam220 ! : Int16 = Int16(-49)) : Option<String> { // block id: 222
        Option<String>.None
    }
;
    var var354 :  (Unit,Float32,Int16,Int64) = ((), Float32(-26.0), Int16(UInt64(171)), 54);
    func217<Aggregate20, Bool>(namedParam218 : func225(), namedParam219 : try { // block id: 339
        ();
        var139;
        let var343 :  (Unit,Float32,Int16,Int64) = ((), Float32(UInt16(Int64(UInt16(41)))), Int16(-19), (-38));
        var343
    } catch (_) { // block id: 352
        var354
    })
}

public struct Aggregate192 {
    public init() { // block id: 194

    }
;
    public mut prop var199 : Unit { // block id: 200
        get() { // block id: 202
            (116.0 as Unit);
            UInt8(66);
            ()
        }

        set(Value) { // block id: 209
            (Int8(Int16(121)), Int32(123), true);
            ()
        }

    }
}

public func func225() : Unit { // block id: 226
    let var240 : Bool = (UInt32(147) is (Aggregate20) -> Bool);
    let var244 : UInt64 = UInt64(140);
    let var248 : Rune = r'r';
    var loopTimeVar252 : Range<UInt64> = ((UInt64(137))..(UInt64(Int8(Float32(UInt32(239))))):(((-123)|1)));
    for (i in loopTimeVar252 where ((Int32(-1), (-122), UInt64(141), var235, var240, var244, UInt16(127), var248)[4])) {

    };
    var var280 : Unit = ();
    try { // block id: 269
        let var283 : Float32 = Float32(Float64(Int8(112)));
        if (false) { // block id: 272
            var var274 : Range<UInt64> = ((UInt64(197))..(UInt64(62)):(39|1));
            var274;
            Float32(-86.0)
        } else if (false) { // block id: 278
            var280;
            var283
        } else { // block id: 287
            Float32(-38.0)
        };
        (var142 ?? ());
        (Option<Unit>.None ?? var139)
    } finally { // block id: 300
        let var305 : Int32 = Int32(Float32(Int64(UInt8(Float32(82.0)))));
        if (var240) { Int32(52) } else { var305 } ;
        var var314 : (Range<UInt32>,UInt8,Float64, (Int32,Int64,UInt64,Float64,Bool,UInt64,UInt16,Rune),Unit,UInt32) = (((UInt32(134))..(UInt32(230)):(93|1)), UInt8(Int32(Float64(41))), (-6.0), (Int32(Int64((-42))), 113, UInt64(42), Float64(Int8(-98)), true, UInt64(73), UInt16(Float32(8.0)), r'b'), (), UInt32(207));
        var314[4]
    }
}



public struct Aggregate411<T0, T1, T2> {
    public init() { // block id: 413

    }
;
    public static var var416 : Bool = false
}

public struct Aggregate473<T0, T1, T2> {
    public init() { // block id: 475

    }
;
    public var var480 : Float64 = (-10.0)
}


/*
[CHIR CodeGen Error]: generate enum selector failed.
return code: 139
*/
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_variable


