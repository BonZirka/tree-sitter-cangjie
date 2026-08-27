/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

private func composition<T1, T2, T3>(f: (T1) -> T2, g: (T2) -> T3): (T1) -> T3 {
    return {x: T1 => g(f(x))}
}

public let var22 : Unit = ()
public let var36 : Int32 = Int32(UInt32(152))
public var var42 : Bool = (match (30) {
    case _: Float32 => true
    case _ => false
})
public let var87 : UInt32 = UInt32(33)
public var var106 : Array<UInt32> = [UInt32(128), UInt32(56), UInt32(146), UInt32(152), UInt32(42), UInt32(18), UInt32(202), UInt32(54), UInt32(98), UInt32(177)]
public var var198 : Option<Range<Int16>> = Option<Range<Int16>>.None
var var219 : UInt16 = UInt16(96)
public var var236 : Int64 = 106
let var255 : Float64 = 89.0
var var305 : Float32 = Float32(70.0)
var var473 : (Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String) = ([UInt64(UInt8(221)), UInt64(Int32(UInt16(25))), UInt64(144), UInt64(UInt8(UInt8(144))), UInt64(223), UInt64(80), UInt64(UInt64(UInt64(78))), UInt64(191), UInt64(52), UInt64(132)], UInt16(161), (UInt32(212), UInt32(89), r't', """
\"5#:g
0/5vV
""", UInt8(UInt8(UInt8(219))), r'y', ((UInt64(206)&127)..=(UInt64(63)&127):(0|1)), ((UInt32(42)&127)..=(UInt32(158)&127):(126|1))), ((match (UInt64(248)) {
    case _: Unit => true
    case _ => false
}), ((Int32(60)&127)..(Int32(-74)&127):(93|1)), [UInt64(Int32(-7)), UInt64(UInt8(189)), UInt64(UInt64(44)), UInt64(Int32(-36)), UInt64(Int8(-52)), UInt64(Int32(12)), UInt64(138), UInt64(UInt64(84)), UInt64(UInt16(154)), UInt64(Int32(76))]), ###"+D&[H14&SX"###)
var var555 : Rune = r'e'
var var592 : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) = ((Float32(-71.0), r'f', Int32(86), (match ((Float32(4.0), r'3', Int32(17), Option<Range<Int16>>.None, ((Int16(106)&127)..=(Int16(-96)&127):((88|1))), ((Int32(-16)&127)..(Int32(86)&127):((94|1))))) {
    case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
    case _ => Option<Range<Int16>>.None
}), ((Int16(79)&127)..(Int16(48)&127):((-83)|1)), ((Int32(Int32(-68))&127)..=(Int32(33)&127):((Int64(Int32(-42))|1)))), Int16(61))
public let var1028 : Class201 = Class201()
public let var1092 : String = "!pkV7or7^|"
public let var1265 : UInt64 = UInt64(29)
public let var1546 : Option<(Bool, Range<Int32>, Array<UInt64>)> = (match (UInt8(UInt8(UInt8(4)))) {
    case newVar: (Bool, Range<Int32>, Array<UInt64>) => Option<(Bool, Range<Int32>, Array<UInt64>)>.Some(newVar)
    case _ => Option<(Bool, Range<Int32>, Array<UInt64>)>.None
})
let var1590 : Option<UInt8> = Option<UInt8>.None
public var var1691 : Array<((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)> = [((Float32(Float32(-22.0)), r'S', Int32(-86), (match ([UInt64(31), UInt64(218), UInt64(93), UInt64(83), UInt64(150), UInt64(32), UInt64(189), UInt64(175), UInt64(154), UInt64(110)]) {
    case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
    case _ => Option<Range<Int16>>.None
}), ((Int16(103)&127)..=(Int16(-94)&127):(69|1)), ((Int32(-51)&127)..=(Int32(59)&127):((48|1)))), Int16(1)), ((Float32(-13.0), r'H', Int32(UInt32(13)), Option<Range<Int16>>.None, ((Int16(-38)&127)..(Int16(114)&127):((-120)|1)), ((Int32(106)&127)..=(Int32(-8)&127):(15|1))), Int16(-18)), ((Float32(Float32(-98.0)), r'j', Int32(UInt16(141)), Option<Range<Int16>>.None, ((Int16(-106)&127)..(Int16(-2)&127):(92|1)), ((Int32(51)&127)..(Int32(34)&127):(((-91)|1)))), Int16(UInt8(148))), ((Float32(30.0), r'E', Int32(-2), Option<Range<Int16>>.None, ((Int16(23)&127)..=(Int16(71)&127):(((-62)|1))), ((Int32(109)&127)..(Int32(41)&127):(119|1))), Int16(-9)), ((Float32(-102.0), r'X', Int32(UInt32(96)), Option<Range<Int16>>.None, ((Int16(44)&127)..=(Int16(-51)&127):((84|1))), ((Int32(85)&127)..=(Int32(-9)&127):(((-116)|1)))), Int16(Int8(Int8(27)))), ((Float32(64.0), r'F', Int32(41), Option<Range<Int16>>.None, ((Int16(77)&127)..=(Int16(-35)&127):(27|1)), ((Int32(111)&127)..(Int32(118)&127):(((-63)|1)))), Int16(Int8(29))), ((Float32(Float32(55.0)), r'B', Int32(-24), (match (Int8(70)) {
    case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
    case _ => Option<Range<Int16>>.None
}), ((Int16(-13)&127)..=(Int16(-86)&127):(((-68)|1))), ((Int32(-50)&127)..=(Int32(5)&127):(((-4)|1)))), Int16(UInt8(68))), ((Float32(79.0), r'M', Int32(80), Option<Range<Int16>>.None, ((Int16(25)&127)..(Int16(-96)&127):((20|1))), ((Int32(-35)&127)..=(Int32(118)&127):(33|1))), Int16(UInt8(UInt8(3)))), ((Float32(Float32(-25.0)), r'e', Int32(Int16(-20)), (match (((UInt8(39)&127)..=(UInt8(61)&127):(94|1))) {
    case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
    case _ => Option<Range<Int16>>.None
}), ((Int16(96)&127)..(Int16(-20)&127):(90|1)), ((Int32(-113)&127)..=(Int32(-29)&127):(19|1))), Int16(Int8(-5))), ((Float32(Float32(119.0)), r'w', Int32(120), (match ([(), (), (), (), (), (), (), (), (), ()]) {
    case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
    case _ => Option<Range<Int16>>.None
}), ((Int16(-9)&127)..=(Int16(-57)&127):((92|1))), ((Int32(17)&127)..(Int32(-50)&127):((7|1)))), Int16(31))]
var var2059 : Int32 = Int32(81)
public let var2260 : Bool = (match ((((UInt8(163)&127)..=(UInt8(93)&127):((-115)|1)), ((78&127)..=((-123)&127):(60|1)), (-116.0), ((Int8(27)&127)..(Int8(-123)&127):((-18)|1)))) {
    case _: Class201 => true
    case _ => false
})
let var2308 : Class201 = Class201()
public let var2464 : UInt8 = UInt8(65)
public let var2541 : Interface204 = Class201()
var var2575 : Float64 = (-84.0)
var var2668 : UInt64 = UInt64(Int16(-95))
var var2955 : Int16 = Int16(-28)
let var2972 : Interface206 = Class201()
var var3154 : Range<Int32> = ((Int32(-77)&127)..=(Int32(UInt32(108))&127):((Int64(UInt8(93))|1)))
public var var3182 : Bool = false
public var var3280 : (Bool, Range<Int32>, Array<UInt64>) = (false, ((Int32(-16)&127)..(Int32(-92)&127):((Int64(Int64(UInt64(225)))|1))), [UInt64(254), UInt64(194), UInt64(184), UInt64(70), UInt64(178), UInt64(93), UInt64(77), UInt64(218), UInt64(90), UInt64(34)])
let var3661 : Option<UInt32> = Option<UInt32>.None
var var3700 : Int16 = Int16(31)
let var3720 : Range<UInt8> = ((UInt8(251)&127)..=(UInt8(Int8(119))&127):((Int64(Int64(UInt64(Int8(-30))))|1)))
var var3737 : Range<Int64> = ((13&127)..((-36)&127):(((-35)|1)))
public let var3744 : Range<Int8> = ((Int8(Int8(Int8(UInt8(126))))&127)..=(Int8(Int8(-126))&127):(((-53)|1)))
var var3779 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(-120.0), r'K', Int32(UInt8(97)), Option<Range<Int16>>.None, ((Int16(103)&127)..=(Int16(Int8(UInt8(188)))&127):((Int64(Int16(Int16(18)))|1))), ((Int32(Int32(Int16(7)))&127)..=(Int32(125)&127):((Int64(UInt32(185))|1))))
public var var3938 : Range<Int16> = ((Int16(-80)&127)..=(Int16(-63)&127):((Int64(UInt16(UInt8(189)))|1)))
public let var4039 : Option<Range<UInt32>> = Option<Range<UInt32>>.None
var var4069 : Int8 = Int8(Int8(UInt8(Int8(Int8(85)))))
public let var4142 : Unit = ()
let var4157 : Array<Unit> = Array<Unit>(10){ i => () }
let var4177 : Option<UInt16> = (match ((match ((true, ((Int32(105)&127)..(Int32(-38)&127):((10|1))), [UInt64(50), UInt64(72), UInt64(125), UInt64(95), UInt64(109), UInt64(202), UInt64(75), UInt64(228), UInt64(4), UInt64(66)])) {
    case newVar: Option<Interface204> => Option<Option<Interface204>>.Some(newVar)
    case _ => Option<Option<Interface204>>.None
})) {
    case newVar: UInt16 => Option<UInt16>.Some(newVar)
    case _ => Option<UInt16>.None
})
var var4248 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) = (56.0, ((Int8(Int8(2))&127)..(Int8(UInt8(2))&127):((Int64(UInt32(47))|1))), [UInt32(131), UInt32(241), UInt32(218), UInt32(211), UInt32(59), UInt32(89), UInt32(129), UInt32(119), UInt32(75), UInt32(250)], (r'B', 113, (), UInt64(Int8(UInt8(33)))), (Float32(Float32(-92.0)), r'E', Int32(Int32(UInt8(14))), Option<Range<Int16>>.None, ((Int16(-37)&127)..(Int16(27)&127):(76|1)), ((Int32(42)&127)..=(Int32(61)&127):((Int64(UInt64(80))|1)))), Float32(-8.0), (r'G', Int64(UInt32(UInt16(86))), (), UInt64(212)), Int32(75))
public let var4352 : UInt8 = UInt8(176)
public var var4357 : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) = (UInt32(UInt16(Int16(UInt16(159)))), UInt32(67), r'g', """
d,${var1092}nCf
l${var1092}^${var1092}3L${var1092}w
""", UInt8(33), r'o', ((UInt64(146)&127)..=(UInt64(UInt16(117))&127):((Int64(Int16(-13))|1))), ((UInt32(208)&127)..=(UInt32(83)&127):((Int64(UInt16(64))|1))))
var var4386 : Range<UInt64> = ((UInt64(174)&127)..=(UInt64(144)&127):(42|1))
var var4454 : Option<Range<UInt8>> = (match (Class201()) {
    case newVar: Range<UInt8> => Option<Range<UInt8>>.Some(newVar)
    case _ => Option<Range<UInt8>>.None
})
public let var4473 : Int32 = Int32(-35)
public let var4644 : Int64 = 48
var var4678 : Bool = (match (UInt64(251)) {
    case _: (Interface204) -> Option<Unit> => true
    case _ => false
})
public let var4764 : Option<Range<UInt8>> = Option<Range<UInt8>>.None
let var4811 : Unit = ()
public let var4851 : Option<Unit> = (match (()) {
    case newVar: Unit => Option<Unit>.Some(newVar)
    case _ => Option<Unit>.None
})
let var4867 : Int16 = Int16(-108)
public let var5065 : Rune = r'p'
let var5079 : Option<Int32> = Option<Int32>.None
public let var5223 : Option<Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>> = Option<Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>>.None
var var5363 : (Rune, Int64, Unit, UInt64) = (r'g', (-26), (), UInt64(Int64(Int64(UInt32(131)))))
public var var5500 : Option<Option<Interface204>> = Option<Option<Interface204>>.None
public var var5537 : Array<UInt64> = Array<UInt64>(10){ i => UInt64(Int64(UInt8(173))) }
public var var5578 : Class201 = Class201()
public var var5878 : Int16 = Int16(UInt8(45))
public var var5887 : Interface205 = Class201()
public var var5891 : UInt32 = UInt32(Int32(93))
let var5920 : Unit = ()
let var6150 : Option<Float64> = (match ((match (Float64(Float32(6.0))) {
    case newVar: Array<Unit> => Option<Array<Unit>>.Some(newVar)
    case _ => Option<Array<Unit>>.None
})) {
    case newVar: Float64 => Option<Float64>.Some(newVar)
    case _ => Option<Float64>.None
})
var var6265 : Range<UInt32> = ((UInt32(Int32(-124))&127)..(UInt32(251)&127):((Int64(UInt32(Int16(Int8(24))))|1)))
let var6294 : UInt32 = UInt32(UInt32(85))
public var var6363 : Option<Option<(Bool, Range<Int32>, Array<UInt64>)>> = Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.None

public interface Interface206 {

}

public interface Interface205 <: Interface206 {
    static func func2299() : Range<Int16> { // block id: 2300
        ((Int16(56)&127)..=(Int16(82)&127):((-106)|1))
    }
;
    static func func2303() : Array<Class201> { // block id: 2304
        let var2326 : UInt8 = UInt8(21);
        let var4831 : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>)) -> Bool = func2329;
        let var4837 : Int32 = Int32(UInt32(Int32(Int32(UInt16(69)))));
        var2308.var2311 *= match {
            case (match (var255) {
            case _: Option<Unit> => true
            case _ => false
        }) =>
            var var2319 : Int8 = Int8(UInt8(Int8(8)));
            var2319 -= var2319;
            var22;
            var2326
            case (var4831((Float32(-103.0), r'E', var4837, Option<Range<Int16>>.Some(var3938), ((Int16(-68)&127)..(Int16(-59)&127):((-121)|1)), ((Int32(-82)&127)..=(Int32(-13)&127):((-36)|1))))) =>
            if (true) { var4851 } else { Option<Unit>.None } ;
            ();
            var2326
            case _ =>
            var3720;
            Option<UInt16>.Some(UInt16(211));
            var2464
        };
        var loopTimeVar4871 : Int64 = 0;
        do {
            loopTimeVar4871++;

        } while ((Int16(var219) <= var4867) && loopTimeVar4871 < 100 ) ;
        var var4898 : UInt32 = UInt32(Int32(Int16(44)));
        match (try { // block id: 4874
                ();
                var var4881 : Option<Array<Unit>> = Option<Array<Unit>>.None;
                if (var3182) { Option<Array<Unit>>.Some(var4157) } else { var4881 } ;
                (var87, UInt32(13), r'X', var1092, UInt8(157), r'O', ((UInt64(52)&127)..=(UInt64(250)&127):(68|1)), ((UInt32(158)&127)..=(UInt32(167)&127):((-84)|1)))
            } finally { // block id: 4892
                Option<Option<UInt16>>.Some(Option<UInt16>.Some(UInt16(32)));
                var4898 /= ((var4898) | 1);
                var4357
            }) {
            case _ =>
                var var4909 : UInt64 = UInt64(50);
                var2668 -= var4909;
                [Class201(), var2308, var2308, Class201(), Class201(), Class201(), Class201(), Class201(), var1028, Class201()]

        }
    }

}

