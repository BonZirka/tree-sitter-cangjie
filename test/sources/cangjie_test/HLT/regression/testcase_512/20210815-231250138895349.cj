/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



// random seed:1629069170671

// All global variable need to be defined before use!
public let var39 : Unit = ()
public let var99 : Bool = (true is UInt32)
public let var104 : Bool = false
public var var126 : Option<Unit> = ((Option<Unit>.None as Unit) as Unit)
public let var185 : Bool = ((false is Int8) is Bool)
public let var221 : Int16 = Int16(74)
public let var229 : Int32 = Int32(-4)
public let var248 : UInt64 = UInt64(5)
public let var268 : Class76 = Class76()
 let var278 : Float32 = Float32(-20.0)
public let var354 : Aggregate8 = Aggregate8()
public let var383 : UInt32 = UInt32(5)
public let var399 : Bool = (false is Class76)
public let var404 : Int8 = Int8(-91)
 var var469 : UInt16 = UInt16(19)
public let var474 : Int32 = Int32(-34)
 let var479 : (Int16*Float64*UInt8) = (Int16(50), (-43.0), UInt8(85))
public let var555 : UInt8 = UInt8(216)
public let var568 : Bool = false
public var var581 : Rune = 'J'
public var var594 : Float64 = 104.0
public var var661 : Option<Unit> = (((Option<Unit>.Some(var39) as Unit) as Unit) as Unit)
public var var686 : Bool = (false is UInt16)
public let var730 : (Bool*UInt32) = (false, UInt32(217))
public let var781 : Option<Aggregate8> = ((Option<Aggregate8>.Some(var354) as Aggregate8) as Aggregate8)
public var var838 : UInt8 = UInt8(55)
public let var862 : Option<Option<Unit>> = ((((Option<Option<Unit>>.Some(var661) as Option<Unit>) as Option<Unit>) as Option<Unit>) as Option<Unit>)
public let var935 : Option<Float32> = Option<Float32>.None
public let var942 : Option<Class76> = (Option<Class76>.Some(var268) as Class76)
public var var1038 : (Unit*Option<Aggregate8>*UInt32) = ((), (Option<Aggregate8>.Some(var354) as Aggregate8), UInt32(233))
public var var1050 : Int64 = (-107)
public var var1059 : Unit = ()
main(): Int64 {
    func12().func853()
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var221), 64)
    crccheck.updateBuffer(UInt64(var404), 64)
    crccheck.updateBuffer(UInt64(var555), 64)
    crccheck.updateBuffer(UInt64(var1050), 64)
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
public struct Aggregate8 {
    public init() { // block id: 10

    }
;
    public static let var1028 : Option<Bool> = Option<Bool>.Some(var185);
    public func func853() : Int64 { // block id: 854
        match ((if (var104) { // block id: 859
                Int8(-48);
                var862
            } else if (var185) { // block id: 870
                ();
                Option<Option<Unit>>.Some(var661)
            } else { // block id: 873
                var661;
                ();
                Option<Option<Unit>>.None
            } ?? Option<Unit>.None)) {
            case caseVar880 => 
                Option<Aggregate8>.Some(var354);
                var39;
                (var185, var383)
            
            case caseVar889 : Option<Aggregate8> => 
                (false, UInt32(91))
            
            case _ => 
                var39;
                (true, var383)
            
        };
        var var1069 : Option<Int64> = Option<Int64>.None;
        if (match (match (UInt8(100)) {
                case _ : Float64 => 
                    var39;
                    Class76(namedParam910 : ())
                
                case _ : Float32 => 
                    Class76()
                
                case _ : UInt16 => 
                    Class76(namedParam910 : (), optionalParam911 : Option<Float64>.Some(var594))
                
                case caseVar969 => 
                    var268
                
                case _ => 
                    ();
                    var39;
                    var268
                
            }) {
            case _ => 
                var39;
                ();
                var399
            
            case _ => 
                var var987 : Option<Aggregate8> = Option<Aggregate8>.None;
                var987;
                ();
                true
            
            case caseVar993 => 
                var104
            
            case _ : (Class76*Int8*UInt32) => 
                ();
                var686
            
            case _ => 
                var39;
                var39;
                var99
            
        }) { // block id: 1006
            match (var838) {
                case caseVar1011 : Option<Float64> => 
                    var var1014 : (Unit*Option<Aggregate8>*UInt32) = ((), (((Option<Aggregate8>.Some(var354) as Aggregate8) as Aggregate8) as Aggregate8), UInt32(248));
                    var1014
                
                case 105 => 
                    UInt16(168);
                    var1028;
                    ((), Option<Aggregate8>.Some(var354), var383)
                
                case _ => 
                    var1038
                
            };
            (Option<Int64>.None ?? (-49))
        } else { // block id: 1054
            if (var568) { // block id: 1057
                var1059;
                ();
                (-45)
            } else if (var568) { // block id: 1064
                true;
                (-2)
            } else { // block id: 1067
                var1069;
                (-14)
            }
        }
    }

}

