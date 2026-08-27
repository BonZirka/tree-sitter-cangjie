/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: test_macro_definition.cj
// EXEC: %compiler %cmp_macro test_macro_definition.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f -o %output

import define.*
@echo public var var77 : Bool = false
@echo public var var83 : Float32 = Float32(-113.0)
@echo public let var89 : (UInt64, Unit) = (UInt64(UInt8(UInt8(33))), ())
@echo public var var96 : (UInt64, Unit) = (UInt64(13), ())
@echo public let var102 : String = "Ke7S0^z#3i"
@echo public var var155 : UInt16 = UInt16(198)
@echo public let var172 : Option<Rune> = Option<Rune>.None
@echo public let var176 : Class8 = Class8()
@echo public var var245 : Interface230 = Class227()
@echo var var289 : (Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit) = (Int64(UInt32(47)), ((7&127)..((-75)&127):((-19)|1)), (UInt32(UInt16(UInt16(98))), Float64(Float32(-70.0)), Float32(65.0), r'5', (), (), UInt64(Int8(-11)), UInt16(UInt8(210)), 106.0), ((Int16(-117)&127)..(Int16(119)&127):((-31)|1)), Option<String>.None, UInt32(Int16(Int16(Int16(-69)))), Int8(Int8(-91)), ((Int8(59)&127)..(Int8(-125)&127):(75|1)), ())
@echo public var var341 : ?Bool = (((Int16(76)&127)..(Int16(58)&127):((-7)|1)) as Bool)
@echo public var var360 : String = "\\Pv]0X5-g("
@echo public var var372 : UInt64 = UInt64(231)
@echo public var var382 : UInt32 = UInt32(179)
@echo var var385 : UInt32 = UInt32(110)
@echo public var var402 : Unit = ()
@echo public let var427 : UInt16 = UInt16(53)
@echo var var431 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(Int8(Int8(Int8(78)))), (-68.0), Float32(-114.0), r'c', (), (), UInt64(2), UInt16(UInt16(Int16(UInt16(245)))), Float64(Float64(Float32(Float32(103.0)))))
@echo public let var519 : UInt16 = UInt16(211)
@echo public var var680 : Float64 = 40.0
@echo var var713 : Float32 = Float32(-38.0)
@echo var var787 : Float32 = Float32(Float32(69.0))
@echo public var var829 : ?Int8 = (Float32(42.0) as Int8)
@echo public let var851 : Float64 = (-53.0)
@echo public var var857 : Int32 = Int32(-121)
@echo let var860 : Range<Int64> = (((-115)&127)..((-91)&127):((-61)|1))
@echo public let var866 : Int8 = Int8(UInt8(119))
@echo public let var1017 : Range<UInt8> = ((UInt8(24)&127)..=(UInt8(213)&127):(27|1))
@echo public var var1061 : Bool = (Class227() is Bool)
@echo let var1066 : Interface232 = Class227()
@echo let var1402 : Int16 = Int16(-30)
@echo public let var1418 : String = "x+S!.OsV>G"
@echo let var1501 : ?Int64 = (r'q' as Int64)
@echo let var1591 : Float32 = Float32(Float32(Float32(78.0)))
@echo public var var1617 : Range<Int16> = ((Int16(91)&127)..(Int16(-53)&127):((-52)|1))
@echo public let var1653 : Unit = ()
@echo public var var1668 : UInt64 = UInt64(205)
@echo public let var1701 : Unit = ()
@echo public let var1737 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(Int32(65)), (-117.0), Float32(Float32(Float32(-70.0))), r'Z', (), (), UInt64(49), UInt16(UInt8(UInt8(125))), Float64(41.0))
@echo var var1763 : UInt64 = UInt64(60)
@echo public var var1889 : Int16 = Int16(-8)
@echo public var var1900 : Option<Range<Int32>> = Option<Range<Int32>>.None
@echo public let var1929 : Array<Bool> = [true, false, false, false, false, false, true, true, false, false]
@echo let var2133 : Rune = r'Q'
@echo public var var2136 : Unit = ()
@echo let var2163 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(57), Float64((-87.0)), Float32(-80.0), r'z', (), (), UInt64(UInt64(183)), UInt16(UInt16(UInt8(UInt8(211)))), Float64(Float32(-47.0)))
@echo public var var2224 : Range<UInt32> = ((UInt32(5)&127)..(UInt32(73)&127):(82|1))
@echo public var var2515 : Interface232 = Class227()
@echo public let var2562 : Bool = true
@echo var var2565 : ((UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Float64, UInt16, Option<Int8>, Rune, Int32, Range<Int64>) = ((UInt32(Int32(-96)), 101.0, Float32(35.0), r'h', (), (), UInt64(UInt16(UInt8(220))), UInt16(Int8(Int8(-128))), Float64(Float32(Float32(14.0)))), Float64(Float64((-122.0))), UInt16(42), Option<Int8>.None, r'f', Int32(29), (((-69)&127)..=(87&127):((-85)|1)))
@echo let var2604 : UInt16 = UInt16(Int16(-122))
@echo var var2614 : ?Int8 = (Class227() as Int8)
@echo public var var2667 : UInt16 = UInt16(UInt16(UInt8(32)))
@echo let var2800 : Array<Range<UInt8>> = Array<Range<UInt8>>(10){ i => ((UInt8(242)&127)..=(UInt8(68)&127):((56|1))) }
@echo let var2922 : Unit = ()
@echo public let var2932 : (UInt64, Unit) = (UInt64(Int8(100)), ())
@echo public let var3006 : UInt32 = UInt32(51)
@echo public let var3048 : Array<UInt32> = [UInt32(237), UInt32(170), UInt32(130), UInt32(126), UInt32(183), UInt32(123), UInt32(28), UInt32(87), UInt32(132), UInt32(155)]
@echo public var var3053 : Option<UInt64> = Option<UInt64>.None
@echo let var3156 : Float64 = Float64(Float32(Float32(49.0)))
@echo public let var3201 : Float64 = (-98.0)
@echo public let var3211 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(53), Float64(126.0), Float32(Float32(Float32(36.0))), r'r', (), (), UInt64(Int64(Int32(-90))), UInt16(75), Float64(Float32(79.0)))
@echo public var var3244 : Interface231 = Class227()
@echo public var var3424 : Float64 = Float64(Float64(Float32(Float32(Float32(-112.0)))))
@echo public var var3669 : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) = ((-36.0), Float32(2.0), ((Int16(20)&127)..=(Int16(-128)&127):(50|1)), (), Int16(-88), ((Int8(-115)&127)..=(Int8(Int8(66))&127):(((-6)|1))), ((Int8(-23)&127)..(Int8(-84)&127):(84|1)), (UInt32(49), (-88.0), Float32(Float32(79.0)), r'O', (), (), UInt64(UInt16(90)), UInt16(18), (-49.0)))
@echo let var3985 : UInt64 = UInt64(UInt32(UInt16(252)))
@echo public let var3993 : UInt32 = UInt32(69)
@echo let var4011 : Unit = ()
@echo let var4049 : Class227 = Class227()
@echo public var var4083 : Float32 = Float32(-50.0)
@echo var var4240 : (Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit) = (Int64(UInt8(247)), ((Int64(UInt32(194))&127)..=(Int64((-13))&127):((Int64(Int32(UInt8(164)))|1))), (UInt32(197), Float64(Float32(Float32(16.0))), Float32(Float32(Float32(58.0))), r'J', (), (), UInt64(UInt8(UInt8(235))), UInt16(44), Float64(Float32(Float32(-9.0)))), ((Int16(UInt16(161))&127)..(Int16(Int8(UInt8(58)))&127):((44|1))), Option<String>.None, UInt32(UInt8(Int8(-31))), Int8(-103), ((Int8(-16)&127)..(Int8(-93)&127):(32|1)), ())
@echo public let var4345 : Rune = r'c'
@echo public let var4361 : Option<Option<UInt64>> = Option<Option<UInt64>>.None
@echo public var var4376 : Unit = ()
@echo public var var4398 : Int64 = (-101)
@echo public var var4412 : Array<Range<UInt64>> = [((UInt64(224)&127)..=(UInt64(39)&127):((-103)|1)), ((UInt64(131)&127)..=(UInt64(91)&127):((-20)|1)), ((UInt64(Int32(-18))&127)..=(UInt64(UInt32(27))&127):((Int64(UInt64(UInt32(238)))|1))), ((UInt64(232)&127)..(UInt64(203)&127):((-94)|1)), ((UInt64(Int32(UInt16(253)))&127)..=(UInt64(185)&127):(((-55)|1))), ((UInt64(133)&127)..=(UInt64(109)&127):((-4)|1)), ((UInt64(216)&127)..(UInt64(218)&127):((-9)|1)), ((UInt64(239)&127)..=(UInt64(87)&127):((-93)|1)), ((UInt64(224)&127)..(UInt64(2)&127):((-115)|1)), ((UInt64(UInt32(UInt32(198)))&127)..=(UInt64(UInt32(22))&127):((Int64(Int16(Int8(-76)))|1)))]
@echo let var4555 : (Range<Int8>, Bool, UInt8, UInt32) = (((Int8(35)&127)..(Int8(16)&127):((-84)|1)), false, UInt8(UInt8(240)), UInt32(UInt16(UInt16(141))))
@echo public let var4614 : Int64 = (-38)
@echo public let var4679 : UInt32 = UInt32(UInt16(UInt16(Int8(UInt8(222)))))
@echo public let var4708 : Option<(UInt64, Unit)> = Option<(UInt64, Unit)>.None
@echo public var var4712 : Int8 = Int8(Int8(-47))
@echo public var var4739 : Int16 = Int16(Int16(-2))
@echo public class Class8 {
    @echo public init() { // block id: 10

    }
;
    @echo public let var148 : Bool = false;
    @echo private static var var186 : Unit = ();
    @echo var var191 : Unit = ();
    @echo private var var4571 : Array<Range<UInt8>> = [((UInt8(90)&127)..(UInt8(3)&127):(18|1)), ((UInt8(78)&127)..=(UInt8(157)&127):(((-10)|1))), ((UInt8(186)&127)..=(UInt8(92)&127):((-36)|1)), ((UInt8(35)&127)..=(UInt8(24)&127):((-116)|1)), ((UInt8(230)&127)..=(UInt8(193)&127):(((-100)|1))), ((UInt8(203)&127)..=(UInt8(117)&127):(17|1)), ((UInt8(178)&127)..=(UInt8(247)&127):(88|1)), ((UInt8(81)&127)..=(UInt8(11)&127):((122|1))), ((UInt8(171)&127)..=(UInt8(93)&127):(((-71)|1))), ((UInt8(79)&127)..(UInt8(198)&127):(((-118)|1)))];
    @echo static var var4651 : UInt64 = UInt64(2);
    @echo private static var var4674 : Range<Int8> = ((Int8(-97)&127)..=(Int8(-38)&127):((-115)|1));
    @echo protected var var4691 : Option<(UInt64, Unit)> = Option<(UInt64, Unit)>.None;
    @echo public func func197(param198 : Int8, namedParam199 ! : Int16, optionalParam200 ! : Range<UInt8> = ((UInt8(247)&127)..=(UInt8(11)&127):(73|1))) : (UInt64, Unit) { // block id: 202
        func4497|>func204;
        ();
        @echo var var4527 : Rune = r'a';
        @echo var var4601 : UInt8 = UInt8(Int8(Int8(59)));
        @echo var var4704 : Range<UInt16> = ((UInt16(220)&127)..(UInt16(189)&127):((-7)|1));
        try { // block id: 4502
            @echo var loopTimeVar4507 : Range<UInt64> = ((UInt64(Int32(UInt32(UInt32(36))))&127)..=(UInt64(UInt8(171))&127):((Int64(Int32(UInt8(Int8(-29))))|1)));
            for (i in loopTimeVar4507 where true) {
                var4376
            };
            Int32(54);
            var96
        } catch (_) { // block id: 4521
            if (true) { // block id: 4524
                var4527 = var4527;
                var191;
                ()
            } else if (true) { // block id: 4533

            };
            @echo let var4540 : (Int16, (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit)) = (Int16(UInt16(UInt16(Int16(-124)))), (((Int16(-50)&127)..(Int16(68)&127):(20|1)), Int16(15), UInt8(UInt8(227)), ((Int32(17)&127)..=(Int32(110)&127):(72|1)), "ZZT(&)M*yf", ()));
            match (var155) {
                case _ : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) => 
                    var4540;
                    var4555
                
                case caseVar4566 : Int8 => 
                    @echo let var4626 : UInt8 = UInt8(136);
                    if (false) { var4571 } else { [((var4601&127)..=(UInt8(5)&127):(((-56)|1))), optionalParam200, optionalParam200, ((UInt8(223)&127)..(UInt8(109)&127):((-18)|1)), ((UInt8(114)&127)..=(UInt8(121)&127):((var4614|1))), ((UInt8(56)&127)..=(UInt8(206)&127):((var4614|1))), ((var4601&127)..=(UInt8(201)&127):((var4614|1))), ((var4626&127)..(var4626&127):((65|1))), optionalParam200, ((UInt8(121)&127)..(var4601&127):((var4614|1)))] } ;
                    (((caseVar4566&127)..(Int8(60)&127):((var4614|1))), false, var4626, UInt32(176))
                
                case _ : (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit) => 
                    if (true) { ((UInt64(6)&127)..=(UInt64(119)&127):(104|1)) } else { ((var4651&127)..=(UInt64(35)&127):((61|1))) } ;
                    (((Int8(-28)&127)..=(Int8(92)&127):((59|1))), var148, UInt8(111), UInt32(248))
                
                case _ => 
                    @echo var var4667 : Float64 = Float64(113.0);
                    var4667 = var4667;
                    var102;
                    (var4674, false, var4601, var4679)
                
            };
            (var4691 ?? (var4651, var186))
        } finally { // block id: 4696
            (Option<Range<UInt16>>.None ?? var4704);
            (var4708 ?? var96)
        }
    }
