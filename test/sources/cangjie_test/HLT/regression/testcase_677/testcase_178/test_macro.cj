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
@echo var var19 : Int16 = Int16(UInt16(Int16(UInt16(UInt8(48)))))
@echo var var42 : Float32 = Float32(Float32(Float32(Float32(-104.0))))
@echo let var58 : Bool = (UInt32(68) is Int32)
@echo let var81 : (Rune, Option<Bool>, Int16, Int64, Float64, UInt8) = (r's', (UInt64(Int16(106)) as Bool), Int16(Int16(38)), Int64(Int32(Int32(104))), 61.0, UInt8(232))
@echo let var140 : Array<Option<Unit>> = Array<Option<Unit>>(10){ i => Option<Unit>.None }
@echo var var155 : UInt32 = UInt32(UInt8(Int8(UInt8(Int8(-91)))))
@echo public var var238 : Array<Unit> = [(), (), (), (), (), (), (), (), (), ()]
@echo let var252 : Enum228 = Enum228.defaultValue
@echo public var var296 : (UInt16, Bool, UInt32, Range<Int32>) = (UInt16(UInt8(114)), false, UInt32(UInt8(Int8(Int8(2)))), ((Int32(41)&127)..=(Int32(UInt32(113))&127):((126|1))))
@echo public var var348 : Bool = (UInt64(88) is Range<UInt16>)
@echo var var352 : Bool = false
@echo public let var377 : Range<UInt32> = ((UInt32(74)&127)..=(UInt32(31)&127):(((-40)|1)))
@echo let var384 : ?Bool = Option<Bool>.None
@echo public let var413 : ?Array<Unit> = ((UInt16(242), false, UInt32(53), ((Int32(UInt32(203))&127)..(Int32(UInt32(61))&127):((2|1)))) as Array<Unit>)
@echo public let var543 : Int64 = Int64(UInt64(114))
@echo var var680 : (UInt16, Bool, UInt32, Range<Int32>) = (UInt16(152), ([Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None] is Range<Int32>), UInt32(Int8(-43)), ((Int32(48)&127)..(Int32(-12)&127):((Int64(Int32(-28))|1))))
@echo public var var724 : UInt8 = UInt8(117)
@echo public var var762 : Unit = ()
@echo public let var917 : UInt64 = UInt64(Int32(86))
@echo public var var1020 : Int32 = Int32(UInt8(Int8(117)))
@echo public var var1029 : UInt8 = UInt8(178)
@echo var var1037 : Int8 = Int8(111)
@echo public let var1094 : Option<Enum228> = Option<Enum228>.None
@echo public let var1180 : Array<Int16> = [Int16(-48), Int16(9), Int16(-30), Int16(-68), Int16(114), Int16(-74), Int16(-99), Int16(-88), Int16(-31), Int16(79)]
@echo public let var1268 : Array<Bool> = [true, true, false, true, false, true, true, false, false, false]
@echo public var var1297 : Aggregate1293<Range<UInt32>> = Aggregate1293<Range<UInt32>>()
@echo var var1317 : Array<UInt64> = [UInt64(UInt16(Int16(Int8(28)))), UInt64(Int32(-55)), UInt64(Int8(Int8(Int8(112)))), UInt64(22), UInt64(UInt32(10)), UInt64(119), UInt64(253), UInt64(UInt64(Int16(UInt8(130)))), UInt64(21), UInt64(82)]
@echo var var1380 : ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) = ((UInt16(36), false, UInt32(205), ((Int32(Int8(-92))&127)..(Int32(UInt16(254))&127):((Int64(UInt64(204))|1)))), ((((Int16(-61)&127)..(Int16(111)&127):((-124)|1)), ((UInt16(175), false, UInt32(193), ((Int32(43)&127)..(Int32(102)&127):(((-50)|1)))), false, Option<Array<Unit>>.None, UInt64(191), Float32(-125.0)), Float32(Float32(-76.0))) is Float32), Option<Array<Unit>>.None, UInt64(UInt16(Int8(48))), Float32(-79.0))
@echo public var var1529 : Option<Range<UInt8>> = Option<Range<UInt8>>.None
@echo public var var1639 : Int64 = (-1)
@echo let var1643 : (UInt64, Range<UInt16>, Option<Option<UInt32>>, Range<Int16>, Int8, Bool) = (UInt64(82), ((UInt16(35)&127)..(UInt16(113)&127):((-21)|1)), Option<Option<UInt32>>.None, ((Int16(UInt16(208))&127)..(Int16(-74)&127):((Int64(Int16(45))|1))), Int8(UInt8(UInt8(UInt8(245)))), false)
@echo public var var1693 : Option<Option<Unit>> = Option<Option<Unit>>.None
@echo let var1709 : ??UInt32 = Option<Option<UInt32>>.None
@echo let var1782 : Int64 = Int64(UInt8(117))
@echo let var1795 : ?Bool = Option<Bool>.None
@echo var var1804 : ?Bool = ((UInt64(14), ((UInt16(149)&127)..(UInt16(247)&127):((-86)|1)), (Option<Array<Unit>>.None as Option<UInt32>), ((Int16(-109)&127)..=(Int16(Int16(37))&127):((112|1))), Int8(UInt8(15)), (UInt16(UInt8(43)) is ((Unit) -> Bool) -> (UInt64, Range<UInt16>, Option<Option<UInt32>>, Range<Int16>, Int8, Bool))) as Bool)
@echo let var1848 : Int16 = Int16(105)
@echo public let var1868 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(217)&127)..=(UInt32(199)&127):(67|1)), ((Int32(80)&127)..=(Int32(108)&127):((116|1))), """
\\O}tf
W%,@S
""", "fu~f]yV'NS", (), Int8(Int8(UInt8(14))), [(), (), (), (), (), (), (), (), (), ()], ((Int8(UInt8(UInt8(60)))&127)..(Int8(56)&127):((Int64(Int16(UInt8(112)))|1))))
@echo let var2084 : Option<Range<UInt32>> = Option<Range<UInt32>>.None
@echo let var2087 : Range<UInt64> = ((UInt64(UInt16(52))&127)..(UInt64(79)&127):((56|1)))
@echo public var var2218 : Option<Unit> = Option<Unit>.None
@echo var var2246 : Bool = true
@echo public let var2286 : Option<Unit> = Option<Unit>.None
@echo let var2468 : Array<UInt8> = [UInt8(246), UInt8(182), UInt8(23), UInt8(252), UInt8(37), UInt8(43), UInt8(80), UInt8(82), UInt8(108), UInt8(51)]
@echo public let var2526 : ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) = ((UInt16(125), (([(), (), (), (), (), (), (), (), (), ()] as Option<UInt32>) is Rune), UInt32(UInt16(84)), ((Int32(UInt32(57))&127)..=(Int32(Int8(70))&127):((Int64(UInt64(9))|1)))), false, Option<Array<Unit>>.None, UInt64(UInt8(98)), Float32(32.0))
@echo public let var2565 : Float64 = Float64(Float64(96.0))
@echo public let var2597 : UInt32 = UInt32(100)
@echo public let var2692 : Option<Int64> = Option<Int64>.None
@echo let var2749 : ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) = ((UInt16(Int8(UInt8(37))), (Aggregate1293<Range<UInt32>>() is Option<Option<Unit>>), UInt32(UInt16(202)), ((Int32(UInt16(148))&127)..=(Int32(81)&127):(((-7)|1)))), (((UInt16(41)&127)..(UInt16(62)&127):(55|1)) is Int16), (Enum228.defaultValue as Array<Unit>), UInt64(UInt8(Int8(Int8(-115)))), Float32(3.0))
@echo var var2837 : Array<Bool> = [true, false, true, true, false, true, true, false, false, true]
@echo public var var2841 : UInt64 = UInt64(181)
@echo let var2877 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32) = (((Int16(-5)&127)..=(Int16(-49)&127):((-111)|1)), ((UInt16(66), (UInt32(143) is Option<Option<Int64>>), UInt32(131), ((Int32(59)&127)..=(Int32(-64)&127):((-105)|1))), true, Option<Array<Unit>>.None, UInt64(175), Float32(Float32(-116.0))), Float32(Float32(Float32(Float32(104.0)))))
@echo public var var3048 : ((UInt16, Bool, UInt32, Range<Int32>), Array<Unit>, Bool, Range<Int8>) = ((UInt16(UInt8(Int8(-10))), true, UInt32(Int16(Int16(-109))), ((Int32(-38)&127)..(Int32(88)&127):((-106)|1))), [(), (), (), (), (), (), (), (), (), ()], false, ((Int8(90)&127)..=(Int8(-25)&127):(23|1)))
@echo let var3130 : Float32 = Float32(82.0)
@echo public var var3207 : UInt16 = UInt16(UInt16(69))
@echo public var var3232 : ?Bool = Option<Bool>.None
@echo public let var3239 : ?UInt32 = (Option<Option<Unit>>.None as UInt32)
@echo var var3286 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None
@echo public let var3323 : Int8 = Int8(Int8(UInt8(85)))
@echo let var3395 : String = "/97?oia7zE"
@echo public let var3486 : ?UInt32 = ((UInt32(Int8(-100)), Int16(UInt16(UInt8(80))), Enum228.defaultValue, ((Int32(2)&127)..=(Int32(74)&127):(68|1)), UInt64(80), Float32(-14.0), Int64(UInt8(Int8(78)))) as UInt32)
@echo let var3538 : Range<UInt16> = ((UInt16(155)&127)..=(UInt16(UInt16(UInt16(216)))&127):(((-46)|1)))
@echo let var3581 : Int8 = Int8(UInt8(142))

@echo public func func34(param35 : Option<Bool>) : Unit { // block id: 36
    Int16(85);
    @echo var loopTimeVar75 : Int64 = 0;
    do {
        loopTimeVar75++;
        (-98.0);
        ()
    } while ((match (Float32(var42)) {
        case caseVar49 =>
            param35;
            @echo let var53 : Float64 = Float64(Float32(Float32(43.0)));
            var53;
            var58

        case -97.0 | -60.0 | -46.0 =>
            ();
            31 >= 114

        case _ =>
            true

    }) && loopTimeVar75 < 100 ) ;
    @echo var loopTimeVar112 : Int64 = 0;
    while ((match (var81[1]) {
        case _ =>
            var58

    }) && loopTimeVar112 < 100 ) {
        loopTimeVar112++;
        UInt16(UInt8(110));
        @echo var var107 : Int8 = Int8(Int8(-23));
        match (Option<Bool>.Some(var58)) {
            case _ =>
                var107;
                ()

        }
    }
}


