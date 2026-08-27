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
public let var144 : Unit = ()
public let var174 : Rune = '4'
public let var210 : Bool = false
public let var214 : (Float32*Int16*Unit) = (Float32(-115.0), Int16(51), ())
public var var799 : Rune = 'n'
public let var1010 : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)) = (6, (UInt64(137), false, false, 'f'), (false, Float32(-64.0)))
public var var1118 : Aggregate1114 = Aggregate1114()
public var var1159 : UInt16 = UInt16(4)
public let var1221 : Int8 = Int8(63)
public let var1388 : Bool = true
public var var1567 : UInt32 = UInt32(150)
public let var1723 : (UInt64*Bool*Bool*Rune) = (UInt64(29), false, false, 'U')
public let var1767 : (UInt64*Bool*Bool*Rune) = (UInt64(217), false, true, 'o')
public var var2085 : Unit = ()
public var var2149 : Int16 = Int16(-77)
public let var30 : Enum27 = Enum27.enumValue32(false)
public let var52 : UInt64 = UInt64(114)
public var var116 : Float32 = Float32(-13.0)
public let var185 : UInt32 = UInt32(188)
public let var188 : Int8 = Int8(-103)
public let var201 : Bool = false
public let var353 : (Bool*Float32) = (false, Float32(-107.0))
public let var363 : Unit = ()
public let var505 : Enum27 = Enum27.enumValue32(false)
public var var664 : UInt8 = UInt8(68)
public var var756 : Bool = true
public var var776 : Float64 = 55.0
public let var892 : Interface11 = Class10()
public var var907 : Class10 = Class10()
public var var1168 : Bool = false
public let var1196 : Aggregate1065 = Aggregate1065()
public let var1336 : Unit = ()
public let var1375 : Bool = true
public var var1747 : Enum1151 = Enum1151.defaultValue
 var var1760 : (UInt64*Bool*Bool*Rune) = (UInt64(92), true, true, 'k')
public let var1795 : Aggregate307 = Aggregate307()
public var var2269 : Unit = ()
public let var20 : Unit = ()
public var var130 : Int64 = 26
public let var171 : Unit = ()
public var var272 : Int32 = Int32(-61)
public let var346 : (UInt64*Bool*Bool*Rune) = (UInt64(109), true, false, 'o')
public let var491 : Interface12 = Class10(namedParam496 : UInt8(30), namedParam497 : Int8(-30))
public var var1098 : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8) = ((UInt64(162), false, false, 't'), (Float32(-123.0), Int16(-73), ()), '0', Int8(105))
public let var1162 : Int64 = (-91)
public var var1301 : Rune = 'E'
public var var1537 : (Unit*Unit*Interface12*UInt32) = ((), (), Class10(((), (), Class10(namedParam496 : UInt8(90), namedParam497 : Int8(-15)), UInt32(85)), namedParam965 : Int32(38)), UInt32(79))
public let var1939 : UInt8 = UInt8(136)
public let var2240 : Unit = ()
public enum Enum27 {
    defaultValue |
    enumValue32(Bool) |
    enumValue1291(Rune)
}
 func func266(param267 : UInt32) : Enum27 { // block id: 268
    UInt32(190);
    match (var272) {
        case _ =>
            var30

    }
}

public struct Aggregate1521 {
    public init() { // block id: 1523

    }
;
    public static let var1526 : Interface12 = Class10(((), (), Class10(), UInt32(62)), namedParam965 : Int32(-18))
}

public func func335(param336 : Int16) : Class10 { // block id: 337
    var loopTimeVar361 : Int64 = 0;
    while ((var130, var346, var353)[1][2] && loopTimeVar361 < 100 ) {
        loopTimeVar361++;

    };
    var363;
    if (func367(var353, namedParam369 : if (false) { var1795 } else { var1795 } , optionalParam370 : if (false) { var185 } else { UInt32(78) } , namedParam372 : UInt32(211))) { if (if (var756) { // block id: 1806
        Aggregate1114();
        UInt8(248);
        false
    } else if (var756) { // block id: 1811
        param336;
        Float32(98.0);
        false
    } else { // block id: 1815
        (false, Float32(-43.0));
        var210
    }) { // block id: 1820
        var907
    } else { // block id: 1822
        Class10(namedParam959 : Int8(48))
    } } else { Class10(namedParam959 : if (var1168) { // block id: 1828
        var20;
        Int8(-116)
    } else { // block id: 1831
        var144;
        var20;
        var1221
    }) }
}