public interface Interface204 <: Interface205 {
    static func func2226() : Range<Int16> { // block id: 2227
        [(), (), (), (), (), (), (), (), (), ()];
        var loopTimeVar2297 : Int64 = 0;
        while ((match (Option<(Bool, Range<Int32>, Array<UInt64>)>.None) {
            case _ : (Range<UInt8>, Range<Int64>, Float64, Range<Int8>) =>
                var22;
                var22;
                [true, false, true, var42, var42, true, var42, var42, var42, true]

            case _ =>
                ();
                ();
                [var42, var42, false, var42, var2260, true, var42, false, true, var42]

        }[8]) && loopTimeVar2297 < 100 ) {
            loopTimeVar2297++;
            if (var42) { // block id: 2276
                ();
                (r'c', 51, var22, UInt64(97));
                Int8(124)
            } else if (var2260) { // block id: 2285
                var var2288 : Int16 = Int16(-114);
                ((var2288&127)..=(var2288&127):((var236|1)));
                Int8(-39)
            } else { // block id: 2293
                Int8(-18)
            };
            ((UInt8(72)&127)..=(UInt8(171)&127):((-102)|1))
        };
        func2299()
    }
;
    func func5084(namedParam5085 ! : ((UInt16) -> Option<(Bool, Range<Int32>, Array<UInt64>)>, (Rune, Int64, Unit, UInt64), (Range<UInt32>) -> UInt8) -> Array<Unit>, namedParam5090 ! : (Int16) -> Option<(Bool, Range<Int32>, Array<UInt64>)>, namedParam5093 ! : Enum2505) : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) { // block id: 5094
        var var5113 : (Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String) = ([UInt64(25), UInt64(18), UInt64(208), UInt64(92), UInt64(187), UInt64(188), UInt64(5), UInt64(238), UInt64(122), UInt64(229)], UInt16(UInt16(Int8(UInt8(69)))), (UInt32(88), UInt32(216), r'Y', """
vDiq(
v&Ee'
""", UInt8(10), r'd', ((UInt64(210)&127)..=(UInt64(192)&127):((Int64(Int16(-114))|1))), ((UInt32(154)&127)..(UInt32(38)&127):((-18)|1))), ((match ((false, ((Int32(-86)&127)..(Int32(37)&127):((54|1))), [UInt64(3), UInt64(135), UInt64(11), UInt64(252), UInt64(253), UInt64(160), UInt64(249), UInt64(97), UInt64(160), UInt64(79)])) {
            case _: (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) => true
            case _ => false
        }), ((Int32(-91)&127)..(Int32(-22)&127):((-81)|1)), [UInt64(242), UInt64(128), UInt64(84), UInt64(170), UInt64(8), UInt64(139), UInt64(26), UInt64(51), UInt64(80), UInt64(130)]), "awJW4$WHd-");
        var var5147 : Array<UInt64> = [UInt64(132), UInt64(251), UInt64(232), UInt64(25), UInt64(81), UInt64(209), UInt64(8), UInt64(40), UInt64(97), UInt64(56)];
        var var5161 : String = "}gzWExpmmU";
        let var5173 : Int64 = Int64(UInt8(UInt8(Int8(51))));
        match (var4644) {
            case _ =>
                if (false) { var4177 } else { Option<UInt16>.None } ;
                if (true) { var473 } else { var473 }

            case _ =>
                let var5153 : UInt32 = UInt32(UInt8(Int8(Int8(Int8(-70)))));
                if (var4678) { var5113 } else { (var5147, UInt16(93), (var87, var5153, var555, var5161, UInt8(172), r'c', ((UInt64(73)&127)..=(UInt64(77)&127):((var4644|1))), ((UInt32(104)&127)..=(UInt32(36)&127):((var5173|1)))), (var2260, var3154, [var2668, UInt64(147), var1265, UInt64(136), UInt64(233), UInt64(208), UInt64(139), UInt64(102), var2668, var2668]), ")k#lu.mpPl") }

        };
        (-33.0);
        var var5214 : Option<Bool> = (match (Option<(Unit, UInt8)>.None) {
            case newVar: Bool => Option<Bool>.Some(newVar)
            case _ => Option<Bool>.None
        });
        var var5226 : Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)> = (match ([UInt32(69), UInt32(5), UInt32(Int32(-42)), UInt32(117), UInt32(UInt16(Int8(-72))), UInt32(181), UInt32(226), UInt32(111), UInt32(96), UInt32(48)]) {
            case newVar: (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.Some(newVar)
            case _ => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.None
        });
        (match (if ((match ([var2464, UInt8(106), UInt8(109), var4352, var4352, UInt8(78), UInt8(220), var4352, var4352, var2464]) {
            case _: Option<Range<UInt32>> => true
            case _ => false
        })) { (match (var5214) {
            case newVar: (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.Some(newVar)
            case _ => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.None
        }) } else { (match (var5223) {
            case Some(num) => num
            case None => var5226
        }) } ) {
            case Some(num) => num
            case None => if ((match ([[UInt8(236), UInt8(38), UInt8(29), UInt8(0), UInt8(18), UInt8(5), UInt8(97), UInt8(18), UInt8(144), UInt8(234)], [UInt8(217), UInt8(244), UInt8(172), UInt8(141), UInt8(209), UInt8(162), UInt8(209), UInt8(218), UInt8(129), UInt8(243)], [UInt8(178), UInt8(125), UInt8(195), UInt8(63), UInt8(166), UInt8(228), UInt8(37), UInt8(68), UInt8(210), UInt8(250)], [UInt8(100), UInt8(25), UInt8(192), UInt8(22), UInt8(125), UInt8(101), UInt8(129), UInt8(123), UInt8(54), UInt8(85)], [UInt8(207), UInt8(86), UInt8(94), UInt8(97), UInt8(99), UInt8(1), UInt8(221), UInt8(249), UInt8(144), UInt8(207)], [UInt8(136), UInt8(26), UInt8(194), UInt8(79), UInt8(250), UInt8(24), UInt8(0), UInt8(230), UInt8(227), UInt8(136)], [UInt8(93), UInt8(208), UInt8(90), UInt8(91), UInt8(175), UInt8(179), UInt8(92), UInt8(185), UInt8(222), UInt8(32)], [UInt8(12), UInt8(8), UInt8(214), UInt8(186), UInt8(238), UInt8(87), UInt8(175), UInt8(190), UInt8(235), UInt8(120)], [UInt8(112), UInt8(231), UInt8(180), UInt8(86), UInt8(210), UInt8(129), UInt8(88), UInt8(148), UInt8(37), UInt8(231)], [UInt8(54), UInt8(90), UInt8(40), UInt8(41), UInt8(181), UInt8(79), UInt8(201), UInt8(4), UInt8(217), UInt8(97)]]) {
            case _: (Float32, Range<UInt64>, Interface205, Bool) -> (Rune, Int64, Unit, UInt64) => true
            case _ => false
        })) { // block id: 5245
            ();
            var var5252 : (Rune, Int64, Unit, UInt64) = (r'q', Int64(Int16(UInt16(100))), (), UInt64(UInt8(201)));
            ((-59.0), ((Int8(-55)&127)..(Int8(48)&127):((-36)|1)), var106, var5252, (Float32(124.0), r'k', Int32(-29), Option<Range<Int16>>.Some(((Int16(93)&127)..(Int16(86)&127):(4|1))), ((Int16(-73)&127)..=(Int16(-101)&127):((-52)|1)), ((Int32(81)&127)..(Int32(102)&127):((5|1)))), var305, (var5065, var236, var4142, var2668), Int32(61))
        } else if (var305 >= var305) { // block id: 5282
            var var5285 : Float32 = Float32(-70.0);

            var var5292 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) = (Float64(Float64(Float32(Float32(-65.0)))), ((Int8(95)&127)..=(Int8(118)&127):((-91)|1)), [UInt32(70), UInt32(Int32(UInt32(30))), UInt32(UInt16(Int8(25))), UInt32(52), UInt32(155), UInt32(UInt32(98)), UInt32(Int32(-92)), UInt32(UInt32(UInt16(174))), UInt32(UInt16(UInt16(239))), UInt32(Int16(-24))], (r'9', Int64(Int16(UInt8(1))), (), UInt64(52)), (Float32(Float32(Float32(89.0))), r'I', Int32(UInt8(226)), Option<Range<Int16>>.None, ((Int16(-49)&127)..=(Int16(Int16(-91))&127):((Int64(UInt16(19))|1))), ((Int32(-60)&127)..(Int32(5)&127):((-15)|1))), Float32(Float32(-34.0)), (r'Y', Int64(53), (), UInt64(Int16(UInt16(214)))), Int32(Int16(UInt16(Int8(-41)))));
            if (var4678) { var4248 } else { var5292 }
        } else { // block id: 5357
            let var5374 : Float32 = Float32(-45.0);
            var var5380 : Range<Int16> = ((Int16(0)&127)..(Int16(-16)&127):((Int64(Int8(Int8(UInt8(67))))|1)));
            (var255, var3744, var106, var5363, (var5374, var5065, var4473, Option<Range<Int16>>.Some(var5380), var5380, ((Int32(-22)&127)..(Int32(-124)&127):((-49)|1))), Float32(-105.0), var5363, Int32(62))
        }
        })
    }

}

public open class Class201 <: Interface204 & Resource {
    public init() { // block id: 203

    }
;
    let var213 : Unit = ();
    public init(param955 : Int32, param956 : (Range<Int64>) -> ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16), param959 : Range<UInt64>, optionalParam960 ! : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(Float32(-4.0)), r'B', Int32(Int16(UInt16(171))), (match (Option<Range<Int16>>.Some(((Int16(79)&127)..(Int16(-34)&127):(((-79)|1))))) {
        case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
        case _ => Option<Range<Int16>>.None
    }), ((Int16(40)&127)..(Int16(2)&127):((Int64((-39))|1))), ((Int32(-100)&127)..(Int32(72)&127):(60|1)))) { // block id: 980
        let var984 : (Range<UInt64>, Range<UInt32>, Array<Unit>, Range<UInt8>, Array<UInt64>, Int32) = (((UInt64(UInt32(29))&127)..=(UInt64(Int8(Int8(-41)))&127):((Int64(Int64(UInt64(243)))|1))), ((UInt32(220)&127)..=(UInt32(157)&127):(66|1)), [(), (), (), (), (), (), (), (), (), ()], ((UInt8(147)&127)..(UInt8(114)&127):((-86)|1)), [UInt64(19), UInt64(37), UInt64(Int8(112)), UInt64(179), UInt64(181), UInt64(45), UInt64(177), UInt64(Int32(-3)), UInt64(Int16(Int8(74))), UInt64(168)], Int32(Int16(62)));
        var984[3]
    }
;
    var var1031 : Int64 = (-98);
    let var1510 : UInt8 = UInt8(149);
    public var var1867 : Int64 = (-58);
    public let var1872 : Int8 = Int8(-120);
    protected var var1968 : UInt64 = UInt64(40);
    static var var2048 : Option<Option<(Bool, Range<Int32>, Array<UInt64>)>> = Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.None;
    protected init(param2030 : Interface205, param2031 : (Range<UInt32>) -> UInt8, namedParam2034 ! : Array<Array<UInt8>>, namedParam2035 ! : Unit) { // block id: 2036
        func1414((match (if (true) { Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.Some(Option<(Bool, Range<Int32>, Array<UInt64>)>.None) } else { var2048 } ) {
            case Some(num) => num
            case None => match (((UInt16(172)&127)..=(UInt16(41)&127):((-83)|1))) {
            case _ =>
                Int32(-62) ^ var36;
                var2059 ^= Int32(-121);
                if (var42) { var1546 } else { var1546 }

        }
        }))
    }
;
    public var var2311 : UInt8 = UInt8(74);
    public init(param2605 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)) { // block id: 2606
        var var2612 : Unit = ();
        var var2663 : Option<Int32> = Option<Int32>.Some(Int32(108));
        var var2676 : UInt32 = UInt32(Int32(-37));
        var var2700 : Unit = ();
        try (resource = Class201()) { // block id: 2608
            try { // block id: 2610
                var2612;
                [(), (), (), (), (), (), (), (), (), ()]
            } catch (e: Exception) { // block id: 2615
                var236 **= (26 & 3);
                [(), var2612, var2612, var22, (), (), (), (), (), ()]
            } finally { // block id: 2630
                if (false) { [(), (), var2612, (), (), var22, (), (), var2612, ()] } else { [var2612, var2612, (), (), (), (), var2612, (), var2612, var2612] }
            };
            match (var198) {
                case caseVar2659 : Range<UInt16> =>
                    ();
                    var2663;
                    var2668--

                case _ =>
                    var2676 <<= ((var2676) & 7);
                    ()

                case _ : Array<Array<UInt8>> =>
                    var22;
                    ()

                case _ =>
                    (((120&127)..=(114&127):(5|1)), Option<UInt8>.None, [var2612, var2612, (), (), var22, var22, var2700, var2700, (), var22]);
                    ();
                    ()

                case _ =>
                    var var2711 : Int16 = Int16(UInt8(2));
                    var2711 ^= Int16(-32)

            };
            ()
        } finally { // block id: 2716

        }
    }
;
    public init(param1957 : (Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String), param1958 : Float32, optionalParam1959 ! : Option<Int32> = Option<Int32>.None, optionalParam1961 ! : Range<Int8> = ((Int8(-106)&127)..=(Int8(61)&127):(9|1))) { // block id: 1963
        var1028.var1968++;
        try { // block id: 1971
            (match (Option<Unit>.None) {
                case Some(num) => num
                case None => ()
            });
            var var2007 : Array<Unit> = [(), (), (), (), (), (), (), (), (), ()];
            match ([(), (), (), (), (), (), (), (), (), ()]) {
                case caseVar1983 : Range<UInt64> =>
                    [var22, var22, (), var22, (), (), (), var22, (), var22]

                case _ =>
                    ();
                    var var2001 : Int32 = Int32(65);
                    var2001 %= ((var36) | 1);
                    if (true) { var2007 } else { var2007 }

            };
            let var2021 : Array<Class201> = Array<Class201>(10){ i => Class201() };
            var2021
        } finally { // block id: 2224
            func2226();
            func2303()
        }
    }
;
    public init(optionalParam402 ! : UInt16 = UInt16(86), namedParam404 ! : UInt64, namedParam405 ! : Range<Int8>, optionalParam406 ! : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(44.0), r'Z', Int32(34), (match (Class201()) {
        case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
        case _ => Option<Range<Int16>>.None
    }), ((Int16(-83)&127)..(Int16(30)&127):((-102)|1)), ((Int32(101)&127)..=(Int32(Int8(UInt8(246)))&127):((60|1))))) { // block id: 420
        func422(optionalParam402);
        match (try { // block id: 5402
                [UInt8(242), UInt8(97), var4352, var4352, UInt8(34), var2464, UInt8(220), UInt8(86), var2464, var2464]
            } catch (e: Exception) { // block id: 5414
                UInt32(85);
                var236 += (-9);
                [var4352, var4352, UInt8(229), var4352, UInt8(200), UInt8(237), var2464, UInt8(189), UInt8(229), UInt8(66)]
            }) {
            case _ =>
                var var5433 : Option<Interface204> = (match (([UInt64(2), UInt64(53), UInt64(147), UInt64(27), UInt64(134), UInt64(198), UInt64(190), UInt64(118), UInt64(151), UInt64(198)], UInt16(Int8(UInt8(164))), (UInt32(UInt8(34)), UInt32(UInt32(4)), r'd', ###"pLk|5zfTHH"###, UInt8(UInt8(70)), r'u', ((UInt64(139)&127)..(UInt64(213)&127):(((-40)|1))), ((UInt32(196)&127)..(UInt32(242)&127):((115|1)))), (true, ((Int32(59)&127)..=(Int32(-13)&127):((-14)|1)), [UInt64(109), UInt64(127), UInt64(242), UInt64(190), UInt64(223), UInt64(17), UInt64(51), UInt64(191), UInt64(47), UInt64(141)]), ".OkxpXS]TA")) {
                    case newVar: Interface204 => Option<Interface204>.Some(newVar)
                    case _ => Option<Interface204>.None
                });
                var5433;
                var2048

        }
    }

    public func isClosed(): Bool { return false }
    public func close(): Unit {}
}


private func func2890(param427 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), namedParam428 ! : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)) : UInt16 { // block id: 429
    let var431 : Range<UInt8> = ((UInt8(155)&127)..=(UInt8(81)&127):((-5)|1));
    var431;
    let var453 : UInt64 = UInt64(Int8(Int8(UInt8(Int8(-30)))));
    var loopTimeVar462 : Int64 = 0;
    while ((try { // block id: 435
        (-4.0);
        !true
    } catch (_) { // block id: 439
        var var445 : Int8 = Int8(Int8(UInt8(84)));
        if (var42) { ((Int8(2)&127)..(Int8(-2)&127):((-77)|1)) } else { ((var445&127)..(var445&127):((var236|1))) } ;
        var453 > var453
    }) && loopTimeVar462 < 100 ) {
        loopTimeVar462++;

    };
    var var548 : String = "Dz]T&+nYZM";
    let var561 : Int64 = 77;
    let var571 : (Bool, Range<Int32>, Array<UInt64>) = ((match (UInt64(UInt32(Int32(-30)))) {
        case _: Option<(Bool, Range<Int32>, Array<UInt64>)> => true
        case _ => false
    }), ((Int32(124)&127)..=(Int32(3)&127):((-30)|1)), [UInt64(216), UInt64(179), UInt64(35), UInt64(191), UInt64(55), UInt64(222), UInt64(201), UInt64(121), UInt64(68), UInt64(247)]);
    match ((match (var106) {
            case newVar: (Bool, Range<Int32>, Array<UInt64>) => Option<(Bool, Range<Int32>, Array<UInt64>)>.Some(newVar)
            case _ => Option<(Bool, Range<Int32>, Array<UInt64>)>.None
        })) {
        case _ =>
            let var551 : UInt8 = UInt8(Int8(34));
            var var564 : Range<UInt32> = ((UInt32(UInt16(5))&127)..(UInt32(137)&127):(((-13)|1)));
            if (false) { var473 } else { ([UInt64(203), UInt64(151), UInt64(201), UInt64(115), UInt64(113), UInt64(100), UInt64(104), var453, var453, var453], var219, (UInt32(84), UInt32(222), r's', var548, var551, var555, ((var453&127)..=(UInt64(67)&127):((var561|1))), var564), var571, var548) }

    }[1]
}