@echo public enum Enum228 {
    defaultValue
}
@echo public func func319(param320 : Int32) : Option<Bool> { // block id: 321
    @echo let var323 : ?Bool = (Option<Bool>.None as Bool);
    var323
}


@echo public func func403(param404 : Unit) : Bool { // block id: 405
    @echo var var449 : Int64 = Int64(UInt16(UInt8(102)));
    @echo var var477 : Option<Unit> = Option<Unit>.None;
    match ((var413 ?? (var296, [(), param404, (), param404, (), (), (), (), param404, ()], false, ((Int8(-21)&127)..(Int8(-128)&127):(88|1)))[1])) {
        case _ =>
            Float32(-17.0);
            var449 -= var449

        case _ : Option<Array<Unit>> =>
            var348 &&= var58;
            param404;
            ()

        case caseVar464 : UInt16 =>
            var155 >>= ((UInt32(177)) & 7);
            param404;
            param404

        case _ =>
            var413;
            [Option<Unit>.None, var477, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(())];
            var449 |= (-30)

    };
    var352
}







@echo public struct Aggregate1293<T0> {
    @echo public init() { // block id: 1295

    }
;
    @echo public let var1300 : (UInt16, Bool, UInt32, Range<Int32>) = (UInt16(115), true, UInt32(45), ((Int32(-95)&127)..=(Int32(109)&127):(41|1)))
}


@echo public func func1507(namedParam968 ! : Option<Range<UInt32>>) : ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) { // block id: 969
    @echo let var981 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(Int8(UInt8(106)))&127)..(UInt32(93)&127):((Int64(UInt16(Int16(-2)))|1))), ((Int32(61)&127)..(Int32(29)&127):(87|1)), ###"|awR8_R)7`"###, ")O;V_ocb!f", (), Int8(UInt8(UInt8(41))), [(), (), (), (), (), (), (), (), (), ()], ((Int8(112)&127)..=(Int8(-122)&127):((Int64(UInt32(73))|1))));
    @echo let var1054 : Range<Int8> = ((Int8(Int8(Int8(UInt8(50))))&127)..=(Int8(Int8(Int8(Int8(-96))))&127):((Int64(UInt64(UInt8(UInt8(186))))|1)));
    @echo var var1071 : Range<UInt16> = ((UInt16(145)&127)..(UInt16(107)&127):(124|1));
    try { // block id: 971
        @echo var loopTimeVar978 : Int64 = 0;
        do {
            loopTimeVar978++;
            UInt16(15);
            var724
        } while ((true) && loopTimeVar978 < 100 ) ;
        var981[4]
    } finally { // block id: 1005
        try { // block id: 1007
            @echo var var1010 : Int32 = Int32(Int16(1));
            var1010--;
            @echo var var1014 : Unit = ();
            var1014;
            var762
        } finally { // block id: 1017

        };
        @echo var var1033 : Unit = ();
        match (var1020) {
            case 108 | -1 | -6 =>
                var1029 *= var1029;
                var1033;
                var1037 /= ((var1037) | 1)

            case caseVar1042 : Range<Int32> =>
                ()

            case _ =>
                if (true) { ((Int8(-26)&127)..(Int8(103)&127):((var543|1))) } else { var1054 } ;
                if (var58) { var1071 } else { ((UInt16(8)&127)..=(UInt16(23)&127):((-42)|1)) } ;
                @echo var var1076 : UInt64 = UInt64(Int32(78));
                var1076 /= ((var1076) | 1)

        }
    };
    @echo let var1104 : Float64 = (-62.0);
    @echo var var1107 : Range<UInt8> = ((UInt8(148)&127)..(UInt8(148)&127):((-107)|1));
    @echo let var1124 : (Int64, Range<Int32>, Int64, Unit, Option<Enum228>, Range<UInt64>, Rune) = (26, ((Int32(Int32(73))&127)..(Int32(-52)&127):((Int64(UInt32(UInt16(113)))|1))), (-91), (), Option<Enum228>.None, ((UInt64(Int8(-9))&127)..=(UInt64(Int8(40))&127):((Int64(UInt64(UInt8(176)))|1))), r'8');
    match (match (Option<Option<UInt32>>.None) {
            case caseVar1087 =>
                if (false) { Option<Enum228>.Some(Enum228.defaultValue) } else { var1094 } ;
                ((var724&127)..=(UInt8(194)&127):((2|1)))

            case _ =>
                var1104;
                var1107

            case _ =>
                ();
                ();
                ((var1029&127)..=(UInt8(10)&127):((var543|1)))

        }) {
        case _ =>
            (((-108)&127)..=((-103)&127):((-9)|1));
            if (var348) { var1124 } else { var1124 }

        case _ =>
            Int32(99.0) % ((Int32(Float32(24.0))) | 1);
            var1124

    }[4];
    @echo func func1185(namedParam1186 ! : (UInt32, Int16, Enum228, Range<Int32>, UInt64, Float32, Int64), optionalParam1187 ! : Range<UInt16> = ((UInt16(94)&127)..=(UInt16(195)&127):(118|1)), namedParam1189 ! : Range<UInt16>) : Range<Int32> { // block id: 1190
        var19;
        ((Int32(85)&127)..=(Int32(-111)&127):(125|1))
    }
;
    @echo func func1156(optionalParam1157 ! : Int16 = Int16(UInt8(149)), namedParam1160 ! : Option<Unit>, optionalParam1161 ! : (Option<Bool>) -> Unit = { lambdaParameter1164 : Option<Bool> =>  }, optionalParam1168 ! : Int64 = (-48)) : Bool { // block id: 1170
        @echo var var1194 : (UInt32, Int16, Enum228, Range<Int32>, UInt64, Float32, Int64) = (UInt32(235), Int16(-61), Enum228.defaultValue, ((Int32(-113)&127)..=(Int32(98)&127):((-63)|1)), UInt64(121), Float32(-80.0), (-59));
        (UInt32(249) >> ((UInt32(163)) & 7), var1180[2], Enum228.defaultValue, func1185(namedParam1186 : var1194, namedParam1189 : ((UInt16(177)&127)..(UInt16(47)&127):((-6)|1))), [UInt64(214), UInt64(235), UInt64(19), UInt64(226), UInt64(68), UInt64(89), UInt64(124), UInt64(186), UInt64(37), UInt64(244)][7], var42 * var42, try { // block id: 1213
            var384;
            115 + optionalParam1168
        } finally { // block id: 1218
            ();
            var1037 <<= ((Int8(-22)) & 7);
            70
        })[2];
        @echo var var1235 : ?Float64 = (Int8(UInt8(Int8(UInt8(0)))) as Float64);
        @echo let var1256 : Float32 = Float32(Float32(Float32(24.0)));
        match (match (var42) {
                case caseVar1232 : Range<UInt32> =>
                    var1235

                case 64.0 =>
                    Option<Float64>.None

                case _ =>
                    var58;
                    Option<Float64>.Some(14.0)

            }) {
            case caseVar1252 : Enum228 =>
                Int32(var1256) % ((Int32(Float32(123.0))) | 1);
                if (var348) { [false, false, false, false, false, true, true, true, false, false] } else { [true, true, true, false, false, false, false, true, false, true] }

            case _ =>
                var1268

        }[7]
    }
;
    @echo let var1274 : Option<Unit> = Option<Unit>.None;
    @echo var var1289 : (Option<Bool>) -> Unit = func34;
    @echo var var1308 : UInt16 = UInt16(156);
    @echo var var1312 : ?Array<Unit> = (Aggregate1293<Range<UInt32>>() as Array<Unit>);
    @echo let var1348 : Option<Float32> = Option<Float32>.Some(Float32(Float32(Float32(72.0))));
    @echo var var1371 : Range<Int32> = ((Int32(21)&127)..=(Int32(-95)&127):(62|1));
    if (func1156(namedParam1160 : [var1274, var1274, var1274, Option<Unit>.None, Option<Unit>.Some(var762), var1274, var1274, Option<Unit>.Some(()), var1274, var1274][3], optionalParam1161 : var1289)) { (var1297.var1300, var1308 <= UInt16(115), var1312, var1317[6], (var1348 ?? Float32(-97.0))) } else { if (if (var352) { // block id: 1357
        true
    } else { // block id: 1359
        var140;
        var1037 <= Int8(-82)
    }) { // block id: 1364
        ((UInt16(17), var352, UInt32(160), var1371), true, var1312, UInt64(48), var42)
    } else { // block id: 1377
        var762;
        var1380
    } }
}


@echo func func921(namedParam922 ! : Option<Bool>, namedParam923 ! : Range<UInt64>, optionalParam924 ! : Int32 = Int32(86)) : Option<Array<Unit>> { // block id: 926
    @echo let var934 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32) = (((Int16(-80)&127)..(Int16(UInt16(96))&127):((Int64(Int8(-112))|1))), ((UInt16(45), (Enum228.defaultValue is (Int32) -> Option<Bool>), UInt32(UInt16(164)), ((Int32(-32)&127)..(Int32(-87)&127):((97|1)))), (((UInt16(155)&127)..(UInt16(92)&127):(((-120)|1))) is UInt64), (UInt16(Int8(66)) as Array<Unit>), UInt64(27), Float32(37.0)), Float32(Float32(68.0)));
    if (var352) { var934[1] } else { func1507(namedParam968 : Option<Range<UInt32>>.None) } [2];
    @echo let var1422 : (Unit) -> Bool = func403;
    @echo var loopTimeVar1439 : Int64 = 0;
    while ((if ((var762|>var1422)) { // block id: 1425
        var762;
        Option<Option<UInt32>>.Some(Option<UInt32>.Some(UInt32(219)));
        var348
    } else { // block id: 1431
        var352
    }) && loopTimeVar1439 < 100 ) {
        loopTimeVar1439++;
        func34(Option<Bool>.None);
        UInt8(Int8(-110))
    };
    @echo var var1449 : UInt16 = UInt16(44);
    @echo let var1455 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None;
    @echo let var1459 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(178)&127)..=(UInt32(158)&127):(35|1)), ((Int32(-124)&127)..=(Int32(-66)&127):(101|1)), "#sDb3~C+(=", "&ZX12g=fSd", (), Int8(Int8(-46)), [(), (), (), (), (), (), (), (), (), ()], ((Int8(Int8(Int8(-22)))&127)..=(Int8(Int8(44))&127):((Int64(Int64(Int32(-15)))|1))));
    @echo var var1499 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None;
    ((var1449, 7, ((UInt64(222)&127)..(UInt64(183)&127):(56|1)), Int16(99), var1455, var1317, var1459)[4] ?? try { // block id: 1480
        Option<Array<Unit>>.Some([(), (), var762, var762, var762, var762, var762, (), (), ()])
    } finally { // block id: 1493
        Float32(-101.0);
        if (var58) { Option<Option<Array<Unit>>>.None } else { var1499 } ;
        if (false) { Option<Array<Unit>>.None } else { Option<Array<Unit>>.None }
    })
}