public func func193() : UInt8 { // block id: 194
    func func225() : Float32 { // block id: 226
        var loopTimeVar262 : Int64 = 0;
        while (if (match (var30) {
            case _ =>
                Class10();
                var210

        }) { // block id: 235
            var20;
            var201
        } else { // block id: 238
            var214;
            var201
        } && loopTimeVar262 < 100 ) {
            loopTimeVar262++;
            match (var30) {
                case enumValue32(var201) =>
                    var20;
                    var20;
                    'f'

                case _ =>
                    var20;
                    'c'

            };
            if (true) { // block id: 257
                UInt64(145);
                var144;
                ()
            }
        };
        var loopTimeVar305 : Int64 = 0;
        while (match (func266(var185)) {
            case caseVar280 : UInt16 =>
                var201

            case defaultValue =>
                var171;
                true

            case caseVar290 : UInt16 =>
                ();
                Int32(-78);
                true

            case enumValue32(_) =>
                var210

            case _ =>
                false

        } && loopTimeVar305 < 100 ) {
            loopTimeVar305++;
            ()
        };
        let var311 : Aggregate307 = Aggregate307();
        var311.func314(if (var756) { // block id: 2154
            Enum27.enumValue1291(var174)
        } else { // block id: 2157
            UInt32(138);
            ();
            let var2162 : Rune = 'U';
            Enum27.enumValue1291(var2162)
        }, (true, var116))
    }
;
    match (if ((var201, Float32(83.0))[0]) { if (var201) { // block id: 207
            var116
        } else if (var210) { // block id: 212
            var214;
            var144;
            var116
        } else { // block id: 221
            UInt64(174);
            var116
        } } else { func225() } ) {
        case caseVar2169@ _ =>
            var144

        case -10.0 =>
            var799;
            var363

        case _ =>
            ()

    };
    if (var1168) { // block id: 2182
        var1336;
        UInt8(149)
    } else { // block id: 2185
        ();
        match {
            case var1168 =>
            Int8(106)
            case false =>
            Enum1151.enumValue1154(UInt16(171), (-19), var346);
            var1118;
            Int8(-23)
            case _ =>
            ();
            Int32(-38);
            var188
        };
        if (var1375) { var664 } else { var1939 }
    }
}

func func70() : Unit { // block id: 71
    func73(match (Int8(8)) {
        case _ =>
            Class10();
            ();
            ()

    }, if (false) { if (true) { // block id: 2218
        ();
        Class10(optionalParam494 : Class10(var1537, namedParam965 : Int32(49)), namedParam496 : UInt8(192), namedParam497 : Int8(72));
        var1388
    } else { // block id: 2227
        var1388
    } } else { var1375 } );
    var171;
    var144
}

public func func62(optionalParam63 ! : Unit = ()) : Interface12 { // block id: 65
    (func70(), if (true) { // block id: 2234
        var907;
        ()
    } else if (true) { // block id: 2238
        var2240;
        ();
        var363
    }, Class10(namedParam496 : var1939, namedParam497 : var1221), match (var1795) {
        case _ : Aggregate1349 =>
            var185

        case caseVar2255 : Int64 =>
            UInt32(26)

        case caseVar2260 : Float64 =>
            ();
            var185

        case _ =>
            ();
            var2269;
            UInt32(233)

        case _ =>
            var171;
            UInt32(15)

    })[2]
}

public interface Interface12 <: Interface11 {
    func func653(namedParam654 ! : Interface11, namedParam655 ! : Aggregate307, namedParam656 ! : Rune, namedParam657 ! : Class10) : Interface11 { // block id: 658
        namedParam657;
        Class10(namedParam496 : if (match (var664) {
            case caseVar668 =>
                true

            case _ =>
                ();
                var201

            case _ =>
                var144;
                false

        }) { (if (true) { UInt8(242) } else { UInt8(253) } ) } else { var664 } , namedParam497 : Int8(105))
    }
;
    func func697(namedParam698 ! : Bool, namedParam699 ! : Int8, namedParam700 ! : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)), namedParam701 ! : Bool) : Bool { // block id: 702
        var363;
        let var707 : Class10 = Class10();
        if (var707.func710(namedParam711 : (var346, (Float32(-90.0), Int16(-96), var363), '9', var188), namedParam712 : var185, namedParam713 : UInt32(191), namedParam714 : var776)) { // block id: 778
            if (true) { true } else { var201 }
        } else if (var756) { // block id: 784
            match (()) {
                case _ =>
                    UInt64(58);
                    ();
                    Float32(76.0)

            };
            var210
        } else { // block id: 793
            var var822 : Unit = ();
            match ((var346, var214, var799, Int8(114))) {
                case (_,caseVar804 : Class10,var174 | var174,91 | namedParam699) =>
                    Aggregate307();
                    var20

                case caseVar813@ _ =>
                    ()

                case caseVar818 : UInt32 =>
                    var363;
                    var822;
                    ()

                case _ =>
                    var20

            };
            var171;
            if (true) { // block id: 831
                UInt32(118);
                true
            } else if (var756) { // block id: 835
                var201
            } else { // block id: 837
                Float32(83.0);
                false
            }
        }
    }