public func func588(param589 : Range<Int64>) : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) { // block id: 590
    var592
}

private func func584(param585 : Range<UInt32>) : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) { // block id: 586
    let var639 : Int32 = Int32(UInt8(Int8(24)));
    let var681 : Option<(Bool, Range<Int32>, Array<UInt64>)> = Option<(Bool, Range<Int32>, Array<UInt64>)>.Some((false, ((Int32(47)&127)..=(Int32(Int8(0))&127):(((-75)|1))), [UInt64(52), UInt64((-44)), UInt64(122), UInt64(UInt64(206)), UInt64(194), UInt64(108), UInt64(167), UInt64(222), UInt64(212), UInt64(176)]));
    let var721 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(Float32(101.0)), r'd', Int32(Int8(Int8(-86))), (match (UInt64(UInt16(Int16(-32)))) {
        case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
        case _ => Option<Range<Int16>>.None
    }), ((Int16(Int16(UInt8(199)))&127)..(Int16(UInt16(64))&127):((80|1))), ((Int32(4)&127)..(Int32(119)&127):((-37)|1)));
    { lambdaParameter622 : Range<Int64> => var var628 : UInt8 = UInt8(Int8(UInt8(127))); (if (match (var628) {
        case _ =>
            var236 - 15;
            var639;
            var42

        case 184 =>
            var22;
            let var653 : UInt64 = UInt64(Int16(UInt8(UInt8(Int8(42)))));
            if (true) { ((UInt64(168)&127)..(var653&127):((var236|1))) } else { ((UInt64(113)&127)..=(UInt64(92)&127):(99|1)) } ;
            var42

        case 194 =>
            var var667 : Int64 = (-62);
            var667 < var236

        case _ =>
            ();
            var var675 : String = "&\"(K8B(&N(";
            var675 = "H[${var675}LJD0${var675}@y+g";
            true

    }) { // block id: 679
        var681;
        var42 ||= false;
        (Float32(5.0), r'L', Int32(19), Option<Range<Int16>>.None, ((Int16(-47)&127)..(Int16(61)&127):(107|1)), ((Int32(122)&127)..=(Int32(118)&127):((-38)|1)))
    } else { // block id: 713
        ();
        var628 /= ((var628) | 1);
        if (true) { var721 } else { (Float32(-25.0), r'7', Int32(26), Option<Range<Int16>>.None, ((Int16(-46)&127)..=(Int16(71)&127):(52|1)), ((Int32(-62)&127)..(Int32(-123)&127):(((-49)|1)))) }
    }, try { // block id: 752
        Int16(-74)
    } finally { // block id: 754
        let var757 : Int16 = Int16(89);
        var757 ^ Int16(-91)
    }) }(match (Class201()) {
        case _ =>
            var22;
            var var869 : (Range<UInt8>, Range<Int64>, Float64, Range<Int8>) = (((UInt8(166)&127)..(UInt8(132)&127):(0|1)), (((-67)&127)..=((-72)&127):((-44)|1)), (-59.0), ((Int8(-6)&127)..=(Int8(56)&127):((-7)|1)));
            if (false) { (((UInt8(185)&127)..(UInt8(147)&127):(1|1)), (((-84)&127)..(104&127):(3|1)), var255, ((Int8(-77)&127)..=(Int8(92)&127):((103|1)))) } else { var869 }

    }[1])
}

public func func1109(param1110 : Range<UInt64>, namedParam1111 ! : UInt8) : (Rune, Int64, Unit, UInt64) { // block id: 1112
    var var1119 : Array<Array<UInt8>> = [[UInt8(114), UInt8(Int8(-3)), UInt8(219), UInt8(163), UInt8(111), UInt8(Int8(-58)), UInt8(246), UInt8(75), UInt8(UInt8(Int8(39))), UInt8(UInt8(23))], [UInt8(Int8(-121)), UInt8(209), UInt8(131), UInt8(UInt8(147)), UInt8(UInt8(Int8(-107))), UInt8(Int8(-128)), UInt8(Int8(Int8(79))), UInt8(UInt8(88)), UInt8(UInt8(192)), UInt8(UInt8(133))], [UInt8(Int8(UInt8(46))), UInt8(223), UInt8(UInt8(UInt8(86))), UInt8(126), UInt8(133), UInt8(242), UInt8(16), UInt8(118), UInt8(220), UInt8(88)], [UInt8(95), UInt8(189), UInt8(UInt8(Int8(-85))), UInt8(101), UInt8(Int8(-61)), UInt8(121), UInt8(UInt8(226)), UInt8(UInt8(169)), UInt8(UInt8(52)), UInt8(Int8(Int8(94)))], [UInt8(59), UInt8(167), UInt8(159), UInt8(198), UInt8(123), UInt8(91), UInt8(66), UInt8(164), UInt8(164), UInt8(98)], [UInt8(180), UInt8(137), UInt8(168), UInt8(216), UInt8(70), UInt8(91), UInt8(19), UInt8(225), UInt8(136), UInt8(42)], [UInt8(Int8(-101)), UInt8(76), UInt8(Int8(-126)), UInt8(43), UInt8(64), UInt8(9), UInt8(UInt8(UInt8(154))), UInt8(92), UInt8(UInt8(26)), UInt8(UInt8(UInt8(183)))], [UInt8(Int8(UInt8(50))), UInt8(217), UInt8(Int8(UInt8(241))), UInt8(193), UInt8(UInt8(Int8(26))), UInt8(Int8(UInt8(108))), UInt8(51), UInt8(UInt8(UInt8(39))), UInt8(UInt8(UInt8(187))), UInt8(233)], [UInt8(16), UInt8(12), UInt8(96), UInt8(197), UInt8(159), UInt8(240), UInt8(209), UInt8(54), UInt8(114), UInt8(125)], [UInt8(99), UInt8(155), UInt8(169), UInt8(39), UInt8(7), UInt8(103), UInt8(223), UInt8(230), UInt8(103), UInt8(133)]];
    var var1249 : (Rune, Int64, Unit, UInt64) = (r'n', Int64(UInt32(Int32(Int32(108)))), (), UInt64(Int32(UInt16(137))));
    var var1283 : Unit = ();
    match (var1119[9][0]) {
        case _ : Array<Unit> =>
            if (var42) { Class201() } else { Class201() } ;
            if (true) { var1249 } else { (var555, 55, var22, var1265) }

        case 64 | 246 | 93 | 148 =>
            var42 ||= true;
            var1249

        case _ =>
            if (false) { var1249 } else { (r'n', var236, var1283, UInt64(179)) }

    }
}



private func func1477(param1478 : Range<UInt32>) : UInt8 { // block id: 1479
    let var1489 : (Range<Int64>, Option<UInt8>, Array<Unit>) = ((((-109)&127)..=((-63)&127):((-46)|1)), (match (Float64(Float32(-18.0))) {
        case newVar: UInt8 => Option<UInt8>.Some(newVar)
        case _ => Option<UInt8>.None
    }), [(), (), (), (), (), (), (), (), (), ()]);
    (match (var1489[1]) {
        case Some(num) => num
        case None => var1028.var1510
    }) >> (((match ((match (Option<(Bool, Range<Int32>, Array<UInt64>)>.Some((false, ((var36&127)..(var36&127):((65|1))), [UInt64(43), UInt64(157), UInt64(131), var1265, UInt64(180), UInt64(183), var1265, var1265, var1265, var1265]))) {
        case newVar: UInt8 => Option<UInt8>.Some(newVar)
        case _ => Option<UInt8>.None
    })) {
        case Some(num) => num
        case None => [UInt8(207), UInt8(168), UInt8(119), UInt8(87), UInt8(6), UInt8(113), UInt8(50), UInt8(94), UInt8(198), UInt8(49)][3]
    })) & 7)
}

private func func1414(param1415 : Option<(Bool, Range<Int32>, Array<UInt64>)>) : Unit { // block id: 1416
    var var1472 : UInt8 = UInt8(Int8(119));
    try { // block id: 1418
        var var1430 : Range<Int8> = ((Int8(Int8(UInt8(UInt8(119))))&127)..=(Int8(-58)&127):((Int64(UInt64(204))|1)));
        if (var42) { // block id: 1421
            var22;
            ()
        } else if (var42) { // block id: 1425
            var36 * Int32(-92);
            var1430;
            var22
        };
        try (resource = Class201()) { // block id: 1441
            var var1444 : Float64 = 1.0;
            var1444 *= (-58.0)
        } finally { // block id: 1447
            var22
        };
        let var1453 : UInt8 = UInt8(196);
        try { // block id: 1450
            Int16(-52);
            var1453;
            UInt8(25)
        } catch (e: Exception) { // block id: 1456
            Class201();
            var1453
        }
    } catch (_) { // block id: 1459
        (match (Option<Int32>.None) {
            case Some(num) => num
            case None => var36
        });
        ((), var1472)[0];
        func1477(((UInt32(88)&127)..(var87&127):((var236|1))))
    };
    try (resource = Class201()) { // block id: 1541

    } finally { // block id: 1542
        var22
    }
    return
}

public func func1289(param1290 : Range<UInt16>) : Array<UInt8> { // block id: 1291
    var var1314 : Int8 = Int8(UInt8(223));
    let var1324 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) = ((-120.0), ((Int8(-113)&127)..=(Int8(-108)&127):((67|1))), [UInt32(78), UInt32(91), UInt32(54), UInt32(130), UInt32(35), UInt32(17), UInt32(15), UInt32(84), UInt32(110), UInt32(91)], (r'P', (-7), (), UInt64(Int32(-26))), (Float32(109.0), r'c', Int32(Int16(Int16(86))), (match (60.0) {
        case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
        case _ => Option<Range<Int16>>.None
    }), ((Int16(Int8(-107))&127)..=(Int16(-79)&127):(((-3)|1))), ((Int32(UInt16(214))&127)..(Int32(UInt8(200))&127):((Int64(UInt8(214))|1)))), Float32(Float32(Float32(Float32(2.0)))), (r'z', 65, (), UInt64(38)), Int32(-24));
    var var1399 : Rune = r'n';
    match (if ((match (var106) {
            case _: Range<UInt32> => true
            case _ => false
        })) { match (var106) {
            case _ =>
                var198

        } } else { (if (false) { var198 } else { var198 } ) } ) {
        case _ =>
            -var255;
            var42 ||= true;
            var1314

        case _ : Int64 =>
            var22;
            let var1376 : (Rune, Int64, Unit, UInt64) = (r'U', 14, (), UInt64(UInt64(Int32(45))));
            var var1390 : Range<Int16> = ((Int16(10)&127)..=(Int16(-108)&127):(((-82)|1)));
            if (var42) { var1324 } else { (var255, ((var1314&127)..=(var1314&127):((var236|1))), var106, var1376, (var305, r'w', var36, var198, var1390, ((Int32(-97)&127)..=(Int32(-118)&127):(61|1))), var305, (var1399, var236, (), UInt64(49)), var36) } ;
            var1314

        case _ =>
            [UInt32(220), UInt32(78), UInt32(126), UInt32(254), UInt32(86), UInt32(48), UInt32(65), UInt32(228), UInt32(117), UInt32(239)];
            var1314

    };
    var loopTimeVar1553 : Range<UInt64> = ((UInt64(63)&127)..=(UInt64(Int8(-126))&127):((Int64(UInt32(250))|1)));
    let iter1410 = loopTimeVar1553.iterator()
    while (true) {
        match (iter1410.next()) {
            case None => break
            case Some(v) => match (v) {
                case i where (var42) => func1414(var1546);Int32(UInt16(144))
                case _ => continue
            }
        }
    }
;
    var var1624 : UInt8 = UInt8(177);
    let var1662 : Array<UInt8> = [UInt8(217), UInt8(246), UInt8(74), UInt8(200), UInt8(188), UInt8(32), UInt8(105), UInt8(130), UInt8(4), UInt8(34)];
    match (try { // block id: 1562
            var1265;
            let var1567 : (Range<Int64>, Option<UInt8>, Array<Unit>) = (((33&127)..=(81&127):(14|1)), Option<UInt8>.Some(UInt8(Int8(55))), [(), (), (), (), (), (), (), (), (), ()]);
            if (true) { var1567 } else { (((var236&127)..=(var236&127):((122|1))), var1590, [(), (), (), (), (), (), (), (), (), ()]) }
        } finally { // block id: 1593
            var1314 &= var1314;
            ();
            var var1599 : (Range<Int64>, Option<UInt8>, Array<Unit>) = ((((-47)&127)..=((-84)&127):(115|1)), Option<UInt8>.Some(UInt8(68)), [(), (), (), (), (), (), (), (), (), ()]);
            var1599
        }) {
        case (_ : Int8,_,_) =>
            var22;
            var var1610 : Array<UInt8> = [UInt8(78), UInt8(239), UInt8(129), UInt8(120), UInt8(254), UInt8(58), UInt8(249), UInt8(178), UInt8(50), UInt8(79)];
            var1610

        case (_ : Int64,caseVar1614 : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16),caseVar1615 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)) =>
            var var1633 : Array<UInt8> = Array<UInt8>(10){ i => UInt8(UInt8(69)) };
            if (var42) { [UInt8(133), UInt8(83), UInt8(8), var1624, UInt8(183), UInt8(215), UInt8(221), var1624, UInt8(189), var1624] } else { var1633 }

        case _ =>
            var var1656 : Array<UInt8> = [UInt8(170), UInt8(175), UInt8(17), UInt8(45), UInt8(182), UInt8(76), UInt8(140), UInt8(159), UInt8(130), UInt8(173)];
            var1656

        case _ : Class201 =>
            var1662

        case _ =>
            ();
            if (var42) { Option<UInt8>.Some(UInt8(200)) } else { Option<UInt8>.Some(var1624) } ;
            [UInt8(140), UInt8(131), UInt8(109), UInt8(23), UInt8(175), UInt8(166), UInt8(140), UInt8(110), UInt8(229), UInt8(53)]

    }
}

public func func942(namedParam943 ! : Float32, optionalParam944 ! : Range<UInt64> = ((UInt64(Int32(-77))&127)..(UInt64(57)&127):((106|1))), namedParam950 ! : Interface205, optionalParam951 ! : Bool = (match (Class201(Int32(Int16(116)), func588, ((UInt64(235)&127)..(UInt64(UInt32(35))&127):(((-16)|1))))) {
    case _: ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) => true
    case _ => false
})) : (Rune, Int64, Unit, UInt64) { // block id: 1024
    let var1056 : UInt64 = UInt64(5);
    func func1034(namedParam1035 ! : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>)) : Int64 { // block id: 1036
        var var1052 : Int64 = 22;
        let var1063 : (Rune, Int64, Unit, UInt64) = (r'2', 7, (), UInt64(59));
        let var1073 : (Rune, Int64, Unit, UInt64) = (r't', Int64(UInt8(204)), (), UInt64((-61)));
        match (if (true) { ((Int32(-14)&127)..(Int32(-1)&127):(114|1)) } else { ((var36&127)..(var36&127):((var236|1))) } ) {
            case _ : UInt8 =>
                (r'2', var1052, (), var1056)

            case _ : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) =>
                ###"H@B9\"5;yGS"###;
                var1063

            case _ =>
                ();
                var1073

        }[1];
        var236
    }