@echo func func1609<T0, T1>(param1610 : (Unit) -> Bool) : (UInt64, Range<UInt16>, Option<Option<UInt32>>, Range<Int16>, Int8, Bool) { // block id: 1613
    @echo let var1630 : UInt8 = UInt8(Int8(Int8(-113)));
    match (try { // block id: 1616
            ();
            var1094
        } finally { // block id: 1619
            Option<Enum228>.None
        }) {
        case _ =>
            @echo var var1626 : UInt16 = UInt16(171);
            var1626 -= UInt16(251);
            var1630;
            var762

        case _ =>
            var1639 /= ((var1639) | 1)

    };
    var1643
}

@echo func func1678(param404 : Unit) : Bool { // block id: 405
    @echo var var449 : Int64 = Int64(UInt16(UInt8(102)));
    @echo var var477 : Option<Unit> = Option<Unit>.None;
    match ((var413 ?? (var296, [(), param404, (), param404, (), (), (), (), param404, ()], false, ((Int8(-21)&127)..(Int8(-128)&127):(88|1)))[1])) {
        case _ =>
            Float32(-17.0);
            var449 -= var449

        case _ : Option<Array<Unit>> =>
            var348 &&= var58;
            param404;
            ()

        case caseVar464 : UInt16 =>
            var155 >>= ((UInt32(177)) & 7);
            param404;
            param404

        case _ =>
            var413;
            [Option<Unit>.None, var477, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(())];
            var449 |= (-30)

    };
    var352
}

@echo func func1532(param1533 : (Option<Range<UInt32>>) -> ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32)) : Option<Option<UInt32>> { // block id: 1536
    @echo var var1660 : ((Unit) -> Bool) -> (UInt64, Range<UInt16>, Option<Option<UInt32>>, Range<Int16>, Int8, Bool) = { lambdaParameter1663 : (Unit) -> Bool => (UInt64(55), ((UInt16(27)&127)..=(UInt16(66)&127):(102|1)), ((UInt16(227), false, UInt32(72), ((Int32(40)&127)..(Int32(15)&127):(60|1))) as Option<UInt32>), ((Int16(-6)&127)..(Int16(-123)&127):((-21)|1)), Int8(-73), (Option<Enum228>.None is (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>))) };
    @echo let var1681 : (Unit) -> Bool = func1678;
    @echo let var1713 : ?UInt32 = ((((Int16(18)&127)..=(Int16(-1)&127):((-29)|1)), ((UInt16(133), false, UInt32(210), ((Int32(-108)&127)..=(Int32(1)&127):((-43)|1))), false, Option<Array<Unit>>.Some([(), (), (), (), (), (), (), (), (), ()]), UInt64(154), Float32(Float32(115.0))), Float32(-69.0)) as UInt32);
    if ((match (((var1020&127)..=(var1020&127):((var543|1)))) {
        case _ =>
            @echo let var1549 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32) = (((Int16(-100)&127)..=(Int16(UInt8(UInt8(156)))&127):((Int64(UInt16(UInt16(223)))|1))), ((UInt16(33), (Option<Enum228>.None is (Int64, Range<Int32>, Int64, Unit, Option<Enum228>, Range<UInt64>, Rune)), UInt32(82), ((Int32(-103)&127)..(Int32(66)&127):((14|1)))), ((((Int16(76)&127)..=(Int16(-64)&127):((-31)|1)), ((UInt16(0), true, UInt32(177), ((Int32(-75)&127)..=(Int32(-38)&127):((-60)|1))), true, Option<Array<Unit>>.Some([(), (), (), (), (), (), (), (), (), ()]), UInt64(153), Float32(-103.0)), Float32(82.0)) is Enum228), (Int64(Int16(-16)) as Array<Unit>), UInt64(141), Float32(-14.0)), Float32(Float32(94.0)));
            if (var352) { var1549 } else { var1549 } ;
            Float32(112.0) + Float32(47.0)

    } == var42)) { (var1681|>var1660)[2] } else { match (Option<Array<Unit>>.None) {
        case caseVar1688 : Option<Float32> =>
            if (true) { var1693 } else { var1693 } ;
            @echo var var1697 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.Some(Option<Array<Unit>>.None);
            var1697;
            @echo var var1701 : ??UInt32 = Option<Option<UInt32>>.None;
            var1701

        case _ : Option<Option<Array<Unit>>> =>
            if (var352) { var1709 } else { Option<Option<UInt32>>.Some(var1713) }

        case caseVar1742 : Option<UInt32> =>
            if (var352) { var1709 } else { Option<Option<UInt32>>.None }

        case _ =>
            var1380;
            @echo var var1754 : Float64 = Float64(Float32(71.0));
            Option<Float64>.Some(var1754);
            Option<Option<UInt32>>.None

        case _ =>
            ();
            @echo var var1762 : ??UInt32 = Option<Option<UInt32>>.Some(Option<UInt32>.None);
            var1762

    } }
}

@echo func func1766(namedParam968 : Option<Range<UInt32>>) : ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) { // block id: 969
    @echo let var981 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(Int8(UInt8(106)))&127)..(UInt32(93)&127):((Int64(UInt16(Int16(-2)))|1))), ((Int32(61)&127)..(Int32(29)&127):(87|1)), ###"|awR8_R)7`"###, ")O;V_ocb!f", (), Int8(UInt8(UInt8(41))), [(), (), (), (), (), (), (), (), (), ()], ((Int8(112)&127)..=(Int8(-122)&127):((Int64(UInt32(73))|1))));
    @echo let var1054 : Range<Int8> = ((Int8(Int8(Int8(UInt8(50))))&127)..=(Int8(Int8(Int8(Int8(-96))))&127):((Int64(UInt64(UInt8(UInt8(186))))|1)));
    @echo var var1071 : Range<UInt16> = ((UInt16(145)&127)..(UInt16(107)&127):(124|1));
    try { // block id: 971
        @echo var loopTimeVar978 : Int64 = 0;
        do {
            loopTimeVar978++;
            UInt16(15);
            var724
        } while ((true) && loopTimeVar978 < 100 ) ;
        var981[4]
    } finally { // block id: 1005
        try { // block id: 1007
            @echo var var1010 : Int32 = Int32(Int16(1));
            var1010--;
            @echo var var1014 : Unit = ();
            var1014;
            var762
        } finally { // block id: 1017

        };
        @echo var var1033 : Unit = ();
        match (var1020) {
            case 108 | -1 | -6 =>
                var1029 *= var1029;
                var1033;
                var1037 /= ((var1037) | 1)

            case caseVar1042 : Range<Int32> =>
                ()

            case _ =>
                if (true) { ((Int8(-26)&127)..(Int8(103)&127):((var543|1))) } else { var1054 } ;
                if (var58) { var1071 } else { ((UInt16(8)&127)..=(UInt16(23)&127):((-42)|1)) } ;
                @echo var var1076 : UInt64 = UInt64(Int32(78));
                var1076 /= ((var1076) | 1)

        }
    };
    @echo let var1104 : Float64 = (-62.0);
    @echo var var1107 : Range<UInt8> = ((UInt8(148)&127)..(UInt8(148)&127):((-107)|1));
    @echo let var1124 : (Int64, Range<Int32>, Int64, Unit, Option<Enum228>, Range<UInt64>, Rune) = (26, ((Int32(Int32(73))&127)..(Int32(-52)&127):((Int64(UInt32(UInt16(113)))|1))), (-91), (), Option<Enum228>.None, ((UInt64(Int8(-9))&127)..=(UInt64(Int8(40))&127):((Int64(UInt64(UInt8(176)))|1))), r'8');
    match (match (Option<Option<UInt32>>.None) {
            case caseVar1087 =>
                if (false) { Option<Enum228>.Some(Enum228.defaultValue) } else { var1094 } ;
                ((var724&127)..=(UInt8(194)&127):((2|1)))

            case _ =>
                var1104;
                var1107

            case _ =>
                ();
                ();
                ((var1029&127)..=(UInt8(10)&127):((var543|1)))

        }) {
        case _ =>
            (((-108)&127)..=((-103)&127):((-9)|1));
            if (var348) { var1124 } else { var1124 }

        case _ =>
            Int32(99.0) % ((Int32(Float32(24.0))) | 1);
            var1124

    }[4];
    @echo func func1185(namedParam1186 ! : (UInt32, Int16, Enum228, Range<Int32>, UInt64, Float32, Int64), optionalParam1187 ! : Range<UInt16> = ((UInt16(94)&127)..=(UInt16(195)&127):(118|1)), namedParam1189 ! : Range<UInt16>) : Range<Int32> { // block id: 1190
        var19;
        ((Int32(85)&127)..=(Int32(-111)&127):(125|1))
    }