public func func12() : Aggregate8 { // block id: 13
    var var22 : (Bool*UInt32) = ((((false is Aggregate8) is UInt16) is Aggregate8), UInt32(151));
    var var30 : Bool = true;
    var var34 : Unit = ();
    let var843 : Float64 = (-55.0);
    if (if (false) { // block id: 19
        ();
        var22
    } else if (var30) { // block id: 32
        var34;
        var22
    } else { // block id: 37
        var39;
        ();
        var22
    }[0]) { // block id: 44
        func46(namedParam52 : var469, namedParam53 : var581);
        if (false) { (var221, (-52.0), var838) } else { (Int16(11), var843, var555) } ;
        if (var399) { () } else { () } 
    };
    var34;
    Aggregate8()
}

public func func46(optionalParam47 ! : Bool = (((true is Rune) is UInt64) is Int64), namedParam52 ! : UInt16, namedParam53 ! : Rune, optionalParam54 ! : (Bool*UInt32) = (((true is Float32) is UInt8), UInt32(76))) : Unit { // block id: 60
    if (false) { // block id: 63
        var39;
        if (true) { // block id: 67

        } else if (optionalParam47) { // block id: 69
            UInt32(100);
            var39
        };
        func73()
    }
}

public func func73() : Unit { // block id: 74
    let var89 : Class76 = Class76();
    func func80(param81 : Float32, namedParam82 ! : Aggregate8, namedParam83 ! : UInt8) : Class76 { // block id: 84
        if (if (var89.var92) { // block id: 95
            var39;
            ();
            var99
        } else if ((var104 is Bool)) { // block id: 106
            true
        } else { // block id: 108
            UInt8(106);
            var var111 : Unit = ();
            var111;
            true
        }) { (match (Class76()) {
            case _ : Aggregate8 => 
                var126
            
            case caseVar132 : Int16 => 
                var126
            
            case _ => 
                var39;
                123;
                Option<Unit>.None
            
        } ?? var39) } else { if (var89.var145) { // block id: 151
            ();
            var39;
            ()
        } } ;
        Int8(123);
        let var253 : (Class76*Int8*UInt32) = (Class76(), Int8(25), UInt32(9));
        if (func158(namedParam161 : match (Option<Bool>.Some(var185)) {
            case caseVar242 => 
                UInt64(114)
            
            case _ => 
                var248
            
        })) { var253[0] } else { (if (var185) { var89 } else { (Option<Class76>.None ?? Class76()) } ) } 
    }
;
    func80(match (var104) {
        case _ => 
            ();
            var278
        
    }, namedParam82 : func281(optionalParam282 : var469, namedParam284 : Option<Bool>.Some(var185), namedParam285 : var474), namedParam83 : var479[2]).var486;
    Class76.func491(if (var99) { // block id: 795
        ();
        UInt32(79);
        (var469, Aggregate8())
    } else if (true) { // block id: 802
        ();
        ();
        let var806 : (UInt16*Aggregate8) = (UInt16(12), Aggregate8());
        var806
    } else { // block id: 810
        var39;
        let var813 : (UInt16*Aggregate8) = (UInt16(12), Aggregate8());
        var813
    }, optionalParam495 : if (var104) { var185 } else { var185 } );
    if ((if (true) { var568 } else { false }  is UInt8)) { // block id: 827
        var39;
        ()
    }
}