;
    let var1086 : UInt32 = UInt32(Int16(Int8(-120)));
    let var1101 : Range<UInt32> = ((UInt32(28)&127)..=(UInt32(205)&127):((Int64(UInt16(UInt8(218)))|1)));
    var1028.var1031 = func1034(namedParam1035 : (var87, var1086, r'g', var1092, UInt8(97), r'Y', ((var1056&127)..(var1056&127):((var236|1))), var1101));
    let var1675 : (Range<UInt16>) -> Array<UInt8> = func1289;
    func1109(((UInt64(171)&127)..=(UInt64(211)&127):(110|1)), namedParam1111 : (var1675(((UInt16(161)&127)..=(UInt16(87)&127):((-1)|1))))[6])
}



public func func2334(param2335 : UInt16) : Option<(Bool, Range<Int32>, Array<UInt64>)> { // block id: 2336
    var1546
}



public enum Enum2505 {
    defaultValue
}
private func func2490(param2491 : Unit) : Interface204 { // block id: 2492
    let var2512 : Unit = ();
    func func2496(optionalParam2497 ! : Float32 = Float32(-43.0), optionalParam2499 ! : Unit = (), optionalParam2501 ! : Interface204 = Class201()) : Interface204 { // block id: 2503
        match (Enum2505.defaultValue) {
            case _ : Int32 =>
                var2512;
                if (true) { optionalParam2501 } else { optionalParam2501 }

            case defaultValue =>
                (true, ((var36&127)..=(var2059&127):((var236|1))), [UInt64(144), UInt64(253), UInt64(46), UInt64(125), UInt64(85), UInt64(90), UInt64(137), UInt64(17), UInt64(161), UInt64(86)]);
                if (false) { optionalParam2501 } else { Class201() }

            case _ =>
                var22;
                if (true) { optionalParam2501 } else { optionalParam2501 }

        }
    }
;
    try { // block id: 2494
        func2496(optionalParam2499 : param2491, optionalParam2501 : var2541)
    } catch (_) { // block id: 2543
        var2541
    } finally { // block id: 2545
        let var2554 : Array<Unit> = [(), (), (), (), (), (), (), (), (), ()];
        var var2571 : Int16 = Int16(-66);
        match ((((UInt64(104)&127)..=(UInt64(17)&127):((var236|1))), ((UInt32(182)&127)..=(UInt32(8)&127):(24|1)), var2554, ((UInt8(167)&127)..(UInt8(27)&127):(29|1)), [UInt64(123), UInt64(127), UInt64(122), UInt64(195), UInt64(209), UInt64(71), UInt64(74), UInt64(221), UInt64(42), UInt64(1)], Int32(17))) {
            case (_ : String,_ : Unit,caseVar2561,caseVar2562,_ : Int64,caseVar2563) =>
                var var2567 : Int16 = Int16(UInt8(166));
                var2567 *= var2571;
                var2575 *= var2575;
                ((Int16(60)&127)..(Int16(38)&127):((-121)|1))

            case _ =>
                ((Int16(50)&127)..(Int16(-92)&127):(32|1))

        };
        ((Int8(32)&127)..=(Int8(-23)&127):(78|1));
        var2541
    }
}


private func func2449(param2450 : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>)) : Interface204 { // block id: 2451
    let var2485 : Option<Interface204> = Option<Interface204>.None;
    if (if (true) { // block id: 2455
        if (var2260) { ((), UInt8(195)) } else { ((), var2464) } ;
        var2464 >= var2464
    } else { // block id: 2469
        var2464 <= var2464
    }) { (match ((match (Option<Option<Interface204>>.Some(var2485)) {
        case Some(num) => num
        case None => Option<Interface204>.Some(Class201())
    })) {
        case Some(num) => num
        case None => (func2490(var22))
    }) } else { (match ((match (Option<Option<Interface204>>.None) {
        case Some(num) => num
        case None => Option<Interface204>.Some(Class201())
    })) {
        case Some(num) => num
        case None => func2490(var22)
    }) }
}





private func func2907(namedParam2908 ! : (UInt16) -> Option<(Bool, Range<Int32>, Array<UInt64>)>, namedParam2911 ! : (Rune, Int64, Unit, UInt64), optionalParam2912 ! : (Range<UInt32>) -> UInt8 = { lambdaParameter2915 : Range<UInt32> => UInt8(Int8(UInt8(UInt8(87)))) }) : Array<Unit> { // block id: 2923
    var var2938 : Option<Option<UInt16>> = (match (Int16(UInt16(144))) {
        case newVar: Option<UInt16> => Option<Option<UInt16>>.Some(newVar)
        case _ => Option<Option<UInt16>>.None
    });
    var var2945 : Option<UInt16> = (match (((), UInt8(Int8(UInt8(232))))) {
        case newVar: UInt16 => Option<UInt16>.Some(newVar)
        case _ => Option<UInt16>.None
    });
    (match ((match (if (false) { Option<Option<UInt16>>.None } else { var2938 } ) {
        case Some(num) => num
        case None => (match (Option<Option<UInt16>>.None) {
        case Some(num) => num
        case None => var2945
    })
    })) {
        case Some(num) => num
        case None => UInt16(63)
    });
    var2955 <<= ((try { // block id: 2958
        var2955 * Int16(65)
    } finally { // block id: 2962
        var2955
    }) & 7);
    let var3024 : Unit = ();
    let var3060 : Array<Unit> = [(), (), (), (), (), (), (), (), (), ()];
    (match (match (match (var2972) {
            case _ =>
                var36 & Int32(-95)

            case caseVar2982 =>
                Option<Int32>.None;
                var2059

            case caseVar2988 =>
                [var2464, var2464, var2464, UInt8(167), UInt8(243), var2464, UInt8(1), UInt8(67), UInt8(63), var2464];
                Option<Int32>.None;
                Int32(-126) | Int32(-4)

            case _ =>
                var22;
                Int32(1)

        }) {
        case _ : Option<Option<(Bool, Range<Int32>, Array<UInt64>)>> =>
            var var3019 : Unit = ();
            if (var42) { Option<Array<Unit>>.Some([var22, var22, var3019, var22, var22, var3024, (), (), var3019, var3019]) } else { Option<Array<Unit>>.None }

        case _ : Interface205 =>
            var var3038 : Option<Array<Unit>> = Option<Array<Unit>>.None;
            if (false) { Option<Array<Unit>>.None } else { var3038 }

        case -40 | -33 =>
            Option<Array<Unit>>.None

        case _ =>
            Option<Array<Unit>>.None

    }) {
        case Some(num) => num
        case None => try { // block id: 3048
        let var3052 : Option<Option<Interface204>> = Option<Option<Interface204>>.Some((match ((match (UInt32(UInt8(32))) {
            case newVar: Option<(Bool, Range<Int32>, Array<UInt64>)> => Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.Some(newVar)
            case _ => Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.None
        })) {
            case newVar: Interface204 => Option<Interface204>.Some(newVar)
            case _ => Option<Interface204>.None
        }));
        if (var2260) { var3052 } else { Option<Option<Interface204>>.None } ;
        var3060
    } finally { // block id: 3062
        var3060
    }
    })
}