;
    @echo func func1156(optionalParam1157 ! : Int16 = Int16(UInt8(149)), namedParam1160 ! : Option<Unit>, optionalParam1161 ! : (Option<Bool>) -> Unit = { lambdaParameter1164 : Option<Bool> =>  }, optionalParam1168 ! : Int64 = (-48)) : Bool { // block id: 1170
        @echo var var1194 : (UInt32, Int16, Enum228, Range<Int32>, UInt64, Float32, Int64) = (UInt32(235), Int16(-61), Enum228.defaultValue, ((Int32(-113)&127)..=(Int32(98)&127):((-63)|1)), UInt64(121), Float32(-80.0), (-59));
        (UInt32(249) >> ((UInt32(163)) & 7), var1180[2], Enum228.defaultValue, func1185(namedParam1186 : var1194, namedParam1189 : ((UInt16(177)&127)..(UInt16(47)&127):((-6)|1))), [UInt64(214), UInt64(235), UInt64(19), UInt64(226), UInt64(68), UInt64(89), UInt64(124), UInt64(186), UInt64(37), UInt64(244)][7], var42 * var42, try { // block id: 1213
            var384;
            115 + optionalParam1168
        } finally { // block id: 1218
            ();
            var1037 <<= ((Int8(-22)) & 7);
            70
        })[2];
        @echo var var1235 : ?Float64 = (Int8(UInt8(Int8(UInt8(0)))) as Float64);
        @echo let var1256 : Float32 = Float32(Float32(Float32(24.0)));
        match (match (var42) {
                case caseVar1232 : Range<UInt32> =>
                    var1235

                case 64.0 =>
                    Option<Float64>.None

                case _ =>
                    var58;
                    Option<Float64>.Some(14.0)

            }) {
            case caseVar1252 : Enum228 =>
                Int32(var1256) % ((Int32(Float32(123.0))) | 1);
                if (var348) { [false, false, false, false, false, true, true, true, false, false] } else { [true, true, true, false, false, false, false, true, false, true] }

            case _ =>
                var1268

        }[7]
    }
;
    @echo let var1274 : Option<Unit> = Option<Unit>.None;
    @echo var var1289 : (Option<Bool>) -> Unit = func34;
    @echo var var1308 : UInt16 = UInt16(156);
    @echo var var1312 : ?Array<Unit> = (Aggregate1293<Range<UInt32>>() as Array<Unit>);
    @echo let var1348 : Option<Float32> = Option<Float32>.Some(Float32(Float32(Float32(72.0))));
    @echo var var1371 : Range<Int32> = ((Int32(21)&127)..=(Int32(-95)&127):(62|1));
    if (func1156(namedParam1160 : [var1274, var1274, var1274, Option<Unit>.None, Option<Unit>.Some(var762), var1274, var1274, Option<Unit>.Some(()), var1274, var1274][3], optionalParam1161 : var1289)) { (var1297.var1300, var1308 <= UInt16(115), var1312, var1317[6], (var1348 ?? Float32(-97.0))) } else { if (if (var352) { // block id: 1357
        true
    } else { // block id: 1359
        var140;
        var1037 <= Int8(-82)
    }) { // block id: 1364
        ((UInt16(17), var352, UInt32(160), var1371), true, var1312, UInt64(48), var42)
    } else { // block id: 1377
        var762;
        var1380
    } }
}


@echo public func func1905(param1906 : (Int32) -> Option<Bool>) : Int64 { // block id: 1909
    ();
    @echo var var1919 : Array<Option<Int64>> = [(Option<Option<Unit>>.None as Int64), (Option<Float32>.Some(Float32(-107.0)) as Int64), ((Option<Range<UInt32>>.Some(((UInt32(102)&127)..(UInt32(2)&127):(((-70)|1)))), ((UInt64(30)&127)..(UInt64(207)&127):((-105)|1)), ((Int32(32)&127)..(Int32(-19)&127):((-61)|1)), UInt32(36)) as Int64), (Option<Option<Unit>>.Some(Option<Unit>.None) as Int64), Option<Int64>.Some(95), Option<Int64>.Some(Int64((-104))), Option<Int64>.None, Option<Int64>.None, Option<Int64>.Some((-25)), ((Option<Range<UInt32>>.None, ((UInt64(230)&127)..=(UInt64(147)&127):((72|1))), ((Int32(-127)&127)..(Int32(119)&127):(28|1)), UInt32(16)) as Int64)];
    (var1919[5] ?? var1782)
}


@echo func func1960<T0, T1>(param1961 : (Option<Bool>, Range<UInt64>, Int32) -> Option<Array<Unit>>) : Int64 { // block id: 1966
    var762;
    @echo let var1983 : (UInt64, Range<UInt16>, Option<Option<UInt32>>, Range<Int16>, Int8, Bool) = (UInt64(107), ((UInt16(249)&127)..=(UInt16(87)&127):((-31)|1)), (Aggregate1293<Range<UInt32>>() as Option<UInt32>), ((Int16(-84)&127)..(Int16(96)&127):(87|1)), Int8(UInt8(Int8(Int8(28)))), true);
    try { // block id: 1969
        var238[4];
        try { // block id: 1974
            Enum228.defaultValue;
            var724
        } finally { // block id: 1977
            ();
            var1029
        }
    } catch (e: Exception) { // block id: 1980
        @echo let var2000 : String = """
m](I-
lDS+L
""";
        match (var1983) {
            case _ =>
                if (false) { var2000 } else { ###"VHwO#(hA-s"### } ;
                var296;
                var19 &= var1848

        };
        @echo var var2010 : Array<UInt8> = Array<UInt8>(10){ i => UInt8(UInt8(30)) };
        var2010[9]
    };
    @echo let var2041 : ?Array<Int64> = Option<Array<Int64>>.None;
    (var2041 ?? [82, 15, 35, 123, (-44), (-51), (-77), 13, 38, (-87)])[7]
}

@echo func func2048(namedParam922 : Option<Bool>, namedParam923 : Range<UInt64>, optionalParam924 : Int32) : Option<Array<Unit>> { // block id: 926
    @echo let var934 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32) = (((Int16(-80)&127)..(Int16(UInt16(96))&127):((Int64(Int8(-112))|1))), ((UInt16(45), (Enum228.defaultValue is (Int32) -> Option<Bool>), UInt32(UInt16(164)), ((Int32(-32)&127)..(Int32(-87)&127):((97|1)))), (((UInt16(155)&127)..(UInt16(92)&127):(((-120)|1))) is UInt64), (UInt16(Int8(66)) as Array<Unit>), UInt64(27), Float32(37.0)), Float32(Float32(68.0)));
    if (var352) { var934[1] } else { func1507(namedParam968 : Option<Range<UInt32>>.None) } [2];
    @echo let var1422 : (Unit) -> Bool = func403;
    @echo var loopTimeVar1439 : Int64 = 0;
    while ((if ((var762|>var1422)) { // block id: 1425
        var762;
        Option<Option<UInt32>>.Some(Option<UInt32>.Some(UInt32(219)));
        var348
    } else { // block id: 1431
        var352
    }) && loopTimeVar1439 < 100 ) {
        loopTimeVar1439++;
        func34(Option<Bool>.None);
        UInt8(Int8(-110))
    };
    @echo var var1449 : UInt16 = UInt16(44);
    @echo let var1455 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None;
    @echo let var1459 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(178)&127)..=(UInt32(158)&127):(35|1)), ((Int32(-124)&127)..=(Int32(-66)&127):(101|1)), "#sDb3~C+(=", "&ZX12g=fSd", (), Int8(Int8(-46)), [(), (), (), (), (), (), (), (), (), ()], ((Int8(Int8(Int8(-22)))&127)..=(Int8(Int8(44))&127):((Int64(Int64(Int32(-15)))|1))));
    @echo var var1499 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None;
    ((var1449, 7, ((UInt64(222)&127)..(UInt64(183)&127):(56|1)), Int16(99), var1455, var1317, var1459)[4] ?? try { // block id: 1480
        Option<Array<Unit>>.Some([(), (), var762, var762, var762, var762, var762, (), (), ()])
    } finally { // block id: 1493
        Float32(-101.0);
        if (var58) { Option<Option<Array<Unit>>>.None } else { var1499 } ;
        if (false) { Option<Array<Unit>>.None } else { Option<Array<Unit>>.None }
    })
}


@echo func func2052(param2053 : (Int32) -> Option<Bool>) : (Option<Bool>, Range<UInt64>, Int32) -> Option<Array<Unit>> { // block id: 2056
    @echo let var2066 : ?Option<Range<UInt32>> = (Option<Enum228>.Some(Enum228.defaultValue) as Option<Range<UInt32>>);
    (if (false) { (var2066 ?? Option<Range<UInt32>>.None) } else { try { // block id: 2072
        var352 &&= false;
        var762;
        Option<Range<UInt32>>.None
    } finally { // block id: 2078
        if (false) { Option<Range<UInt32>>.Some(((UInt32(18)&127)..=(UInt32(117)&127):(95|1))) } else { var2084 }
    } } , var2087, if (var58) { ((Int32(37)&127)..(Int32(-5)&127):((74|1))) } else { ((Int32(-11)&127)..=(Int32(43)&127):(93|1)) } , UInt32(205));
    @echo let var2102 : (Option<Bool>, Range<UInt64>, Int32) -> Option<Array<Unit>> = func2048;
    var2102
}

@echo func func2107(param320 : Int32) : Option<Bool> { // block id: 321
    @echo let var323 : ?Bool = (Option<Bool>.None as Bool);
    var323
}

@echo func func1835(param1836 : (Option<Bool>) -> Unit) : Range<UInt64> { // block id: 1839
    @echo var var2046 : ((Option<Bool>, Range<UInt64>, Int32) -> Option<Array<Unit>>) -> Int64 = func1960<Bool, Option<Option<Range<UInt32>>>>;
    @echo let var2105 : ((Int32) -> Option<Bool>) -> (Option<Bool>, Range<UInt64>, Int32) -> Option<Array<Unit>> = func2052;
    @echo var var2110 : (Int32) -> Option<Bool> = func2107;
    ((-(UInt64(219) % ((var917) | 1))&127)..=(if (var1848 != Int16(-99)) { // block id: 1851
        ();
        if (var58) { var1380 } else { var1380 } ;
        var917
    } else if (func403(())) { // block id: 1860
        UInt64(95) & UInt64(33)
    } else { // block id: 1864
        if (true) { var1868 } else { var1868 } ;
        UInt64(223) - UInt64(30)
    }&127):((var2110|>(var2105~>var2046))|1))
}

