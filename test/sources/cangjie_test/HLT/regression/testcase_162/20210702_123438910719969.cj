/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-1:%compiler %cmp_opt %n.cj

// All global variable need to be defined before use!
public let var10 : Unit = ()
public let var230 : UInt16 = UInt16(75)
public var var244 : Int8 = Int8(-96)
public let var281 : (Bool*Unit*Float32*UInt32) = (false, (), Float32(-70.0), UInt32(244))
public let var303 : UInt64 = UInt64(199)
public var var338 : (Float32*Int16*Interface16*(Bool*Unit*Float32*UInt32)*UInt32) = (Float32(-86.0), Int16(-37), Class15(), (true, (), Float32(85.0), UInt32(63)), UInt32(16))
public var var377 : Int16 = Int16(-25)
public let var169 : Interface16 = Class15(namedParam172 : Int32(71), namedParam173 : Aggregate46(), namedParam174 : UInt64(74))
public let var505 : UInt32 = UInt32(32)
public var var931 : Aggregate927 = Aggregate927()
 var var1063 : Unit = ()
public let var57 : Bool = true
public var var90 : Int32 = Int32(-67)
 let var107 : Interface17 = Class15()
public let var113 : UInt16 = UInt16(68)
public var var160 : (Unit*Unit) = ((), ())
public let var165 : UInt8 = UInt8(97)
public let var192 : Unit = ()
public let var197 : Int32 = Int32(-8)
public var var321 : Bool = true
 let var561 : UInt16 = UInt16(30)
 let var568 : Int32 = Int32(-87)
public var var473 : Aggregate46 = Aggregate46(namedParam476 : UInt64(88), optionalParam477 : Class15())
public var var681 : (Unit*Unit) = ((), ())
public let var741 : Float64 = 21.0
public let var846 : Float32 = Float32(-70.0)
public let var961 : (Bool*Int8) = (false, Int8(23))
public var var991 : Int64 = (-104)
 let var1024 : UInt8 = UInt8(29)
public let var1047 : Bool = true
public let var1072 : Rune = 'e'
public let var1104 : Int64 = 95
public interface Interface17 {
    func func110() : Unit { // block id: 111
        var113;
        let var457 : Enum66 = Enum66.defaultValue;
        let var694 : Enum289 = Enum289.defaultValue;
        func func118() : Interface16 { // block id: 119
            func121(namedParam122 : var113, namedParam125 : if (if (true) { true } else { var57 } ) { // block id: 138
                Aggregate46()
            } else { // block id: 140
                var var142 : Aggregate46 = Aggregate46();
                var142
            });
            if ((var57, Int8(-74))[0]) { (Class15.var153) } else { match {
                case var57 => 
                ();
                var160;
                var165
                case var169.func383(Int32(-69), 64.0) => 
                ();
                (-90);
                var165
                case _ => 
                var165
            } } ;
            func func420(namedParam421 ! : UInt32, optionalParam422 ! : Float32 = Float32(-94.0), optionalParam424 ! : Enum289 = Enum289.defaultValue, namedParam426 ! : UInt64) : (Int64*Interface16*Rune) { // block id: 427
                var var429 : Rune = '2';
                var429;
                (match (((-70.0), optionalParam424, var165)[1]) {
                    case caseVar442@ defaultValue => 
                        caseVar442;
                        ();
                        81
                    
                    case defaultValue => 
                        31.0;
                        67
                    
                    case _ => 
                        (-57)
                    
                }, match (var457) {
                    case defaultValue => 
                        var169
                    
                    case caseVar465@ _ : UInt64 => 
                        (optionalParam422, var377, Class15(namedParam172 : var90, namedParam173 : var473, namedParam174 : namedParam426), (true, (), Float32(102.0), var505), var505);
                        ();
                        Class15(namedParam480 : Aggregate46(namedParam476 : UInt64(14)))
                    
                    case _ => 
                        var192;
                        var192;
                        var169
                    
                    case _ => 
                        var192;
                        var var666 : (Float64*Enum289*UInt8) = (51.0, Enum289.defaultValue, UInt8(114));
                        var666;
                        var169
                    
                }, match (Class15.var676) {
                    case _ => 
                        var681;
                        var429
                    
                })
            }
;
            let var690 : Float32 = Float32(54.0);
            func420(namedParam421 : UInt32(121), optionalParam422 : if (true) { var690 } else { var690 } , optionalParam424 : var694, namedParam426 : UInt64(112))[1]
        }
;
        match (func118().func699(var230, namedParam701 : Enum66.defaultValue, namedParam702 : Enum66.defaultValue, namedParam703 : var846)) {
            case defaultValue  => 
                ()
            
            case _ : Enum289 => 
                ();
                var10
            
            case _ => 
                UInt32(105);
                var10;
                var192
            
            case caseVar866@ caseVar865 : (Unit*Unit) => 
                var694;
                var10;
                ()
            
            case _ => 
                var303;
                var10
            
        };
        ()
    }

}