private func func2903(param2904 : Option<Interface204>) : UInt32 { // block id: 2905
    let var3065 : (UInt16) -> Option<(Bool, Range<Int32>, Array<UInt64>)> = func2334;
    var var3077 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) = (39.0, ((Int8(-44)&127)..(Int8(-119)&127):((-65)|1)), [UInt32(177), UInt32(87), UInt32(105), UInt32(181), UInt32(196), UInt32(225), UInt32(38), UInt32(232), UInt32(247), UInt32(214)], (r'1', (-67), (), UInt64(251)), (Float32(Float32(-10.0)), r'N', Int32(UInt16(Int16(85))), Option<Range<Int16>>.None, ((Int16(-77)&127)..=(Int16(-51)&127):((-122)|1)), ((Int32(-46)&127)..=(Int32(51)&127):(117|1))), Float32(13.0), (r'4', (-34), (), UInt64(11)), Int32(62));
    func2907(namedParam2908 : var3065, namedParam2911 : (try { // block id: 3069
        var555
    } catch (_) { // block id: 3071
        r'8'
    }, var236, match (Class201(var3077)) {
        case _ : Range<UInt16> =>
            ()

        case _ =>
            ()

    }, var1265));
    let var3132 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(-5.0), r'0', Int32(24), Option<Range<Int16>>.None, ((Int16(-47)&127)..=(Int16(-21)&127):(18|1)), ((Int32(-106)&127)..=(Int32(12)&127):(104|1)));
    var var3168 : Option<Array<Unit>> = Option<Array<Unit>>.Some([(), (), (), (), (), (), (), (), (), ()]);
    let var3193 : Int32 = Int32(UInt16(UInt16(181)));
    let var3216 : Interface205 = Class201((Float64(Float64(121.0)), ((Int8(-23)&127)..=(Int8(-101)&127):((-68)|1)), [UInt32(170), UInt32(25), UInt32(162), UInt32(100), UInt32(232), UInt32(48), UInt32(161), UInt32(243), UInt32(204), UInt32(78)], (r's', 12, (), UInt64(219)), (Float32(-89.0), r'T', Int32(-126), Option<Range<Int16>>.Some(((Int16(-113)&127)..=(Int16(116)&127):(((-76)|1)))), ((Int16(-60)&127)..=(Int16(103)&127):(90|1)), ((Int32(-83)&127)..=(Int32(66)&127):((35|1)))), Float32(Float32(-64.0)), (r'j', 25, (), UInt64(UInt32(141))), Int32(-50)));
    let var3304 : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) = (UInt32(UInt8(Int8(64))), UInt32(UInt32(241)), r'R', """
g4;(k
vzxc3
""", UInt8(UInt8(Int8(Int8(-86)))), r'H', ((UInt64(36)&127)..=(UInt64(115)&127):(89|1)), ((UInt32(3)&127)..(UInt32(10)&127):(110|1)));
    let var3549 : (Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String) = ([UInt64(UInt32(65)), UInt64(Int16(Int16(85))), UInt64(UInt32(UInt16(40))), UInt64(Int16(-27)), UInt64(74), UInt64(Int16(-30)), UInt64(Int16(Int8(121))), UInt64(138), UInt64(5), UInt64(150)], UInt16(UInt16(Int8(Int8(-61)))), (UInt32(226), UInt32(Int32(UInt32(192))), r'K', """
BDA|o
Q3$V)
""", UInt8(34), r'o', ((UInt64(216)&127)..(UInt64(12)&127):(64|1)), ((UInt32(242)&127)..=(UInt32(63)&127):(18|1))), ((match (UInt16(Int16(-42))) {
        case _: Int32 => true
        case _ => false
    }), ((Int32(UInt32(248))&127)..=(Int32(Int16(120))&127):((8|1))), [UInt64(83), UInt64(38), UInt64(UInt8(162)), UInt64(Int16(-99)), UInt64(UInt64(224)), UInt64(Int16(-128)), UInt64((-17)), UInt64(222), UInt64(Int8(82)), UInt64(229)]), "9I)Kyx|x|,");
    if (if (match (var1028) {
        case caseVar3118 : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) =>
            (r'x', var236, var22, var2668);
            var22;
            var2260

        case caseVar3129 =>
            var3132;
            var var3142 : Int64 = (-8);
            var3142 ^= var236;
            true

        case caseVar3148 : (Range<Int64>, Option<UInt8>, Array<Unit>) =>
            var22;
            if (var42) { var3154 } else { ((Int32(40)&127)..(Int32(-78)&127):(108|1)) } ;
            Int32(-127) <= var36

        case _ =>
            var3168;
            var3182

    }) { // block id: 3184
        Int16(-82) != Int16(-111)
    } else if (var42) { // block id: 3189
        var2059 >= var3193
    } else { // block id: 3197
        (var3182, ((Int32(-81)&127)..=(Int32(-13)&127):((-119)|1)), [UInt64(95), var1265, var2668, UInt64(43), UInt64(228), var2668, UInt64(223), UInt64(60), UInt64(230), UInt64(147)]);
        var42
    }) { // block id: 3213
        var var3341 : UInt16 = UInt16(UInt16(35));
        let var3377 : Array<UInt64> = [UInt64(Int64(Int16(UInt16(65)))), UInt64(154), UInt64(Int16(Int8(46))), UInt64(UInt64(UInt64(210))), UInt64(14), UInt64(UInt16(188)), UInt64(Int16(24)), UInt64(108), UInt64(UInt32(86)), UInt64(188)];
        let var3403 : UInt32 = UInt32(Int8(UInt8(246)));
        let var3423 : String = """
zrn68
_:@`v
""";
        match (var3216) {
            case caseVar3254 =>
                ();
                ();
                if (false) { var473 } else { ([UInt64(216), UInt64(128), UInt64(244), UInt64(11), UInt64(45), UInt64(41), UInt64(42), UInt64(221), UInt64(98), UInt64(39)], UInt16(45), (var87, var87, var555, var1092, var2464, r'Q', ((UInt64(162)&127)..(UInt64(58)&127):((var236|1))), ((UInt32(108)&127)..(UInt32(51)&127):(((-63)|1)))), var3280, var1092) }

            case caseVar3293 =>
                Option<UInt8>.Some(var2464);
                var22;
                var var3300 : Array<UInt64> = [UInt64(118), UInt64(128), UInt64(143), UInt64(61), UInt64(23), UInt64(42), UInt64(107), UInt64(120), UInt64(184), UInt64(229)];
                (var3300, UInt16(176), var3304, (var3182, ((Int32(-61)&127)..(Int32(103)&127):(19|1)), [UInt64(201), UInt64(52), UInt64(195), UInt64(174), var2668, UInt64(86), UInt64(132), UInt64(101), var1265, var2668]), var1092)

            case _ : Float64 =>
                var22;
                var3341++;
                var var3352 : Array<UInt64> = Array<UInt64>(10){ i => UInt64(222) };
                ([UInt64(144), UInt64(51), UInt64(239), UInt64(201), UInt64(151), UInt64(32), UInt64(143), UInt64(113), UInt64(192), UInt64(121)], var219, var3304, (var2260, var3154, var3352), "a{iL$U9!sY)")

            case _ =>
                33.0;
                var var3413 : Range<UInt32> = ((UInt32(97)&127)..(UInt32(206)&127):((-84)|1));
                (var3377, var3341, (var87, var3403, var555, var1092, var2464, var555, ((UInt64(95)&127)..(UInt64(82)&127):(102|1)), var3413), (var3182, ((var2059&127)..(var36&127):(((-92)|1))), [UInt64(44), UInt64(67), UInt64(172), UInt64(42), UInt64(157), UInt64(139), UInt64(154), UInt64(136), UInt64(136), UInt64(74)]), var3423)

            case _ =>
                var473

        }
    } else if (var42) { // block id: 3429
        let var3451 : (Bool, Range<Int32>, Array<UInt64>) = ((match (UInt32(246)) {
            case _: Option<Unit> => true
            case _ => false
        }), ((Int32(UInt16(Int16(67)))&127)..(Int32(-6)&127):((Int64(UInt32(Int8(-67)))|1))), [UInt64(186), UInt64(206), UInt64(17), UInt64(131), UInt64(38), UInt64(56), UInt64(47), UInt64(117), UInt64(231), UInt64(102)]);
        (match (Option<(Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String)>.None) {
            case Some(num) => num
            case None => ([UInt64(185), var2668, var2668, var1265, var2668, var1265, var1265, var2668, var1265, var2668], UInt16(227), var3304, var3451, """
sM&CF
&KNCb
""")
        })
    } else { // block id: 3465
        if (false) { var2972 } else { var2972 } ;
        try { // block id: 3471
            ();
            Class201()
        } finally { // block id: 3474
            Class201()
        };
        var var3480 : Array<UInt64> = [UInt64(221), UInt64(190), UInt64(97), UInt64(177), UInt64(157), UInt64(165), UInt64(58), UInt64(136), UInt64(159), UInt64(146)];
        let var3508 : Range<UInt64> = ((UInt64(Int32(-102))&127)..(UInt64((-57))&127):((Int64(UInt8(Int8(Int8(26))))|1)));
        let var3519 : Range<UInt32> = ((UInt32(147)&127)..(UInt32(242)&127):((-47)|1));
        try { // block id: 3477
            (var3480, UInt16(200), var3304, (true, ((Int32(-113)&127)..(var2059&127):((var236|1))), var3480), var1092)
        } finally { // block id: 3492
            ((UInt64(227)&127)..(UInt64(32)&127):(24|1));
            var22;
            var var3523 : Bool = (match ([UInt64(46), UInt64(175), UInt64(Int64(UInt8(230))), UInt64(38), UInt64(229), UInt64(Int16(-99)), UInt64(Int32(Int16(-100))), UInt64(Int8(99)), UInt64(UInt8(24)), UInt64(UInt8(UInt8(82)))]) {
                case _: UInt32 => true
                case _ => false
            });
            if (true) { ([UInt64(131), UInt64(231), UInt64(220), UInt64(48), UInt64(193), UInt64(204), UInt64(234), UInt64(177), UInt64(198), UInt64(131)], UInt16(208), (UInt32(106), var87, var555, ">raLq~1oNv", var2464, r'b', var3508, var3519), (var3523, var3154, [UInt64(2), UInt64(235), UInt64(137), UInt64(53), UInt64(137), UInt64(242), UInt64(139), UInt64(30), UInt64(15), UInt64(7)]), ###"nr;?VMtXF/"###) } else { var3549 }
        }
    };
    var var3624 : Array<Array<UInt8>> = [[UInt8(199), UInt8(176), UInt8(212), UInt8(124), UInt8(251), UInt8(76), UInt8(145), UInt8(52), UInt8(146), UInt8(15)], [UInt8(46), UInt8(32), UInt8(51), UInt8(168), UInt8(129), UInt8(90), UInt8(248), UInt8(158), UInt8(74), UInt8(43)], [UInt8(85), UInt8(17), UInt8(70), UInt8(147), UInt8(197), UInt8(145), UInt8(187), UInt8(49), UInt8(24), UInt8(65)], [UInt8(245), UInt8(93), UInt8(189), UInt8(205), UInt8(130), UInt8(165), UInt8(121), UInt8(38), UInt8(103), UInt8(124)], [UInt8(148), UInt8(252), UInt8(75), UInt8(227), UInt8(126), UInt8(70), UInt8(204), UInt8(55), UInt8(43), UInt8(70)], [UInt8(228), UInt8(102), UInt8(110), UInt8(245), UInt8(234), UInt8(81), UInt8(89), UInt8(214), UInt8(190), UInt8(197)], [UInt8(237), UInt8(225), UInt8(229), UInt8(156), UInt8(223), UInt8(195), UInt8(122), UInt8(69), UInt8(156), UInt8(164)], [UInt8(236), UInt8(107), UInt8(60), UInt8(223), UInt8(185), UInt8(95), UInt8(16), UInt8(146), UInt8(202), UInt8(92)], [UInt8(194), UInt8(155), UInt8(58), UInt8(209), UInt8(33), UInt8(181), UInt8(226), UInt8(231), UInt8(69), UInt8(43)], [UInt8(116), UInt8(193), UInt8(114), UInt8(12), UInt8(181), UInt8(20), UInt8(130), UInt8(135), UInt8(88), UInt8(147)]];
    match (try { // block id: 3618
            ();
            if (true) { [[UInt8(189), UInt8(246), UInt8(154), UInt8(46), UInt8(58), UInt8(72), UInt8(0), UInt8(33), UInt8(212), UInt8(150)], [UInt8(103), UInt8(106), UInt8(151), UInt8(63), UInt8(153), UInt8(121), UInt8(115), UInt8(225), UInt8(159), UInt8(246)], [UInt8(113), UInt8(38), UInt8(6), UInt8(173), UInt8(71), UInt8(208), UInt8(252), UInt8(215), UInt8(156), UInt8(163)], [UInt8(29), UInt8(148), UInt8(69), UInt8(218), UInt8(105), UInt8(80), UInt8(94), UInt8(30), UInt8(59), UInt8(238)], [UInt8(239), UInt8(234), UInt8(103), UInt8(131), UInt8(225), UInt8(6), UInt8(63), UInt8(15), UInt8(124), UInt8(35)], [UInt8(51), UInt8(104), UInt8(182), UInt8(30), UInt8(72), UInt8(77), UInt8(38), UInt8(13), UInt8(139), UInt8(228)], [UInt8(24), UInt8(27), UInt8(233), UInt8(162), UInt8(35), UInt8(86), UInt8(91), UInt8(215), UInt8(8), UInt8(225)], [UInt8(200), UInt8(211), UInt8(14), UInt8(230), UInt8(158), UInt8(112), UInt8(11), UInt8(9), UInt8(217), UInt8(181)], [UInt8(28), UInt8(150), UInt8(187), UInt8(195), UInt8(143), UInt8(135), UInt8(234), UInt8(64), UInt8(188), UInt8(197)], [UInt8(218), UInt8(10), UInt8(167), UInt8(158), UInt8(159), UInt8(161), UInt8(56), UInt8(176), UInt8(83), UInt8(154)]] } else { var3624 }
        } catch (e: Exception) { // block id: 3626
            var3624
        } finally { // block id: 3628
            if (true) { var3624 } else { [[UInt8(191), UInt8(61), UInt8(17), UInt8(157), UInt8(59), UInt8(160), UInt8(103), UInt8(189), UInt8(198), UInt8(208)], [UInt8(171), UInt8(175), UInt8(64), UInt8(126), UInt8(205), UInt8(17), UInt8(197), UInt8(131), UInt8(76), UInt8(18)], [UInt8(225), UInt8(103), UInt8(103), UInt8(128), UInt8(248), UInt8(217), UInt8(204), UInt8(66), UInt8(208), UInt8(63)], [UInt8(18), UInt8(209), UInt8(22), UInt8(30), UInt8(127), UInt8(107), UInt8(95), UInt8(185), UInt8(160), UInt8(96)], [UInt8(200), UInt8(148), UInt8(118), UInt8(205), UInt8(97), UInt8(69), UInt8(0), UInt8(50), UInt8(25), UInt8(245)], [UInt8(162), UInt8(3), UInt8(250), UInt8(191), UInt8(104), UInt8(224), UInt8(102), UInt8(17), UInt8(154), UInt8(150)], [UInt8(69), UInt8(102), UInt8(62), UInt8(218), UInt8(94), UInt8(42), UInt8(192), UInt8(11), UInt8(123), UInt8(193)], [UInt8(112), UInt8(191), UInt8(32), UInt8(189), UInt8(38), UInt8(148), UInt8(241), UInt8(60), UInt8(129), UInt8(56)], [UInt8(157), UInt8(70), UInt8(109), UInt8(116), UInt8(233), UInt8(123), UInt8(103), UInt8(116), UInt8(240), UInt8(45)], [UInt8(179), UInt8(219), UInt8(81), UInt8(201), UInt8(245), UInt8(112), UInt8(254), UInt8(95), UInt8(82), UInt8(228)]] }
        }) {
        case _ =>
            var2955 *= var2955;
            var2668 += UInt64(68);
            UInt32(183)

        case _ =>
            ();
            var87

    } << (((match (try { // block id: 3653
        var22;
        Option<UInt32>.None
    } catch (_) { // block id: 3656
        Option<UInt32>.Some(var87)
    } finally { // block id: 3659
        var3661
    }) {
        case Some(num) => num
        case None => UInt32(52)
    })) & 7)
}


public func func2896(param2897 : Array<((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)>) : Bool { // block id: 2898
    func1414(match ((func2903(Option<Interface204>.Some(Class201())))) {
        case _ =>
            var22;
            Option<(Bool, Range<Int32>, Array<UInt64>)>.None

    });
    var var3680 : Option<Bool> = (match (((Int16(113)&127)..(Int16(77)&127):((-12)|1))) {
        case newVar: Bool => Option<Bool>.Some(newVar)
        case _ => Option<Bool>.None
    });
    var var3693 : Range<Int16> = ((Int16(79)&127)..=(Int16(22)&127):((-70)|1));
    var loopTimeVar3703 : Range<UInt64> = ((UInt64(173)&127)..(UInt64(Int8(Int8(-83)))&127):((Int64(UInt8(42))|1)));
    let iter3671 = loopTimeVar3703.iterator()
    while (true) {
        match (iter3671.next()) {
            case None => break
            case Some(v) => match (v) {
                case i where ((match (if (true) { var3680 } else { var3680 } ) {
                    case Some(num) => num
                    case None => (match (((Float32(-90.0), r'G', var2059, Option<Range<Int16>>.Some(((Int16(-61)&127)..(Int16(-105)&127):((-34)|1))), var3693, ((var2059&127)..(var2059&127):((var236|1)))), var3700)) {
                    case _: Range<Int64> => true
                    case _ => false
                })
                })) => ();
                case _ => continue
            }
        }
    }
;
    (match ((match ((if (true) { ((UInt8(5)&127)..=(UInt8(50)&127):((var236|1))) } else { var3720 } )) {
        case newVar: Bool => Option<Bool>.Some(newVar)
        case _ => Option<Bool>.None
    })) {
        case Some(num) => num
        case None => (match ((match ((((UInt8(122)&127)..(UInt8(141)&127):((109|1))), var3737, (-115.0), var3744)) {
        case newVar: Bool => Option<Bool>.Some(newVar)
        case _ => Option<Bool>.None
    })) {
        case Some(num) => num
        case None => false
    })
    })
}


public func func2890(param2891 : Array<((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)>) : Option<Unit> { // block id: 2892
    ();
    var var3755 : (Array<((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)>) -> Bool = func2896;
    var var3834 : ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) = ((Float32(60.0), r'L', Int32(20), Option<Range<Int16>>.None, ((Int16(-8)&127)..=(Int16(-87)&127):(((-107)|1))), ((Int32(-82)&127)..=(Int32(29)&127):((Int64(UInt8(82))|1)))), Int16(-21));
    let var3863 : Int64 = (-82);
    var var3909 : Int16 = Int16(UInt8(153));
    var var3930 : Option<Range<Int16>> = Option<Range<Int16>>.Some(((Int16(-36)&127)..=(Int16(-34)&127):((Int64(UInt8(218))|1))));
    let var3977 : Range<Int32> = ((Int32(-115)&127)..(Int32(-86)&127):((-1)|1));
    var var3996 : Int16 = Int16(67);
    var loopTimeVar4028 : Int64 = 0;
    while (((var3755(try { // block id: 3758
        ();
        ();
        [var592, var592, ((Float32(57.0), var555, var36, Option<Range<Int16>>.None, ((Int16(-81)&127)..=(Int16(-116)&127):((-75)|1)), ((Int32(-113)&127)..(var2059&127):(((-97)|1)))), var2955), var592, (var3779, Int16(49)), ((var305, var555, Int32(-85), Option<Range<Int16>>.None, ((var2955&127)..(Int16(-18)&127):((var236|1))), ((var36&127)..=(var36&127):(((-105)|1)))), Int16(11)), var592, var592, var592, var592]
    } catch (_) { // block id: 3821
        if (true) { param2891 } else { [var592, (var3779, var2955), (var3779, var3700), var3834, var3834, var592, ((Float32(3.0), r'W', var36, var198, ((var3700&127)..(Int16(-90)&127):((var3863|1))), var3154), Int16(25)), var3834, var3834, (var3779, var2955)] }
    } finally { // block id: 3872
        let var3895 : Int16 = Int16(UInt8(UInt8(165)));
        let var3917 : Int64 = 98;
        if (true) { [(var3779, Int16(-34)), (var3779, var2955), var592, ((var305, r'G', var2059, Option<Range<Int16>>.None, ((Int16(-118)&127)..(Int16(25)&127):((-15)|1)), ((Int32(-115)&127)..(Int32(-6)&127):((-66)|1))), var3700), (var3779, var3895), ((Float32(-9.0), r'D', var2059, Option<Range<Int16>>.Some(((Int16(34)&127)..=(Int16(-49)&127):(39|1))), ((Int16(-84)&127)..=(var3909&127):((var236|1))), ((Int32(-18)&127)..(Int32(24)&127):((var3917|1)))), var3700), var3834, (var3779, Int16(-80)), ((var305, var555, var2059, var3930, var3938, ((Int32(48)&127)..(Int32(-66)&127):(((-65)|1)))), var3895), var592] } else { [((var305, r'y', Int32(-50), Option<Range<Int16>>.None, ((Int16(16)&127)..(Int16(6)&127):((9|1))), ((Int32(68)&127)..=(Int32(-114)&127):(((-60)|1)))), var3909), var3834, var592, ((Float32(103.0), var555, var36, var198, ((Int16(-7)&127)..(Int16(-74)&127):(98|1)), var3977), Int16(123)), var592, ((Float32(72.0), r'h', Int32(94), var3930, var3938, ((Int32(19)&127)..=(var36&127):((var3917|1)))), var3909), (var3779, var3996), var592, ((Float32(-25.0), var555, Int32(74), var3930, var3938, ((Int32(-111)&127)..(Int32(56)&127):(106|1))), var3996), ((var305, r'I', var2059, Option<Range<Int16>>.None, ((Int16(-65)&127)..=(Int16(-86)&127):((-11)|1)), ((Int32(91)&127)..(Int32(87)&127):(29|1))), var3895)] }
    }))) && loopTimeVar4028 < 100 ) {
        loopTimeVar4028++;
        match (UInt16(203)) {
            case _ =>
                Option<UInt8>.None

            case _ =>
                var1590

        }
    };
    (match ((if ((match (Float32(124.0)) {
        case _: Option<Unit> => true
        case _ => false
    })) { (match (var4039) {
        case Some(num) => num
        case None => ((UInt32(12)&127)..=(UInt32(94)&127):(25|1))
    }) } else { ((var87&127)..(UInt32(215)&127):((var3863|1))) } )) {
        case newVar: Unit => Option<Unit>.Some(newVar)
        case _ => Option<Unit>.None
    })
}

private func func2854(param2855 : Array<Unit>) : Option<Unit> { // block id: 2856
    var22;
    var var4078 : Option<Option<Interface204>> = Option<Option<Interface204>>.None;
    var var4095 : Option<Unit> = (match (([UInt64(152), UInt64(56), UInt64(117), UInt64(57), UInt64(105), UInt64(70), UInt64(250), UInt64(19), UInt64(227), UInt64(20)], UInt16(109), (UInt32(137), UInt32(170), r'y', "-*K(^=*FSW", UInt8(Int8(42)), r'r', ((UInt64(136)&127)..=(UInt64(240)&127):((117|1))), ((UInt32(46)&127)..(UInt32(168)&127):(((-125)|1)))), (true, ((Int32(110)&127)..(Int32(-115)&127):(((-48)|1))), [UInt64(66), UInt64(184), UInt64(98), UInt64(93), UInt64(10), UInt64(98), UInt64(86), UInt64(82), UInt64(80), UInt64(111)]), "0}V+fLxl3~")) {
        case newVar: Unit => Option<Unit>.Some(newVar)
        case _ => Option<Unit>.None
    });
    try { // block id: 2859
        var loopTimeVar2865 : Range<UInt64> = ((UInt64(231)&127)..(UInt64(UInt64(Int64(UInt32(67))))&127):((Int64(Int32(-43))|1)));
        let iter2860 = loopTimeVar2865.iterator()
        while (true) {
            match (iter2860.next()) {
                case None => break
                case Some(v) => match (v) {
                    case i where (var42) => ();()
                    case _ => continue
                }
            }
        }
;
        match (var555) {
            case _ : Int32 =>
                ();
                ();
                (-26) & 115

            case _ =>
                (-42) ^ (-88)

        };
        func2890(var1691)
    } catch (e: Exception) { // block id: 4048
        if (var2260) { var1092 } else { var1092 } ;
        var var4057 : UInt32 = UInt32(81);
        var var4065 : Int8 = Int8(Int8(46));
        try (resource = Class201()) { // block id: 4054
            var4057 <<= ((var87) & 7);
            var219;
            var22
        } finally { // block id: 4062
            var4065 = var4069;
            var22
        };
        match (var4078) {
            case caseVar4082 =>
                var22;
                var22;
                Option<Unit>.Some(())

            case _ =>
                false;
                if (true) { Option<Unit>.None } else { var4095 }

        }
    }
}

public func func2378(param2379 : (Unit, UInt8)) : Option<Unit> { // block id: 2380
    true;
    var var2399 : UInt8 = UInt8(UInt8(132));
    var var2445 : UInt64 = UInt64(178);
    var var2598 : ((UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>)) -> Interface204 = { lambdaParameter2601 : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) => Class201((54.0, ((Int8(122)&127)..(Int8(101)&127):((-14)|1)), [UInt32(184), UInt32(3), UInt32(121), UInt32(227), UInt32(228), UInt32(173), UInt32(141), UInt32(61), UInt32(24), UInt32(125)], (r'0', 102, (), UInt64(38)), (Float32(-65.0), r'A', Int32(-33), Option<Range<Int16>>.None, ((Int16(118)&127)..(Int16(-88)&127):(86|1)), ((Int32(-6)&127)..=(Int32(-109)&127):((-9)|1))), Float32(Float32(104.0)), (r's', 15, (), UInt64(200)), Int32(Int16(2)))) };
    var var2753 : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) = (UInt32(UInt16(230)), UInt32(UInt8(UInt8(123))), r'C', "K@)wM]NpmL", UInt8(UInt8(183)), r'4', ((UInt64(221)&127)..(UInt64(74)&127):(94|1)), ((UInt32(UInt16(UInt16(56)))&127)..=(UInt32(UInt16(UInt16(209)))&127):(((-16)|1))));
    var var2789 : (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) = (Float64(Float32(77.0)), ((Int8(-80)&127)..(Int8(Int8(-97))&127):(((-108)|1))), [UInt32(250), UInt32(Int16(Int16(16))), UInt32(121), UInt32(UInt32(188)), UInt32(96), UInt32(UInt32(27)), UInt32(70), UInt32(UInt8(132)), UInt32(243), UInt32(Int16(-49))], (r'd', Int64(Int8(UInt8(147))), (), UInt64(Int8(32))), (Float32(Float32(Float32(87.0))), r'R', Int32(125), Option<Range<Int16>>.Some(((Int16(-32)&127)..(Int16(79)&127):((-20)|1))), ((Int16(63)&127)..=(Int16(UInt8(218))&127):((Int64(UInt64(115))|1))), ((Int32(Int32(-85))&127)..(Int32(-105)&127):((Int64(UInt8(229))|1)))), Float32(91.0), (r'M', Int64(UInt16(UInt8(177))), (), UInt64(250)), Int32(Int8(-119)));
    try { // block id: 2383
        Class201()
    } catch (e: Exception) { // block id: 2385
        try { // block id: 2387
            [UInt8(194), UInt8(1), UInt8(96), UInt8(44), UInt8(43), UInt8(236), UInt8(208), UInt8(34), UInt8(217), UInt8(192)]
        } finally { // block id: 2389
            var1092;
            var var2395 : UInt8 = UInt8(121);
            let var2404 : UInt8 = UInt8(157);
            var var2408 : UInt8 = UInt8(Int8(Int8(Int8(Int8(-96)))));
            [UInt8(246), UInt8(15), var2395, UInt8(50), var2399, var2399, var2404, UInt8(200), var2408, var2408]
        };
        match (var1028) {
            case _ =>
                var305 -= Float32(54.0)

            case _ : Range<Int16> =>
                ((UInt8(236)&127)..(var2399&127):((var236|1)));
                var236 <<= ((var236) & 7)

            case caseVar2435 =>

                var22

            case _ =>
                var2445 ^= var2445

        };
        var2598(var2753)
    } finally { // block id: 2774
        let var2781 : Option<Range<UInt8>> = Option<Range<UInt8>>.None;
        (match (var2781) {
            case Some(num) => num
            case None => ((UInt8(85)&127)..=(UInt8(223)&127):((-11)|1))
        });
        (match (Option<Interface204>.Some(Class201())) {
            case Some(num) => num
            case None => Class201(var2789)
        })
    };
    func2854(match (((Int16(105)&127)..=(Int16(-106)&127):(21|1))) {
        case caseVar4129 : Array<Class201> =>
            var4069 |= Int8(117);
            [var22, (), var22, var22, (), var22, var4142, (), (), var4142]

        case caseVar4149 =>
            (-102.0) ** Float64(Int32(var255) & 3);
            Option<Range<UInt32>>.Some(((UInt32(222)&127)..(UInt32(120)&127):(60|1)));
            var4157

        case caseVar4171 : Option<Range<UInt32>> =>
            var36 << ((Int32(63)) & 7);
            var4177;
            if (var3182) { var4157 } else { var4157 }

        case _ =>
            var2445 <<= ((UInt64(46)) & 7);
            var4157;
            let var4211 : Unit = ();
            if (false) { [var4211, var22, (), var4142, var22, var4211, (), (), (), ()] } else { var4157 }

    })
}



public func func2374(param2375 : Interface204) : Option<Unit> { // block id: 2376
    var var4224 : ((Unit, UInt8)) -> Option<Unit> = func2378;
    var var4237 : Option<Option<(Unit, UInt8)>> = Option<Option<(Unit, UInt8)>>.None;
    let var4240 : Option<(Unit, UInt8)> = Option<(Unit, UInt8)>.None;
    var4224((match ((match (var4237) {
        case Some(num) => num
        case None => var4240
    })) {
        case Some(num) => num
        case None => ((), UInt8(245))
    }))
}

public func func2343(param2344 : (Range<UInt8>, Range<Int64>, Float64, Range<Int8>), param2345 : Array<UInt8>, optionalParam2346 ! : (Range<UInt64>, Range<UInt32>, Array<Unit>, Range<UInt8>, Array<UInt64>, Int32) = (((UInt64(UInt64(172))&127)..=(UInt64(60)&127):((Int64(UInt64((-50)))|1))), ((UInt32(105)&127)..(UInt32(195)&127):(27|1)), [(), (), (), (), (), (), (), (), (), ()], ((UInt8(28)&127)..(UInt8(8)&127):(47|1)), [UInt64(138), UInt64(114), UInt64(209), UInt64(87), UInt64(14), UInt64(24), UInt64(190), UInt64(158), UInt64(210), UInt64(211)], Int32(-82))) : (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>) { // block id: 2370
    var22;
    var var4293 : Option<Int32> = Option<Int32>.Some(Int32(45));
    (match ((func2374(Class201(var4248)))) {
        case Some(num) => num
        case None => (var2059 ^= (match (var4293) {
        case Some(num) => num
        case None => Int32(39)
    }))
    });
    var var4313 : Bool = (match ((Float32(70.0), r'B', Int32(Int8(7)), (match (Class201()) {
        case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
        case _ => Option<Range<Int16>>.None
    }), ((Int16(UInt8(78))&127)..(Int16(UInt8(102))&127):((27|1))), ((Int32(-86)&127)..=(Int32(-67)&127):((-72)|1)))) {
        case _: () -> Range<Int16> => true
        case _ => false
    });
    (UInt32(UInt8(165)) | UInt32(173), if (try { // block id: 4304
        var3182 ||= var3182;
        var2260
    } catch (e: Exception) { // block id: 4309
        ();
        !var4313
    } finally { // block id: 4329
        var305;
        false
    }) { // block id: 4332
        var87
    } else { // block id: 4334
        var4142;
        ();
        var87
    }, var555, var1092, (match (Option<UInt8>.None) {
        case Some(num) => num
        case None => if (true) { // block id: 4344
        var2464
    } else { // block id: 4346
        ();
        var219 += UInt16(130);
        var4352
    }
    }), if ((match (var4357) {
        case _: Enum2505 => true
        case _ => false
    })) { // block id: 4379
        ();
        r'U'
    } else { // block id: 4382
        var22;
        var555
    }, var4386, ((UInt32(209)&127)..=(UInt32(131)&127):(34|1)))
}

public func func2339(param2340 : Int16) : Option<(Bool, Range<Int32>, Array<UInt64>)> { // block id: 2341
    var var4476 : (Range<UInt64>, Range<UInt32>, Array<Unit>, Range<UInt8>, Array<UInt64>, Int32) = (((UInt64(UInt32(220))&127)..=(UInt64(Int64(Int32(39)))&127):((Int64(Int64(Int8(-122)))|1))), ((UInt32(Int32(Int16(-43)))&127)..(UInt32(85)&127):(((-57)|1))), [(), (), (), (), (), (), (), (), (), ()], ((UInt8(218)&127)..=(UInt8(109)&127):((-84)|1)), [UInt64(46), UInt64(UInt16(35)), UInt64(25), UInt64(Int16(UInt16(139))), UInt64(46), UInt64(26), UInt64(UInt16(162)), UInt64(211), UInt64(Int32(-71)), UInt64(145)], Int32(UInt8(Int8(UInt8(148)))));
    func2343((((UInt8(165)&127)..(UInt8(33)&127):(42|1)), ((112&127)..=((-59)&127):((-28)|1)), var2575, try { // block id: 4394
        ((Int8(40)&127)..(Int8(-31)&127):((-103)|1))
    } catch (_) { // block id: 4396
        var22;
        var4352 << ((UInt8(60)) & 7);
        var3744
    }), match (try { // block id: 4404
            var2668 &= var1265;
            var var4411 : (Range<UInt64>, Range<UInt32>, Array<Unit>, Range<UInt8>, Array<UInt64>, Int32) = (((UInt64(140)&127)..=(UInt64(251)&127):((-12)|1)), ((UInt32(245)&127)..(UInt32(17)&127):((-35)|1)), [(), (), (), (), (), (), (), (), (), ()], ((UInt8(83)&127)..=(UInt8(245)&127):(57|1)), [UInt64(25), UInt64(27), UInt64(67), UInt64(1), UInt64(99), UInt64(26), UInt64(246), UInt64(22), UInt64(245), UInt64(248)], Int32(85));
            if (false) { var4411 } else { (((UInt64(17)&127)..=(UInt64(139)&127):(37|1)), ((var87&127)..=(var87&127):(((-35)|1))), var4157, ((UInt8(69)&127)..=(UInt8(126)&127):((-111)|1)), [var2668, UInt64(108), var2668, UInt64(99), var2668, UInt64(4), UInt64(110), UInt64(228), UInt64(105), var1265], Int32(-83)) }
        } finally { // block id: 4449
            if (var2260) { Option<Range<UInt8>>.None } else { var4454 } ;
            var22;
            if (true) { (((var2668&127)..(UInt64(67)&127):((var236|1))), ((UInt32(72)&127)..=(UInt32(220)&127):((19|1))), [(), (), (), (), (), (), (), (), (), ()], ((UInt8(76)&127)..=(UInt8(181)&127):((-94)|1)), [UInt64(72), UInt64(219), UInt64(138), UInt64(64), UInt64(193), UInt64(243), UInt64(146), UInt64(235), UInt64(54), UInt64(151)], var4473) } else { var4476 }
        }) {
        case _ =>
            var305 = var305;
            var236 |= var236;
            [UInt8(252), UInt8(34), UInt8(114), UInt8(78), UInt8(20), UInt8(225), UInt8(133), UInt8(195), UInt8(2), UInt8(254)]

        case _ =>
            if (var42) { [UInt8(210), UInt8(126), UInt8(136), UInt8(114), UInt8(211), UInt8(58), UInt8(93), UInt8(33), UInt8(178), UInt8(185)] } else { [var2464, UInt8(16), var2464, var2464, UInt8(27), var4352, var2464, UInt8(144), var4352, var2464] }

    });
    try (resource = Class201()) { // block id: 4542
        match (((Int16(-68)&127)..(Int16(93)&127):(11|1))) {
            case _ : Array<UInt32> =>
                ((UInt8(1)&127)..(UInt8(47)&127):((-68)|1));
                ()

            case caseVar4554 : Array<Array<UInt8>> =>
                [(), (), (), (), (), (), (), (), (), ()];
                var305;
                var var4560 : UInt8 = UInt8(Int8(Int8(-2)));
                var4560 %= ((var4560) | 1)

            case caseVar4567 : Rune =>
                var2668 *= UInt64(196)

            case _ =>
                ()

        };
        var2955 ^= param2340
    } finally { // block id: 4578
        (match (Option<Unit>.None) {
            case Some(num) => num
            case None => var4142
        })
    };
    var1546
}



private func func4586(param4587 : UInt16) : Int16 { // block id: 4588
    var loopTimeVar4602 : Range<UInt64> = ((UInt64(162)&127)..=(UInt64(171)&127):((Int64(Int64(UInt16(UInt8(98))))|1)));
    let iter4589 = loopTimeVar4602.iterator()
    while (true) {
        match (iter4589.next()) {
            case None => break
            case Some(v) => match (v) {
                case i where (try { // block id: 4591
                    [UInt32(18), UInt32(180), UInt32(76), UInt32(207), UInt32(226), UInt32(107), UInt32(166), UInt32(81), UInt32(152), UInt32(33)];
                    false
                } catch (_) { // block id: 4594
                    var2668 += UInt64(249);
                    var22;
                    false
                }) => break
                case _ => continue
            }
        }
    }
;
    let var4656 : Option<Array<Bool>> = Option<Array<Bool>>.Some([false, true, false, false, false, true, false, false, true, true]);
    let var4724 : Option<Option<UInt16>> = Option<Option<UInt16>>.None;
    match ((match (match (Class201((var255, var3744, var106, (r'5', var236, var4142, UInt64(9)), (var305, var555, Int32(82), Option<Range<Int16>>.None, ((var2955&127)..=(Int16(44)&127):((var236|1))), ((var2059&127)..(Int32(115)&127):((var236|1)))), var305, (r's', var4644, var22, var2668), var2059))) {
            case _ =>
                var4352;
                if (true) { var4656 } else { Option<Array<Bool>>.None }

            case _ =>
                ((UInt32(89)&127)..(var87&127):((var236|1)));
                if (var3182) { Option<UInt8>.Some(var4352) } else { var1590 } ;
                if (true) { Option<Array<Bool>>.Some([false, var4678, false, var3182, false, var3182, true, var42, var3182, false]) } else { Option<Array<Bool>>.None }

            case _ =>
                Option<Array<Bool>>.Some([true, var3182, var42, true, false, var4678, true, var42, false, var4678])

        }) {
            case Some(num) => num
            case None => if (false) { [true, false, true, true, true, true, true, false, true, false] } else { [false, false, false, false, true, false, false, true, true, true] }
        })) {
        case _ =>
            ((UInt64(48)&127)..=(UInt64(51)&127):((-79)|1));
            var4454

        case caseVar4715 =>
            let var4719 : Bool = true;
            if (var4719) { Option<Option<UInt16>>.Some(var4177) } else { var4724 } ;
            let var4727 : (Range<Int64>, Option<UInt8>, Array<Unit>) = (((96&127)..((-6)&127):(15|1)), (match ((match ((match (((UInt16(38)&127)..(UInt16(219)&127):((76|1)))) {
                case _: Option<Array<Bool>> => true
                case _ => false
            })) {
                case newVar: Interface204 => Option<Interface204>.Some(newVar)
                case _ => Option<Interface204>.None
            })) {
                case newVar: UInt8 => Option<UInt8>.Some(newVar)
                case _ => Option<UInt8>.None
            }), [(), (), (), (), (), (), (), (), (), ()]);
            var4727;
            if (true) { Option<Range<UInt8>>.None } else { Option<Range<UInt8>>.Some(((UInt8(97)&127)..(var2464&127):((var236|1)))) }

        case caseVar4758 =>
            var2308;
            if (true) { var4764 } else { var4454 }

        case _ =>
            Option<Range<UInt8>>.None

    };
    match ((match (Option<Int16>.Some(var3700)) {
            case Some(num) => num
            case None => Int16(-104)
        })) {
        case 45 =>
            var219;
            var2668 /= ((UInt64(224)) | 1);
            Int16(33)

        case 12 | -68 =>
            Int16(-44)

        case _ =>
            var22;
            var4142;
            Int16(-114)

    }
}

private func func2329(param2330 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>)) : Bool { // block id: 2331
    let var4584 : (Int16) -> Option<(Bool, Range<Int32>, Array<UInt64>)> = func2339;
    let var4797 : (UInt16) -> Int16 = func4586;
    match (((composition(var4797,var4584))(var219 / ((var219) | 1)))) {
        case _ =>
            Float32(92.0)

        case caseVar4808 : Option<Option<Interface204>> =>
            var4811;
            ();
            var305

        case _ : (Bool, Range<Int32>, Array<UInt64>) =>
            var305

        case _ =>
            var var4824 : Float32 = Float32(Float32(Float32(40.0)));
            var305 /= Float32((Int32(var4824)) | 1);
            var305

    };
    false
}