@echo public func func2113(param35 : Option<Bool>) : Unit { // block id: 36
    Int16(85);
    @echo var loopTimeVar75 : Int64 = 0;
    do {
        loopTimeVar75++;
        (-98.0);
        ()
    } while ((match (Float32(var42)) {
        case caseVar49 =>
            param35;
            @echo let var53 : Float64 = Float64(Float32(Float32(43.0)));
            var53;
            var58

        case -97.0 | -60.0 | -46.0 =>
            ();
            31 >= 114

        case _ =>
            true

    }) && loopTimeVar75 < 100 ) ;
    @echo var loopTimeVar112 : Int64 = 0;
    while ((match (var81[1]) {
        case _ =>
            var58

    }) && loopTimeVar112 < 100 ) {
        loopTimeVar112++;
        UInt16(UInt8(110));
        @echo var var107 : Int8 = Int8(Int8(-23));
        match (Option<Bool>.Some(var58)) {
            case _ =>
                var107;
                ()

        }
    }
}


@echo func func1788(param1789 : (Int64, Range<Int32>, Int64, Unit, Option<Enum228>, Range<UInt64>, Rune)) : Array<Option<Unit>> { // block id: 1790
    @echo let var1831 : Range<UInt64> = ((UInt64(29)&127)..(UInt64(238)&127):((-60)|1));
    func921(namedParam922 : try { // block id: 1793
        var1795
    } catch (e: Exception) { // block id: 1797
        UInt64(46) | var917;
        if (false) { var1804 } else { Option<Bool>.None }
    } finally { // block id: 1822
        var1804
    }, namedParam923 : if ((var1804 ?? true)) { (if (true) { var1831 } else { var1831 } ) } else { (func2113|>func1835) } );
    @echo var var2118 : Option<Unit> = Option<Unit>.None;
    @echo var var2123 : (UInt16, Int64, Range<UInt64>, Int16, Option<Option<Array<Unit>>>, Array<UInt64>, (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>)) = (UInt16(185), 106, ((UInt64(235)&127)..(UInt64(221)&127):(55|1)), Int16(UInt16(UInt8(67))), Option<Option<Array<Unit>>>.Some(([(-89), 54, 28, (-16), (-128), 86, 47, 111, (-116), (-10)] as Array<Unit>)), [UInt64(UInt64(88)), UInt64(222), UInt64(251), UInt64(UInt64(Int32(99))), UInt64(94), UInt64(132), UInt64(Int16(-15)), UInt64(UInt16(Int16(-43))), UInt64(185), UInt64(Int32(-32))], (((UInt32(UInt16(8))&127)..=(UInt32(UInt32(88))&127):((Int64(Int8(-107))|1))), ((Int32(Int8(46))&127)..(Int32(108)&127):(((-119)|1))), "dLKq$eChs_", "?MC&;WAV4}", (), Int8(Int8(122)), [(), (), (), (), (), (), (), (), (), ()], ((Int8(-14)&127)..(Int8(Int8(8))&127):((Int64(UInt64(189))|1)))));
    (var2118 ?? (match (var2123) {
        case (caseVar2199 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32),_,caseVar2200,_,caseVar2201 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>),caseVar2202 : Array<UInt8>,(caseVar2203,caseVar2204,caseVar2205 : UInt16,_,caseVar2206,_ : Range<Int16>,_,caseVar2207 : (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32))) =>
            var2118

        case _ =>
            ((Int16(-87)&127)..=(Int16(8)&127):(64|1));
            Option<Unit>.None

        case _ =>
            var2218

    } ?? match (((UInt16(116)&127)..(UInt16(159)&127):((-20)|1))) {
        case _ =>
            Option<Option<Array<Unit>>>.Some(var413);
            var1037 ^= Int8(-126)

        case _ =>
            if (var58) { var2123 } else { var2123 } ;
            ()

    }));
    @echo let var2249 : Option<Array<Option<Unit>>> = Option<Array<Option<Unit>>>.Some([Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.Some(()), Option<Unit>.Some(())]);
    @echo var var2302 : Option<Unit> = Option<Unit>.Some(());
    @echo var var2311 : UInt16 = UInt16(UInt16(69));
    (Option<Array<Option<Unit>>>.None ?? (if (var2246) { var2249 } else { Option<Array<Option<Unit>>>.Some([Option<Unit>.Some(()), Option<Unit>.None, var2218, var2218, var2218, var2218, Option<Unit>.None, var2218, Option<Unit>.Some(var762), Option<Unit>.None]) }  ?? try { // block id: 2281
        ();
        var762;
        @echo var var2298 : Option<Unit> = Option<Unit>.Some(());
        [var2286, Option<Unit>.Some(var762), Option<Unit>.Some(()), var2286, Option<Unit>.Some(()), var2286, var2286, var2298, var2302, var2302]
    } catch (e: Exception) { // block id: 2306
        @echo let var2317 : Range<Int32> = ((Int32(22)&127)..=(Int32(-50)&127):((-57)|1));
        if (var58) { (var2311, false, UInt32(92), var2317) } else { (var2311, false, var155, ((Int32(-81)&127)..=(Int32(-92)&127):((23|1)))) } ;
        var140
    }))
}

@echo func func1507(param1508 : UInt8) : Option<Bool> { // block id: 1509
    @echo let var1769 : (Option<Range<UInt32>>) -> ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32) = func1766;
    @echo let var2329 : ((Int64, Range<Int32>, Int64, Unit, Option<Enum228>, Range<UInt64>, Rune)) -> Array<Option<Unit>> = func1788;
    try { // block id: 1511
        try { // block id: 1513
            var348 &&= var352;
            var762
        } catch (_) { // block id: 1518

        } finally { // block id: 1519
            ();
            var724--
        };
        var1529.getOrThrow();
        var1769|>func1532
    } catch (e: Exception) { // block id: 1771
        (Option<Range<UInt32>>.Some(((UInt32(213)&127)..(UInt32(114)&127):(77|1))), ((UInt64(49)&127)..=(UInt64(27)&127):((-35)|1)), ((Int32(122)&127)..=(var1020&127):((var1782|1))), UInt32(63))[0];
        @echo var var2346 : Rune = r't';
        (var543, ((var1020&127)..(Int32(-31)&127):((var1782|1))), var543, var762, Option<Enum228>.Some(var252), ((UInt64(180)&127)..=(UInt64(144)&127):((var543|1))), var2346)|>var2329;
        var1709
    } finally { // block id: 2349
        @echo let var2351 : Unit = ();
        var2351;
        var1709
    };
    @echo var loopTimeVar2382 : Int64 = 0;
    while (((try { // block id: 2357
        var2246 &&= true;
        if (var58) { var1804 } else { Option<Bool>.None }
    } catch (_) { // block id: 2365
        ();
        if (var348) { var1804 } else { Option<Bool>.Some(true) }
    } ?? UInt8(22) != var724)) && loopTimeVar2382 < 100 ) {
        loopTimeVar2382++;
        @echo var loopTimeVar2380 : Int64 = 0;
        do {
            loopTimeVar2380++;

        } while ((var352) && loopTimeVar2380 < 100 )
    };
    Option<Bool>.Some(if ((Option<Bool>.None ?? var352)) { // block id: 2388
        ();
        false
    } else if (match {
        case false =>
        var1029 += UInt8(125);
        var352
        case _ =>
        @echo var var2401 : Rune = r'J';
        var2401 = var2401;
        false
    }) { // block id: 2405
        true
    } else { // block id: 2407
        var762;
        var1037 + var1037;
        var58
    })
}

@echo func func2416(param2417 : Int32) : UInt8 { // block id: 2418
    var1029
}


@echo func func831(param832 : UInt8) : Option<Array<Unit>> { // block id: 833
    @echo let var850 : Float64 = 16.0;
    @echo var var857 : UInt16 = UInt16(Int16(UInt8(Int8(UInt8(48)))));
    match (((var19 as Float64) ?? match (UInt8(138)) {
            case _ =>
                Int8(86);
                -var850

            case 249 | 225 | 45 | 12 =>
                var857--;
                (-26.0) - var850

            case 197 | 81 =>
                var850

            case 251 | 5 | 57 =>
                68 << (((-112)) & 7);
                (-116.0)

            case _ =>
                (r'1', var384, Int16(56), var543, 43.0, UInt8(130));
                var850

        })) {
        case _ =>
            ()

    };
    @echo var var899 : ?UInt32 = (Int16(28) as UInt32);
    -match ((Option<Option<UInt32>>.None ?? var899)) {
        case caseVar904 : Int32 =>
            ();
            @echo var var909 : UInt64 = UInt64(82);
            var909 >> ((UInt64(90)) & 7)

        case _ =>
            ();
            var762;
            var917

    };
    @echo var var2414 : (UInt8) -> Option<Bool> = func1507;
    @echo let var2421 : (Int32) -> UInt8 = func2416;
    func921(namedParam922 : (if (true) { // block id: 2425
        (-91.0) / Float64((Int32(72.0)) | 1);
        var19 %= ((Int16(-64)) | 1);
        var1020
    } else if (true) { // block id: 2434
        Int32(6)
    } else { // block id: 2436
        var762;
        var680;
        var1020
    }|>(var2421~>var2414)), namedParam923 : ((var1380 as Range<UInt64>) ?? var2087))
}