public struct Aggregate46 {
    public init() { // block id: 48

    }
;
    public static func func51(param52 : Int32, namedParam53 ! : Interface16) : Unit { // block id: 54
        var loopTimeVar61 : Int64 = 0;
        while (var57 && loopTimeVar61 < 100 ) {
            loopTimeVar61++;

        };
        var var80 : UInt64 = UInt64(31);
        var loopTimeVar88 : Int64 = 0;
        while (var57 && loopTimeVar88 < 100 ) {
            loopTimeVar88++;
            match (Enum66.defaultValue) {
                case caseVar71 => 
                    ();
                    ()
                
                case caseVar77@ defaultValue => 
                    var80;
                    UInt64(69);
                    ()
                
                case _ => 
                    var10
                
            }
        }
    }
;
    public static var var638 : Aggregate46 = Aggregate46();
    public init(namedParam476 ! : UInt64, optionalParam477 ! : Class15 = Class15(namedParam480 : Aggregate46())) { // block id: 589
        var10;
        var var626 : Aggregate622 = Aggregate622();
        if (if (if (var321) { // block id: 595
            (var57, (), Float32(-91.0), UInt32(173));
            true;
            var321
        } else if (true) { // block id: 604
            let var606 : (Bool*Int8) = (false, Int8(57));
            var606;
            ();
            var321
        } else { // block id: 612
            var321
        }) { (var169.func383(var197, 50.0)) } else { true } ) { // block id: 620
            var626.var629
        } else if (var57) { // block id: 632
            var var635 : Bool = false;
            if (var635) { var638 } else { Aggregate46() } 
        } else { // block id: 641
            var638
        }
    }
;
    public init(param953 : (Unit*Unit)) { // block id: 954
        ();
        var638
    }

}

public enum Enum66 {
    defaultValue |
    enumValue908
}
public func func270(param271 : Float32, param272 : UInt64, optionalParam273 ! : Int16 = Int16(26), namedParam275 ! : UInt8) : Bool { // block id: 276
    false
}

public struct Aggregate389 {
    public init() { // block id: 391

    }
;
    public static let var394 : Bool = false
}

public struct Aggregate581 {
    public init() { // block id: 583

    }
;
    public static let var586 : Int8 = Int8(-121)
}

public struct Aggregate622 {
    public init() { // block id: 624

    }
;
    public var var629 : Aggregate46 = Aggregate46();
    public init(param770 : (Float32*Int16*Interface16*(Bool*Unit*Float32*UInt32)*UInt32), optionalParam771 ! : (Bool*Unit*Float32*UInt32) = (false, (), Float32(25.0), UInt32(11)), namedParam777 ! : (Bool*Int8), optionalParam778 ! : (Int64*Interface16*Rune) = (19, Class15(namedParam480 : Aggregate46(namedParam476 : UInt64(185))), 'Y')) { // block id: 785
        var loopTimeVar795 : Int64 = 0;
        while (var57 && loopTimeVar795 < 100 ) {
            loopTimeVar795++;
            match (var741) {
                case _ => 
                    ()
                
            }
        };
        let var811 : Unit = ();
        match (if (false) { // block id: 799
                var505;
                UInt64(148)
            } else if (if (var321) { var57 } else { var321 } ) { // block id: 806
                ();
                var303
            } else { // block id: 809
                var811;
                namedParam777;
                var303
            }) {
            case 46 => 
                var165;
                7.0;
                var811
            
            case _ => 
                ()
            
        };
        Aggregate622()
    }

}