;
    func func900(param901 : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8), namedParam902 ! : Int64) : Unit { // block id: 903
        match (var907.var910) {
            case caseVar917@ caseVar916@ caseVar915 =>
                var20

            case caseVar922 =>
                var30;
                (var52, true, false, var174);
                ()

            case _ : UInt64 =>
                ()

            case caseVar937 : (UInt64*Bool*Bool*Rune) =>
                Int16(-123);
                var20;
                var144

            case _ =>
                ()

        };
        var20
    }
;
    func func1296(namedParam1297 ! : Interface12, namedParam1298 ! : (UInt64*Bool*Bool*Rune)) : Rune

}

public func func102(optionalParam103 ! : Float64 = 43.0, namedParam105 ! : Bool, optionalParam106 ! : UInt8 = UInt8(174), namedParam108 ! : UInt8) : Unit { // block id: 109
    let var120 : Unit = ();
    let var135 : Int16 = Int16(64);
    let var166 : Int64 = (-49);
    match (match ((var116, Int16(-45), var120)[1]) {
            case caseVar125 : Rune =>
                Float32(93.0);
                var120;
                var130

            case caseVar141@ caseVar140@ caseVar139@ caseVar138@ var135 | var135 =>
                var144;
                var130

            case _ =>
                106

            case -3 | var135 | -83 =>
                68

            case _ =>
                (Float32(-82.0), Int16(23), ());
                var130

        }) {
        case var166 | -60 | var166 =>
            var171;
            var174;
            ()

        case caseVar179 : Int8 =>
            var171

        case _ =>
            var185;
            var188;
            ()

    }
}

public enum Enum616 {
    defaultValue
}
public struct Aggregate1065 {
    public init() { // block id: 1067

    }
;
    public static let var1234 : Int32 = Int32(-100);
    public static func func1070(param1071 : Int32, param1072 : Float32, param1073 : UInt64) : Int32 { // block id: 1074
        match (if ((var892.func1080(var214, namedParam1082 : var1196))) { if (true) { // block id: 1200
                var144;
                ();
                var188
            } else if (false) { // block id: 1205
                var188
            } else { // block id: 1207
                var52;
                var188
            } } else { Int8(31) } ) {
            case caseVar1213 : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)) =>
                let var1216 : Int32 = Int32(-2);
                var1216

            case caseVar1224@ var1221 | var1221 =>
                (122, var346, (var201, var116));
                UInt16(210);
                var1234

            case _ =>
                var30;
                Class10();
                var272

        }
    }

}

public struct Aggregate1114 {
    public init() { // block id: 1116

    }
;
    public func func1121() : Bool { // block id: 1122
        var var1134 : Int16 = Int16(18);
        if (match {
            case if (var756) { // block id: 1127
                ();
                true
            } else if (var201) { // block id: 1131
                var171;
                var1134;
                true
            } else { // block id: 1137
                ();
                false
            } =>
            var907;
            var363;
            true
            case var201 =>
            ();
            var756
            case _ =>
            true
        }) { match (Enum1151.enumValue1154(var1159, var1162, (var52, var201, var1168, 'H'))) {
            case _ : (Float32*Int16*Unit) =>
                var892;
                ();
                true

            case _ =>
                var171;
                var1098;
                true

        } } else { if (false) { // block id: 1184
            ();
            true
        } else if (var756) { // block id: 1188
            ();
            true
        } else { // block id: 1191
            ();
            var210
        } }
    }

}

public struct Aggregate1349 {
    public init() { // block id: 1351

    }
;
    public let var1356 : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8) = ((UInt64(147), true, true, 'N'), (Float32(-60.0), Int16(-105), ()), 's', Int8(-82))
}