;
    @echo static let var4730 : Range<Int32> = ((Int32(-29)&127)..=(Int32(2)&127):((93|1)));
    @echo public static var var4803 : Float64 = (-117.0);
    @echo public init(param180 : Int64, param181 : Int32) { // block id: 182
        Class8.var186;
        var176.var191;
        @echo let var4716 : Int16 = Int16(Int16(0));
        @echo var var4744 : UInt8 = UInt8(86);
        @echo var var4754 : Bool = ([((UInt64(Int32(6))&127)..(UInt64(37)&127):((2|1))), ((UInt64(222)&127)..(UInt64(252)&127):((-64)|1)), ((UInt64(UInt16(173))&127)..(UInt64(68)&127):((Int64(UInt8(6))|1))), ((UInt64(227)&127)..=(UInt64(42)&127):((-104)|1)), ((UInt64(213)&127)..(UInt64(76)&127):((102|1))), ((UInt64(226)&127)..=(UInt64(16)&127):((-47)|1)), ((UInt64(160)&127)..(UInt64(UInt32(25))&127):((Int64(74)|1))), ((UInt64(Int32(82))&127)..=(UInt64(Int16(101))&127):(((-47)|1))), ((UInt64(UInt8(227))&127)..(UInt64(29)&127):((Int64(UInt32(250))|1))), ((UInt64(186)&127)..(UInt64(8)&127):(107|1))] is (Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit));
        match (this.func197(var4712, namedParam199 : var4716)) {
            case caseVar4721 : Range<Int16> => 
                (Int16(118), (((Int16(-102)&127)..(Int16(50)&127):((-28)|1)), var4716, UInt8(55), var4730, ###"@O\\8q6?\\@D"###, var186));
                var4739 -= Int16(121);
                var4744
            
            case (_ : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)),caseVar4748 : Rune) => 
                var4712++;
                var4754 &&= false;
                UInt8(228)
            
            case (caseVar4798 : (Range<UInt8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), UInt32, Float64, UInt64, Range<Int32>),caseVar4799) => 
                var4803 - var4803;
                caseVar4799;
                var4744
            
            case caseVar4810 => 
                ((Int8(-79)&127)..(var4712&127):((param180|1)));
                UInt8(253) & UInt8(43)
            
            case _ => 
                @echo var var4823 : Int32 = Int32(-104);
                var4823 += var4823;
                UInt8(139)
            
        }
    }
;
    @echo public let var4837 : UInt32 = UInt32(218)
}


@echo func func64(param65 : Rune) : Bool { // block id: 66
    if ((Option<Bool>.Some(var77) ?? var77)) { // block id: 80
        var83 -= var83;
        if (var77) { var89 } else { var96 } 
    } else { // block id: 100
        var102;
        (UInt64(16), ())
    }[1];
    @echo let var122 : Unit = ();
    @echo var var131 : Float64 = (-49.0);
    @echo var var134 : Int8 = Int8(UInt8(Int8(122)));
    match {
        case true => 
        if (var77) { // block id: 113
            ();
            ();
            @echo let var117 : Int8 = Int8(-31);
            var117
        } else if (false) { // block id: 120
            var122;
            @echo let var125 : Int8 = Int8(Int8(-97));
            var125
        } else { // block id: 128
            ();
            var131;
            var134
        };
        @echo var var139 : Bool = true;
        var139
        case true => 
        @echo var var145 : Class8 = Class8();
        var145.var148
        case _ => 
        try { // block id: 152
            var155 %= ((var155) | 1);
            var131 += (-14.0);
            Int16(8) < Int16(-34)
        } finally { // block id: 164
            true
        }
    }
}



@echo public interface Interface232 {

}

@echo public interface Interface231 <: Interface232 {

}

@echo public interface Interface234 <: Interface232 {

}

@echo public interface Interface233 <: Interface234 {

}

@echo public interface Interface230 <: Interface231 & Interface233 {

}

@echo public open class Class227 <: Interface230 {
    @echo public init() { // block id: 229

    }
;
    @echo var var953 : UInt64 = UInt64(187);
    @echo static var var1079 : Option<String> = Option<String>.None;
    @echo static let var1203 : (Range<Int8>, Bool, UInt8, UInt32) = (((Int8(113)&127)..=(Int8(-99)&127):(((-43)|1))), true, UInt8(124), UInt32(185));
    @echo private static let var2392 : Option<Rune> = Option<Rune>.None;
    @echo public static var var2441 : Bool = true;
    @echo public init(param2228 : Range<Int64>) { // block id: 2229
        @echo var var2245 : (Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>, Int64, Interface231) = ([(UInt32(47), Float64(122.0), Float32(44.0), r'D', (), (), UInt64(UInt8(147)), UInt16(65), Float64((-83.0))), (UInt32(10), Float64(Float32(5.0)), Float32(Float32(-11.0)), r'p', (), (), UInt64(123), UInt16(20), 32.0), (UInt32(239), 44.0, Float32(113.0), r'Y', (), (), UInt64(232), UInt16(103), Float64((-7.0))), (UInt32(143), Float64(12.0), Float32(Float32(109.0)), r'Q', (), (), UInt64(UInt16(140)), UInt16(UInt8(178)), Float64(Float32(-115.0))), (UInt32(211), (-4.0), Float32(Float32(-20.0)), r'n', (), (), UInt64(5), UInt16(239), 74.0), (UInt32(89), Float64(2.0), Float32(-118.0), r'f', (), (), UInt64(UInt8(4)), UInt16(UInt16(99)), Float64(Float32(-99.0))), (UInt32(73), Float64(Float32(-113.0)), Float32(Float32(-111.0)), r'T', (), (), UInt64(UInt32(229)), UInt16(206), Float64(Float32(125.0))), (UInt32(UInt32(160)), Float64(Float32(-25.0)), Float32(-49.0), r'p', (), (), UInt64(Int32(-9)), UInt16(154), 118.0), (UInt32(Int32(-20)), (-20.0), Float32(-76.0), r'8', (), (), UInt64(224), UInt16(21), Float64((-46.0))), (UInt32(UInt32(42)), Float64((-108.0)), Float32(122.0), r'k', (), (), UInt64(31), UInt16(133), Float64(Float32(60.0)))], 116, Class227());
        match (if (true) { // block id: 2233
                var1653;
                @echo var var2237 : UInt8 = UInt8(Int8(Int8(UInt8(UInt8(61)))));
                var2237 *= UInt8(16);
                var2245
            } else { // block id: 2378
                var77 &&= var77;
                var2245
            }) {
            case _ => 
                ();
                var245
            
        };
        @echo var var2468 : Int64 = Int64(Int8(Int8(72)));
        if (var77) { // block id: 2389
            @echo var var2403 : Int8 = Int8(UInt8(UInt8(116)));
            @echo var var2420 : UInt8 = UInt8(Int8(-7));
            match (var2392) {
                case _ : Interface233 => 
                    if (true) { ((UInt64(82)&127)..=(UInt64(160)&127):(32|1)) } else { ((UInt64(89)&127)..(UInt64(76)&127):(75|1)) } ;
                    var2403 >>= ((var866) & 7)
                
                case _ => 
                    if (var1061) { (((Int8(39)&127)..(Int8(120)&127):(((-32)|1))), true, var2420, var382) } else { (((Int8(-117)&127)..(Int8(42)&127):((-121)|1)), false, var2420, var382) } ;
                    ()
                
                case caseVar2432 => 
                    var402;
                    [false, false, false, false, var2441, var77, var2441, true, var77, true];
                    var1889 &= var1889
                
                case _ => 
                    @echo var var2458 : Int64 = 89;
                    ((var1763&127)..(UInt64(227)&127):((var2458|1)));
                    ();
                    ()
                
                case _ => 
                    ();
                    var2136;
                    var2468 |= 90
                
            };
            @echo var loopTimeVar2479 : Int64 = 0;
            do {
                loopTimeVar2479++;
                var382;
                var2224
            } while ((var77) && loopTimeVar2479 < 100 ) 
        }
    }
;
    @echo let var4298 : Range<Int16> = ((Int16(53)&127)..(Int16(-113)&127):((-13)|1))
}