public func func21(optionalParam22 ! : Rune = 'k', optionalParam24 ! : Float32 = Float32(-74.0), optionalParam26 ! : Int32 = Int32(57), optionalParam28 ! : Rune = 'F') : Class15 { // block id: 30
    func32(namedParam33 : var505);
    let var1066 : Class15 = Class15();
    if (false) { // block id: 1035
        let var1040 : Class15 = Class15(namedParam480 : Aggregate46(((), ())));
        if (var321) { // block id: 1038
            var1040
        } else if (var1047) { // block id: 1049
            var1040
        } else { // block id: 1051
            (-10.0);
            var1040
        }
    } else { // block id: 1054
        match (UInt64(16)) {
            case _ => 
                ((), var10);
                var1063;
                var1066
            
        }
    }
}

public interface Interface16 {
    func func383(param384 : Int32, param385 : Float64) : Bool { // block id: 386
        var loopTimeVar407 : Int64 = 0;
        while (Aggregate389.var394 && loopTimeVar407 < 100 ) {
            loopTimeVar407++;
            var loopTimeVar401 : Int64 = 0;
            while (false && loopTimeVar401 < 100 ) {
                loopTimeVar401++;

            };
            if (var57) { var10 } else { var192 } 
        };
        true
    }
;
    func func553(param554 : Int16, param555 : UInt16, param556 : Rune, param557 : Rune) : Unit { // block id: 558

    }
;
    func func699(param700 : UInt16, namedParam701 ! : Enum66, namedParam702 ! : Enum66, namedParam703 ! : Float32) : Enum66 { // block id: 704
        Class15.func708(optionalParam709 : Class15.var767, namedParam719 : if (true) { var10 } else { () } )
    }
;
    func func893(param894 : Aggregate622, param895 : Int32, namedParam896 ! : (Unit*Unit), namedParam897 ! : UInt8) : UInt64 { // block id: 898
        match (if (if (var321) { var57 } else { true } ) { // block id: 905
                var505;
                Enum66.enumValue908
            } else { // block id: 909
                var192;
                var281;
                Enum66.defaultValue
            }) {
            case _ => 
                var10;
                var303
            
        }
    }

}