public func func417(param418 : UInt8, param419 : Rune) : (UInt64*Bool*Bool*Rune) { // block id: 420
    var var448 : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8) = ((UInt64(5), true, true, 'm'), (Float32(-31.0), Int16(107), ()), 'y', Int8(39));
    var loopTimeVar464 : Int64 = 0;
    while (match (var30) {
        case defaultValue  =>
            ();
            false

        case caseVar431@ defaultValue  =>
            var210

        case caseVar436 =>
            ();
            var144;
            var201

        case _ =>
            var201

    } && loopTimeVar464 < 100 ) {
        loopTimeVar464++;
        var448[1];
        (-127.0)
    };
    let var688 : Aggregate307 = Aggregate307();
    let var856 : Int16 = Int16(104);
    let var868 : Interface11 = Class10();
    func func467(namedParam468 ! : Class10, optionalParam469 ! : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8) = ((UInt64(238), false, true, 'c'), (Float32(111.0), Int16(7), ()), 'v', Int8(-109)), optionalParam482 ! : UInt32 = UInt32(9), namedParam484 ! : (Float32*Int16*Unit)) : Bool { // block id: 485
        if (var210) { // block id: 488
            var491.func653(namedParam654 : Class10(), namedParam655 : var688, namedParam656 : var174, namedParam657 : Class10())
        } else if (if (true) { (var491.func697(namedParam698 : true, namedParam699 : Int8(105), namedParam700 : (var130, var346, (true, var116)), namedParam701 : false)) } else { false } ) { // block id: 850
            match (Int16(-110)) {
                case var856 | 26 | -58 | var856 =>
                    Class10(namedParam496 : UInt8(51), namedParam497 : var188)

                case var856 | -24 =>
                    var868

                case 8 | var856 | var856 | var856 =>
                    var868

                case _ : Float32 =>
                    var144;
                    ();
                    Class10(UInt64(41), namedParam887 : var346)

                case _ =>
                    var20;
                    ();
                    var892

            }
        } else { // block id: 1592
            Class10(UInt64(52), namedParam887 : (var52, var756, var1388, 'C'))
        };
        ();
        let var1641 : Aggregate307 = Aggregate307();
        match {
            case match (if (var756) { // block id: 1605
                    (var210, var116)
                } else { // block id: 1609
                    var353
                }) {
                case _ =>
                    var52;
                    true

            } =>
            if (false) { var756 } else { var1168 }
            case _ =>
            if (var201) { // block id: 1623
                73.0;
                var20
            } else if (false) { // block id: 1627
                ()
            };
            match ((-94)) {
                case -39 =>
                    var1168

                case caseVar1638@ var1162 =>
                    var1641;
                    namedParam468;
                    var210

                case caseVar1647 : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)) =>
                    ();
                    ();
                    var1168

                case _ =>
                    (UInt64(30), true, var756, 'M');
                    ();
                    var210

            }
        }
    }
;
    if (func467(namedParam468 : match (Class10(namedParam959 : Int8(28))) {
        case _ : Unit =>
            Class10(namedParam959 : var188)

        case _ : UInt8 =>
            var363;
            Enum27.defaultValue;
            var907

        case _ =>
            var1336;
            Class10(namedParam959 : var188)

    }, optionalParam482 : if (true) { // block id: 1682
        false;
        var353;
        var185
    } else if (true) { // block id: 1687
        var171;
        var171;
        UInt32(175)
    } else { // block id: 1691
        Aggregate307();
        var185
    }, namedParam484 : if (false) { // block id: 1696
        var214
    } else { // block id: 1698
        UInt64(147);
        var214
    })) { match (if (var1168) { ((var52, true, var1375, var174), var214, 'N', var1221) } else { (var346, var214, param419, var188) } ) {
        case caseVar1720 : Int16 =>
            var1723

        case _ =>
            var var1732 : (UInt64*Bool*Bool*Rune) = (UInt64(227), false, true, 'S');
            var1732

    } } else { (if (if (var1375) { // block id: 1741
        true
    } else if (var756) { // block id: 1744
        ();
        var1747;
        true
    } else { // block id: 1750
        false
    }) { (if (false) { (var52, true, false, 'V') } else { var1760 } ) } else { var1767 } ) }
}