@echo func func277(param278 : (Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)) : Option<UInt64> { // block id: 279
    @echo let var281 : Option<UInt64> = Option<UInt64>.Some(UInt64(UInt32(UInt8(Int8(-100)))));
    var281
}


@echo func func331(namedParam332 ! : UInt64, optionalParam333 ! : UInt64 = UInt64(Int32(-30))) : Int8 { // block id: 336
    @echo var var397 : Int16 = Int16(-109);
    @echo var loopTimeVar405 : Int64 = 0;
    while ((if ((var341 ?? var77)) { // block id: 345
        @echo var var348 : Int16 = Int16(41);
        var348 |= Int16(-35);
        optionalParam333 < UInt64(41)
    } else { // block id: 354
        true
    }) && loopTimeVar405 < 100 ) {
        loopTimeVar405++;
        match (Option<String>.Some(var360)) {
            case _ => 
                ()
            
            case caseVar368 => 
                var372 >>= ((UInt64(125)) & 7);
                ()
            
            case caseVar378 => 
                var382 // too hard to revise the test case
            
            case _ => 
                @echo var var391 : Unit = ();
                var391
            
            case _ => 
                var397 >>= ((var397) & 7);
                ();
                var402
            
        }
    };
    @echo var var421 : Rune = r't';
    @echo let var458 : Float32 = Float32(Float32(106.0));
    @echo var var523 : Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)> = [(UInt32(86), 117.0, Float32(-107.0), r'H', (), (), UInt64(Int64(UInt32(57))), UInt16(49), Float64(Float32(Float32(123.0)))), (UInt32(Int16(UInt16(80))), (-38.0), Float32(-9.0), r'F', (), (), UInt64(99), UInt16(Int16(Int16(-1))), Float64(Float64((-22.0)))), (UInt32(Int32(Int32(85))), (-125.0), Float32(84.0), r't', (), (), UInt64(Int64(Int16(87))), UInt16(Int8(89)), 52.0), (UInt32(241), 3.0, Float32(Float32(-20.0)), r'g', (), (), UInt64(Int64(UInt16(194))), UInt16(109), (-17.0)), (UInt32(Int8(-57)), Float64((-102.0)), Float32(Float32(0.0)), r'A', (), (), UInt64(231), UInt16(181), Float64(Float32(Float32(-49.0)))), (UInt32(UInt16(UInt8(173))), 112.0, Float32(Float32(62.0)), r'J', (), (), UInt64(UInt64(Int32(38))), UInt16(UInt8(171)), Float64(Float64(Float32(34.0)))), (UInt32(Int32(Int8(-19))), Float64(124.0), Float32(-104.0), r'o', (), (), UInt64(UInt8(147)), UInt16(Int16(UInt8(100))), Float64(Float64(122.0))), (UInt32(212), 56.0, Float32(Float32(Float32(10.0))), r'N', (), (), UInt64(104), UInt16(210), (-47.0)), (UInt32(Int8(-50)), (-74.0), Float32(-98.0), r'7', (), (), UInt64(Int32(UInt32(44))), UInt16(252), (-58.0)), (UInt32(111), 52.0, Float32(Float32(Float32(97.0))), r'c', (), (), UInt64(105), UInt16(Int8(UInt8(25))), (-38.0))];
    @echo let var687 : UInt64 = UInt64(107);
    @echo var var722 : UInt16 = UInt16(UInt16(UInt8(45)));
    @echo let var776 : Rune = r'c';
    try { // block id: 409
        @echo var var412 : Bool = (UInt16(32) is Interface231);
        @echo let var455 : Float64 = (-122.0);
        @echo var var483 : Unit = ();
        if (var412) { [(UInt32(137), 93.0, Float32(5.0), var421, (), var402, UInt64(19), var427, (-22.0)), var431, var431, (var382, var455, var458, var421, (), (), UInt64(65), UInt16(233), 98.0), (UInt32(31), (-119.0), Float32(-64.0), var421, var402, var402, UInt64(254), UInt16(0), var455), (UInt32(99), var455, var458, r'o', var483, (), var372, UInt16(179), var455), (UInt32(190), (-96.0), Float32(66.0), var421, var483, (), namedParam332, UInt16(22), var455), (var385, 76.0, Float32(116.0), var421, var483, var483, UInt64(43), var427, 26.0), var431, (var382, var455, var458, var421, (), (), UInt64(252), var519, var455)] } else { var523 } 
    } finally { // block id: 673
        @echo var var696 : Float64 = Float64(Float64(Float32(Float32(Float32(-109.0)))));
        @echo var var718 : Unit = ();
        if (var77) { [(var385, var680, var458, var421, var402, (), var687, var519, 12.0), var431, var431, (UInt32(202), var696, Float32(60.0), r'b', var402, var402, UInt64(218), UInt16(91), (-86.0)), (UInt32(98), (-103.0), var713, r'l', var402, var718, UInt64(30), var722, var680), var431, var431, (UInt32(132), (-64.0), Float32(18.0), r'm', (), var402, var372, UInt16(222), var680), (UInt32(186), var680, var458, var421, var718, var718, namedParam332, UInt16(69), var680), var431] } else { [(UInt32(210), var696, var713, r'v', var718, var402, var372, UInt16(11), var696), (UInt32(51), 74.0, Float32(10.0), r'u', (), var718, optionalParam333, var427, (-81.0)), (UInt32(143), (-91.0), var713, var776, var718, (), optionalParam333, UInt16(216), 98.0), (UInt32(68), 53.0, var787, r'a', var718, var402, optionalParam333, UInt16(80), 63.0), var431, var431, (UInt32(60), (-64.0), var713, r'U', var402, (), UInt64(44), UInt16(21), 42.0), var431, (UInt32(141), 62.0, var458, r'o', var402, var718, UInt64(68), UInt16(72), var696), var431] } 
    }[1];
    (try { // block id: 827
        var829;
        var829
    } catch (_) { // block id: 833
        Option<Int8>.Some(Int8(-100))
    } ?? (((var385, var680, var787, var776, var402, (), UInt64(157), UInt16(17), (-7.0)), var851, var519, Option<Int8>.None, var776, var857, var860)[3] ?? try { // block id: 864
        var866
    } catch (_) { // block id: 869
        ();
        Int8(107)
    }))
}

@echo func func3697<T0>() : Class227 { // block id: 322
    @echo var var324 : Float64 = 68.0;
    var324;
    try { // block id: 327

    } finally { // block id: 328

    };
    @echo let var898 : Class227 = Class227();
    match (func331(namedParam332 : (var372, ())[0])) {
        case caseVar879 => 
            @echo var var884 : Range<Int32> = ((Int32(-7)&127)..(Int32(81)&127):((-45)|1));
            if (var77) { var884 } else { ((Int32(-6)&127)..(Int32(2)&127):((-115)|1)) } ;
            @echo let var890 : Class227 = Class227();
            if (var77) { var890 } else { var890 } 
        
        case caseVar895 : Range<Int8> => 
            var898
        
        case -49 | -89 => 
            @echo var var904 : ((UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Float64, UInt16, Option<Int8>, Rune, Int32, Range<Int64>) = ((UInt32(Int8(-112)), 112.0, Float32(39.0), r'N', (), (), UInt64(43), UInt16(Int8(UInt8(167))), Float64(Float32(Float32(-69.0)))), (-80.0), UInt16(242), Option<Int8>.Some(Int8(-8)), r'N', Int32(Int16(UInt8(Int8(32)))), (((-39)&127)..=(Int64(Int32(-102))&127):((Int64(UInt16(202))|1))));
            var904;
            var77 = true;
            if (false) { var898 } else { Class227() } 
        
        case _ => 
            @echo var var947 : UInt8 = UInt8(Int8(-101));
            var947 <<= ((UInt8(33)) & 7);
            var898
        
    }
}

@echo func func265(optionalParam266 ! : UInt16 = UInt16(45), namedParam268 ! : Float32, namedParam269 ! : Range<UInt8>) : Option<Bool> { // block id: 270
    ((var289|>func277) ?? func3697<Float32>().var953);
    var245;
    @echo var var962 : UInt8 = UInt8(UInt8(239));
    @echo let var967 : Int64 = Int64(Int32(111));
    match (try { // block id: 958
            UInt64(137);
            ((var962&127)..=(UInt8(39)&127):((var967|1)));
            (UInt64(45), var402)
        } catch (e: Exception) { // block id: 973
            (var372, var402)
        }) {
        case caseVar979 => 
            @echo var var984 : Class227 = Class227();
            if (true) { var984 } else { Class227() } ;
            if (var77) { Option<Bool>.None } else { var341 } 
        
        case caseVar993 => 
            ();
            Option<Bool>.Some(var77)
        
        case _ => 
            var372 | var372;
            if (false) { var341 } else { var341 } 
        
        case _ => 
            Float32(38.0) - namedParam268;
            var341
        
    }
}

@echo public func func1047<T0, T1>(param1048 : Option<String>) : Interface232 { // block id: 1049
    try { // block id: 1051
        var77 ||= false;
        ("R((xfa &j4", var680, var1061, var1061, var1066)[4]
    } finally { // block id: 1069
        var1066
    }
}







@echo func func1373(param1374 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>) : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) { // block id: 1375
    @echo let var1414 : UInt8 = UInt8(218);
    @echo func func1377(param1378 : UInt16, namedParam1379 ! : UInt64) : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) { // block id: 1380
        @echo var var1388 : (Int16, (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit)) = (Int16(54), (((Int16(78)&127)..=(Int16(64)&127):((-77)|1)), Int16(52), UInt8(UInt8(UInt8(75))), ((Int32(-101)&127)..(Int32(8)&127):((-59)|1)), ###"a{v3=gd*pkT"###, ()));
        @echo let var1409 : Int64 = Int64(Int32(45));
        if (var1061) { var1388 } else { (var1402, (((var1402&127)..=(var1402&127):((var1409|1))), var1402, var1414, ((Int32(-67)&127)..=(Int32(-28)&127):((-38)|1)), var1418, ())) } [1][3];
        @echo let var1517 : Unit = ();
        @echo let var1582 : Unit = ();
        try { // block id: 1424
            try { // block id: 1426
                var385 <<= ((var382) & 7);
                UInt16(231);
                @echo let var1432 : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) = (Float64(Float32(Float32(Float32(89.0)))), Float32(Float32(-94.0)), ((Int16(Int16(-10))&127)..=(Int16(101)&127):(((-39)|1))), (), Int16(82), ((Int8(51)&127)..(Int8(117)&127):(41|1)), ((Int8(Int8(20))&127)..=(Int8(116)&127):((Int64(Int8(-111))|1))), (UInt32(193), Float64(Float64(6.0)), Float32(42.0), r'd', (), (), UInt64(UInt16(225)), UInt16(186), (-121.0)));
                var1432
            } finally { // block id: 1467
                Option<String>.Some("e:z-HZ$=qg");
                Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.None;
                (120.0, Float32(-20.0), ((Int16(104)&127)..=(Int16(81)&127):((-33)|1)), var402, var1402, ((Int8(-46)&127)..=(Int8(-41)&127):((-58)|1)), ((Int8(-51)&127)..(Int8(-22)&127):((-22)|1)), var431)
            }
        } finally { // block id: 1480
            @echo func func1482(namedParam1483 ! : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)), optionalParam1484 ! : Unit = ()) : Unit { // block id: 1486
                @echo let var1496 : Unit = ();
                ((try { // block id: 1494
                    var1496;
                    if (true) { var1501 } else { var1501 } 
                } catch (_) { // block id: 1505
                    Option<Int64>.Some(var1409)
                } ?? var1409)&127)..(var1409&127):((try { // block id: 1511
                    "I3fmT6|)=5";
                    var1409
                } catch (_) { // block id: 1514
                    ();
                    var1517;
                    var1409
                } finally { // block id: 1520
                    (-67)
                }|1));
                @echo let var1526 : Bool = (UInt32(UInt16(UInt16(202))) is Range<Int16>);
                @echo var var1548 : Bool = ((((Int16(-124)&127)..(Int16(UInt8(51))&127):((Int64(UInt32(165))|1))), Int16(Int8(-119)), UInt8(181), ((Int32(Int32(41))&127)..(Int32(-17)&127):((Int64(UInt8(214))|1))), """
dsQ+@
qy}1>
""", ()) is Option<Int64>);
                @echo let var1576 : Unit = ();
                try { // block id: 1523
                    @echo var loopTimeVar1536 : Int64 = 0;
                    do {
                        loopTimeVar1536++;
                        @echo let var1533 : Interface234 = Class227();
                        var1533
                    } while ((var1526) && loopTimeVar1536 < 100 ) 
                } finally { // block id: 1537
                    if (var1061) { // block id: 1540

                    } else if (var1526) { // block id: 1542
                        ();
                        Class227();
                        var1517
                    };
                    match (var1548) {
                        case _ => 
                            var1496
                        
                        case _ : Interface232 => 
                            var1576
                        
                        case _ : UInt8 => 
                            var1582
                        
                        case _ => 
                            var402;
                            ()
                        
                    }
                }
            }
;
            func1482(namedParam1483 : (var851, var1591, ((Int16(-36)&127)..(Int16(-78)&127):((-29)|1)), var1582, Int16(97), ((var866&127)..=(Int8(-119)&127):((var1409|1))), ((Int8(68)&127)..(var866&127):(((-120)|1))), var431));
            @echo var var1623 : Range<Int8> = ((Int8(-7)&127)..(Int8(-106)&127):(34|1));
            (Option<(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64))>.None ?? (var680, Float32(-72.0), var1617, var402, Int16(-37), ((Int8(119)&127)..(Int8(-23)&127):(2|1)), var1623, var431))
        }
    }
