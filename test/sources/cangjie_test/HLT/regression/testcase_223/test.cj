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

let var_1669316351935_31 : Float32 = Float32(Float32(3.0))
var var_1669316351935_39 : Bool = false
let var_1669316351935_83 : Int32 = Int32(-72)
public var var_1669316351935_97 : Unit = ()
var var_1669316351935_122 : Int8 = Int8(UInt8(94))
public var var_1669316351935_222 : Unit = ()
var var_1669316351935_264 : Enum_1669316351935_261 = Enum_1669316351935_261.defaultValue
var var_1669316351935_445 : UInt16 = UInt16(Int8(Int8(UInt8(UInt8(89)))))
public var var_1669316351935_499 : Unit = ()
public var var_1669316351935_556 : Range<Int8> = ((Int8(82)&127)..(Int8(-33)&127):((Int64(UInt8(6))|1)))
public var var_1669316351935_616 : Bool = (((UInt16(UInt8(7))&127)..(UInt16(Int16(Int16(5)))&127):((Int64(UInt64(220))|1))) is (Float32, Unit, Unit, UInt64))
public let var_1669316351935_632 : Bool = false
public var var_1669316351935_651 : UInt64 = UInt64(UInt8(105))
public var var_1669316351935_662 : Int8 = Int8(-126)
public let var_1669316351935_702 : Float64 = (-11.0)
public let var_1669316351935_752 : Array<Range<UInt64>> = [((UInt64(56)&127)..=(UInt64(128)&127):((-56)|1)), ((UInt64(145)&127)..=(UInt64(82)&127):((-1)|1)), ((UInt64(146)&127)..=(UInt64(65)&127):(25|1)), ((UInt64(194)&127)..=(UInt64(184)&127):((-107)|1)), ((UInt64(111)&127)..(UInt64(49)&127):((-42)|1)), ((UInt64(124)&127)..(UInt64(222)&127):(24|1)), ((UInt64(238)&127)..=(UInt64(181)&127):(14|1)), ((UInt64(33)&127)..=(UInt64(222)&127):(52|1)), ((UInt64(156)&127)..=(UInt64(203)&127):(68|1)), ((UInt64(113)&127)..(UInt64(86)&127):(54|1))]
public var var_1669316351935_845 : Float64 = (-9.0)
public var var_1669316351935_862 : (Float32, Unit, Unit, UInt64) = (Float32(Float32(-73.0)), (), (), UInt64(UInt32(Int32(97))))
var var_1669316351935_872 : Int16 = Int16(Int16(Int8(Int8(-97))))
public var var_1669316351935_909 : Float64 = (-30.0)
public let var_1669316351935_1007 : Int64 = Int64(Int32(-89))
public open class Class_1669316351935_6 <: Resource {
    public init() { // block id: 8

    }
;
    public static var var_1669316351935_23 : (Float32, Unit, Unit, UInt64) = (Float32(28.0), (), (), UInt64(192));
    public static prop var_1669316351935_71 : Unit { // block id: 72
        get() { // block id: 74
            ()
        }

    };
    public static let var_1669316351935_521 : Rune = r'K';
    public open func func_1669316351935_1002(param_1669316351935_1003 : Float32, namedParam_1669316351935_1004 ! : Int16) : Int64 { // block id: 1005
        var_1669316351935_1007
    }

    public func isClosed(): Bool { return true }
    public func close(): Unit {}
}




public enum Enum_1669316351935_261 {
    defaultValue
}



func func_1669316351935_508(param_1669316351935_509 : Range<UInt64>) : Option<Enum_1669316351935_261> { // block id: 510
    Option<Enum_1669316351935_261>.None
}