public open class Class15 <: Interface16 & Interface17 {
    public init() { // block id: 19

    }
;
    public static var var130 : Int64 = (-79);
    public static var var153 : UInt8 = UInt8(1);
    private static var var237 : Int64 = 77;
    public static let var260 : Aggregate46 = Aggregate46();
    public var var363 : Bool = true;
    private static var var369 : Interface16 = Class15();
    public var var373 : Float64 = 50.0;
    protected func func265(namedParam266 ! : Int16) : Interface16 { // block id: 267
        if (func270(var281[2], match (Enum289.defaultValue) {
            case caseVar294 : (Unit*Unit) => 
                UInt64(31)
            
            case _ : Aggregate46 => 
                var192;
                ();
                var303
            
            case caseVar307 : Unit => 
                UInt64(226)
            
            case _ => 
                Int8(-74);
                UInt64(183)
            
        }, namedParam275 : if (var57) { // block id: 316
            Float32(-104.0);
            var107;
            var153
        } else if (var321) { // block id: 323
            UInt8(208);
            var165
        } else { // block id: 326
            ();
            var10;
            UInt8(230)
        })) { match (Float32(-99.0)) {
            case _ => 
                Enum66.defaultValue;
                var338
            
        }[2] } else { if (if (false) { // block id: 353
            Enum66.defaultValue;
            false
        } else { // block id: 356
            ();
            var113;
            var321
        }) { // block id: 360
            Class15()
        } else if (var363) { // block id: 365
            ();
            true;
            var369
        } else { // block id: 371
            var373;
            Class15()
        } } 
    }
;
    public init(namedParam172 ! : Int32, namedParam173 ! : Aggregate46, namedParam174 ! : UInt64) { // block id: 175
        var var178 : Int8 = Int8(46);
        match (var178) {
            case caseVar183@ caseVar182 => 
                ()
            
            case _ => 
                Int32(-63);
                Int32(112);
                var192
            
            case _ => 
                var197;
                var192
            
        };
        let var224 : Enum66 = Enum66.defaultValue;
        if (if (false) { // block id: 203
            68.0;
            ();
            true
        } else { // block id: 207
            var192;
            true
        }) { match (var113) {
            case caseVar216@ 42 | var113 | var113 | 239 => 
                var130
            
            case caseVar221 : Bool => 
                var224;
                (-43)
            
            case caseVar232@ var230 => 
                var192;
                'c';
                var237
            
            case _ => 
                Class15();
                var244;
                var237
            
            case _ => 
                var130
            
        } } else { func121(namedParam122 : match ((-94)) {
            case _ => 
                UInt16(64)
            
        }, namedParam125 : if (var57) { namedParam173 } else { var260 } ) } ;
        Class15().func265(namedParam266 : var377)
    }
;
    public static let var571 : Class15 = Class15();
    private init(param484 : (Unit*Unit), namedParam485 ! : Int8) { // block id: 486
        Aggregate488.func493(var568);
        var571
    }
;
    private var var576 : (Unit*Unit) = ((), ());
    public init(namedParam480 ! : Aggregate46) { // block id: 481
        Class15(var571.var576, namedParam485 : Aggregate581.var586)
    }
;
    public static let var676 : Rune = 'y';
    public var var727 : Enum66 = Enum66.defaultValue;
    public static func func708(optionalParam709 ! : Aggregate622 = Aggregate622(), optionalParam711 ! : Aggregate389 = Aggregate389(), optionalParam713 ! : Interface17 = Class15(((), ()), namedParam485 : Int8(-92)), namedParam719 ! : Unit) : Enum66 { // block id: 720
        var260;
        let var759 : Aggregate581 = Aggregate581();
        var loopTimeVar762 : Int64 = 0;
        while (match (var571.var727) {
            case defaultValue  => 
                true
            
            case caseVar735 => 
                false
            
            case _ => 
                var741;
                var57
            
        } && loopTimeVar762 < 100 ) {
            loopTimeVar762++;
            if (false) { // block id: 747
                var473;
                Int8(-82);
                Aggregate581()
            } else if (var321) { // block id: 752
                var160;
                var244;
                Aggregate581()
            } else { // block id: 756
                var192;
                var759
            }
        };
        Enum66.defaultValue
    }
;
    public static var var767 : Aggregate622 = Aggregate622((Float32(98.0), Int16(-121), Class15(), (false, (), Float32(-56.0), UInt32(53)), UInt32(57)), namedParam777 : (true, Int8(-82)));
    public static var var884 : (Unit*Unit) = ((), ());
    public var var1075 : UInt8 = UInt8(222)
}

public func func121(namedParam122 ! : UInt16, optionalParam123 ! : UInt64 = UInt64(150), namedParam125 ! : Aggregate46) : Int64 { // block id: 126
    Class15.var130
}

public enum Enum289 {
    defaultValue
}
struct Aggregate488 {
    public init() { // block id: 490

    }
;
    public static func func493(param494 : Int32) : Unit { // block id: 495
        var var527 : (Bool*Int8) = (false, Int8(69));
        var var564 : Rune = 'r';
        if ((if (match (Enum289.defaultValue) {
            case defaultValue  => 
                ();
                var505;
                true
            
            case caseVar512@ caseVar511@ caseVar510 : UInt64 => 
                (true, var244);
                var321
            
            case _ => 
                ();
                true;
                false
            
        }) { match {
            case false => 
            var527;
            var57
            case var57 => 
            var57
            case _ => 
            Enum66.defaultValue;
            var321
        } } else { (if (true) { false } else { false } ) } )) { if (if (true) { true } else { true } ) { // block id: 547
            ();
            var10
        } } else { (var169.func553(var377, var561, var564, var564)) } 
    }

}