;
    @echo let var1663 : Rune = r'n';
    @echo var var1716 : Float32 = Float32(64.0);
    @echo let var1770 : Float64 = Float64(Float32(-91.0));
    @echo let var1840 : (Range<UInt8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), UInt32, Float64, UInt64, Range<Int32>) = (((UInt8(170)&127)..(UInt8(56)&127):(((-123)|1))), (UInt32(12), 65.0, Float32(Float32(-86.0)), r's', (), (), UInt64(97), UInt16(117), Float64(1.0)), UInt32(15), Float64(Float32(Float32(Float32(7.0)))), UInt64(105), ((Int32(Int16(Int8(-73)))&127)..=(Int32(-13)&127):((Int64(Int32(68))|1))));
    func1377(match (UInt8(Int8(102))) {
        case _ => 
            var402;
            var402;
            UInt16(179)
        
        case 1 | 222 => 
            ();
            UInt16(145)
        
        case _ : Option<Int8> => 
            @echo let var1705 : UInt64 = UInt64(157);
            @echo var var1787 : Unit = ();
            if (var77) { [(UInt32(101), 69.0, Float32(-55.0), r'h', var402, var1653, var372, var519, (-115.0)), (var385, var851, var713, var1663, var1653, (), var1668, UInt16(19), (-107.0)), (var385, (-125.0), Float32(-97.0), var1663, var1653, (), UInt64(206), UInt16(67), 95.0), var431, var431, (var385, (-46.0), Float32(-69.0), r'd', var1653, (), var1668, var519, (-62.0)), var431, (UInt32(63), var851, Float32(-52.0), var1663, var1701, (), var1705, var519, var680), var431, var431] } else { [(var382, var851, var1716, r'r', var402, var1653, UInt64(143), var427, (-19.0)), var431, var431, (var382, (-119.0), Float32(18.0), r'O', var1701, (), UInt64(170), var427, (-33.0)), var1737, var431, (var385, 12.0, var1591, var1663, var1653, (), var1763, var519, var680), (UInt32(239), var1770, Float32(-73.0), r'o', var1653, (), var1705, UInt16(44), 67.0), var1737, (var385, (-76.0), var787, r'w', var1787, (), UInt64(166), var519, var1770)] } ;
            @echo let var1796 : UInt16 = UInt16(Int16(UInt16(UInt8(Int8(71)))));
            UInt16(34) * var1796
        
        case _ => 
            UInt16(42)
        
        case _ => 
            if (var77) { Option<Int64>.None } else { Option<Int64>.None } ;
            var1418;
            var427 >> ((UInt16(21)) & 7)
        
    }, namedParam1379 : match {
        case false => 
        var382++;
        var1617;
        if (true) { (((var1414&127)..=(UInt8(52)&127):((95|1))), var1737, var385, (-34.0), UInt64(141), ((var857&127)..(Int32(82)&127):(((-42)|1)))) } else { var1840 } 
        case _ => 
        var1840
    }[4])
}


@echo func func1880(param1881 : (UInt64, UInt64) -> Int8) : Range<Int32> { // block id: 1885
    var1653;
    var1889 *= Int16(-84);
    try { // block id: 1893
        (var1900 ?? ((Int32(85)&127)..=(Int32(111)&127):(70|1)))
    } finally { // block id: 1903
        UInt16(48) ^ var519;
        Int8(var866);
        @echo let var1910 : Range<Int32> = ((Int32(-4)&127)..=(Int32(-122)&127):(40|1));
        var1910
    }
}



@echo public func func2189(param2190 : Range<Int8>) : Unit { // block id: 2191
    @echo var var2220 : Int8 = Int8(-5);
    @echo var var2511 : Interface232 = Class227(((96&127)..(102&127):((-12)|1)));
    @echo var var2545 : UInt8 = UInt8(Int8(-78));
    @echo var loopTimeVar2557 : Int64 = 0;
    while ((match (match ((((UInt8(65)&127)..=(UInt8(167)&127):(86|1)), (var382, 96.0, Float32(-53.0), r'D', (), (), UInt64(97), var427, 117.0), UInt32(187), (-17.0), UInt64(148), ((var857&127)..(var857&127):((12|1))))) {
            case caseVar2216 : Range<Int16> => 
                var2220 |= Int8(4);
                var2224;
                @echo let var2482 : Int64 = Int64(Int16(UInt16(Int8(Int8(-91)))));
                Class227(((var2482&127)..=(var2482&127):((8|1))))
            
            case caseVar2492 => 
                var402;
                @echo let var2496 : (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit) = (((Int16(65)&127)..(Int16(96)&127):((75|1))), Int16(-21), UInt8(Int8(39)), ((Int32(-107)&127)..(Int32(-69)&127):(40|1)), "p$1E[r R_6", ());
                var2496;
                if (var77) { var2511 } else { var2515 } 
            
            case (caseVar2519,(caseVar2520 : Float32,_,caseVar2521 : Int64,caseVar2522,_ : Int16,caseVar2523 : Range<UInt16>,_ : Range<Int8>,caseVar2524 : ((UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Float64, UInt16, Option<Int8>, Rune, Int32, Range<Int64>),caseVar2525 : Int16),_,_ : (String, Float64, Bool, Bool, Interface232),_,_) => 
                Option<Interface230>.Some(Class227());
                if (false) { Class227() } else { var2515 } 
            
            case _ => 
                Option<String>.None;
                var857 &= Int32(66);
                Class227(var860)
            
        }) {
        case _ => 
            var2545;
            ();
            true
        
        case _ => 
            Float32(115.0) >= Float32(116.0)
        
    }) && loopTimeVar2557 < 100 ) {
        loopTimeVar2557++;

    };
    @echo let var2596 : Float64 = (-114.0);
    @echo let var2608 : Float64 = Float64(Float32(68.0));
    @echo var var2681 : Bool = (Option<Range<Int32>>.Some(((Int32(-11)&127)..(Int32(-23)&127):((Int64(Int16(-64))|1)))) is Unit);
    @echo let var2714 : Array<Bool> = [false, true, false, false, true, true, true, false, false, true];
    @echo let var2751 : Interface234 = Class227();
    @echo func func2719(optionalParam2720 ! : ((Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)) -> Option<UInt64> = func277, namedParam2724 ! : Option<Rune>, optionalParam2725 ! : Range<Int64> = ((76&127)..=((-34)&127):(((-45)|1)))) : Unit { // block id: 2730
        @echo let var2787 : Range<UInt8> = ((UInt8(Int8(51))&127)..=(UInt8(UInt8(181))&127):((Int64(UInt8(Int8(78)))|1)));
        match (match (Class227()) {
                case caseVar2738 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> => 
                    namedParam2724;
                    @echo var var2745 : Interface234 = Class227();
                    if (true) { Class227() } else { var2745 } 
                
                case _ => 
                    var2751
                
                case _ => 
                    var382 *= var382;
                    var1889 ^= Int16(32);
                    if (false) { Class227() } else { var2751 } 
                
            }) {
            case _ => 
                @echo let var2775 : UInt8 = UInt8(Int8(UInt8(Int8(Int8(13)))));
                [((UInt8(23)&127)..(UInt8(23)&127):(70|1)), ((UInt8(20)&127)..=(UInt8(166)&127):((-30)|1)), ((UInt8(134)&127)..(UInt8(30)&127):((-108)|1)), ((UInt8(122)&127)..=(var2775&127):((75|1))), ((UInt8(62)&127)..=(UInt8(158)&127):((-5)|1)), var1017, var1017, var1017, var2787, ((UInt8(67)&127)..=(UInt8(38)&127):((-126)|1))]
            
            case _ => 
                var2800
            
        }[4];
        var1701
    }
;
    @echo var var2845 : Option<Rune> = Option<Rune>.None;
    if (match (if (var2562) { var2565 } else { ((var385, var2596, var713, var2133, (), var2136, var1763, var2604, var2608), (-71.0), var427, var2614, var2133, var857, var860) } ) {
        case caseVar2622 => 
            var1889 += Int16(-10);
            true
        
        case caseVar2630 => 
            ();
            var2545;
            true
        
        case ((_,_,_,caseVar2637,_ : Float32,caseVar2638,_ : String,_ : Range<Int16>,caseVar2639 : Option<Bool>),caseVar2640,caseVar2641 : Option<Rune>,_ : (Int16, (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit)),_,caseVar2642 : Range<Int32>,_ : Float64) => 
            false
        
        case ((caseVar2647,caseVar2648,_ : Unit,caseVar2649,_ : Option<(UInt64, Unit)>,_ : UInt64,caseVar2650 : Range<Int32>,_ : UInt16,_),caseVar2651 : Range<Int8>,caseVar2652 : UInt32,_ : Interface232,_,_,_) => 
            false
        
        case _ => 
            var2136;
            var2562 && var2562
        
    }) { // block id: 2661

    } else if (try { // block id: 2664
        var2667 |= var427;
        @echo var var2678 : Bool = false;
        @echo let var2693 : Bool = false;
        [var77, true, var1061, true, var2678, var2681, true, true, var2681, var2693]
    } finally { // block id: 2695
        Option<(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64))>.None;
        var787 - var787;
        @echo var var2702 : Bool = (((UInt64(Int16(-81))&127)..(UInt64(Int32(-95))&127):((Int64(UInt8(Int8(117)))|1))) is (UInt64, Unit));
        if (var2702) { [true, false, false, true, true, true, true, true, true, true] } else { var2714 } 
    }[5]) { // block id: 2717
        func2719(namedParam2724 : var2845, optionalParam2725 : ((91&127)..=((-3)&127):(49|1)));
        @echo var loopTimeVar2856 : Int64 = 0;
        do {
            loopTimeVar2856++;
            ();
            var2667 = var2667
        } while ((var77) && loopTimeVar2856 < 100 ) ;
        if (var1061) { // block id: 2859

        }
    }
}