public open class Class76 {
    public init() { // block id: 78

    }
;
    public var var92 : Bool = (true is (Bool*UInt32));
    public var var145 : Bool = ((((false is Bool) is UInt8) is UInt8) is Rune);
    public let var313 : Bool = false;
    public var var438 : Aggregate423<Aggregate8, Rune> = Aggregate423<Aggregate8, Rune>();
    public open func func407(namedParam408 ! : Option<Aggregate8>, namedParam409 ! : UInt16, namedParam410 ! : Option<Aggregate8>) : Aggregate8 { // block id: 411
        var var418 : (UInt16*Aggregate8) = (UInt16(151), Aggregate8());
        if (var399) { // block id: 416
            var418
        } else if (Aggregate423<Aggregate8, Rune>.var428) { // block id: 431
            var39;
            (namedParam409, var354)
        } else { // block id: 436
            var438;
            var418
        }[1]
    }
;
    public let var486 : Int8 = Int8(109);
    public static var var506 : Bool = (false is UInt32);
    private func func540(namedParam541 ! : Bool) : Option<Unit> { // block id: 542
        var var550 : Option<Bool> = Option<Bool>.Some(var185);
        match ((if (var145) { // block id: 547
                Float32(115.0);
                var550
            } else if (var99) { // block id: 553
                var555;
                'U';
                var550
            } else { // block id: 559
                var550
            } as Bool)) {
            case _ => 
                var39;
                ();
                var126
            
        }
    }
;
    private static func func531(namedParam532 ! : UInt64, optionalParam533 ! : Aggregate8 = Aggregate8(), namedParam535 ! : Unit) : Option<Unit> { // block id: 536
        var268.func540(namedParam541 : if (var568) { true } else { var568 } );
        namedParam535;
        (Option<Unit>.None as Unit)
    }
;
    public static let var602 : Option<Float64> = (Option<Float64>.None as Float64);
    private static var var735 : Option<(Bool*UInt32)> = Option<(Bool*UInt32)>.None;
    private static func func641(param642 : UInt64, optionalParam643 ! : UInt64 = UInt64(48), optionalParam645 ! : Float32 = Float32(-105.0)) : Float64 { // block id: 647
        (((Option<Option<Unit>>.Some(var661) ?? Option<Unit>.Some(var39)) as Unit) ?? ());
        var loopTimeVar704 : Int64 = 0;
        var loopTimeVar720 : Int64 = 0;
        if ((if (false) { (var506 is (Class76*Int8*UInt32)) } else { (var506 is Option<Aggregate8>) } )) { (if (if (true) { // block id: 681
            var221;
            var39;
            var99
        } else if (var686) { // block id: 689
            Option<Option<Unit>>.None;
            Option<Aggregate8>.None;
            var506
        } else { // block id: 693
            ();
            ();
            false
        }) { while (var104 && loopTimeVar704 < 100 ) {
            loopTimeVar704++;
            var var701 : Option<Aggregate8> = Option<Aggregate8>.None;
            var701
        } } else { (if (var99) { var39 } else { () } ) } ) } else { (var126 ?? do {
            loopTimeVar720++;
            ((), Option<Aggregate8>.None, UInt32(223));
            ()
        } while (true && loopTimeVar720 < 100 ) ) } ;
        if (var506) { match ((var735 ?? (false, UInt32(178)))) {
            case (false | false,var383 | 182) => 
                var39;
                71.0
            
            case (caseVar748 : UInt32,caseVar748 | 148) => 
                ();
                var39;
                var594
            
            case _ => 
                var39;
                (-85.0)
            
            case _ => 
                38.0
            
        } } else { 77.0 } 
    }
;
    public static func func630(param631 : UInt8, namedParam632 ! : Int16, optionalParam633 ! : UInt32 = UInt32(207), optionalParam635 ! : Rune = 'N') : Float64 { // block id: 637
        Class76.func641(if (false) { UInt64(229) } else { UInt64(225) } )
    }
;
    public static func func525(namedParam526 ! : UInt16) : Unit { // block id: 527
        Class76.func531(namedParam532 : var248, optionalParam533 : match (Option<Class76>.None) {
            case _ => 
                var581;
                var39;
                var var585 : Aggregate8 = Aggregate8();
                var585
            
        }, namedParam535 : var39);
        (if ((if (var506) { false } else { true } )) { var602 } else { match ((Int16(-44), var594, UInt8(54))) {
            case _ => 
                var39;
                var126;
                Option<Float64>.Some(var594)
            
            case caseVar618 : (Int16*Float64*UInt8) => 
                ();
                Option<Float64>.None
            
            case _ => 
                UInt16(151);
                ();
                var602
            
        } }  ?? Class76.func630(UInt8(77), namedParam632 : Int16(15), optionalParam633 : UInt32(5), optionalParam635 : 'w'));
        var loopTimeVar789 : Int64 = 0;
        while (var399 && loopTimeVar789 < 100 ) {
            loopTimeVar789++;
            (var781 ?? var354);
            ()
        }
    }
;
    public static let var791 : UInt16 = UInt16(131);
    public static func func491(param492 : (UInt16*Aggregate8), optionalParam493 ! : UInt32 = UInt32(252), optionalParam495 ! : Bool = ((false is UInt16) is Int32)) : Unit { // block id: 499
        var229;
        Int8(28);
        let var511 : Bool = (false is Option<Class76>);
        if ((Class76.var506)) { (if (var511) { (if (optionalParam495) { () } else { var39 } ) } else { (if (optionalParam495) { var39 } else { var39 } ) } ) } else { (Class76.func525(namedParam526 : var791)) } 
    }
;
    public static var var938 : Float32 = Float32(92.0);
    public init(namedParam910 ! : Unit, optionalParam911 ! : Option<Float64> = Option<Float64>.None) { // block id: 913
        var var924 : (Unit*Option<Aggregate8>*UInt32) = ((), (Option<Aggregate8>.Some(var354) as Aggregate8), UInt32(174));
        (if (var568) { // block id: 922
            var924;
            Option<Float32>.None
        } else { // block id: 931
            var39;
            ();
            var935
        } ?? var938);
        match (var942) {
            case caseVar948 : UInt16 => 
                namedParam910;
                Float32(-12.0);
                Class76()
            
            case _ => 
                var268
            
        }
    }

}