public func func367(param368 : (Bool*Float32), namedParam369 ! : Aggregate307, optionalParam370 ! : UInt32 = UInt32(92), namedParam372 ! : UInt32) : Bool { // block id: 373
    ();
    if (func378()) { func417(var664, 'H') } else { match (Enum27.enumValue1291('q')) {
        case defaultValue  =>
            var1760;
            (UInt64(58), var1168, var1168, 'm')

        case _ =>
            var1723

    } } [1]
}

public interface Interface11 {
    func func1080(param1081 : (Float32*Int16*Unit), namedParam1082 ! : Aggregate1065) : Bool { // block id: 1083
        ();
        if (if (true) { // block id: 1088
            var210
        } else { // block id: 1090
            param1081;
            Aggregate1065();
            true
        }) { (var491.func900(var1098, namedParam902 : 105)) } else { () } ;
        var1118.func1121()
    }
;
    func func1287(param1288 : Int64) : Enum27 { // block id: 1289
        let var1305 : (Unit*Unit*Interface12*UInt32) = ((), (), Class10(((), (), Class10(), UInt32(158)), namedParam965 : Int32(90)), UInt32(110));
        Enum27.enumValue1291(var907.func1296(namedParam1297 : Class10(var1305, namedParam965 : Int32(-77)), namedParam1298 : var346))
    }
;
    func func895() : Bool { // block id: 896
        var var950 : Rune = '4';
        var491.func900((var346, var214, var950, var188), namedParam902 : var130);
        let var956 : Class10 = Class10(namedParam959 : Int8(7));
        let var1353 : Aggregate1349 = Aggregate1349();
        var956.func710(namedParam711 : var1353.var1356, namedParam712 : if (false) { UInt32(211) } else { var185 } , namedParam713 : match (var1375) {
            case var1375 | var210 | var210 =>
                var185

            case var1375 | var1388 | false | false =>
                var1336;
                UInt32(106)

            case _ =>
                var185

        }, namedParam714 : Class10.var1399)
    }
;
    func func1296(namedParam1297 ! : Interface12, namedParam1298 ! : (UInt64*Bool*Bool*Rune)) : Rune

}

public open class Class10 <: Interface11 & Interface12 {
    public init() { // block id: 14

    }
;
    public static var var17 : Bool = true;
    private static var var590 : Interface12 = Class10();
    protected static func func567(param568 : (Float32*Int16*Unit), param569 : Float64, namedParam570 ! : Float32, namedParam571 ! : (Bool*Float32)) : Interface12 { // block id: 572
        if (if (if (var201) { var210 } else { var201 } ) { // block id: 579
            var52;
            ();
            false
        } else { // block id: 583
            UInt16(237);
            var210
        }) { Class10() } else { (if (var201) { var590 } else { if (var210) { // block id: 594
            UInt32(15);
            var590
        } else { // block id: 597
            var130;
            ((), (), var590, var185);
            var590
        } } ) }
    }
;
    public static var var633 : Enum616 = Enum616.defaultValue;
    public init(optionalParam494 ! : Interface12 = Class10(), namedParam496 ! : UInt8, namedParam497 ! : Int8) { // block id: 498
        let var525 : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)) = (115, (UInt64(29), true, true, 'Z'), (true, Float32(-15.0)));
        match {
            case match (if (false) { var30 } else { var505 } ) {
                case caseVar511@ caseVar510 : Enum27 =>
                    false

                case _ : Int16 =>
                    (-118);
                    var201

                case _ =>
                    ();
                    var210

            } =>
            var525
            case _ =>
            match (var505) {
                case caseVar541@ _ =>
                    ();
                    'o';
                    (var130, var346, var353)

                case defaultValue  =>
                    var20;
                    ();
                    (125, var346, var353)

                case _ =>
                    ();
                    var144;
                    var525

            }
        };
        (-110.0);
        var var613 : Float64 = (-8.0);
        Class10.func567((Float32(59.0), Int16(14), var20), if (false) { (-53.0) } else { var613 } , namedParam570 : match (Enum616.defaultValue) {
            case defaultValue  =>
                ();
                Float32(52.0)

            case caseVar626 =>
                var116

            case defaultValue  =>
                var633;
                var363;
                Float32(-31.0)

            case _ =>
                var20;
                UInt64(172);
                var116

        }, namedParam571 : if (true) { (var210, Float32(-3.0)) } else { (true, var116) } )
    }