@echo public func func1966(param1967 : String) : Unit { // block id: 1968
    @echo var var1980 : Option<UInt64> = Option<UInt64>.Some(UInt64(135));
    @echo var var2008 : Option<Option<UInt64>> = Option<Option<UInt64>>.Some(Option<UInt64>.Some(UInt64(40)));
    @echo var var2026 : Int64 = Int64(65);
    @echo var var2037 : Range<UInt64> = ((UInt64(102)&127)..(UInt64(13)&127):((-35)|1));
    @echo let var2114 : Int8 = Int8(UInt8(25));
    match (match (match (Float32(77.0)) {
                case 79.0 => 
                    var1418;
                    ();
                    Option<Option<UInt64>>.Some(var1980)
                
                case -109.0 => 
                    Option<Option<UInt64>>.Some(var1980)
                
                case 4.0 | 126.0 => 
                    var1653;
                    @echo var var1993 : (Range<Int8>, Bool, UInt8, UInt32) = (((Int8(-3)&127)..(Int8(UInt8(159))&127):(((-14)|1))), ((-5.0) is Option<Int64>), UInt8(33), UInt32(UInt16(UInt16(Int16(-20)))));
                    var1993;
                    var2008
                
                case _ => 
                    Option<Option<UInt64>>.None
                
            }) {
            case caseVar2018 => 
                if (var77) { ((UInt64(14)&127)..=(var1763&127):((var2026|1))) } else { ((UInt64(180)&127)..(UInt64(67)&127):(43|1)) } 
            
            case caseVar2032 => 
                var402;
                var1701;
                var2037
            
            case _ => 
                ();
                ((UInt64(52)&127)..(UInt64(51)&127):(96|1))
            
            case caseVar2046 : Option<Rune> => 
                @echo let var2049 : (Int16, (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit)) = (Int16(UInt16(UInt8(41))), (((Int16(111)&127)..=(Int16(-121)&127):(60|1)), Int16(Int8(-111)), UInt8(118), ((Int32(-58)&127)..=(Int32(48)&127):((-80)|1)), "kJ|N\\+udZ8", ()));
                var2049;
                var2037
            
            case _ => 
                var1653;
                false;
                if (false) { ((UInt64(87)&127)..=(UInt64(5)&127):((-82)|1)) } else { ((var1763&127)..(UInt64(239)&127):((var2026|1))) } 
            
        }) {
        case _ : Option<Interface230> => 
            ();
            var289
        
        case _ : Array<Bool> => 
            ();
            ((Int16(74)&127)..(Int16(75)&127):((-83)|1));
            var289
        
        case _ => 
            UInt32(226);
            var2026--;
            (var2026, ((var2026&127)..(var2026&127):((49|1))), (UInt32(60), 59.0, Float32(-10.0), r'a', (), (), UInt64(172), var427, (-67.0)), var1617, Option<String>.Some(param1967), UInt32(237), Int8(60), ((var2114&127)..(var866&127):((20|1))), var402)
        
        case caseVar2122 => 
            ();
            @echo var var2140 : UInt64 = UInt64(UInt32(137));
            @echo var var2150 : Option<String> = Option<String>.Some("g(y9'94bbZ");
            (var2026, var860, (var382, 79.0, Float32(-123.0), var2133, var2136, (), var2140, UInt16(249), var851), ((Int16(77)&127)..=(var1889&127):((var2026|1))), var2150, var382, var866, ((Int8(3)&127)..=(Int8(47)&127):(46|1)), var1701)
        
        case _ => 
            @echo var var2182 : Option<String> = Option<String>.None;
            (var2026, var860, var2163, var1617, var2182, UInt32(16), Int8(-113), ((Int8(17)&127)..=(Int8(22)&127):(78|1)), ())
        
    };
    ((Int8(-52)&127)..(Int8(-110)&127):(31|1))|>{ lambdaParameter2862 : Range<Int8> =>  }
}

@echo func func1913(param1914 : ((UInt64, UInt64) -> Int8) -> Range<Int32>) : Range<Int32> { // block id: 1917
    @echo let var2871 : Class227 = Class227();
    @echo var var2899 : Range<Int32> = ((Int32(-100)&127)..(Int32(-128)&127):((-91)|1));
    @echo let var2911 : Int64 = (-46);
    match {
        case (Option<Array<Bool>>.Some([true, true, true, false, false, false, false, false, true, false]) ?? var1929)[8] => 
        @echo var var1939 : ?(UInt64, Unit) = (((Int16(-41), (((Int16(3)&127)..(Int16(124)&127):((10|1))), Int16(33), UInt8(164), ((Int32(44)&127)..(Int32(-112)&127):((76|1))), """
2Y2Ff
h6xpW
""", ())) as Bool) as (UInt64, Unit));
        @echo var var1958 : (UInt64, Unit) = (UInt64(Int64(UInt8(170))), ());
        (var1939 ?? var1958)
        case _ => 
        @echo var var2866 : (String) -> Unit = func1966;
        var1418|>var2866;
        @echo let var2886 : UInt8 = UInt8(26);
        match (var2871) {
            case _ => 
                var245;
                @echo let var2877 : ?Interface230 = Option<Interface230>.Some(Class227());
                var2877;
                if (false) { (var1617, Int16(-128), var2886, ((Int32(-2)&127)..=(var857&127):((21|1))), ###"P-5kHZGq,'"###, var2136) } else { (((Int16(26)&127)..=(Int16(37)&127):((-91)|1)), var1889, var2886, var2899, var360, var1653) } 
            
        };
        @echo var var2919 : Range<Int8> = ((Int8(28)&127)..=(Int8(68)&127):(11|1));
        match (Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(((-28), (((-40)&127)..((-16)&127):((var2911|1))), var1737, var1617, Option<String>.None, UInt32(111), Int8(23), var2919, var2922))) {
            case caseVar2926 : Interface231 => 
                ();
                if (var2562) { var2932 } else { var2932 } 
            
            case _ => 
                (var372, ())
            
            case _ : Option<Range<Int32>> => 
                if (true) { var2932 } else { var2932 } 
            
            case caseVar2953 => 
                var1889 // too hard to revise the test case
                @echo var var2960 : Bool = (r'x' is Range<Int64>);
                var2960 = true;
                var2932
            
            case _ => 
                var1653;
                var77;
                var2932
            
        }
    };
    @echo var var2976 : (Range<Int16>, Int16, UInt8, Range<Int32>, String, Unit) = (((Int16(-56)&127)..=(Int16(15)&127):((-19)|1)), Int16(Int8(-52)), UInt8(Int8(78)), ((Int32(92)&127)..(Int32(Int8(Int8(-119)))&127):((114|1))), "(]-F`2Iy]|", ());
    match ((var1889, var2976)) {
        case (_,(caseVar2993 : Range<Int64>,_ : Range<Int8>,_ : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>,_,_,_)) => 
            Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.None;
            if (var1061) { [UInt32(17), var382, var385, var382, var382, UInt32(6), var3006, var3006, var3006, var3006] } else { [UInt32(75), UInt32(210), UInt32(181), UInt32(98), UInt32(159), UInt32(202), UInt32(219), UInt32(59), UInt32(85), UInt32(182)] } 
        
        case (caseVar3014,(_,caseVar3015,caseVar3016 : Unit,caseVar3017,_ : Option<Int8>,caseVar3018)) => 
            ();
            ();
            @echo let var3033 : UInt32 = UInt32(UInt16(Int16(UInt16(98))));
            [UInt32(180), UInt32(158), var382, UInt32(151), UInt32(180), UInt32(48), var382, var382, UInt32(252), var3033]
        
        case _ : String => 
            ();
            [UInt32(119), UInt32(16), UInt32(76), UInt32(189), UInt32(109), UInt32(47), UInt32(51), UInt32(234), UInt32(130), UInt32(228)]
        
        case _ => 
            ();
            var3048
        
        case _ => 
            var3053;
            ();
            [UInt32(79), UInt32(204), UInt32(254), UInt32(230), UInt32(43), UInt32(200), UInt32(217), UInt32(205), UInt32(29), UInt32(73)]
        
    }[9];
    @echo let var3060 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> = Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(((-112), ((Int64(UInt64(5))&127)..=(Int64(Int16(-39))&127):((50|1))), (UInt32(189), 82.0, Float32(-78.0), r'f', (), (), UInt64(170), UInt16(209), Float64(Float32(85.0))), ((Int16(31)&127)..=(Int16(-60)&127):(((-69)|1))), Option<String>.None, UInt32(Int32(UInt32(166))), Int8(Int8(UInt8(11))), ((Int8(78)&127)..(Int8(45)&127):(9|1)), ()));
    @echo var var3262 : Rune = r'4';
    @echo let var3318 : Range<Int32> = ((Int32(109)&127)..(Int32(-33)&127):(106|1));
    match (var3060) {
        case caseVar3096 : Interface234 => 
            @echo var var3114 : Float64 = Float64(83.0);
            @echo var var3127 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(27), 83.0, Float32(Float32(36.0)), r'S', (), (), UInt64(83), UInt16(Int16(Int16(36))), 32.0);
            @echo var var3185 : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) = (UInt32(186), (-29.0), Float32(-42.0), r'n', (), (), UInt64(UInt32(64)), UInt16(97), Float64(Float32(31.0)));
            if (var1061) { [(UInt32(108), (-18.0), Float32(97.0), r'R', (), (), var1668, UInt16(231), 33.0), (UInt32(12), var3114, Float32(61.0), r'D', var402, (), UInt64(87), var2667, var3114), var2163, var2163, var3127, (var385, var851, var1591, r'z', var1701, (), var1668, var2604, (-41.0)), var2163, var2163, (var3006, var3156, var787, var2133, (), (), UInt64(32), UInt16(159), 28.0), var3127] } else { [var1737, var3127, var1737, var3127, (var382, 1.0, Float32(60.0), r'y', (), var2922, UInt64(40), var2604, (-35.0)), var431, var3185, (var382, var3201, var787, var2133, var1701, (), var372, var2604, (-49.0)), var3211, (UInt32(220), 73.0, var787, r'h', (), (), UInt64(70), var2667, var3156)] } ;
            @echo let var3240 : Bool = false;
            if (var3240) { Class227() } else { var3244 } ;
            ((var857&127)..=(Int32(-67)&127):((var2911|1)))
        
        case _ => 
            if (var77) { (var1017, (UInt32(107), (-110.0), var713, var3262, var2922, var402, UInt64(205), UInt16(122), var851), UInt32(165), var3156, UInt64(42), ((var857&127)..=(Int32(-48)&127):(((-19)|1)))) } else { (var1017, (UInt32(207), var680, Float32(-24.0), var3262, var1653, var1653, var1668, UInt16(143), 112.0), UInt32(136), var851, UInt64(108), ((Int32(-117)&127)..(var857&127):((104|1)))) } ;
            if (false) { Class227() } else { Class227() } ;
            var2899
        
        case _ : Range<UInt32> => 
            var2667 /= ((UInt16(157)) | 1);
            Option<Option<UInt64>>.Some(Option<UInt64>.None);
            if (var2562) { ((Int32(12)&127)..=(Int32(-33)&127):(27|1)) } else { ((Int32(-88)&127)..=(Int32(-102)&127):((-114)|1)) } 
        
        case _ => 
            if (true) { ((Int32(-43)&127)..(Int32(-28)&127):(120|1)) } else { var3318 } 
        
    }
}