public func func422(param423 : UInt16) : UInt16 { // block id: 424
    let var877 : Range<UInt32> = ((UInt32(214)&127)..(UInt32(198)&127):(5|1));
    let var912 : (Rune, Int64, Unit, UInt64) = (r'N', Int64(Int8(Int8(UInt8(112)))), (), UInt64(114));
    let var1685 : Interface205 = Class201();
    func func891(namedParam892 ! : Rune, optionalParam893 ! : Int64 = Int64(UInt64(106)), namedParam896 ! : Int8, namedParam897 ! : (Range<Int64>) -> ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)) : Array<((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16)> { // block id: 900
        var loopTimeVar905 : Int64 = 0;
        do {
            loopTimeVar905++;

        } while ((true) && loopTimeVar905 < 100 ) ;
        var loopTimeVar1689 : Int64 = 0;
        do {
            loopTimeVar1689++;
            var22;
            func942(namedParam943 : var305, optionalParam944 : ((UInt64(177)&127)..=(var1265&127):((var236|1))), namedParam950 : var1685, optionalParam951 : var42)
        } while ((if (var42) { // block id: 909
            ();
            var912;
            true
        } else if (try { // block id: 923
            false
        } finally { // block id: 925
            false
        }) { // block id: 927
            Int8(36) % ((Int8(-44)) | 1);
            let var933 : Int16 = Int16(UInt8(82));
            var933 <= Int16(57)
        } else { // block id: 937
            true
        }) && loopTimeVar1689 < 100 ) ;
        var1691
    }
;
    let var1857 : Unit = ();
    let var1864 : Class201 = Class201();
    let var1954 : Class201 = Class201(([UInt64(Int8(68)), UInt64(UInt32(193)), UInt64(35), UInt64(102), UInt64(99), UInt64((-97)), UInt64(89), UInt64(UInt32(105)), UInt64(196), UInt64(UInt64(214))], UInt16(UInt8(178)), (UInt32(Int8(-8)), UInt32(97), r'N', """
WBN=R
@(k7p
""", UInt8(Int8(-72)), r'l', ((UInt64(165)&127)..(UInt64(122)&127):(((-35)|1))), ((UInt32(73)&127)..=(UInt32(181)&127):(((-120)|1)))), (true, ((Int32(-59)&127)..=(Int32(-50)&127):((-124)|1)), [UInt64(203), UInt64(18), UInt64(172), UInt64(191), UInt64(113), UInt64(129), UInt64(240), UInt64(203), UInt64(123), UInt64(7)]), ###".c<,O@umTI"###), Float32(Float32(Float32(Float32(47.0)))));
    let var5048 : Range<Int8> = ((Int8(-58)&127)..=(Int8(-42)&127):((Int64(UInt16(231))|1)));
    func func882(namedParam883 ! : Interface206, namedParam884 ! : Range<Int64>, namedParam885 ! : Bool) : Class201 { // block id: 886
        var22;
        func891(namedParam892 : match (Int8(-84)) {
            case caseVar1851 : (Range<UInt64>, Range<UInt32>, Array<Unit>, Range<UInt8>, Array<UInt64>, Int32) =>
                r'e'

            case _ =>
                var1857;
                var219--;
                r'Q'

        }, optionalParam893 : var1864.var1867, namedParam896 : var1028.var1872, namedParam897 : func588)[8];
        var var1889 : Array<Class201> = Array<Class201>(10){ i => Class201() };
        match (var198) {
            case caseVar1882 =>
                if (true) { var1590 } else { Option<UInt8>.None } ;
                var1889

            case caseVar1903 : (Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String) =>
                var var1919 : Array<Class201> = [Class201(), Class201(), Class201(), Class201(), Class201(), Class201(), Class201(), Class201(), Class201(), Class201()];
                if (namedParam885) { [Class201(), var1028, var1864, var1028, Class201(), var1028, Class201(), Class201(), Class201(), Class201()] } else { var1919 }

            case caseVar1933 =>
                var42 = false;
                let var1941 : Interface204 = Class201();
                if (false) { var1941 } else { var1941 } ;
                if (namedParam885) { [var1028, var1864, var1864, Class201(), Class201(), var1954, Class201(), Class201(), Class201(([var1265, UInt64(127), var2668, var2668, UInt64(155), UInt64(201), UInt64(161), var1265, UInt64(92), var1265], var219, (UInt32(75), var87, var555, var1092, var2464, var555, ((UInt64(193)&127)..=(UInt64(102)&127):(5|1)), ((UInt32(16)&127)..=(UInt32(131)&127):(92|1))), var3280, """
l*.`x
\\9t(k
"""), var305), var1954] } else { var1889 }

            case _ =>
                var4811;
                var var5008 : Option<Int32> = (match (Option<Bool>.Some((match (Option<(Array<UInt64>, UInt16, (UInt32, UInt32, Rune, String, UInt8, Rune, Range<UInt64>, Range<UInt32>), (Bool, Range<Int32>, Array<UInt64>), String)>.Some(([UInt64(232), UInt64(212), UInt64(140), UInt64(246), UInt64(135), UInt64(173), UInt64(99), UInt64(188), UInt64(149), UInt64(50)], UInt16(57), (UInt32(210), UInt32(159), r'V', """
AH6HJ
6d-dA
""", UInt8(238), r'd', ((UInt64(176)&127)..(UInt64(57)&127):(((-103)|1))), ((UInt32(68)&127)..(UInt32(119)&127):(((-34)|1)))), (true, ((Int32(-84)&127)..=(Int32(71)&127):(46|1)), [UInt64(66), UInt64(213), UInt64(119), UInt64(44), UInt64(190), UInt64(214), UInt64(217), UInt64(34), UInt64(33), UInt64(180)]), """
xr[~!
osS *
"""))) {
                    case _: (Range<Int64>) -> ((Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Int16) => true
                    case _ => false
                }))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                });
                if (false) { [Class201(var473, var305, optionalParam1959 : var5008), Class201(), var1028, var1864, var1028, var1954, var1864, Class201(), Class201(var473, Float32(-8.0), optionalParam1959 : var5008, optionalParam1961 : var5048), var1864] } else { var1889 }

        }[6]
    }
;
    let var5394 : ((UInt16) -> Option<(Bool, Range<Int32>, Array<UInt64>)>, (Rune, Int64, Unit, UInt64), (Range<UInt32>) -> UInt8) -> Array<Unit> = func2907;
    func2890(func584(var877)[0], namedParam428 : func882(namedParam883 : Class201(([UInt64(188), UInt64(210), UInt64(76), UInt64(106), UInt64(135), UInt64(185), UInt64(92), UInt64(59), UInt64(11), UInt64(169)], UInt16(140), (UInt32(209), UInt32(140), var5065, ###"W`wO2Q[wb^"###, var2464, var555, var4386, ((UInt32(15)&127)..=(var87&127):((90|1)))), var3280, var1092), Float32(-110.0), optionalParam1959 : var5079), namedParam884 : (((-21)&127)..=(33&127):((-116)|1)), namedParam885 : true).func5084(namedParam5085 : var5394, namedParam5090 : func2339, namedParam5093 : Enum2505.defaultValue))
}

public func func194(param195 : Float64) : UInt8 { // block id: 196
    var198;
    func func208() : Class201 { // block id: 209
        false;
        Class201()
    }
;
    func208().var213;
    let var258 : Range<Int8> = ((Int8(121)&127)..=(Int8(96)&127):(54|1));
    let var330 : Class201 = Class201();
    let var347 : Int8 = Int8(Int8(Int8(Int8(-72))));
    let var5609 : UInt16 = UInt16(Int8(63));
    let var5701 : (Unit, UInt8) = ((), UInt8(UInt8(Int8(UInt8(53)))));
    let var5736 : Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)> = (match (r'A') {
        case newVar: (Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32) => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.Some(newVar)
        case _ => Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.None
    });
    try { // block id: 216

        match (Option<Range<Int16>>.None) {
            case _ =>
                var var229 : Int64 = (-91);
                var229--

            case _ : Option<Range<Int16>> =>
                var236 <<= (((-80)) & 7)

            case _ =>
                var22

        };
        let var267 : UInt32 = UInt32(UInt32(150));
        let var285 : (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>) = (Float32(Float32(Float32(Float32(-100.0)))), r'1', Int32(Int32(38)), Option<Range<Int16>>.None, ((Int16(UInt16(Int16(-62)))&127)..=(Int16(68)&127):((Int64(UInt8(UInt8(189)))|1))), ((Int32(21)&127)..=(Int32(-61)&127):((-70)|1)));
        let var398 : Option<(Bool, Range<Int32>, Array<UInt64>)> = (match (Class201(namedParam404 : UInt64(193), namedParam405 : ((Int8(108)&127)..(Int8(85)&127):(114|1)), optionalParam406 : (Float32(Float32(49.0)), r'5', Int32(-16), (match (Int16(-107)) {
            case newVar: Range<Int16> => Option<Range<Int16>>.Some(newVar)
            case _ => Option<Range<Int16>>.None
        }), ((Int16(111)&127)..(Int16(109)&127):((74|1))), ((Int32(-26)&127)..=(Int32(77)&127):((-114)|1))))) {
            case newVar: (Bool, Range<Int32>, Array<UInt64>) => Option<(Bool, Range<Int32>, Array<UInt64>)>.Some(newVar)
            case _ => Option<(Bool, Range<Int32>, Array<UInt64>)>.None
        });
        func func243(optionalParam244 ! : UInt8 = UInt8(UInt8(107))) : UInt8 { // block id: 247
            var var276 : Rune = r'B';
            var var281 : UInt64 = UInt64(Int16(-113));
            var var356 : (Rune, Int64, Unit, UInt64) = (r'U', 35, (), UInt64(UInt8(UInt8(77))));
            match ((var255, var258, [UInt32(68), var87, UInt32(134), UInt32(68), var87, var267, var87, var267, UInt32(161), var267], (var276, (-31), (), var281), var285, var305, (r'I', var236, (), UInt64(37)), var36)[4][3]) {
                case _ =>
                    Class201()

                case _ =>
                    var var324 : Int16 = Int16(Int8(Int8(64)));
                    var324 |= var324;
                    var330

                case _ =>
                    if (false) { var330 } else { Class201() }

                case caseVar341 : Range<Int64> =>
                    (param195, ((var347&127)..=(var347&127):((var236|1))), var106, var356, var285, var305, var356, Int32(-34));
                    Class201()

                case _ =>
                    // var305 %= Float32((Int32(Float32(-59.0))) | 1);
                    if (var42) { [UInt32(123), var267, var267, var267, var267, UInt32(236), UInt32(132), UInt32(230), var267, var87] } else { var106 } ;
                    var330

            };
            var loopTimeVar5482 : Int64 = 0;
            do {
                loopTimeVar5482++;

            } while (((match (var398) {
                case Some(num) => num
                case None => var3280
            })[0]) && loopTimeVar5482 < 100 ) ;
            var var5566 : Int32 = Int32(-93);
            var var5572 : Float32 = Float32(Float32(Float32(122.0)));
            var var5625 : (Bool, Range<Int32>, Array<UInt64>) = (true, ((Int32(-81)&127)..(Int32(-7)&127):(7|1)), [UInt64(162), UInt64(53), UInt64(220), UInt64(152), UInt64(217), UInt64(197), UInt64(92), UInt64(188), UInt64(32), UInt64(5)]);
            let var5678 : Range<UInt16> = ((UInt16(100)&127)..(UInt16(Int16(UInt16(UInt16(136))))&127):((Int64(UInt16(Int8(-69)))|1)));
            try { // block id: 5484
                let var5490 : Range<Int32> = ((Int32(94)&127)..(Int32(-74)&127):((Int64(UInt64(41))|1)));
                try { // block id: 5486
                    if (var4678) { var5490 } else { var5490 } ;
                    if (false) { var5500 } else { var5500 } ;
                    var5500
                } catch (_) { // block id: 5504
                    Option<Option<Interface204>>.Some(Option<Interface204>.Some(var2541))
                };
                optionalParam244
            } catch (_) { // block id: 5509
                var loopTimeVar5665 : Range<UInt64> = ((UInt64(UInt8(227))&127)..=(UInt64(UInt16(195))&127):(((-14)|1)));
                let iter5510 = loopTimeVar5665.iterator()
                while (true) {
                    match (iter5510.next()) {
                        case None => break
                        case Some(v) => match (v) {
                            case i where (false) => Option<Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>>.None;var var5645 : UInt64 = UInt64(Int32(82));if (var42) { [var2308, var330, Class201(namedParam404 : UInt64(214), namedParam405 : ((var4069&127)..=(Int8(-122)&127):((113|1)))), Class201(namedParam404 : var281, namedParam405 : ((Int8(-24)&127)..(Int8(-5)&127):(((-99)|1))), optionalParam406 : var3779), var330, var1028, Class201((var5537, var219, var4357, (false, ((Int32(-74)&127)..(var5566&127):(((-60)|1))), var5537), """
*VaJL
<pg^A
"""), var5572, optionalParam1959 : var5079), var5578, Class201(), var2308] } else { [Class201(optionalParam402 : UInt16(207), namedParam404 : var2668, namedParam405 : ((Int8(-56)&127)..(Int8(32)&127):((-57)|1))), Class201(optionalParam402 : UInt16(38), namedParam404 : var2668, namedParam405 : ((Int8(-43)&127)..=(Int8(-73)&127):((-52)|1))), var330, Class201(var473, var305), Class201(([UInt64(17), UInt64(89), UInt64(253), var1265, UInt64(179), var2668, var2668, UInt64(239), var1265, var2668], var5609, (UInt32(146), UInt32(157), var276, """
>v*gw
;hcxB
""", optionalParam244, var5065, ((UInt64(134)&127)..=(UInt64(183)&127):((-35)|1)), ((UInt32(112)&127)..=(UInt32(2)&127):((81|1)))), var5625, "Px.&OHYn,5"), Float32(-5.0), optionalParam1959 : var5079, optionalParam1961 : ((Int8(53)&127)..(Int8(-64)&127):((-110)|1))), Class201(([var2668, var2668, UInt64(250), var1265, UInt64(140), var1265, UInt64(151), var5645, UInt64(59), UInt64(42)], UInt16(12), var4357, var3280, var1092), Float32(-70.0), optionalParam1961 : var3744), var330, Class201(), Class201(), Class201(namedParam404 : UInt64(150), namedParam405 : ((var347&127)..(Int8(62)&127):((79|1))))] }
                            case _ => continue
                        }
                    }
                }
;
                try { // block id: 5673
                    if (false) { ((UInt16(68)&127)..(UInt16(16)&127):((-4)|1)) } else { var5678 }
                } finally { // block id: 5688
                    ((var5609&127)..=(var219&127):((var236|1)))
                };
                var2464
            } finally { // block id: 5694
                if (var42) { // block id: 5697
                    Option<Option<(Unit, UInt8)>>.Some(Option<(Unit, UInt8)>.Some(var5701));
                    Int32(-100)
                } else { // block id: 5709
                    var4473
                };
                (match (var1590) {
                    case Some(num) => num
                    case None => var2464
                })
            }
        }
;
        func243(optionalParam244 : var2464)
    } catch (e: Exception) { // block id: 5715
        if (false) { Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)>.Some((param195, ((Int8(102)&127)..(var4069&127):((var4644|1))), [UInt32(82), UInt32(127), UInt32(18), UInt32(214), UInt32(159), UInt32(71), UInt32(94), UInt32(106), UInt32(218), UInt32(151)], (r'i', (-82), var22, UInt64(41)), var3779, Float32(91.0), var5363, Int32(-106))) } else { var5736 } ;
        let var5770 : Array<UInt8> = [UInt8(UInt8(88)), UInt8(Int8(UInt8(124))), UInt8(UInt8(52)), UInt8(UInt8(141)), UInt8(212), UInt8(31), UInt8(UInt8(57)), UInt8(Int8(Int8(-68))), UInt8(UInt8(44)), UInt8(Int8(-38))];
        try { // block id: 5740
            var236 = 10;
            [UInt64(158), UInt64(250), UInt64(78), UInt64(186), UInt64(29), UInt64(152), UInt64(96), UInt64(88), UInt64(100), UInt64(145)];
            UInt8(126) ^ var2464
        } catch (_) { // block id: 5748
            var4142;
            var var5758 : UInt8 = UInt8(Int8(Int8(Int8(Int8(-51)))));
            [[UInt8(104), UInt8(33), UInt8(104), UInt8(150), UInt8(105), UInt8(247), UInt8(109), UInt8(180), UInt8(40), UInt8(81)], [var4352, UInt8(118), UInt8(128), UInt8(160), var5758, UInt8(207), UInt8(135), UInt8(131), UInt8(133), UInt8(105)], var5770, var5770, [UInt8(114), UInt8(189), UInt8(171), var4352, UInt8(181), UInt8(113), UInt8(45), var4352, UInt8(70), var4352], var5770, [UInt8(82), UInt8(70), UInt8(3), UInt8(159), UInt8(2), UInt8(39), UInt8(171), UInt8(244), UInt8(184), UInt8(209)], [UInt8(23), UInt8(234), UInt8(180), UInt8(200), var2464, var2464, var2464, var4352, UInt8(238), var5758], [UInt8(59), UInt8(226), UInt8(173), UInt8(112), UInt8(148), UInt8(238), UInt8(33), UInt8(114), UInt8(166), UInt8(193)], var5770];
            UInt8(175)
        }
    } finally { // block id: 5820
        var var5824 : Option<Option<Interface204>> = Option<Option<Interface204>>.None;
        if (var3182) { var5824 } else { Option<Option<Interface204>>.None } ;
        var2059 %= ((Int32(-23)) | 1);
        (match (Option<UInt8>.Some(var2464)) {
            case Some(num) => num
            case None => UInt8(237)
        })
    }
}



private func func169(optionalParam170 ! : Bool = (match (UInt8(Int8(UInt8(Int8(118))))) {
    case _: Float64 => true
    case _ => false
}), optionalParam176 ! : Float64 = Float64(23.0), namedParam179 ! : Float64) : (Rune, Int64, Unit, UInt64) { // block id: 180
    let var5835 : (Float64) -> UInt8 = func194;
    func func187(param188 : Int32, param189 : Bool, param190 : Unit, param191 : Range<UInt64>) : Option<Range<Int16>> { // block id: 192
        var5835(52.0);
        if (if (false) { // block id: 5841
            var2059 -= Int32(49);
            var42
        } else { // block id: 5846
            var1265 < var1265
        }) { try { // block id: 5851
            var var5855 : UInt64 = UInt64(UInt16(Int16(Int8(UInt8(167)))));
            UInt64(169) << ((var5855) & 7);
            if (var3182) { var198 } else { Option<Range<Int16>>.Some(var3938) }
        } finally { // block id: 5866
            if (var4678) { Option<Range<Int16>>.None } else { Option<Range<Int16>>.Some(((var3700&127)..(var4867&127):(((-126)|1)))) }
        } } else { Option<Range<Int16>>.Some(((var5878&127)..=(Int16(-92)&127):((var236|1)))) }
    }
;
    var var5907 : Unit = ();
    var var5930 : Int16 = Int16(UInt8(UInt8(Int8(-12))));
    (match (func187(var2059, try { // block id: 5885
        var5887;
        var5891 <<= ((UInt32(188)) & 7);
        optionalParam176 < (-114.0)
    } finally { // block id: 5898
        ();
        var5878 <<= ((Int16(26)) & 7);
        UInt16(244) >= var219
    }, var5907, (match (Option<Range<UInt64>>.None) {
        case Some(num) => num
        case None => var4386
    }))) {
        case Some(num) => num
        case None => try { // block id: 5917
        true;
        var5920;
        ((Int16(43)&127)..=(Int16(-44)&127):(70|1))
    } finally { // block id: 5923
        ((var4069&127)..(Int8(-80)&127):((var236|1)));
        ((var5930&127)..=(var4867&127):((4|1)))
    }
    });
    let var5954 : Option<UInt16> = Option<UInt16>.None;
    var var5967 : Option<Bool> = (match ((true, ((Int32(UInt32(133))&127)..(Int32(121)&127):((48|1))), [UInt64(13), UInt64(128), UInt64(116), UInt64(35), UInt64(55), UInt64(211), UInt64(218), UInt64(204), UInt64(69), UInt64(104)])) {
        case newVar: Bool => Option<Bool>.Some(newVar)
        case _ => Option<Bool>.None
    });
    let var6010 : Array<Array<UInt8>> = [[UInt8(122), UInt8(229), UInt8(106), UInt8(44), UInt8(198), UInt8(44), UInt8(195), UInt8(198), UInt8(115), UInt8(85)], [UInt8(Int8(UInt8(187))), UInt8(105), UInt8(75), UInt8(UInt8(Int8(-87))), UInt8(Int8(UInt8(245))), UInt8(9), UInt8(UInt8(16)), UInt8(22), UInt8(Int8(UInt8(239))), UInt8(UInt8(Int8(65)))], [UInt8(94), UInt8(203), UInt8(55), UInt8(197), UInt8(136), UInt8(240), UInt8(31), UInt8(205), UInt8(113), UInt8(215)], [UInt8(95), UInt8(93), UInt8(Int8(35)), UInt8(UInt8(UInt8(197))), UInt8(132), UInt8(244), UInt8(UInt8(184)), UInt8(Int8(UInt8(244))), UInt8(35), UInt8(UInt8(UInt8(11)))], [UInt8(183), UInt8(156), UInt8(196), UInt8(188), UInt8(76), UInt8(178), UInt8(60), UInt8(129), UInt8(152), UInt8(167)], [UInt8(12), UInt8(33), UInt8(2), UInt8(3), UInt8(214), UInt8(68), UInt8(78), UInt8(80), UInt8(88), UInt8(2)], [UInt8(158), UInt8(180), UInt8(Int8(Int8(106))), UInt8(210), UInt8(UInt8(165)), UInt8(Int8(94)), UInt8(181), UInt8(21), UInt8(147), UInt8(Int8(UInt8(194)))], [UInt8(UInt8(UInt8(55))), UInt8(UInt8(Int8(110))), UInt8(Int8(74)), UInt8(Int8(74)), UInt8(2), UInt8(Int8(9)), UInt8(179), UInt8(UInt8(62)), UInt8(UInt8(Int8(82))), UInt8(Int8(76))], [UInt8(8), UInt8(8), UInt8(18), UInt8(245), UInt8(142), UInt8(153), UInt8(180), UInt8(134), UInt8(221), UInt8(104)], [UInt8(UInt8(201)), UInt8(UInt8(105)), UInt8(Int8(92)), UInt8(244), UInt8(UInt8(241)), UInt8(UInt8(UInt8(14))), UInt8(Int8(-29)), UInt8(141), UInt8(254), UInt8(UInt8(194))]];
    let var6204 : Int32 = Int32(Int8(UInt8(85)));
    match {
        case (match (match (var4851) {
        case _ : Float64 =>
            if (true) { Option<Bool>.Some(false) } else { Option<Bool>.None }

        case caseVar5951 : Rune =>
            var5954;
            var4069 -= var4069;
            Option<Bool>.Some(var3182)

        case _ : Option<Range<UInt64>> =>
            ();
            Option<Bool>.None;
            var5967

        case _ =>
            var22;
            Option<Bool>.Some(false)

        case _ =>
            if (var2260) { var5967 } else { var5967 }

    }) {
        case Some(num) => num
        case None => UInt32(14) != UInt32(198)
    }) =>
        var loopTimeVar5997 : Int64 = 0;
        do {
            loopTimeVar5997++;

        } while ((true) && loopTimeVar5997 < 100 ) ;
        ((Int32(87)&127)..(Int32(-119)&127):((-36)|1));
        var5363
        case match (((Int32(39)&127)..(Int32(21)&127):((var236|1)))) {
        case _ : Option<Int32> =>
            var6010;
            (-25.0)

        case _ : Option<Array<Bool>> =>
            var42;
            var4811;
            (-18.0)

        case _ : (Range<UInt8>, Range<Int64>, Float64, Range<Int8>) =>
            var5920;
            ();
            78.0

        case _ =>
            var236++;
            let var6135 : Option<(Unit, UInt8)> = (match (Option<UInt32>.Some(UInt32(Int8(UInt8(45))))) {
                case newVar: (Unit, UInt8) => Option<(Unit, UInt8)>.Some(newVar)
                case _ => Option<(Unit, UInt8)>.None
            });
            Option<Option<(Unit, UInt8)>>.Some(var6135);
            (-84.0) - optionalParam176

    } <= (match (var6150) {
        case Some(num) => num
        case None => var2575
    }) =>
        var loopTimeVar6160 : Range<UInt64> = ((UInt64(93)&127)..(UInt64(UInt8(Int8(-125)))&127):((Int64(UInt32(UInt8(UInt8(36))))|1)));
        let iter6157 = loopTimeVar6160.iterator()
        while (true) {
            match (iter6157.next()) {
                case None => break
                case Some(v) => match (v) {
                    case i where (false) => ();
                    case _ => continue
                }
            }
        }
;
        var5920;
        match (Option<Unit>.Some(())) {
            case _ =>
                if (var3182) { Class201(var4248) } else { Class201(((-51.0), var3744, var106, (var5065, (-72), var4811, var1265), (Float32(-89.0), r'F', Int32(38), Option<Range<Int16>>.Some(((Int16(-56)&127)..=(Int16(54)&127):((-60)|1))), ((Int16(-29)&127)..(Int16(125)&127):((var4644|1))), var3154), Float32(70.0), var5363, var6204)) } ;
                (var555, 41, (), UInt64(207))

        }
        case _ =>
        var3700 <<= ((Int16(63)) & 7);
        ();
        match {
            case true =>
            Option<Interface204>.None;
            (r'N', 78, (), UInt64(34))
            case true =>
            var3280;
            (r'A', (-81), var4811, var2668)
            case _ =>
            (var5065, var236, (), UInt64(58))
        }
    }
}

private func func123(param124 : Float32) : UInt8 { // block id: 125
    let var130 : Array<UInt64> = [UInt64(197), UInt64(48), UInt64(52), UInt64(87), UInt64(98), UInt64(73), UInt64(29), UInt64(24), UInt64(235), UInt64(5)];
    let var143 : Int64 = Int64(UInt16(31));
    let var154 : Int16 = Int16(6);
    match (var130[1]) {
        case caseVar135 =>
            if (var42) { ((var36&127)..=(var36&127):((var143|1))) } else { ((Int32(40)&127)..(Int32(-49)&127):((-49)|1)) } ;
            51

        case caseVar150 =>
            ((var154&127)..=(Int16(14)&127):((122|1)));
            80 | 123

        case _ =>
            (-47) + (-90)

    };
    func169(optionalParam170 : try { // block id: 6242
        ();
        var3700 += Int16(-104);
        false
    } finally { // block id: 6248
        ();
        false
    }, namedParam179 : try { // block id: 6252
        ((UInt64(123)&127)..(var2668&127):(((-111)|1)));
        var5891 >>= ((var87) & 7);
        (-105.0) - 27.0
    } catch (e: Exception) { // block id: 6263
        var6265;
        (-43.0)
    })[2];
    var4352
}



private func func14(param15 : Int16) : Rune { // block id: 16
    var var76 : Int8 = Int8(UInt8(Int8(67)));
    try { // block id: 18
        try { // block id: 20
            var22;
            let var27 : Rune = r'6';
            if (true) { var27 } else { var27 } ;
            Int32(-22)
        } finally { // block id: 31
            ();
            UInt16(6);
            Int32(Int64(var36) ** UInt64(var36 & 3))
        };
        var42 ||= var42;
        Int16(15)
    } catch (_) { // block id: 47
        Int16(-23) - param15
    } finally { // block id: 51
        [var22, var22, var22, (), var22, (), (), (), var22, ()][3];
        Int16(var76)
    };
    let var92 : UInt32 = UInt32(Int16(-64));
    let var97 : UInt32 = UInt32(33);
    ([var87, var87, UInt32(88), var92, UInt32(205), var97, UInt32(198), UInt32(134), UInt32(7), UInt32(8)][9], var106[6], match (UInt8(36)) {
        case _ =>
            ();
            var var116 : Int32 = Int32(UInt8(91));
            var116 %= ((Int32(-50)) | 1);
            r'8'

    }, "3pcga (HRV", (func123(var305)), (match (Option<Rune>.None) {
        case Some(num) => num
        case None => var555
    }), ((UInt64(169)&127)..=(UInt64(182)&127):((var236|1))), if (var3182) { ((var6294&127)..=(var92&127):((56|1))) } else { ((var6294&127)..(UInt32(84)&127):((var236|1))) } )[3];
    match ((match ((match (((25&127)..=(56&127):((-84)|1))) {
            case newVar: Range<Int64> => Option<Range<Int64>>.Some(newVar)
            case _ => Option<Range<Int64>>.None
        })) {
            case Some(num) => num
            case None => match (var6150) {
            case _ : Option<(Float64, Range<Int8>, Array<UInt32>, (Rune, Int64, Unit, UInt64), (Float32, Rune, Int32, Option<Range<Int16>>, Range<Int16>, Range<Int32>), Float32, (Rune, Int64, Unit, UInt64), Int32)> =>
                var3737

            case _ =>
                if (true) { var5363 } else { var5363 } ;
                var1546;
                ((var4644&127)..=(var236&127):(((-34)|1)))

        }
        })) {
        case caseVar6331 =>
            var5065

        case _ =>
            var555

        case caseVar6340 : (Bool, Range<Int32>, Array<UInt64>) =>
            var2668 ^= var2668;
            var4811;
            r's'

        case _ =>
            var219 ^= var219;
            if (true) { r'g' } else { r'R' }

    }
}

public func func7(param8 : Int32, param9 : Bool, param10 : Rune, param11 : Int64) : UInt32 { // block id: 12
    func14(try { // block id: 6357
        var5920;
        if (var3182) { Option<Option<(Bool, Range<Int32>, Array<UInt64>)>>.None } else { var6363 } ;
        var5878
    } catch (_) { // block id: 6366
        var236++;
        let var6370 : Unit = ();
        var6370;
        Int16(-55)
    });
    var87
}

main(): Int64 {
    try {
        ();
        func7(if (var3182) { // block id: 6376
            let var6380 : Option<Bool> = Option<Bool>.None;
            if (true) { var6380 } else { Option<Bool>.None } ;
            var305;
            Int32(92)
        } else if (var4678) { // block id: 6386
            ();
            Int32(-27)
        } else { // block id: 6389
            var22;
            Int32(95)
        }, var4678, var5065, var4644);
        (-58) + 113
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var36*var36), 64)
        crccheck.updateBuffer(UInt64(var87*var87), 64)
        crccheck.updateBuffer(UInt64(var219*var219), 64)
        crccheck.updateBuffer(UInt64(var236*var236), 64)
        crccheck.updateBuffer(UInt64(var1265*var1265), 64)
        crccheck.updateBuffer(UInt64(var2059*var2059), 64)
        crccheck.updateBuffer(UInt64(var2464*var2464), 64)
        crccheck.updateBuffer(UInt64(var2668*var2668), 64)
        crccheck.updateBuffer(UInt64(var2955*var2955), 64)
        crccheck.updateBuffer(UInt64(var3700*var3700), 64)
        crccheck.updateBuffer(UInt64(var4069*var4069), 64)
        crccheck.updateBuffer(UInt64(var4352*var4352), 64)
        crccheck.updateBuffer(UInt64(var4473*var4473), 64)
        crccheck.updateBuffer(UInt64(var4644*var4644), 64)
        crccheck.updateBuffer(UInt64(var4867*var4867), 64)
        crccheck.updateBuffer(UInt64(var5878*var5878), 64)
        crccheck.updateBuffer(UInt64(var5891*var5891), 64)
        crccheck.updateBuffer(UInt64(var6294*var6294), 64)
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
extend Enum2505 {

}
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_dce_unused_operator
// ASSERT: scan chir_dce_unused_function
// ASSERT: scan chir_arithmetic_operator_overflow