public func func42(namedParam43 ! : (Unit*Unit)) : (Bool*Int8) { // block id: 44
    let var103 : Interface16 = Class15();
    Aggregate46.func51(var90, namedParam53 : if (var57) { // block id: 94
        ();
        ();
        var var98 : Interface16 = Class15();
        var98
    } else { // block id: 100
        ();
        var103
    });
    var107.func110();
    var var877 : (Bool*Int8) = (false, Int8(4));
    var877
}

public struct Aggregate927 {
    public init() { // block id: 929

    }
;
    public mut func func934(optionalParam935 ! : (Bool*Unit*Float32*UInt32) = (true, (), Float32(63.0), UInt32(8)), optionalParam941 ! : Int8 = Int8(-122), namedParam943 ! : Rune, namedParam944 ! : Aggregate46) : Bool { // block id: 945
        true
    }

}

public func func32(namedParam33 ! : UInt32) : Unit { // block id: 34
    func func36(param37 : UInt64) : UInt8 { // block id: 38
        func42(namedParam43 : Class15.var884)[0];
        UInt8(194)
    }
;
    let var918 : Aggregate622 = Aggregate622();
    func36(var169.func893(var918, var90, namedParam896 : ((), var192), namedParam897 : UInt8(38)));
    var var949 : Rune = 'T';
    if ((var931.func934(optionalParam941 : Int8(-83), namedParam943 : var949, namedParam944 : Aggregate46(((), var192))))) { var961 } else { match (if (var321) { // block id: 968
            var10;
            var107
        } else if (var321) { // block id: 972
            Int16(4);
            Class15()
        } else { // block id: 975
            ();
            Class15(namedParam480 : var473)
        }) {
        case _ : Unit => 
            ();
            ();
            var961
        
        case caseVar987 : Aggregate622 => 
            var192;
            var991;
            var961
        
        case caseVar996 => 
            (false, Int8(106))
        
        case caseVar1005@ caseVar1004@ caseVar1003 => 
            Int8(54);
            (false, Int8(73))
        
        case _ => 
            (var321, var244)
        
    } } ;
    if (var57) { // block id: 1018
        if (false) { var113 } else { var113 } ;
        var1024;
        var loopTimeVar1031 : Int64 = 0;
        while (var57 && loopTimeVar1031 < 100 ) {
            loopTimeVar1031++;
            false
        }
    }
}

main(): Int64 {
    (var10, ())[1];
    func21(optionalParam22 : '6', optionalParam24 : var846, optionalParam26 : Int32(-13), optionalParam28 : var1072).var1075;
    var var1086 : Enum66 = Enum66.enumValue908;
    if (match (UInt64(118)) {
        case 209 | 19 | 125 | var303 => 
            Aggregate389();
            var1086;
            false
        
        case caseVar1091 => 
            ();
            ();
            var57
        
        case _ => 
            var192;
            true
        
    }) { (if (true) { 9 } else { var1104 } ) } else { 8 } 
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var90), 64)
    crccheck.updateBuffer(UInt64(var113), 64)
    crccheck.updateBuffer(UInt64(var165), 64)
    crccheck.updateBuffer(UInt64(var197), 64)
    crccheck.updateBuffer(UInt64(var561), 64)
    crccheck.updateBuffer(UInt64(var568), 64)
    crccheck.updateBuffer(UInt64(var991), 64)
    crccheck.updateBuffer(UInt64(var1024), 64)
    crccheck.updateBuffer(UInt64(var1104), 64)
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

/*
[31merror[0m: Call Expr unimplemented yet.
return code: 139
*/