@echo public func func3323(param1881 : (UInt64, UInt64) -> Int8) : Range<Int32> { // block id: 1885
    var1653;
    var1889 *= Int16(-84);
    try { // block id: 1893
        (var1900 ?? ((Int32(85)&127)..=(Int32(111)&127):(70|1)))
    } finally { // block id: 1903
        UInt16(48) ^ var519;
        Int8(var866);
        @echo let var1910 : Range<Int32> = ((Int32(-4)&127)..=(Int32(-122)&127):(40|1));
        var1910
    }
}

@echo func func3328<T0>(param3329 : (UInt64, UInt64) -> Int8) : ((UInt64, UInt64) -> Int8) -> Range<Int32> { // block id: 3333
    @echo let var3335 : ((UInt64, UInt64) -> Int8) -> Range<Int32> = func3323;
    var3335
}

@echo public func func3340(namedParam332 : UInt64, optionalParam333 : UInt64) : Int8 { // block id: 336
    @echo var var397 : Int16 = Int16(-109);
    @echo var loopTimeVar405 : Int64 = 0;
    while ((if ((var341 ?? var77)) { // block id: 345
        @echo var var348 : Int16 = Int16(41);
        var348 |= Int16(-35);
        optionalParam333 < UInt64(41)
    } else { // block id: 354
        true
    }) && loopTimeVar405 < 100 ) {
        loopTimeVar405++;
        match (Option<String>.Some(var360)) {
            case _ => 
                ()
            
            case caseVar368 => 
                var372 >>= ((UInt64(125)) & 7);
                ()
            
            case caseVar378 => 
                var382 // Too hard to revise the fuzz test case.
            
            case _ => 
                @echo var var391 : Unit = ();
                var391
            
            case _ => 
                var397 >>= ((var397) & 7);
                ();
                var402
            
        }
    };
    @echo var var421 : Rune = r't';
    @echo let var458 : Float32 = Float32(Float32(106.0));
    @echo var var523 : Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)> = Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>(10){ i => (UInt32(86), 117.0, Float32(-107.0), r'H', (), (), UInt64(Int64(UInt32(57))), UInt16(49), Float64(Float32(Float32(123.0)))) };
    @echo let var687 : UInt64 = UInt64(107);
    @echo var var722 : UInt16 = UInt16(UInt16(UInt8(45)));
    @echo let var776 : Rune = r'c';
    try { // block id: 409
        @echo var var412 : Bool = (UInt16(32) is Interface231);
        @echo let var455 : Float64 = (-122.0);
        @echo var var483 : Unit = ();
        if (var412) { [(UInt32(137), 93.0, Float32(5.0), var421, (), var402, UInt64(19), var427, (-22.0)), var431, var431, (var382, var455, var458, var421, (), (), UInt64(65), UInt16(233), 98.0), (UInt32(31), (-119.0), Float32(-64.0), var421, var402, var402, UInt64(254), UInt16(0), var455), (UInt32(99), var455, var458, r'o', var483, (), var372, UInt16(179), var455), (UInt32(190), (-96.0), Float32(66.0), var421, var483, (), namedParam332, UInt16(22), var455), (var385, 76.0, Float32(116.0), var421, var483, var483, UInt64(43), var427, 26.0), var431, (var382, var455, var458, var421, (), (), UInt64(252), var519, var455)] } else { var523 } 
    } finally { // block id: 673
        @echo var var696 : Float64 = Float64(Float64(Float32(Float32(Float32(-109.0)))));
        @echo var var718 : Unit = ();
        if (var77) { [(var385, var680, var458, var421, var402, (), var687, var519, 12.0), var431, var431, (UInt32(202), var696, Float32(60.0), r'b', var402, var402, UInt64(218), UInt16(91), (-86.0)), (UInt32(98), (-103.0), var713, r'l', var402, var718, UInt64(30), var722, var680), var431, var431, (UInt32(132), (-64.0), Float32(18.0), r'm', (), var402, var372, UInt16(222), var680), (UInt32(186), var680, var458, var421, var718, var718, namedParam332, UInt16(69), var680), var431] } else { [(UInt32(210), var696, var713, r'v', var718, var402, var372, UInt16(11), var696), (UInt32(51), 74.0, Float32(10.0), r'u', (), var718, optionalParam333, var427, (-81.0)), (UInt32(143), (-91.0), var713, var776, var718, (), optionalParam333, UInt16(216), 98.0), (UInt32(68), 53.0, var787, r'a', var718, var402, optionalParam333, UInt16(80), 63.0), var431, var431, (UInt32(60), (-64.0), var713, r'U', var402, (), UInt64(44), UInt16(21), 42.0), var431, (UInt32(141), 62.0, var458, r'o', var402, var718, UInt64(68), UInt16(72), var696), var431] } 
    }[1];
    (try { // block id: 827
        var829;
        var829
    } catch (_) { // block id: 833
        Option<Int8>.Some(Int8(-100))
    } ?? (((var385, var680, var787, var776, var402, (), UInt64(157), UInt16(17), (-7.0)), var851, var519, Option<Int8>.None, var776, var857, var860)[3] ?? try { // block id: 864
        var866
    } catch (_) { // block id: 869
        ();
        Int8(107)
    }))
}

@echo public func func1876(param1877 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>) : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) { // block id: 1878
    @echo let var3321 : (((UInt64, UInt64) -> Int8) -> Range<Int32>) -> Range<Int32> = func1913;
    @echo var var3338 : ((UInt64, UInt64) -> Int8) -> ((UInt64, UInt64) -> Int8) -> Range<Int32> = func3328<Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>>;
    func3340|>(var3338~>var3321);
    @echo var var3358 : ?(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) = Option<(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64))>.None;
    @echo var var3631 : Unit = ();
    if ([[false, false, true, true, true, false, false, false, false, true], [true, true, true, true, true, true, true, true, true, false], [false, false, false, false, true, false, false, false, true, false], [true, true, true, true, true, true, false, false, true, false], [false, false, true, true, true, true, true, false, true, true], [true, true, true, true, false, false, true, true, true, true], [true, false, true, true, false, false, true, false, false, true], [true, true, false, true, true, true, false, false, false, true], [true, false, false, true, true, true, false, true, true, true], [false, false, true, true, true, true, false, false, false, false]][9][2]) { // block id: 3351
        if (var2562) { var1900 } else { var1900 } ;
        @echo let var3367 : Range<Int8> = ((Int8(UInt8(101))&127)..(Int8(-118)&127):(((-86)|1)));
        (var3358 ?? (var851, var787, ((Int16(72)&127)..=(Int16(93)&127):((-11)|1)), (), Int16(60), var3367, ((Int8(-107)&127)..(Int8(-17)&127):(54|1)), (var3006, var680, var1591, r'1', var1653, (), UInt64(66), var519, var3201)))
    } else { // block id: 3384
        match (Class227()) {
            case _ => 
                var1061 ||= var2562;
                ()
            
        };
        @echo var var3448 : Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)> = Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>(10){ i => (UInt32(Int8(UInt8(78))), Float64(75.0), Float32(-5.0), r'B', (), (), UInt64(UInt32(Int8(-126))), UInt16(UInt16(206)), Float64(Float64((-76.0)))) };
        @echo var var3661 : UInt16 = UInt16(Int8(-48));
        match (var385) {
            case 169 => 
                @echo let var3399 : Unit = ();
                var3399;
                if (false) { [var3211, var2163, var3211, var1737, var431, var2163, (UInt32(109), var851, var787, var2133, (), (), UInt64(195), var427, var680), var431, (UInt32(188), var3424, var713, r'n', (), var1653, UInt64(182), UInt16(26), var851), (var382, var851, Float32(-114.0), r'y', (), (), UInt64(216), var2604, (-125.0))] } else { var3448 } 
            
            case 223 => 
                Option<Range<Int32>>.Some(((Int32(78)&127)..=(var857&127):((77|1))));
                Int8(-12) | Int8(-51);
                [var1737, (var3006, 126.0, var713, r'g', (), var402, UInt64(118), var519, var3201), (var3006, var680, var787, r'u', var3631, (), UInt64(124), UInt16(48), var3201), var2163, var1737, var431, var1737, var2163, (var382, var680, Float32(-12.0), r'G', var2922, (), var1763, UInt16(130), var851), (UInt32(170), var851, Float32(82.0), r'G', (), (), var1668, var3661, var851)]
            
            case _ => 
                var3448
            
        };
        var3669
    }
}