;
    public static var var718 : Class10 = Class10();
    public var var721 : UInt8 = UInt8(168);
    public open func func710(namedParam711 ! : ((UInt64*Bool*Bool*Rune)*(Float32*Int16*Unit)*Rune*Int8), namedParam712 ! : UInt32, namedParam713 ! : UInt32, namedParam714 ! : Float64) : Bool { // block id: 715
        var718.var721;
        var loopTimeVar763 : Int64 = 0;
        while (if (if (var201) { // block id: 727
            ();
            var210
        } else if (var17) { // block id: 731
            var144;
            true
        } else { // block id: 734
            Int16(-35);
            var201
        }) { // block id: 737
            ();
            true
        } else if (if (var210) { var210 } else { var17 } ) { // block id: 744
            var210
        } else { // block id: 746
            Class10();
            false
        } && loopTimeVar763 < 100 ) {
            loopTimeVar763++;
            if (true) { // block id: 753
                ();
                var756
            } else { // block id: 758
                var144;
                var17
            };
            true
        };
        var756
    }
;
    public var var910 : Enum27 = Enum27.enumValue32(false);
    public static var var1024 : Unit = ();
    private init(param1028 : Enum27, optionalParam1029 ! : Rune = 'L') { // block id: 1031
        if (true) { (Class10.var590) } else { var491 }
    }
;
    public init(param964 : (Unit*Unit*Interface12*UInt32), namedParam965 ! : Int32) { // block id: 966
        if (match ('I') {
            case _ =>
                var210

        }) { (if (if (false) { // block id: 976
            var20;
            var171;
            false
        } else { // block id: 980
            false
        }) { var664 } else { match (UInt16(229)) {
            case _ : Int16 =>
                Class10(optionalParam494 : var491, namedParam496 : UInt8(170), namedParam497 : Int8(-28));
                ();
                UInt8(235)

            case _ =>
                var664

        } } ) } else { var664 } ;
        if (false) { // block id: 1000
            if (var17) { (11, var346, (false, Float32(117.0))) } else { var1010 } ;
            Class10.var1024
        };
        Class10(match (if (var17) { var633 } else { var633 } ) {
            case _ : Int16 =>
                var1024;
                var188;
                var30

            case _ =>
                ();
                ();
                let var1054 : Enum27 = Enum27.enumValue32(false);
                var1054

        })
    }
;
    protected let var1249 : (Unit*Unit*Interface12*UInt32) = ((), (), Class10(Enum27.defaultValue), UInt32(247));
    public open func func1296(namedParam1297 ! : Interface12, namedParam1298 ! : (UInt64*Bool*Bool*Rune)) : Rune { // block id: 1299
        var1301
    }
;
    public init(namedParam959 ! : Int8) { // block id: 960
        var20;
        let var1058 : (Unit*Unit*Interface12*UInt32) = ((), (), Class10(), UInt32(140));
        Class10(var1058, namedParam965 : Aggregate1065.func1070(Int32(-28), Float32(91.0), UInt64(43)));
        if (match (var907.var1249) {
            case caseVar1266@ (var171,caseVar1263@ var144 | var363 | var144 | var363,caseVar1265@ caseVar1264@ _,_) =>
                UInt16(17);
                false

            case caseVar1272 : Int32 =>
                var363;
                Class10(namedParam496 : UInt8(207), namedParam497 : var188);
                var210

            case _ =>
                var144;
                true

        }) { match (var892.func1287(var130)) {
            case defaultValue  =>
                var363;
                var718

            case _ =>
                Class10();
                Class10()

            case caseVar1332@ defaultValue  =>
                true;
                var1336;
                Class10()

            case _ =>
                var130;
                Class10()

        } } else { (Class10.var718) }
    }
;
    public static var var1399 : Float64 = (-58.0);
    public static var var1422 : Int16 = Int16(-83);
    protected static func func1418() : Bool { // block id: 1419
        match (var1422) {
            case _ =>
                Int32(57)

        };
        var var1494 : Bool = true;
        if (match {
            case var1388 =>
            var1336;
            var188;
            true
            case true =>
            Class10();
            true
            case _ =>
            var20;
            false
        }) { var210 } else { (if (var1388) { match (var1162) {
            case 84 =>
                var1159;
                var1388

            case caseVar1454@ var1162 =>
                Aggregate1349();
                false

            case caseVar1460 =>
                var171;
                ((), (), Class10(Enum27.defaultValue), UInt32(25));
                false

            case _ =>
                UInt8(123);
                Class10(Enum27.enumValue32(var756));
                var1375

        } } else { match (Int32(-127)) {
            case -79 | -59 | 34 | 46 =>
                var1375

            case _ : Enum27 =>
                var20;
                false

            case -106 | 3 =>
                var144;
                Enum616.defaultValue;
                var1494

            case caseVar1498 : (UInt64*Bool*Bool*Rune) =>
                Float32(70.0);
                Enum616.defaultValue;
                var210

            case _ =>
                Float32(-121.0);
                false

        } } ) }
    }