public func func158(optionalParam159 ! : UInt16 = UInt16(25), namedParam161 ! : UInt64, optionalParam162 ! : Rune = 'W') : Bool { // block id: 164
    let var193 : Float32 = Float32(-36.0);
    var var208 : Option<Bool> = (Option<Bool>.Some(var185) as Bool);
    if ((match (Option<Unit>.Some(var39)) {
        case caseVar172 => 
            var104
        
        case caseVar177 => 
            var39;
            var99
        
        case _ => 
            var185
        
        case _ => 
            var193;
            var99;
            var99
        
        case _ => 
            false
        
    } is Int16)) { if ((var208 ?? false)) { // block id: 212

    } } else { match (if (var104) { Int16(111) } else { Int16(89) } ) {
        case -50 | -49 | var221 | -53 => 
            Int8(79);
            var39
        
        case _ => 
            var229;
            var39;
            var39
        
    } } ;
    var var234 : Unit = ();
    var234;
    var185
}



 func func281(optionalParam282 ! : UInt16 = UInt16(231), namedParam284 ! : Option<Bool>, namedParam285 ! : Int32) : Aggregate8 { // block id: 286
    var var293 : Rune = 'r';
    var loopTimeVar296 : Int64 = 0;
    let var300 : (Int32*Unit*Int64*UInt64) = (Int32(-61), (), (-106), UInt64(253));
    if (true) { while (true && loopTimeVar296 < 100 ) {
        loopTimeVar296++;
        var293
    } } else { var300[1] } ;
    ();
    let var372 : (Unit*Option<Aggregate8>*UInt32) = ((), Option<Aggregate8>.Some(var354), UInt32(163));
    func func388(optionalParam389 ! : Bool = false, optionalParam391 ! : Unit = (), optionalParam393 ! : Class76 = Class76(), namedParam395 ! : Int8) : Class76 { // block id: 396
        Class76()
    }
;
    func func341(param342 : Float32, namedParam343 ! : Int32, namedParam344 ! : Option<Unit>, optionalParam345 ! : Rune = 'C') : Aggregate8 { // block id: 347
        (if (true) { // block id: 360
            var39;
            Int8(11);
            (var39, Option<Aggregate8>.Some(var354), UInt32(230))
        } else if (var99) { // block id: 369
            var221;
            var372
        } else { // block id: 377
            var39;
            ((), Option<Aggregate8>.Some(var354), var383)
        }[1] ?? func388(optionalParam389 : var399, optionalParam391 : var39, namedParam395 : var404).func407(namedParam408 : Option<Aggregate8>.Some(var354), namedParam409 : UInt16(208), namedParam410 : Option<Aggregate8>.Some(var354)))
    }
;
    if (if (var268.var313) { // block id: 315
        var104
    } else if (if (false) { false } else { true } ) { // block id: 321
        ();
        false
    } else { // block id: 324
        Int32(100);
        false
    }) { // block id: 327
        if (var104) { () } else { var39 } ;
        (Option<Unit>.None ?? ());
        func341(var278, namedParam343 : var229, namedParam344 : Option<Unit>.Some(var39), optionalParam345 : 'V')
    } else { // block id: 451
        Aggregate453<Int64, Bool>.var458;
        if (false) { // block id: 463
            ();
            Aggregate8()
        } else { // block id: 466
            Aggregate8()
        }
    }
}



public struct Aggregate423<T1, T2> {
    public init() { // block id: 425

    }
;
    public static let var428 : Bool = (true is (Unit*Option<Aggregate8>*UInt32))
}

public struct Aggregate453<T1, T2> {
    public init() { // block id: 455

    }
;
    public static var var458 : Option<Unit> = (Option<Unit>.Some(var39) as Unit)
}
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_unmatched_right_delimiter
// ASSERT: scan parse_illegal_or_pattern
// ASSERT: scan parse_expected_decl