@echo public func func3697(param3698 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>) : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> { // block id: 3699
    @echo var var3722 : ?Int8 = Option<Int8>.None;
    @echo let var3875 : Option<String> = Option<String>.Some(###"W?0,aCuA<("###);
    @echo var var3881 : Range<Int8> = ((Int8(-30)&127)..(Int8(-37)&127):((-17)|1));
    @echo let var3887 : Int64 = Int64(Int8(24));
    (try { // block id: 3702
        var2136;
        Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.Some(Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(var289))
    } finally { // block id: 3707
        ((var382, var3424, var713, var2133, var2922, var1701, var372, UInt16(63), var680), var3156, UInt16(237), var3722, var2133, Int32(28), (((-45)&127)..(35&127):(8|1)));
        @echo let var3730 : (Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>, Int64, Interface231) = ([(UInt32(8), (-119.0), Float32(Float32(-59.0)), r'q', (), (), UInt64(72), UInt16(115), (-110.0)), (UInt32(UInt32(69)), 92.0, Float32(-23.0), r'U', (), (), UInt64(153), UInt16(UInt16(229)), Float64(43.0)), (UInt32(89), Float64(Float32(-3.0)), Float32(-13.0), r'r', (), (), UInt64((-107)), UInt16(Int16(-122)), (-97.0)), (UInt32(UInt32(251)), (-39.0), Float32(Float32(79.0)), r'T', (), (), UInt64(Int8(-77)), UInt16(UInt16(154)), (-61.0)), (UInt32(UInt32(252)), Float64(29.0), Float32(Float32(-45.0)), r'w', (), (), UInt64(Int8(-14)), UInt16(Int8(113)), Float64(Float32(-46.0))), (UInt32(28), 6.0, Float32(Float32(124.0)), r'g', (), (), UInt64(Int8(101)), UInt16(Int8(49)), 100.0), (UInt32(UInt32(86)), (-38.0), Float32(Float32(95.0)), r't', (), (), UInt64(33), UInt16(151), Float64(Float32(-117.0))), (UInt32(Int8(55)), Float64(Float32(-102.0)), Float32(-10.0), r'x', (), (), UInt64(71), UInt16(UInt8(128)), 70.0), (UInt32(Int16(56)), Float64(Float32(-27.0)), Float32(-62.0), r'W', (), (), UInt64(48), UInt16(Int16(74)), (-48.0)), (UInt32(6), 99.0, Float32(-4.0), r'P', (), (), UInt64(UInt8(152)), UInt16(39), Float64(Float32(-48.0)))], (-48), Class227());
        if (false) { var3730 } else { var3730 } ;
        Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.Some(Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(((-5), var860, var3211, var1617, var3875, UInt32(43), var866, var3881, var402)))
    } ?? Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some((var3887, (((-19)&127)..=(100&127):((-73)|1)), var1737, ((var1402&127)..(Int16(123)&127):(((-125)|1))), var3875, UInt32(251), var866, var3881, var1653)))
}

@echo public func func1370() : (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) { // block id: 1371
    @echo var var3695 : (Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>) -> (Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) = func1876;
    @echo let var3903 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> = Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some((Int64(UInt64(161)), (((-88)&127)..=((-100)&127):(112|1)), (UInt32(UInt8(240)), (-36.0), Float32(Float32(-21.0)), r'Z', (), (), UInt64(Int16(-101)), UInt16(Int8(88)), 88.0), ((Int16(UInt16(42))&127)..(Int16(UInt16(239))&127):((Int64(Int8(39))|1))), Option<String>.None, UInt32(Int16(Int8(-76))), Int8(UInt8(142)), ((Int8(91)&127)..(Int8(-8)&127):(88|1)), ()));
    var3903|>(func3697~>var3695)
}


@echo public func func1364(param1365 : Range<UInt32>) : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) { // block id: 1366
    func1370()[3];
    @echo let var4014 : UInt64 = UInt64(Int32(58));
    @echo let var4063 : Int64 = 73;
    try { // block id: 3940
        try { // block id: 3942
            var1889--;
            ()
        } catch (e: Exception) { // block id: 3946
            var1061 &&= false
        };
        @echo let var3957 : ?(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)) = Option<(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64))>.None;
        Option<Option<(Float64, Float32, Range<Int16>, Unit, Int16, Range<Int8>, Range<Int8>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64))>>.Some(var3957).getOrThrow();
        @echo let var3965 : Option<String> = Option<String>.Some(###"Ud25*$~za{)"###);
        match {
            case var1061 => 
            if (false) { var3965 } else { Option<String>.None } ;
            @echo var var3974 : Float64 = Float64(Float64(Float64(Float64((-84.0)))));
            if (var2562) { (UInt32(160), var3974, var1591, r'p', (), (), var3985, UInt16(185), var3201) } else { (var3993, 113.0, var787, var2133, var1701, var2922, var1763, UInt16(248), var3156) } 
            case _ => 
            (UInt32(72), 19.0, Float32(-107.0), r'G', var1701, var4011, var4014, UInt16(34), 66.0)
        }
    } finally { // block id: 4019
        @echo var var4038 : UInt8 = UInt8(UInt8(UInt8(UInt8(68))));
        match (var3669) {
            case _ : Option<String> => 
                ()
            
            case _ => 
                var2922;
                ();
                ()
            
            case caseVar4034 => 
                var4038 |= UInt8(114)
            
            case _ => 
                if (true) { var4049 } else { Class227() } ;
                @echo var var4054 : Float64 = Float64(Float32(Float32(-14.0)));
                ()
            
        };
        ((var866&127)..(var866&127):((var4063|1)));
        try { // block id: 4066
            (UInt32(84), var3156, var713, var2133, (), var4011, var1668, var519, var680)
        } catch (_) { // block id: 4077
            var4011;
            (var385, (-97.0), var4083, r'd', var1701, var402, UInt64(53), UInt16(114), (-43.0))
        } finally { // block id: 4091
            var3669;
            ((Int32(43)&127)..=(Int32(-117)&127):((-43)|1));
            (var3006, var3201, Float32(-100.0), var2133, (), var4011, UInt64(101), UInt16(162), 112.0)
        }
    }
}

@echo func func1222(param1223 : Range<Int64>) : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64) { // block id: 1224
    @echo let var1228 : (Array<(UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64)>, Int64, Interface231) = ([(UInt32(181), 63.0, Float32(Float32(-27.0)), r'8', (), (), UInt64(180), UInt16(214), Float64(Float32(-122.0))), (UInt32(Int16(95)), Float64(Float32(84.0)), Float32(Float32(-111.0)), r'8', (), (), UInt64(46), UInt16(UInt16(26)), Float64(Float32(-83.0))), (UInt32(Int16(-95)), (-71.0), Float32(Float32(37.0)), r'k', (), (), UInt64(20), UInt16(166), (-94.0)), (UInt32(33), 119.0, Float32(Float32(-41.0)), r'D', (), (), UInt64(57), UInt16(Int16(-29)), 120.0), (UInt32(206), Float64(Float32(-56.0)), Float32(-77.0), r'k', (), (), UInt64(UInt8(214)), UInt16(Int8(-113)), Float64(80.0)), (UInt32(Int32(83)), Float64(100.0), Float32(Float32(16.0)), r'o', (), (), UInt64(234), UInt16(239), Float64((-31.0))), (UInt32(215), 0.0, Float32(117.0), r'h', (), (), UInt64(Int32(39)), UInt16(172), 109.0), (UInt32(UInt16(37)), 79.0, Float32(Float32(-60.0)), r'Z', (), (), UInt64(Int32(14)), UInt16(111), 24.0), (UInt32(UInt8(147)), (-81.0), Float32(Float32(-40.0)), r'R', (), (), UInt64(99), UInt16(UInt8(10)), Float64(Float32(44.0))), (UInt32(199), 104.0, Float32(Float32(109.0)), r'R', (), (), UInt64(186), UInt16(UInt16(245)), (-107.0))], (-2), Class227());
    var1228[2];
    ((UInt32(181)&127)..=(UInt32(197)&127):(13|1))|>func1364
}