;
    public init(param884 : UInt64, optionalParam885 ! : UInt16 = UInt16(60), namedParam887 ! : (UInt64*Bool*Bool*Rune)) { // block id: 888
        if (var892.func895()) { // block id: 1401
            var loopTimeVar1408 : Int64 = 0;
            while (var1388 && loopTimeVar1408 < 100 ) {
                loopTimeVar1408++;
                var171;
                ()
            };
            var loopTimeVar1413 : Int64 = 0;
            while (true && loopTimeVar1413 < 100 ) {
                loopTimeVar1413++;

            };
            var491
        } else if (Class10.func1418()) { // block id: 1507
            var loopTimeVar1512 : Int64 = 0;
            while (false && loopTimeVar1512 < 100 ) {
                loopTimeVar1512++;

            };
            let var1515 : Bool = false;
            if (var1515) { // block id: 1517

            } else if (var1515) { // block id: 1519

            };
            Aggregate1521.var1526
        } else { // block id: 1534
            match (var1537) {
                case (_,caseVar1554@ var171,caseVar1556@ caseVar1555 : Int8,caseVar1557) =>
                    Class10((var171, var363, Class10(var505, optionalParam1029 : var174), var1567), namedParam965 : var272)

                case _ =>
                    Class10(Enum27.enumValue32(false), optionalParam1029 : var799)

            };
            if (false) { // block id: 1578
                ();
                Class10()
            } else { // block id: 1581
                var590
            }
        };
        var30;
        var892
    }
;
    public let var1837 : Interface12 = Class10(((), (), Class10(optionalParam494 : Class10(((), (), Class10(Enum27.defaultValue), UInt32(10)), namedParam965 : Int32(-120)), namedParam496 : UInt8(60), namedParam497 : Int8(19)), UInt32(111)), namedParam965 : Int32(54))
}