func func_1669316351935_335(param_1669316351935_336 : Rune) : Option<Enum_1669316351935_261> { // block id: 337
    let var_1669316351935_353 : Array<UInt64> = [UInt64(115), UInt64(UInt16(Int8(UInt8(174)))), UInt64(46), UInt64(99), UInt64(UInt8(237)), UInt64(UInt64(26)), UInt64(Int32(Int32(Int32(47)))), UInt64(Int16(43)), UInt64(UInt8(Int8(Int8(65)))), UInt64(178)];
    var var_1669316351935_383 : UInt64 = UInt64(Int16(20));
    let var_1669316351935_410 : ?Unit = Option<Unit>.Some(());
    let var_1669316351935_417 : Array<Option<Unit>> = [Option<Unit>.None, Option<Unit>.Some(()), (Enum_1669316351935_261.defaultValue as Unit), (UInt32(12) as Unit), Option<Unit>.None, (UInt64(UInt16(85)) as Unit), Option<Unit>.Some(()), (((UInt64(153)&127)..(UInt64(168)&127):(20|1)) as Unit), (Int16(UInt8(UInt8(70))) as Unit), (((Int32(125)&127)..=(Int32(59)&127):((-67)|1)) as Unit)];
    var loopTimeVar_1669316351935_452 : Int64 = 0;
    (((Int8(-74), var_1669316351935_353, (Float32(0.0), (), (), var_1669316351935_383), Int16(-3), Option<Option<Unit>>.None)[4] ?? match (Option<Unit>.Some(())) {
        case caseVar_1669316351935_394 => 
            var var_1669316351935_397 : ?Unit = (UInt16(UInt16(Int16(UInt8(187)))) as Unit);
            var_1669316351935_397
        
        case _ => 
            if (true) { var_1669316351935_264 } else { Enum_1669316351935_261.defaultValue } ;
            var_1669316351935_410
        
    }) ?? (var_1669316351935_417[0] ?? do {
        loopTimeVar_1669316351935_452++;
        var_1669316351935_445
    } while ((true) && loopTimeVar_1669316351935_452 < 100 ) ));
    var var_1669316351935_458 : Enum_1669316351935_261 = Enum_1669316351935_261.defaultValue;
    var var_1669316351935_495 : Int64 = Int64(Int16(-58));
    match (try { // block id: 455
        Option<Enum_1669316351935_261>.Some(var_1669316351935_458)
    } catch (e: Exception) { // block id: 460
        Option<Enum_1669316351935_261>.Some(Enum_1669316351935_261.defaultValue)
    }) {
        case None => 
            var_1669316351935_222
        
        case None => 
            var var_1669316351935_472 : UInt32 = UInt32(112);
            var_1669316351935_472 = var_1669316351935_472
        
        case None => 
            ();
            let var_1669316351935_480 : String = """
G7MU,
gV]}s
""";
            var_1669316351935_480;
            ()
        
        case None => 
            var var_1669316351935_488 : UInt8 = UInt8(143);
            var_1669316351935_488 <<= ((UInt8(127)) & 7);
            ((UInt8(44)&127)..=(var_1669316351935_488&127):((var_1669316351935_495|1)));
            var_1669316351935_499
        
        case _ => 
            var_1669316351935_122 <<= ((Int8(-79)) & 7);
            var_1669316351935_97
        
    };
    [((UInt64(64)&127)..(UInt64(97)&127):(3|1)), ((UInt64(71)&127)..(UInt64(83)&127):(54|1)), ((UInt64(125)&127)..=(UInt64(199)&127):((-124)|1)), ((UInt64(52)&127)..=(UInt64(199)&127):(18|1)), ((UInt64(30)&127)..=(UInt64(242)&127):(68|1)), ((UInt64(147)&127)..(UInt64(160)&127):(91|1)), ((UInt64(36)&127)..=(UInt64(26)&127):(53|1)), ((UInt64(51)&127)..=(UInt64(247)&127):((-98)|1)), ((UInt64(21)&127)..(UInt64(86)&127):(101|1)), ((UInt64(39)&127)..(UInt64(250)&127):(110|1))][8]|>func_1669316351935_508
}

public func func_1669316351935_326(param_1669316351935_327 : Range<Int8>) : Enum_1669316351935_261 { // block id: 328
    var var_1669316351935_536 : Range<Int16> = ((Int16(Int8(-97))&127)..=(Int16(UInt8(204))&127):((Int64(UInt16(170))|1)));
    ((Class_1669316351935_6.var_1669316351935_521|>func_1669316351935_335) ?? ((((UInt16(127)&127)..=(UInt16(205)&127):((-25)|1)), Option<Enum_1669316351935_261>.Some(var_1669316351935_264), Int32(2), ((Int8(2)&127)..(var_1669316351935_122&127):((47|1))), var_1669316351935_536)[1] ?? (Option<Enum_1669316351935_261>.Some(Enum_1669316351935_261.defaultValue) ?? Enum_1669316351935_261.defaultValue)))
}