@echo func func817(param818 : (Option<Bool>) -> Unit) : Option<Array<Unit>> { // block id: 821
    ();
    @echo let var828 : Bool = false;
    @echo let var2449 : (UInt8) -> Option<Array<Unit>> = func831;
    @echo var var2502 : Rune = r'F';
    try { // block id: 824
        func34(Option<Bool>.Some(var828));
        var1029|>var2449;
        (Option<Unit>.Some(var762) ?? var762)
    } catch (e: Exception) { // block id: 2460
        @echo var loopTimeVar2465 : Int64 = 0;
        do {
            loopTimeVar2465++;

        } while ((false) && loopTimeVar2465 < 100 ) ;
        match (var2468) {
            case _ =>
                var724 &= UInt8(1)

            case _ =>
                if (true) { [(), (), (), (), (), (), (), (), (), ()] } else { [(), (), (), (), (), (), (), (), (), ()] } ;
                var1037 &= Int8(-64)

            case caseVar2488 =>
                var1639 += var543;
                ();
                var1037 -= Int8(-106)

            case _ : Range<Int8> =>
                var2502 = r'O'

            case _ =>
                ()

        }
    } finally { // block id: 2508

    };
    @echo var var2519 : Bool = false;
    if ((match {
        case var58 =>
        var1639 >>= (((-43)) & 7);
        false
        case var2519 =>
        ();
        if (true) { var2526 } else { var1380 } ;
        false
        case _ =>
        var762;
        var81;
        (-119.0) <= var2565
    } || if (var2519) { // block id: 2571
        ();
        @echo let var2574 : Bool = (UInt8(86) is (Option<Bool>) -> Unit);
        var2574
    } else { // block id: 2577
        var352
    })) { Option<Array<Unit>>.None } else { match (if (var58) { var1643 } else { var1643 } ) {
        case (caseVar2587 : Option<Range<UInt32>>,caseVar2588,_,_ : Float64,_,_) =>
            125 + var1639;
            @echo var var2600 : Range<Int32> = ((Int32(-24)&127)..=(Int32(86)&127):((-75)|1));
            (UInt16(228), var352, var2597, var2600);
            Option<Array<Unit>>.Some([(), (), (), (), (), (), (), (), (), ()])

        case (caseVar2606,caseVar2607 : Option<Array<Unit>>,_,_,caseVar2608,caseVar2609 : Range<UInt64>) =>
            if (false) { caseVar2607 } else { var413 }

        case _ =>
            Option<Array<Unit>>.None

    } }
}

@echo public func func2621(param35 : Option<Bool>) : Unit { // block id: 36
    Int16(85);
    @echo var loopTimeVar75 : Int64 = 0;
    do {
        loopTimeVar75++;
        (-98.0);
        ()
    } while ((match (Float32(var42)) {
        case caseVar49 =>
            param35;
            @echo let var53 : Float64 = Float64(Float32(Float32(43.0)));
            var53;
            var58

        case -97.0 | -60.0 | -46.0 =>
            ();
            31 >= 114

        case _ =>
            true

    }) && loopTimeVar75 < 100 ) ;
    @echo var loopTimeVar112 : Int64 = 0;
    while ((match (var81[1]) {
        case _ =>
            var58

    }) && loopTimeVar112 < 100 ) {
        loopTimeVar112++;
        UInt16(UInt8(110));
        @echo var var107 : Int8 = Int8(Int8(-23));
        match (Option<Bool>.Some(var58)) {
            case _ =>
                var107;
                ()

        }
    }
}