public struct Aggregate307 {
    public init() { // block id: 309

    }
;
    public static let var1858 : Aggregate1521 = Aggregate1521();
    private var var1871 : Bool = true;
    public let var1889 : (Bool*Float32) = (true, Float32(-20.0));
    private let var1901 : Int16 = Int16(-72);
    public let var1936 : UInt8 = UInt8(61);
    private func func326(param327 : Enum27, param328 : UInt32, namedParam329 ! : Float32) : Interface12 { // block id: 330
        if (var201) { (func335(Int16(-84)).var1837) } else { (if (match (var1858) {
            case _ : Aggregate1349 =>
                ();
                var1159;
                var201

            case caseVar1868 =>
                var1871

            case caseVar1875 =>
                true

            case _ : Interface12 =>
                (var130, (UInt64(107), var1871, false, 'k'), var1889);
                var171;
                true

            case _ =>
                var52;
                (var116, var1901, ());
                var756

        }) { Class10(namedParam959 : Int8(-52)) } else { Class10() } ) } ;
        let var1932 : UInt8 = UInt8(178);
        if (match {
            case true =>
            var210
            case _ =>
            var756
        }) { // block id: 1915

        } else if (if (match (var664) {
            case caseVar1921 =>
                var363;
                false

            case _ : (Int64*(UInt64*Bool*Bool*Rune)*(Bool*Float32)) =>
                false

            case var1932 | var1932 | var1936 | var1939 =>
                ();
                var144;
                var1168

            case _ =>
                ();
                var363;
                var201

        }) { // block id: 1950
            ();
            var1098;
            false
        } else { // block id: 1954
            ((UInt64(96), true, false, 'F'), var214, var799, var188);
            true
        }) { // block id: 1965
            match (Class10(namedParam959 : var1221)) {
                case caseVar1971@ _ : Float64 =>
                    var1336;
                    var1858

                case _ =>
                    ();
                    var171;
                    Aggregate1521()

                case _ =>
                    var1336;
                    Aggregate1521()

            };
            ()
        };
        var491
    }
;
    public func func321(param322 : Float64) : Interface12 { // block id: 323
        var var2010 : Int8 = Int8(-77);
        func326(var505, UInt32(129), namedParam329 : if (var201) { var116 } else { Float32(6.0) } ).func697(namedParam698 : var210, namedParam699 : match (var1901) {
            case _ =>
                var20;
                Int8(18)

            case _ =>
                (var52, var1388, var1168, var799);
                var2010

        }, namedParam700 : match (var214) {
            case _ =>
                var363;
                ();
                var1010

        }, namedParam701 : var210);
        if ((if (true) { match (var130) {
            case caseVar2027 =>
                var1388

            case _ =>
                var1871

        } } else { if (var210) { // block id: 2035
            var776;
            var1375
        } else if (false) { // block id: 2039
            var1375
        } else { // block id: 2041
            true
        } } )) { var491 } else { Class10(namedParam496 : var1939, namedParam497 : if (var1388) { // block id: 2048
            Int8(64)
        } else if (var1168) { // block id: 2051
            Enum27.enumValue1291('z');
            var188
        } else { // block id: 2055
            Int8(-97)
        }) }
    }
;
    public func func314(param315 : Enum27, param316 : (Bool*Float32)) : Float32 { // block id: 317
        if (func321(82.0).func697(namedParam698 : var1871, namedParam699 : var1221, namedParam700 : (var1162, var1723, var353), namedParam701 : false)) { // block id: 2066
            match (var116) {
                case caseVar2072@ caseVar2071@ -121.0 =>
                    Int32(84)

                case _ =>
                    Int32(-77)

            };
            if (var1168) { Class10(namedParam959 : Int8(114)) } else { Class10((var2085, (), Class10((var2085, (), Class10(), var185), namedParam965 : Int32(125)), var1567), namedParam965 : var272) } ;
            var116
        } else if (false) { // block id: 2099
            var116
        } else { // block id: 2101
            match (var491) {
                case caseVar2106 : Enum27 =>
                    var1118

                case _ : Enum616 =>
                    var1871;
                    Aggregate1114()

                case caseVar2116 : Aggregate1349 =>
                    var1118

                case caseVar2121 : (Bool*Float32) =>
                    ();
                    var1118

                case _ =>
                    Aggregate1114()

            };
            var var2134 : (Float32*Int16*Unit) = (Float32(70.0), Int16(122), ());
            match (Float32(33.0)) {
                case _ =>
                    var171;
                    var2134;
                    var144

            };
            match {
                case false =>
                Float32(120.0)
                case var1168 =>
                var116
                case _ =>
                var2149;
                Float32(108.0)
            }
        }
    }

}

public func func378() : Bool { // block id: 379
    match (var30) {
        case caseVar386@ caseVar385@ caseVar384@ enumValue32(true) =>
            ();
            var210

        case caseVar393@ caseVar392@ _ =>
            true

        case _ =>
            var363;
            ();
            false

    };
    ();
    if (var210) { (var52, true, var210, 'y') } else { (var52, true, false, var174) } [2]
}

public enum Enum1151 {
    defaultValue |
    enumValue1154(UInt16, Int64, (UInt64*Bool*Bool*Rune))
}
public func func73(param74 : Unit, param75 : Bool) : Unit { // block id: 76
    let var82 : Int64 = (-93);
    var var86 : Float64 = (-125.0);
    match (27) {
        case var82 =>
            var86

        case -107 | -95 | 41 =>
            85.0

        case _ =>
            var86

        case _ =>
            param74;
            (-36.0)

    };
    param74;
    func102(namedParam105 : param75, namedParam108 : func193())
}

 func func23(param24 : UInt8) : Unit { // block id: 25
    var var42 : Int64 = (-100);
    match (var30) {
        case caseVar39@ caseVar38@ caseVar37 : Interface12 =>
            var42;
            var var45 : Int8 = Int8(-105);
            var45

        case _ =>
            (-50.0);
            var52;
            let var55 : Int8 = Int8(6);
            var55

        case _ =>
            Int8(-20)

    };
    func62().func900(var1098, namedParam902 : var42)
}

main(): Int64 {
    Float32(-76.0);
    if ((Class10.var17)) { var20 } else { func23(UInt8(183)) } ;
    var130
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var130), 64)
    crccheck.updateBuffer(UInt64(var272), 64)
    crccheck.updateBuffer(UInt64(var1162), 64)
    crccheck.updateBuffer(UInt64(var1939), 64)
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
can't bind a nullptr CHIR node to a Cangjie node
return code: 139
*/