func func_1669316351935_159(param_1669316351935_160 : Int8) : Bool { // block id: 161
    var var_1669316351935_227 : Int16 = Int16(56);
    try { // block id: 163
        var loopTimeVar_1669316351935_175 : Range<UInt64> = ((UInt64(158)&127)..=(UInt64(Int32(38))&127):((Int64(Int64(UInt32(Int8(121))))|1)));
        for (i in loopTimeVar_1669316351935_175 where true) {
            let var_1669316351935_170 : Option<(Class_1669316351935_6, Float64)> = (r'b' as (Class_1669316351935_6, Float64));
            if (true) { var_1669316351935_170 } else { Option<(Class_1669316351935_6, Float64)>.None } ;
            ()
        }
    } finally { // block id: 193
        try { // block id: 195
            if (true) { Class_1669316351935_6() } else { Class_1669316351935_6() } ;
            var_1669316351935_97;
            ((UInt32(194)&127)..=(UInt32(39)&127):(119|1))
        } catch (e: Exception) { // block id: 203
            ((UInt32(201)&127)..(UInt32(2)&127):(40|1))
        };
        var var_1669316351935_210 : Float32 = Float32(Float32(66.0));
        try { // block id: 206
            Int16(29);
            var_1669316351935_210 /= Float32((Int32(Float32(62.0))) | 1);
            ()
        } catch (_) { // block id: 215
            ();
            let var_1669316351935_218 : Option<(Class_1669316351935_6, Float64)> = ("""
5@Ubs
07]A|
""" as (Class_1669316351935_6, Float64));
            var_1669316351935_218;
            var_1669316351935_222
        } finally { // block id: 224
            var_1669316351935_227 >>= ((Int16(3)) & 7);
            false;
            ()
        }
    };
    let var_1669316351935_244 : (Bool, String) = (true, ###"+oRH\".pZa+"###);
    let var_1669316351935_250 : Range<UInt32> = ((UInt32(UInt8(Int8(Int8(60))))&127)..=(UInt32(Int8(UInt8(214)))&127):((42|1)));
    var var_1669316351935_274 : UInt32 = UInt32(Int32(UInt32(Int16(Int8(3)))));
    ((UInt16(Int8(-103)) as Range<UInt32>) ?? if (var_1669316351935_244[0]) { var_1669316351935_250 } else { match (var_1669316351935_264) {
        case defaultValue => 
            let var_1669316351935_281 : Int64 = Int64(UInt32(Int16(-106)));
            if (false) { ((UInt32(105)&127)..(var_1669316351935_274&127):((var_1669316351935_281|1))) } else { var_1669316351935_250 } 
        
        case defaultValue => 
            ();
            var_1669316351935_122 |= Int8(43);
            var_1669316351935_250
        
        case defaultValue => 
            var_1669316351935_97;
            var var_1669316351935_300 : UInt64 = UInt64(UInt64(Int8(UInt8(189))));
            var_1669316351935_300 <<= ((var_1669316351935_300) & 7);
            ((UInt32(116)&127)..=(UInt32(182)&127):((-35)|1))
        
        case _ => 
            Float32(-111.0);
            ();
            let var_1669316351935_316 : Int64 = Int64(UInt64(UInt64(54)));
            ((var_1669316351935_274&127)..(UInt32(216)&127):((var_1669316351935_316|1)))
        
        case _ => 
            Float32(84.0);
            ((UInt32(169)&127)..(UInt32(82)&127):(92|1))
        
    } } );
    var var_1669316351935_550 : (Range<Int8>) -> Enum_1669316351935_261 = func_1669316351935_326;
    let var_1669316351935_566 : String = ###"ndx>ca{t_CP"###;
    match ((if (var_1669316351935_39) { ((Int8(-16)&127)..=(Int8(-25)&127):(81|1)) } else { var_1669316351935_556 } |>var_1669316351935_550)) {
        case defaultValue => 
            var_1669316351935_566;
            ();
            var_1669316351935_445 < var_1669316351935_445
        
        case caseVar_1669316351935_574 => 
            false
        
        case defaultValue => 
            if (false) { var_1669316351935_264 } else { Enum_1669316351935_261.defaultValue } ;
            false
        
        case _ => 
            var_1669316351935_31;
            var var_1669316351935_592 : Option<(Class_1669316351935_6, Float64)> = Option<(Class_1669316351935_6, Float64)>.None;
            if (true) { Option<(Class_1669316351935_6, Float64)>.None } else { var_1669316351935_592 } ;
            var_1669316351935_39
        
    }
}

func func_1669316351935_155<T0, T1, T2>(param_1669316351935_156 : Option<(Class_1669316351935_6, Float64)>) : Bool { // block id: 157
    var var_1669316351935_596 : (Int8) -> Bool = func_1669316351935_159;
    let var_1669316351935_605 : UInt8 = UInt8(227);
    Int8(match (50) {
        case _ => 
            var_1669316351935_222;
            var_1669316351935_605
        
    })|>var_1669316351935_596
}

public struct Struct_1669316351935_668<T0, T1> {
    init() { // block id: 670

    }
;
    static mut prop var_1669316351935_673 : (Float32, Unit, Unit, UInt64) { // block id: 674
        get() { // block id: 676
            ();
            r'C';
            (Float32(118.0), (), (), UInt64(206));
            var_1669316351935_1015
        }

        set(Value) { // block id: 686
            ();
            var_1669316351935_1015 = Value
        }

    };
    static var var_1669316351935_1015 : (Float32, Unit, Unit, UInt64) = (Float32(-77.0), (), (), UInt64(13))
}


public func func_1669316351935_150() : Float64 { // block id: 151
    var loopTimeVar_1669316351935_689 : Int64 = 0;
    do {
        loopTimeVar_1669316351935_689++;
        Struct_1669316351935_668<UInt16, Bool>.var_1669316351935_673
    } while ((if ((Option<(Class_1669316351935_6, Float64)>.Some((Class_1669316351935_6(), 76.0))|>func_1669316351935_155<Unit, Option<Option<(Class_1669316351935_6, Float64)>>, Range<UInt64>>)) { // block id: 612
        var_1669316351935_39
    } else if (if (var_1669316351935_616) { // block id: 626
        var_1669316351935_616
    } else if (false) { // block id: 629
        var_1669316351935_632 || false
    } else { // block id: 635
        var var_1669316351935_639 : UInt8 = UInt8(153);
        UInt8(124) & var_1669316351935_639;
        let var_1669316351935_643 : Bool = (Int32(126) is Range<UInt32>);
        var_1669316351935_643 || true
    }) { // block id: 647
        var_1669316351935_499;
        var_1669316351935_651 <<= ((UInt64(233)) & 7);
        false || false
    } else { // block id: 658
        ((Int8(70)&127)..(var_1669316351935_662&127):(((-80)|1)));
        true
    }) && loopTimeVar_1669316351935_689 < 100 ) ;
    (try { // block id: 692
        let var_1669316351935_694 : ?Float64 = (UInt8(Int8(-114)) as Float64);
        var_1669316351935_694
    } finally { // block id: 698
        true;
        Option<Float64>.Some(var_1669316351935_702)
    } ?? (Option<(Float64, UInt8, Array<UInt64>, UInt16)>.None ?? ((-101.0), UInt8(119), [UInt64(31), UInt64(241), UInt64(217), UInt64(30), UInt64(103), UInt64(97), UInt64(139), UInt64(142), UInt64(231), UInt64(254)], var_1669316351935_445))[0])
}

public func func_1669316351935_144(param_1669316351935_145 : UInt64) : Option<Float64> { // block id: 146
    var var_1669316351935_771 : Bool = false;
    let var_1669316351935_774 : ?Float64 = Option<Float64>.Some(Float64(Float32(38.0)));
    let var_1669316351935_783 : (Int32, Int64, Option<Float64>, Rune, Rune) = (Int32(UInt16(UInt8(Int8(-95)))), Int64(UInt32(248)), ([(UInt32(190) as Unit), Option<Unit>.Some(()), Option<Unit>.Some(()), Option<Unit>.Some(()), Option<Unit>.Some(()), Option<Unit>.None, (Option<(Float64, UInt8, Array<UInt64>, UInt16)>.None as Unit), (Option<(Float64, UInt8, Array<UInt64>, UInt16)>.Some(((-73.0), UInt8(123), [UInt64(235), UInt64(248), UInt64(117), UInt64(236), UInt64(95), UInt64(135), UInt64(100), UInt64(218), UInt64(80), UInt64(246)], UInt16(105))) as Unit), Option<Unit>.Some(()), Option<Unit>.Some(())] as Float64), r'm', r'L');
    try { // block id: 148
        func_1669316351935_150();
        Option<Float64>.Some(var_1669316351935_702)
    } catch (e: Exception) { // block id: 720
        ();
        var var_1669316351935_763 : Array<UInt64> = [UInt64(13), UInt64(72), UInt64(55), UInt64(187), UInt64(55), UInt64(178), UInt64(43), UInt64(52), UInt64(125), UInt64(174)];
        match (Option<Option<Unit>>.Some(Option<Unit>.None)) {
            case caseVar_1669316351935_727 => 
                var_1669316351935_499;
                ()
            
            case caseVar_1669316351935_733 => 
                var_1669316351935_499
            
            case caseVar_1669316351935_738 : (Range<UInt16>, Option<Enum_1669316351935_261>, Int32, Range<Int8>, Range<Int16>) => 
                ();
                var var_1669316351935_742 : Unit = ();
                var_1669316351935_742
            
            case _ : Enum_1669316351935_261 => 
                var_1669316351935_662--;
                if (true) { var_1669316351935_752 } else { var_1669316351935_752 } ;
                var_1669316351935_222
            
            case _ => 
                Option<Unit>.None;
                (var_1669316351935_702, UInt8(75), var_1669316351935_763, UInt16(118));
                var_1669316351935_651 /= ((UInt64(27)) | 1)
            
        };
        if (var_1669316351935_771) { var_1669316351935_774 } else { Option<Float64>.None } 
    } finally { // block id: 779
        var_1669316351935_783[2]
    }
}

public func func_1669316351935_57(param_1669316351935_58 : Int64) : Float64 { // block id: 59
    try (resource = Class_1669316351935_6()) { // block id: 61
        var loopTimeVar_1669316351935_66 : Int64 = 0;
        while ((var_1669316351935_39) && loopTimeVar_1669316351935_66 < 100 ) {
            loopTimeVar_1669316351935_66++;

        }
    } finally { // block id: 67
        Class_1669316351935_6.var_1669316351935_71;
        var var_1669316351935_80 : Unit = ();
        if (true) { // block id: 78
            var_1669316351935_80;
            var_1669316351935_83;
            ()
        } else if (true) { // block id: 87
            ()
        }
    };
    var var_1669316351935_104 : Int32 = Int32(Int16(38));
    let var_1669316351935_831 : (UInt64) -> Option<Float64> = func_1669316351935_144;
    (if (match (var_1669316351935_97) {
        case () => 
            var_1669316351935_104--;
            false
        
        case _ => 
            UInt32(157);
            let var_1669316351935_114 : Bool = true;
            var_1669316351935_114 || var_1669316351935_39
        
        case () => 
            var_1669316351935_122 = var_1669316351935_122;
            false
        
        case _ : Unit => 
            (Float32(-18.0), var_1669316351935_97, (), UInt64(90));
            var var_1669316351935_136 : Unit = ();
            var_1669316351935_136;
            var_1669316351935_39
        
        case _ => 
            ();
            var_1669316351935_39
        
    }) { (UInt64(143)|>var_1669316351935_831) } else { (false as Float64) }  ?? match (UInt64(54)) {
        case 74 | 28 => 
            var_1669316351935_845 /= Float64((Int32((-108.0))) | 1);
            let var_1669316351935_878 : ??Unit = Option<Option<Unit>>.None;
            (Int8(3), [var_1669316351935_651, UInt64(245), UInt64(206), UInt64(138), UInt64(122), var_1669316351935_651, var_1669316351935_651, UInt64(154), var_1669316351935_651, UInt64(104)], var_1669316351935_862, var_1669316351935_872, var_1669316351935_878);
            var var_1669316351935_883 : Array<Float64> = [(-30.0), 67.0, 116.0, (-13.0), 71.0, (-64.0), 89.0, 53.0, 123.0, (-104.0)];
            if (true) { var_1669316351935_883 } else { [(-95.0), 17.0, 6.0, (-105.0), (-104.0), (-12.0), 51.0, (-57.0), (-36.0), 10.0] } 
        
        case _ : Int16 => 
            [(-14.0), (-53.0), (-81.0), (-31.0), 13.0, (-5.0), 41.0, 73.0, (-51.0), (-79.0)]
        
        case _ => 
            Int32(-115);
            var var_1669316351935_895 : Array<Float64> = [122.0, 21.0, 16.0, (-54.0), (-57.0), 74.0, (-102.0), (-50.0), (-128.0), (-103.0)];
            var_1669316351935_895
        
        case 253 => 
            var_1669316351935_222;
            false;
            [(-79.0), (-47.0), var_1669316351935_702, var_1669316351935_702, 68.0, var_1669316351935_909, var_1669316351935_702, 39.0, (-119.0), var_1669316351935_845]
        
        case _ => 
            [(-50.0), (-117.0), 69.0, 62.0, (-95.0), (-102.0), (-89.0), (-88.0), (-102.0), (-106.0)]
        
    }[6])
}



main(): Int64 {
    try {
        let var_1669316351935_48 : (Class_1669316351935_6, Float64) = (Class_1669316351935_6(), 30.0);
        func func_1669316351935_53<T0>(namedParam_1669316351935_54 ! : Unit) : (Class_1669316351935_6, Float64) { // block id: 55
            (-49)|>func_1669316351935_57;
            var var_1669316351935_933 : Option<Option<Option<(Class_1669316351935_6, Float64)>>> = (Option<(Class_1669316351935_6, Float64)>.Some((Class_1669316351935_6(), Float64(Float32(52.0)))) as Option<Option<(Class_1669316351935_6, Float64)>>);
            var var_1669316351935_971 : UInt32 = UInt32(154);
            (((var_1669316351935_933 ?? Option<Option<(Class_1669316351935_6, Float64)>>.None) ?? (((var_1669316351935_662&127)..(Int8(-91)&127):((90|1))) as (Class_1669316351935_6, Float64))) ?? (([UInt64(50), UInt64(199), UInt64(174), UInt64(170), UInt64(253), UInt64(237), UInt64(132), UInt64(3), UInt64(12), UInt64(206)] as (Class_1669316351935_6, Float64)) ?? match (Option<Range<UInt32>>.None) {
                case _ : Option<Option<Unit>> => 
                    var_1669316351935_499;
                    var_1669316351935_222;
                    let var_1669316351935_960 : Class_1669316351935_6 = Class_1669316351935_6();
                    if (var_1669316351935_39) { (var_1669316351935_960, var_1669316351935_909) } else { (Class_1669316351935_6(), 85.0) } 
                
                case _ => 
                    var_1669316351935_971 %= ((UInt32(127)) | 1);
                    if (true) { var_1669316351935_48 } else { var_1669316351935_48 } 
                
                case _ => 
                    var_1669316351935_48
                
                case caseVar_1669316351935_984 : (Class_1669316351935_6, Float64) => 
                    var_1669316351935_97;
                    let var_1669316351935_990 : (Class_1669316351935_6, Float64) = (Class_1669316351935_6(), 80.0);
                    if (false) { var_1669316351935_990 } else { var_1669316351935_48 } 
                
                case _ => 
                    var_1669316351935_48
                
            }))
        }
;
        func func_1669316351935_10(param_1669316351935_11 : Int8) : Class_1669316351935_6 { // block id: 12
            Class_1669316351935_6.func_1669316351935_18(".&+rKuoRyo", namedParam_1669316351935_20 : var_1669316351935_31)[1];
            if (var_1669316351935_39) { (Option<(Class_1669316351935_6, Float64)>.None ?? var_1669316351935_48) } else { func_1669316351935_53<Range<UInt16>>(namedParam_1669316351935_54 : var_1669316351935_97) } [0]
        }
;
        func_1669316351935_10(var_1669316351935_662).func_1669316351935_1002(var_1669316351935_31, namedParam_1669316351935_1004 : Int16(25))
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1669316351935_83*var_1669316351935_83), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_122*var_1669316351935_122), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_445*var_1669316351935_445), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_651*var_1669316351935_651), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_662*var_1669316351935_662), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_872*var_1669316351935_872), 64)
        crccheck.updateBuffer(UInt64(var_1669316351935_1007*var_1669316351935_1007), 64)
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
extend Class_1669316351935_6 {
    static func func_1669316351935_18(param_1669316351935_19 : String, namedParam_1669316351935_20 ! : Float32) : (Float32, Unit, Unit, UInt64) { // block id: 21
        var_1669316351935_23
    }

}

extend Enum_1669316351935_261 {

}

extend<T0, T1> Struct_1669316351935_668<T0, T1> {

}