@echo public func func398(param399 : UInt32) : Option<Unit> { // block id: 400
    @echo var loopTimeVar502 : Int64 = 0;
    @echo var loopTimeVar504 : Range<UInt64> = ((UInt64(234)&127)..(UInt64(138)&127):((Int64(UInt16(139))|1)));
    for (i in loopTimeVar504 where (do {
        loopTimeVar502++;
        var42 -= Float32(-114.0)
    } while ((true) && loopTimeVar502 < 100 ) |>func403)) {

    };
    @echo let var524 : UInt16 = UInt16(163);
    @echo let var605 : Option<Unit> = Option<Unit>.Some(());
    @echo let var616 : Range<UInt32> = ((UInt32(141)&127)..=(UInt32(14)&127):((-91)|1));
    @echo let var765 : Bool = ([Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.None, Option<Unit>.Some(())] is Unit);
    @echo let var2639 : ?UInt32 = (UInt16(UInt8(UInt8(43))) as UInt32);
    @echo func func619(optionalParam620 ! : Int64 = 41, optionalParam622 ! : UInt16 = UInt16(124)) : UInt32 { // block id: 624
        @echo var var631 : Rune = r'v';
        @echo let var643 : (UInt16, Bool, UInt32, Range<Int32>) = (UInt16(Int16(Int16(-125))), ((r'Y', (Option<Bool>.None as Bool), Int16(-50), Int64(UInt16(110)), (-116.0), UInt8(136)) is Array<Option<Unit>>), UInt32(142), ((Int32(UInt32(10))&127)..=(Int32(-108)&127):((Int64(Int16(7))|1))));
        @echo var var670 : Range<Int32> = ((Int32(74)&127)..=(Int32(0)&127):((Int64(UInt16(Int16(-101)))|1)));
        @echo var loopTimeVar719 : Int64 = 0;
        while ((try { // block id: 628
            var631 = r'n';
            @echo var var636 : Int64 = Int64(UInt32(21));
            var636 *= 88;
            if (var352) { var643 } else { (UInt16(171), var348, UInt32(38), var670) }
        } catch (_) { // block id: 677
            UInt32(243);
            var680
        } finally { // block id: 702
            (optionalParam622, var58, UInt32(57), ((Int32(88)&127)..=(Int32(9)&127):(9|1)))
        }[1]) && loopTimeVar719 < 100 ) {
            loopTimeVar719++;
            (Option<Enum228>.Some(var252) ?? Enum228.defaultValue)
        };
        @echo var loopTimeVar804 : Range<UInt64> = ((UInt64(244)&127)..=(UInt64(UInt16(219))&127):(((-102)|1)));
        for (i in loopTimeVar804 where match (-var724) {
            case caseVar728 : Option<Array<Unit>> =>
                @echo let var731 : Range<Int8> = ((Int8(-42)&127)..(Int8(-83)&127):(74|1));
                var731;
                ((var724&127)..=(var724&127):(((-16)|1)));
                false

            case _ =>
                var155 ^= UInt32(199);
                var58

            case 55 | 132 | 175 | 230 =>
                true

            case _ =>
                Int16(22) != var19

        }) {
            @echo var var785 : Float64 = Float64((-23.0));
            if (var58) { // block id: 757
                var42 *= Float32(-28.0);
                var762
            } else if (var765) { // block id: 782
                UInt32(56);
                var785;
                ()
            };
            @echo var var792 : (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>) = (((UInt32(99)&127)..(UInt32(67)&127):((-60)|1)), ((Int32(80)&127)..(Int32(-101)&127):((-62)|1)), ###"y^7-a{'R(E,"###, ###"2GX!u.jlOM"###, (), Int8(UInt8(68)), [(), (), (), (), (), (), (), (), (), ()], ((Int8(14)&127)..(Int8(101)&127):(85|1)));
            var792[4]
        };
        @echo var var2619 : ((Option<Bool>) -> Unit) -> Option<Array<Unit>> = func817;
        (match ((func2621|>var2619)) {
            case caseVar2626 : Option<Float64> =>
                var762;
                ();
                Option<UInt32>.Some(var2597)

            case caseVar2634 : Float64 =>
                @echo let var2645 : ?UInt32 = (Option<Option<Unit>>.Some(Option<Unit>.None) as UInt32);
                if (var765) { var2639 } else { var2645 }

            case caseVar2651 =>
                @echo var var2656 : ?UInt32 = Option<UInt32>.Some(UInt32(UInt32(147)));
                if (false) { var2656 } else { var2656 }

            case caseVar2663 : UInt32 =>
                var2639

            case _ =>
                var631;
                Option<UInt32>.Some(var155)

        } ?? match (UInt64(95)) {
            case _ =>
                Int32(-51);
                var155 + UInt32(198)

        })
    }
;
    try { // block id: 511
        @echo let var586 : UInt64 = UInt64(137);
        @echo func func513(param514 : Enum228, optionalParam515 ! : Enum228 = Enum228.defaultValue, namedParam517 ! : Rune) : Range<UInt32> { // block id: 518
            @echo var var528 : Float64 = Float64(Float32(Float32(69.0)));
            @echo var var559 : Int8 = Int8(UInt8(184));
            match (Option<Bool>.Some(try { // block id: 522
                    var524;
                    var528 < 104.0
                } finally { // block id: 533
                    true
                })) {
                case caseVar537 =>
                    ((var155&127)..=(UInt32(68)&127):((var543|1)))

                case caseVar548 =>
                    ();
                    ((UInt64(154)&127)..=(UInt64(254)&127):(112|1));
                    ((UInt32(93)&127)..=(UInt32(8)&127):(34|1))

                case caseVar555 : Range<UInt16> =>
                    var559 &= var559;
                    ((Int32(-71)&127)..(Int32(81)&127):((-21)|1));
                    ((UInt32(40)&127)..=(UInt32(93)&127):(91|1))

                case _ : Option<Unit> =>
                    @echo var var573 : Range<Int32> = ((Int32(113)&127)..=(Int32(116)&127):(98|1));
                    (UInt16(43), var352, UInt32(107), var573);

                    ((UInt32(88)&127)..=(param399&127):((var543|1)))

                case _ =>
                    var586 << ((UInt64(131)) & 7);
                    ();
                    var377

            }
        }
;
        @echo let var592 : Enum228 = Enum228.defaultValue;
        func513(var592, optionalParam515 : var252, namedParam517 : r'Q');
        Option<Option<Unit>>.Some(Option<Unit>.None).getOrThrow()
    } catch (_) { // block id: 603
        var605
    } finally { // block id: 608
        (Option<Range<UInt32>>.None ?? var616);
        func619(optionalParam622 : var524);
        if (false) { var2218 } else { Option<Unit>.Some(()) }
    }
}


@echo public func func394(param395 : Range<UInt8>) : Int64 { // block id: 396
    @echo let var2697 : Option<Int64> = Option<Int64>.Some(Int64(Int8(Int8(101))));
    func398(match ([Option<Int64>.Some(var1782), Option<Int64>.Some((-93)), var2692, Option<Int64>.Some(var1639), var2697, Option<Int64>.Some(97), Option<Int64>.Some((-79)), var2697, var2697, var2697]) {
        case caseVar2711 : UInt32 =>
            108 ** UInt64(109 & 3);
            (((Int16(3)&127)..=(Int16(-1)&127):((-74)|1)), var1380, var42);
            var2597

        case _ =>
            var2246 &&= var58;
            UInt32(63)

        case caseVar2730 =>
            var1643;
            var155

        case caseVar2736 =>
            var155 / ((var2597) | 1)

        case _ =>
            (((Int16(88)&127)..=(Int16(45)&127):((var543|1))), var2749, var42);
            @echo let var2775 : Unit = ();
            var2775;
            var2597

    });
    if (var19 == Int16(126)) { // block id: 2783
        var1848
    } else { // block id: 2785
        var19++;
        var762;
        Int16(71)
    } ^ Int16(-109);
    (if ((Option<Option<Range<UInt32>>>.Some(Option<Range<UInt32>>.None) is (Range<Int16>, ((UInt16, Bool, UInt32, Range<Int32>), Bool, Option<Array<Unit>>, UInt64, Float32), Float32))) { (param395 as Int64) } else { (Option<Option<Int64>>.Some(Option<Int64>.Some(var1639)) ?? Option<Int64>.None) }  ?? try { // block id: 2808
        Int16(44);
        if (false) { [UInt8(29), UInt8(71), UInt8(155), UInt8(75), UInt8(180), UInt8(144), UInt8(26), UInt8(117), UInt8(240), UInt8(182)] } else { [UInt8(229), UInt8(187), UInt8(48), UInt8(167), UInt8(154), UInt8(104), UInt8(127), UInt8(37), UInt8(188), UInt8(104)] } ;
        var1639 & var543
    } finally { // block id: 2817
        var762;
        ();
        var1782
    })
}


@echo func func388(param389 : Range<UInt16>) : UInt64 { // block id: 390
    @echo var var2823 : Range<UInt8> = ((UInt8(UInt8(Int8(Int8(7))))&127)..(UInt8(10)&127):((89|1)));
    ((var2823|>func394) >> ((try { // block id: 2832
        if (var352) { var1268 } else { var2837 } ;
        var2841 = UInt64(59);
        @echo let var2845 : Int64 = 75;
        var2845
    } finally { // block id: 2847
        65
    }) & 7)) % (((((-19) | var1639) << ((Int64(UInt8(201))) & 7))) | 1);
    @echo let var2868 : Bool = true;
    @echo let var2912 : ??UInt32 = Option<Option<UInt32>>.None;
    @echo var var2927 : UInt16 = UInt16(UInt16(159));
    @echo var var2938 : Range<Int32> = ((Int32(115)&127)..=(Int32(UInt16(188))&127):((Int64(UInt64(UInt8(Int8(-62))))|1)));
    @echo let var2955 : Range<Int8> = ((Int8(Int8(34))&127)..(Int8(UInt8(158))&127):(((-63)|1)));
    @echo var var3016 : UInt64 = UInt64(149);
    (match (try { // block id: 2862
            if (false) { (var296, var2868, var413, var917, Float32(-100.0)) } else { var2526 } ;
            if (false) { var2877 } else { var2877 } ;
            var1643
        } catch (_) { // block id: 2898
            if (var2868) { (UInt64(5), param389, var1709, ((Int16(58)&127)..=(Int16(80)&127):((-21)|1)), var1037, var352) } else { (UInt64(122), param389, var2912, ((Int16(-47)&127)..(Int16(118)&127):((-118)|1)), var1037, var2246) }
        }) {
        case _ =>
            Option<UInt64>.None

    } ?? try { // block id: 2921
        Option<Bool>.None;
        @echo let var2949 : String = """
Fa_ _
dh:QP
""";
        @echo var var2963 : (UInt16, Int64, Range<UInt64>, Int16, Option<Option<Array<Unit>>>, Array<UInt64>, (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>)) = (UInt16(Int8(Int8(56))), Int64(Int8(-3)), ((UInt64(UInt16(Int8(-81)))&127)..(UInt64(Int64(Int16(-13)))&127):((Int64(UInt8(203))|1))), Int16(Int16(8)), Option<Option<Array<Unit>>>.Some(Option<Array<Unit>>.Some([(), (), (), (), (), (), (), (), (), ()])), [UInt64(212), UInt64(126), UInt64(38), UInt64(145), UInt64(108), UInt64(50), UInt64(228), UInt64(117), UInt64(198), UInt64(153)], (((UInt32(202)&127)..(UInt32(UInt8(58))&127):((44|1))), ((Int32(101)&127)..(Int32(-126)&127):((Int64(UInt32(90))|1))), """
E`82B
`vT${var2949}9${var2949}(${var2949}
""", "sGK#${var2949}qZ[/${var2949}Ud", (), Int8(Int8(UInt8(1))), [(), (), (), (), (), (), (), (), (), ()], ((Int8(-49)&127)..=(Int8(-3)&127):(104|1))));
        if (var352) { (var2927, var1639, var2087, Int16(-121), Option<Option<Array<Unit>>>.None, [UInt64(233), UInt64(114), UInt64(162), UInt64(33), UInt64(135), UInt64(140), UInt64(153), UInt64(169), UInt64(108), UInt64(115)], (var377, var2938, """
pk[h7
HNq2Y
""", var2949, var762, Int8(21), [(), (), (), (), (), (), (), (), (), ()], var2955)) } else { var2963 } ;
        @echo var var3019 : UInt64 = UInt64(142);
        var3016 & var3019
    } catch (_) { // block id: 3021
        24.0;
        Option<Int64>.None;
        var2841
    } finally { // block id: 3025
        if (true) { ((UInt16(76), var2246, UInt32(13), ((Int32(60)&127)..=(Int32(15)&127):(113|1))), [var762, (), (), var762, (), var762, (), var762, (), ()], false, ((Int8(116)&127)..=(Int8(125)&127):(35|1))) } else { var3048 } ;
        UInt64(20)
    })
}

@echo func func327(param328 : Rune) : Option<Bool> { // block id: 329
    @echo var var3064 : (Range<UInt16>) -> UInt64 = func388;
    if ((match (Enum228.defaultValue) {
        case defaultValue =>
            @echo let var341 : Int64 = 31;
            ((var155&127)..=(var155&127):((var341|1)))

        case _ : UInt16 =>
            var348 &&= var352;
            ();
            ((UInt32(206)&127)..=(UInt32(229)&127):(85|1))

        case _ =>
            @echo let var360 : Unit = ();
            var360;
            var360;
            ((UInt32(252)&127)..=(UInt32(73)&127):((-79)|1))

        case defaultValue =>
            ((UInt32(242)&127)..(UInt32(221)&127):((119|1)))

        case _ =>
            UInt64(233);
            if (false) { var377 } else { ((UInt32(7)&127)..(UInt32(202)&127):(99|1)) }

    } is String)) { var384 } else { ((((UInt16(192)&127)..=(UInt16(39)&127):((-113)|1))|>var3064) as Bool) }
}

@echo public func func3070(param3071 : Int32) : Rune { // block id: 3072
    r'j'
}

@echo public func func315(param316 : String) : Option<Bool> { // block id: 317
    @echo var var3068 : (Rune) -> Option<Bool> = func327;
    match {
        case ([(), (), (), (), (), (), (), (), (), ()] is Range<Int64>) =>
        @echo var var3082 : Array<UInt64> = [UInt64(160), UInt64(41), UInt64(112), UInt64(72), UInt64(148), UInt64(158), UInt64(237), UInt64(217), UInt64(65), UInt64(249)];
        if (var348) { var3082 } else { [UInt64(134), UInt64(208), UInt64(181), UInt64(114), UInt64(46), UInt64(100), UInt64(56), UInt64(195), UInt64(118), UInt64(193)] } ;
        var1020
        case _ =>
        Int32(27)
    }|>(func3070~>var3068)
}

@echo public func func222(param223 : Range<Int8>) : Bool { // block id: 224
    @echo func func231(param232 : Int8, param233 : String) : Enum228 { // block id: 234
        var238[6];
        var252
    }
;
    @echo var var255 : Int8 = Int8(-94);
    @echo var var258 : String = ###"ouS%ZGp[s]"###;
    match (func231(var255, var258)) {
        case _ =>
            ();
            @echo let var275 : Int32 = Int32(53);
            @echo var var279 : Int64 = Int64(UInt16(UInt16(146)));
            if (true) { (UInt16(232), false, var155, ((var275&127)..(var275&127):((var279|1)))) } else { (UInt16(171), false, var155, ((Int32(-98)&127)..=(Int32(6)&127):((-34)|1))) }

        case _ =>
            @echo let var291 : Float32 = Float32(9.0);
            var291;
            if (var58) { var296 } else { var296 }

    }[1];
    @echo let var3089 : (String) -> Option<Bool> = func315;
    @echo let var3095 : Rune = r'w';
    if ((("""
|j~${var258}I${var258}<${var258}
e${var258}o.g;
"""|>var3089) ?? match ((var3095, Option<Bool>.None, Int16(-116), 72, (-48.0), var1029)) {
        case (caseVar3104 : Array<Int64>,_ : Array<Option<Int64>>,caseVar3105,caseVar3106 : Array<UInt8>,caseVar3107,caseVar3108 : Range<UInt8>) =>
            var42;
            Aggregate1293<Range<UInt32>>();
            Int32(-85) >= Int32(6)

        case _ =>
            @echo var var3122 : Range<Int32> = ((Int32(-22)&127)..=(Int32(-104)&127):((Int64(Int32(-35))|1)));
            (UInt32(176), Int16(-62), Enum228.defaultValue, var3122, UInt64(184), var3130, 30);
            ();
            false

    })) { // block id: 3135
        @echo var var3138 : (UInt16, Int64, Range<UInt64>, Int16, Option<Option<Array<Unit>>>, Array<UInt64>, (Range<UInt32>, Range<Int32>, String, String, Unit, Int8, Array<Unit>, Range<Int8>)) = (UInt16(UInt8(UInt8(Int8(-47)))), Int64(UInt8(209)), ((UInt64(190)&127)..(UInt64(50)&127):(((-11)|1))), Int16(UInt16(30)), Option<Option<Array<Unit>>>.None, [UInt64(94), UInt64(82), UInt64(136), UInt64(139), UInt64(185), UInt64(79), UInt64(210), UInt64(71), UInt64(72), UInt64(98)], (((UInt32(UInt8(231))&127)..(UInt32(41)&127):((112|1))), ((Int32(38)&127)..=(Int32(83)&127):(69|1)), """
_&a{=E
Pk\"&$
""", """
E@)8+
#%MCX
""", (), Int8(-56), [(), (), (), (), (), (), (), (), (), ()], ((Int8(Int8(-74))&127)..=(Int8(35)&127):((Int64(21)|1)))));
        match (var3138) {
            case (caseVar3174,_ : Int16,caseVar3175,caseVar3176,caseVar3177,_ : Int8,(caseVar3178,_ : Option<Float32>,_,caseVar3179,_ : Option<Float64>,caseVar3180,_,_)) =>
                @echo let var3194 : Option<Unit> = Option<Unit>.None;
                [var2218, var2218, Option<Unit>.None, Option<Unit>.Some(var762), Option<Unit>.None, var2286, Option<Unit>.Some(()), Option<Unit>.None, var3194, Option<Unit>.None];
                var762

            case _ : Int16 =>
                ((var155&127)..(UInt32(52)&127):((var1639|1)));
                ()

            case _ =>
                ()

        };
        var1529;
        (var2218 ?? var762)
    } else if ((try { // block id: 3220
        var2246 &&= false;
        if (var352) { var384 } else { var1804 }
    } finally { // block id: 3228
        Option<UInt64>.None;
        ();
        var3232
    } is Option<Bool>)) { // block id: 3234

    };
    @echo let var3283 : Option<Option<Array<Unit>>> = Option<Option<Array<Unit>>>.None;
    (match (match (var3239) {
            case caseVar3244 : Option<Unit> =>
                @echo var var3247 : Unit = ();
                var3247;
                ((var155&127)..(UInt32(168)&127):(((-84)|1)))

            case caseVar3255 =>
                var2218;
                ((var2597&127)..(UInt32(147)&127):((25|1)))

            case caseVar3264 =>
                ();
                ((UInt32(224)&127)..(UInt32(130)&127):((-81)|1))

            case caseVar3270 : Range<Int64> =>
                55.0;
                Option<Enum228>.None;
                ((UInt32(5)&127)..=(var155&127):(((-117)|1)))

            case _ =>
                if (true) { var3283 } else { var3286 } ;
                "a{;7CN#:N6v";
                ((UInt32(71)&127)..=(UInt32(87)&127):((-45)|1))

        }) {
        case caseVar3292 : Option<Option<Array<Unit>>> =>
            UInt32(100);
            ();
            var384

        case _ =>
            [Option<Unit>.None, Option<Unit>.Some(()), Option<Unit>.Some(()), var2286, Option<Unit>.None, var2286, var2286, Option<Unit>.None, var2286, Option<Unit>.Some(var762)];
            if (var348) { Option<Bool>.None } else { var3232 }

    } ?? !true)
}



@echo func func208(namedParam209 ! : Range<Int8>) : Option<Bool> { // block id: 210
    @echo let var3355 : UInt8 = UInt8(31);
    @echo func func212(param213 : Range<UInt64>, namedParam214 ! : Range<UInt32>) : Option<Bool> { // block id: 215
        @echo var var217 : Unit = ();
        var217;
        @echo let var3450 : Unit = ();
        @echo let var3464 : Unit = ();
        @echo var var3474 : ?Bool = (Option<Range<UInt32>>.Some(((UInt32(UInt16(0))&127)..=(UInt32(153)&127):(((-81)|1)))) as Bool);
        if (if ((((var1037&127)..(var3323&127):((var1782|1)))|>func222)) { // block id: 3328
            var252;
            if (true) { Option<Range<UInt64>>.Some(((UInt64(102)&127)..=(UInt64(204)&127):((var1782|1)))) } else { Option<Range<UInt64>>.None } ;
            false
        } else if (true) { // block id: 3340
            ();
            var1037 += Int8(-58);
            var348
        } else { // block id: 3346
            92 > (-89)
        }) { (match (((var724&127)..=(var3355&127):((71|1)))) {
            case caseVar3360 : Array<Int16> =>
                var724 <<= ((var3355) & 7);
                ((UInt32(200)&127)..=(UInt32(210)&127):((-53)|1));
                var413

            case _ : (Option<Range<UInt32>>, Range<UInt64>, Range<Int32>, UInt32) =>
                var2246 &&= false;
                if (true) { var413 } else { Option<Array<Unit>>.None }

            case caseVar3379 : Option<Float64> =>
                (var3207, var1782, param213, Int16(-69), var3286, [UInt64(43), UInt64(50), UInt64(171), UInt64(163), UInt64(43), UInt64(115), UInt64(143), UInt64(38), UInt64(203), UInt64(125)], (((UInt32(156)&127)..=(UInt32(74)&127):(87|1)), ((var1020&127)..=(Int32(19)&127):((var543|1))), var3395, var3395, var217, Int8(-84), [(), (), (), (), (), (), (), (), (), ()], ((Int8(37)&127)..(Int8(2)&127):(6|1))));
                var81;
                Option<Array<Unit>>.None

            case caseVar3406 : Option<Option<Unit>> =>
                var2218;
                var917;
                Option<Array<Unit>>.None

            case _ =>
                if (var348) { var238 } else { [var217, (), (), (), var217, var217, (), (), (), ()] } ;
                if (var352) { Option<Array<Unit>>.Some(var238) } else { Option<Array<Unit>>.Some([var217, var762, var217, (), (), var762, var762, var217, (), ()]) }

        } as Bool) } else { try { // block id: 3444
            @echo var var3455 : Rune = r'N';
            (119, ((Int32(90)&127)..=(Int32(28)&127):((-126)|1)), var1782, var3450, var1094, param213, var3455);
            if (var352) { Option<Bool>.Some(true) } else { Option<Bool>.None }
        } finally { // block id: 3462
            var3464;
            Int64(var3323) ** UInt64(var3323 & 3);
            if (var2246) { Option<Bool>.Some(true) } else { var3474 }
        } }
    }
;
    func212(match (try { // block id: 3484
            var3486
        } finally { // block id: 3501
            ();
            var724 /= ((var724) | 1);
            Option<UInt32>.None
        }) {
        case _ =>
            ((Int32(89)&127)..(Int32(-121)&127):(114|1));
            if (false) { ((UInt64(6)&127)..=(var2841&127):((var1782|1))) } else { ((var917&127)..=(var917&127):(((-80)|1))) }

        case _ =>
            var1029 /= ((var3355) | 1);
            if (true) { var2087 } else { ((UInt64(177)&127)..(UInt64(85)&127):(1|1)) }

    }, namedParam214 : var377);
    (Option<Range<UInt16>>.Some(var3538) ?? ((UInt16(UInt16(88))&127)..((Option<UInt16>.Some(UInt16(112)) ?? var3207)&127):(((-7) << ((4) & 7)|1))));
    match (try { // block id: 3561
            ((UInt8(59)&127)..(UInt8(108)&127):(121|1))
        } catch (_) { // block id: 3563
            ((var1029&127)..=(var1029&127):(((-113)|1)))
        }) {
        case _ =>
            Int32(81) & Int32(-47);
            if (true) { var384 } else { Option<Bool>.Some(false) }

    }
}

main(): Int64 {
    try {
        if ((Option<Bool>.None ?? false)) { // block id: 13
            @echo let var15 : Unit = ();
            var15;
            var19 | var19
        } else if (false) { // block id: 27
            Int16(-68)
        } else { // block id: 29
            Int16(33) | Int16(-48)
        };
        @echo let var175 : Option<Unit> = Option<Unit>.Some(());
        func208(namedParam209 : ((Int8(14)&127)..=(var3581&127):((var1782|1))))|>{ lambdaParameter115 : Option<Bool> => @echo let var167 : Unit = (); @echo var var181 : Option<Unit> = Option<Unit>.None; @echo let var201 : Unit = (); (try { // block id: 133
            @echo var var136 : UInt64 = UInt64(2);
            var136 %= ((var136) | 1);
            var140
        } finally { // block id: 152
            var155 &= UInt32(208);
            @echo let var170 : Option<Unit> = Option<Unit>.Some(());
            if (false) { [Option<Unit>.Some(var167), var170, Option<Unit>.None, var175, Option<Unit>.None, Option<Unit>.None, var181, Option<Unit>.Some(var167), Option<Unit>.Some(()), Option<Unit>.Some(())] } else { [var175, var175, Option<Unit>.Some(()), Option<Unit>.None, var181, Option<Unit>.Some(()), Option<Unit>.None, Option<Unit>.Some(var201), var175, var170] }
        }[0] ?? var201) };
        @echo var var3617 : Option<Unit> = Option<Unit>.Some(());
        Int64(match ([var19, Int16(35), Int16(-64), Int16(-28), Int16(42), var1848, Int16(-57), var19, var1848, Int16(109)]) {
            case caseVar3600 =>
                if (false) { Option<Array<Option<Unit>>>.None } else { Option<Array<Option<Unit>>>.Some([Option<Unit>.None, var2286, Option<Unit>.None, Option<Unit>.Some(var762), Option<Unit>.Some(()), Option<Unit>.Some(var762), var3617, Option<Unit>.Some(()), Option<Unit>.Some(()), var175]) } ;
                UInt32(181)

            case _ =>
                var762;
                UInt32(250)

        })
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var19*var19), 64)
        crccheck.updateBuffer(UInt64(var155*var155), 64)
        crccheck.updateBuffer(UInt64(var543*var543), 64)
        crccheck.updateBuffer(UInt64(var724*var724), 64)
        crccheck.updateBuffer(UInt64(var917*var917), 64)
        crccheck.updateBuffer(UInt64(var1020*var1020), 64)
        crccheck.updateBuffer(UInt64(var1029*var1029), 64)
        crccheck.updateBuffer(UInt64(var1037*var1037), 64)
        crccheck.updateBuffer(UInt64(var1639*var1639), 64)
        crccheck.updateBuffer(UInt64(var1782*var1782), 64)
        crccheck.updateBuffer(UInt64(var1848*var1848), 64)
        crccheck.updateBuffer(UInt64(var2597*var2597), 64)
        crccheck.updateBuffer(UInt64(var2841*var2841), 64)
        crccheck.updateBuffer(UInt64(var3207*var3207), 64)
        crccheck.updateBuffer(UInt64(var3323*var3323), 64)
        crccheck.updateBuffer(UInt64(var3581*var3581), 64)
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
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_arithmetic_operator_overflow
// ASSERT: scan chir_dce_unused_operator