@echo public func func204(param205 : (Rune) -> Bool) : Unit { // block id: 208
    @echo let var217 : Option<String> = Option<String>.None;
    @echo func func222() : Range<UInt64> { // block id: 223
        @echo func func236(param237 : Unit, param238 : Class8, param239 : Interface230) : Class227 { // block id: 240
            Class227()
        }
;
        @echo let var4309 : UInt8 = UInt8(UInt8(UInt8(UInt8(UInt8(81)))));
        func236((), var176, var245).func248(optionalParam258 : Class227(), namedParam260 : var4309)[4];
        try { // block id: 4317
            @echo var var4323 : UInt64 = UInt64(219);
            try { // block id: 4319
                var1668 >>= ((var4323) & 7);
                var2224
            } catch (_) { // block id: 4326
                var1617;
                var2224
            } finally { // block id: 4329
                Option<Bool>.Some(true);
                ();
                if (false) { ((UInt32(167)&127)..=(UInt32(149)&127):((-83)|1)) } else { ((UInt32(158)&127)..=(UInt32(207)&127):(71|1)) } 
            }
        } finally { // block id: 4337
            match ((var3211, var3424, var427, Option<Int8>.None, var4345, Int32(-8), ((12&127)..=((-23)&127):((83|1))))) {
                case caseVar4354 => 
                    if (false) { Option<Option<UInt64>>.Some(Option<UInt64>.None) } else { var4361 } 
                
                case _ => 
                    @echo var var4369 : UInt64 = UInt64(107);
                    Option<Option<UInt64>>.Some(Option<UInt64>.Some(var4369))
                
                case _ => 
                    Class227();
                    var4376;
                    if (var2562) { Option<Option<UInt64>>.None } else { Option<Option<UInt64>>.Some(Option<UInt64>.None) } 
                
                case _ => 
                    Option<Option<UInt64>>.Some(var3053)
                
            };
            if (true) { var341 } else { var341 } ;
            ((UInt32(137)&127)..=(UInt32(151)&127):((-127)|1))
        };
        if (try { // block id: 4394
            ((UInt64(207)&127)..=(UInt64(0)&127):((-88)|1));
            var4398 += (-105);
            var866 != var866
        } finally { // block id: 4404
            false
        }) { if (var77) { [((UInt64(20)&127)..=(UInt64(26)&127):((-75)|1)), ((UInt64(143)&127)..(UInt64(140)&127):((-86)|1)), ((UInt64(16)&127)..(UInt64(45)&127):((-39)|1)), ((UInt64(171)&127)..=(UInt64(145)&127):((-27)|1)), ((UInt64(106)&127)..=(UInt64(3)&127):((-88)|1)), ((UInt64(85)&127)..(UInt64(0)&127):((-37)|1)), ((UInt64(223)&127)..=(UInt64(172)&127):((-88)|1)), ((UInt64(101)&127)..(UInt64(247)&127):(20|1)), ((UInt64(224)&127)..(UInt64(172)&127):(43|1)), ((UInt64(199)&127)..=(UInt64(146)&127):((-25)|1))] } else { var4412 } [0] } else { (((Option<UInt64>.None ?? UInt64(197))&127)..=(UInt64(37)&127):(((Option<Int64>.Some(84) ?? (-1))|1))) } 
    }
;
    @echo var loopTimeVar4455 : Int64 = 0;
    do {
        loopTimeVar4455++;
        func222()
    } while ((((var217 ?? ###"1zudN?<)l6"###) is UInt32)) && loopTimeVar4455 < 100 ) ;
    @echo var loopTimeVar4495 : Int64 = 0;
    do {
        loopTimeVar4495++;
        @echo var loopTimeVar4491 : Int64 = 0;
        while ((true) && loopTimeVar4491 < 100 ) {
            loopTimeVar4491++;
            var866 == Int8(67);
            ((UInt8(39)&127)..(UInt8(215)&127):(84|1))
        };
        Option<Int64>.Some(var4398)
    } while ((try { // block id: 4459
        var402;
        var4376;
        @echo let var4468 : Bool = ((Float64(Float64(Float32(76.0))) as Int8) is Option<String>);
        [false, var2562, true, var1061, var4468, var77, var77, true, var2562, false]
    } finally { // block id: 4479
        var1929
    }[7]) && loopTimeVar4495 < 100 ) 
}

@echo public func func4497(param65 : Rune) : Bool { // block id: 66
    match {
        case (Option<Bool>.Some(var77) ?? var77) => 
        var83 -= var83;
        if (var77) { var89 } else { var96 } 
        case _ => 
        var102;
        (UInt64(16), ())
    }[1];
    @echo let var122 : Unit = ();
    @echo var var131 : Float64 = (-49.0);
    @echo var var134 : Int8 = Int8(UInt8(Int8(122)));
    if (true) { // block id: 110
        if (var77) { // block id: 113
            ();
            ();
            @echo let var117 : Int8 = Int8(-31);
            var117
        } else if (false) { // block id: 120
            var122;
            @echo let var125 : Int8 = Int8(Int8(-97));
            var125
        } else { // block id: 128
            ();
            var131;
            var134
        };
        @echo var var139 : Bool = true;
        var139
    } else if (true) { // block id: 142
        @echo var var145 : Class8 = Class8();
        var145.var148
    } else { // block id: 150
        try { // block id: 152
            var155 %= ((var155) | 1);
            var131 += (-14.0);
            Int16(8) < Int16(-34)
        } finally { // block id: 164
            true
        }
    }
}



main(): Int64 {
    try {
        @echo let var31 : Rune = r't';
        @echo let var43 : Bool = true;
        @echo func func19() : Class8 { // block id: 20
            try { // block id: 22

            } finally { // block id: 23
                @echo let var36 : UInt64 = UInt64(217);
                (UInt32(227), 14.0, Float32(126.0), var31, (), (), var36, UInt16(20), 18.0)[4];
                @echo var loopTimeVar46 : Range<UInt64> = ((UInt64(Int32(-108))&127)..(UInt64(Int16(108))&127):((Int64(UInt64(92))|1)));
                for (i in loopTimeVar46 where var43) {

                }
            };
            if (func64((var172 ?? r'G'))) { var176 } else { Class8((Option<Int64>.Some(21) ?? var4614), var857) } 
        }
;
        @echo func func12(param13 : Bool, namedParam14 ! : Int8, namedParam15 ! : Float64, namedParam16 ! : Int32) : Class8 { // block id: 17
            func19()
        }
;
        func12(var2562, namedParam14 : Int8(-59), namedParam15 : var3201, namedParam16 : Int32(-30)).var4837;
        @echo var var4848 : Range<Int16> = ((Int16(-67)&127)..(Int16(33)&127):((-104)|1));
        try { // block id: 4840
            ();
            var1061 &&= true;
            var1653
        } finally { // block id: 4846
            var4848;
            ()
        };
        (-3)
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var155*var155), 64)
        crccheck.updateBuffer(UInt64(var4712*var4712), 64)
        crccheck.updateBuffer(UInt64(var4739*var4739), 64)
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
extend Class227 {
    @echo public func func248(optionalParam249 ! : (UInt64, Unit) = (UInt64(Int32(Int16(Int8(21)))), ()), optionalParam256 ! : Interface232 = Class227(), optionalParam258 ! : Interface233 = Class227(), namedParam260 ! : UInt8) : (Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit) { // block id: 261
        @echo var loopTimeVar1022 : Range<UInt64> = ((UInt64(UInt32(Int32(UInt8(175))))&127)..(UInt64(UInt64(14))&127):(((-83)|1)));
        for (i in loopTimeVar1022 where (func265(optionalParam266 : UInt16(145), namedParam268 : var713, namedParam269 : var1017) ?? !false)) {

        };
        @echo var var1072 : (Option<String>) -> Interface232 = { lambdaParameter1075 : Option<String> => Class227() };
        try { // block id: 1032
            @echo var loopTimeVar1039 : Range<UInt64> = ((UInt64(219)&127)..=(UInt64((-7))&127):((32|1)));
            for (i in loopTimeVar1039 where var77) {
                var77 &&= true
            }
        } finally { // block id: 1045
            var1079|>var1072;
            @echo var var1085 : Int64 = Int64(Int32(-4));
            ((var519&127)..(var519&127):((var1085|1)));
            @echo var var1092 : Range<Int16> = ((Int16(82)&127)..=(Int16(-7)&127):((-69)|1));
            if (var77) { // block id: 1090
                var1092;
                var402
            }
        };
        @echo var var4111 : Array<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>> = [Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some((77, ((125&127)..=((-5)&127):((18|1))), (UInt32(200), (-18.0), Float32(23.0), r'J', (), (), UInt64(111), UInt16(215), (-11.0)), ((Int16(-31)&127)..(Int16(-1)&127):(((-128)|1))), Option<String>.None, UInt32(Int8(60)), Int8(UInt8(80)), ((Int8(121)&127)..(Int8(21)&127):((112|1))), ())), Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some((Int64(UInt64(148)), ((59&127)..=(112&127):((54|1))), (UInt32(180), 124.0, Float32(33.0), r'S', (), (), UInt64(44), UInt16(53), (-122.0)), ((Int16(-73)&127)..=(Int16(78)&127):((-42)|1)), Option<String>.None, UInt32(Int8(23)), Int8(86), ((Int8(109)&127)..=(Int8(51)&127):(((-106)|1))), ())), Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None, Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some((Int64(UInt64(243)), (((-111)&127)..=((-53)&127):(((-28)|1))), (UInt32(175), (-128.0), Float32(90.0), r'u', (), (), UInt64(142), UInt16(189), (-54.0)), ((Int16(-75)&127)..(Int16(-39)&127):((101|1))), Option<String>.Some("""
WJO:1
+G5E+
"""), UInt32(Int8(-55)), Int8(UInt8(99)), ((Int8(2)&127)..=(Int8(27)&127):((-22)|1)), ())), Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None, Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None, Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(((-122), (((-33)&127)..=(32&127):((40|1))), (UInt32(54), (-122.0), Float32(112.0), r'0', (), (), UInt64(3), UInt16(238), (-32.0)), ((Int16(50)&127)..(Int16(-79)&127):((-53)|1)), Option<String>.None, UInt32(115), Int8(-34), ((Int8(71)&127)..=(Int8(-21)&127):((-27)|1)), ())), Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None, Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None, Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None];
        @echo var var4236 : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> = Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None;
        @echo var var4304 : Range<Int8> = ((Int8(-28)&127)..=(Int8(55)&127):(67|1));
        (func1101(var1203[0], (Option<Interface230>.Some(var245) ?? var245), namedParam1104 : ((((-11)&127)..(13&127):((-66)|1))|>func1222), optionalParam1105 : var4111[4]) ?? (if (var2441) { var4236 } else { Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(var4240) }  ?? ((-113), ((111&127)..((-53)&127):((-44)|1)), (UInt32(123), var851, Float32(-96.0), r'p', (), var1701, var3985, UInt16(22), var851), var4298, var1079, UInt32(43), var866, var4304, ())))
    }
;
    @echo private func func1101(param1102 : Range<Int8>, param1103 : Interface230, namedParam1104 ! : (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), optionalParam1105 ! : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> = Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None) : Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)> { // block id: 1107
        @echo var var1123 : Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>> = Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.Some(Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(((-93), ((89&127)..=(9&127):((-77)|1)), (UInt32(70), (-112.0), Float32(-118.0), r'H', (), (), UInt64(61), UInt16(79), 62.0), ((Int16(-12)&127)..=(Int16(-19)&127):(2|1)), Option<String>.Some("Di*atf}aV2"), UInt32(19), Int8(116), ((Int8(29)&127)..(Int8(107)&127):((55|1))), ())));
        @echo let var1159 : Option<UInt64> = Option<UInt64>.None;
        @echo var var1167 : Int64 = Int64(44);
        (try { // block id: 1114
            UInt16(222) - UInt16(159);
            Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.None
        } finally { // block id: 1119
            if (true) { var1123 } else { Option<Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>>.Some(optionalParam1105) } 
        } ?? match ((Option<Option<UInt64>>.Some(var1159) ?? var1159)) {
            case _ : Option<Rune> => 

                if (true) { Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(var289) } else { optionalParam1105 } 
            
            case _ => 
                optionalParam1105
            
            case _ : Range<UInt16> => 

                if (var77) { Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.Some(var289) } else { Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None } 
            
            case _ : UInt32 => 
                Option<(Int64, Range<Int64>, (UInt32, Float64, Float32, Rune, Unit, Unit, UInt64, UInt16, Float64), Range<Int16>, Option<String>, UInt32, Int8, Range<Int8>, Unit)>.None
            
            case _ => 
                if (var77) { optionalParam1105 } else { optionalParam1105 } 
            
        })
    }

}
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_arithmetic_operator_overflow
// ASSERT: scan chir_dce_unused_operator
