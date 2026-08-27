/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan-not input parameter error

@Deprecated
var var_1743341905737_23: (UInt64, UInt64, Float32, Option<Unit>) = (UInt64(120), UInt64(Int32(75)), Float32(-85.0), Option<Unit>
        .None)
public var var_1743341905737_35: (UInt8, Bool) = (UInt8(205), false)
internal const var_1743341905737_80: Bool = false
@Deprecated
let var_1743341905737_108: Option<Int32> = Option<Int32>.None
let var_1743341905737_118: Option<Int32> = Option<Int32>.None
internal var var_1743341905737_238: ??(Option<(UInt8, Bool)>, Int32) = Option<Option<(Option<(UInt8, Bool)>, Int32)>>
    .None
internal let var_1743341905737_244: (Option<(UInt8, Bool)>, Int32) = ((match (Int64(42)) {
        case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
        case _ => Option<(UInt8, Bool)>.None
    }), Int32(UInt8(Int8(Int8(117)))))
@Deprecated
public let var_1743341905737_408: Option<Int32> = (match (UInt64(Int64(UInt16(Int16(103))))) {
    case newVar: Int32 => Option<Int32>.Some(newVar)
    case _ => Option<Int32>.None
})
const var_1743341905737_470: Rune = r'l'
let var_1743341905737_693: Bool = (match (VArray<Unit, $3>({i => ()})) {
    case _: Range<Int64> => true
    case _ => false
})
public var var_1743341905737_810: UInt64 = UInt64(Int64(102))
public const var_1743341905737_855: Int32 = 69
public let var_1743341905737_863: Int64 = Int64(14)
public var var_1743341905737_871: Class_1743341905737_867 = Class_1743341905737_867()
@Deprecated
var var_1743341905737_1419: ((Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, Option<(Option<(UInt8, 
    Bool)>, Int32)>, (UInt8, Bool), Int64) = (([Option<Int32>.None, (match (Option<Int64>.None) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (UInt16(86)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (Option<Int32>.None) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (UInt16(243)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, (match (Option<(UInt8, Bool)>.None) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (VArray<Unit, $3>({i => ()})) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None,
            (match ((([Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.None], r's', Option<(Option<(UInt8, Bool)>, Int32)>.None), ((UInt8(UInt8(14)) & 127)..=(UInt8(UInt8(228)) &
                127) : (Int64(121) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.None, (UInt8(59), true), Int64(114))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        })], r'F', (match (((UInt32(UInt32(39)) & 127)..=(UInt32(UInt32(5)) & 127) : (Int64(57) | 1))) {
            case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
            case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
        })), ((UInt8(UInt8(239)) & 127)..(UInt8(UInt8(248)) & 127) : (Int64(116) | 1)), Option<(Option<(UInt8, Bool)>, 
            Int32)>.None, (UInt8(8), (match (((UInt8(7), false), Int8(-13), [Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>(repeat: ()), UInt8(52), ([UInt64(169),
                    UInt64(194), UInt64(121), UInt64(9), UInt64(221), UInt64(3), UInt64(94), UInt64(159), UInt64(243),
                    UInt64(172)], ([Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None], r'R', Option<(Option<(UInt8, Bool)>, Int32)>.None),
                UInt16(245)))) {
            case _: VArray<Unit, $3> => true
            case _ => false
        })), Int64(100))
public let var_1743341905737_1779: Unit = ()
public var var_1743341905737_1877: Option<(UInt8, Bool)> = Option<(UInt8, Bool)>.None
var var_1743341905737_2151: UInt16 = UInt16(Int16(-72))
internal var var_1743341905737_2351: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, 
    Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
    Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) = (((Int32(Int32(UInt32(UInt16(35)))) & 127)..=(Int32(Int32(Int32(Int32(46)))) &
        127) : (Int64(-57) | 1)), "L]WsvDba{7v", UInt8(253), ((match (Option<((UInt8, Bool), Int8, Array<Option<Int32>>, 
                VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                Int32)>), UInt16))>.None) {
            case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
            case _ => Option<(UInt8, Bool)>.None
        }), Int32(UInt32(67))), ((UInt8(Int8(-21)), (match ((([Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'5', Option<(Option<(UInt8, 
                            Bool)>, Int32)>.None), ((UInt8(UInt8(14)) & 127)..=(UInt8(UInt8(153)) & 127) : (Int64(-122) |
                    1)), Option<(Option<(UInt8, Bool)>, Int32)>.None, (UInt8(18), false), Int64(43))) {
                case _: ((Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, Option<(Option<(UInt8, 
                        Bool)>, Int32)>, (UInt8, Bool), Int64) => true
                case _ => false
            })), Int8(Int8(Int8(-91))), [Option<Int32>.None, (match (Option<(Option<(UInt8, Bool)>, Int32)>.None) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, (match (((UInt8(UInt8(49)) & 127)..=(UInt8(UInt8(165)) & 127) : (Int64(4) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (UInt16(213)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, (match (((UInt8(UInt8(164)) & 127)..(UInt8(UInt8(39)) & 127) : (Int64(67) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }),
            (match ((UInt16(29), true, UInt64(54), Float64(-104.0), Int32(98), UInt32(69), Float64(-79.0), Float64(58.0),
            Int16(-105))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (((Int64(Int64(38)) & 127)..=(Int64(Int64(73)) & 127) : (Int64(-41) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (Int8(1)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        })], VArray<Unit, $3>(repeat: ()), UInt8(144), ([UInt64(103), UInt64(123), UInt64(183), UInt64(89), UInt64(239),
                UInt64(241), UInt64(235), UInt64(140), UInt64(66), UInt64(132)], ([Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'n', Option<(Option<(UInt8, 
                        Bool)>, Int32)>.None), UInt16(118))), ((UInt8(80), true), Int8(-57), [Option<Int32>.None,
            Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
            (match (Int8(124)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, (match ([false, false, false, false, true, true, false, true, false, true]) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(Int8(68)), ([UInt64(209), UInt64(172), UInt64(59),
                UInt64(93), UInt64(114), UInt64(20), UInt64(102), UInt64(135), UInt64(102), UInt64(110)], ([Option<Int32>
                    .None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None],
                r'4', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(UInt8(19)))), UInt32(Int16(98)))
public var var_1743341905737_2518: (UInt8, Bool) = (UInt8(248), (match (Int8(Int8(16))) {
        case _: UInt32 => true
        case _ => false
    }))
internal let var_1743341905737_2577: UInt32 = UInt32(Int8(-111))
@Deprecated
public var var_1743341905737_2609: (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>) = ([Option<Int32>
        .None, (match (((Int64(Int64(57)) & 127)..=(Int64(Int64(-61)) & 127) : (Int64(-101) | 1))) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }),
        (match (([Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
            Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r't', Option<(Option<(UInt8, 
                Bool)>, Int32)>.None)) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }), (match (Float64(-41.0)) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }), Option<Int32>.None, Option<Int32>.None, (match (Float64(Float64(-99.0))) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }), (match ((match (Float32(35.0)) {
        case newVar: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) => Option<((UInt8, Bool), Int8, Array<Option<Int32>>, 
                VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                Int32)>), UInt16))>.Some(newVar)
        case _ => Option<((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))>.None
    })) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }), Option<Int32>.None,
        (match (["YH~sq]d?$l", """
}~)$#
7#w|<
""", """
xT)[@
bTZC#
""", "J952dMnkeB", ###"=z-4QX;]Pz"###,
        """
!@(Wn
A6%gt
""", """
[\"rsv
%3=<(
""", ###"k'Cg}Z<Uhs"###, """
4yC/$
\\a{<s<
""", "fvl8Dbcl_a{"]) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    })], r'i', Option<(Option<(UInt8, Bool)>, Int32)>.None)
@Deprecated
public let var_1743341905737_2686: Enum_1743341905737_2683 = Enum_1743341905737_2683.enumValue_1743341905737_2688(
    (UInt8(12), false))
internal const var_1743341905737_2828: UInt8 = 241
let var_1743341905737_2891: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) = ((UInt8(UInt8(Int8(53))), false), Int8(Int8(88)), [Option<Int32>
        .None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
        (match (Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
            VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
            UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
            Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }),
        (match (["""
4%DtX
ep&$%
""", ###"9T'yz;W:(q"###, "2J,4U1e$}X", ")q[3q$*brT", ###"S9?v~ENP4>"###, "QJ^E'._>!d",
        """
SUY|U
[[6&r
""", "cF5X5yZ&1\"", """
07@LR
;]h)w
""", "fc+haiR+Eh"]) {
        case newVar: Int32 => Option<Int32>.Some(newVar)
        case _ => Option<Int32>.None
    }), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>(repeat: ()),
    UInt8(Int8(Int8(Int8(36)))), ([UInt64(146), UInt64(UInt16(218)), UInt64(Int64(-10)), UInt64(Int16(-17)),
            UInt64(UInt64(35)), UInt64(185), UInt64(UInt32(9)), UInt64(231), UInt64(Int32(115)), UInt64(19)], ([Option<Int32>
                .None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'6',
            (match ([true, false, false, false, false, false, true, false, false, false]) {
                case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
            })), UInt16(77)))
var var_1743341905737_2968: ?Class_1743341905737_44 = Option<Class_1743341905737_44>.None
@Deprecated
public var var_1743341905737_2982: Int32 = Int32(-38)
internal var var_1743341905737_3053: Int16 = Int16(UInt16(222))
internal var var_1743341905737_3066: Int32 = Int32(-23)
let var_1743341905737_3145: ?Unit = Option<Unit>.None
internal var var_1743341905737_3194: Array<UInt64> = [UInt64(UInt16(215)), UInt64(178), UInt64(141), UInt64(100),
    UInt64(Int16(UInt16(192))), UInt64(237), UInt64(91), UInt64(95), UInt64(UInt16(Int16(7))), UInt64(21)]
public let var_1743341905737_3424: Range<Int16> = ((Int16(Int16(116)) & 127)..(Int16(Int16(-60)) & 127) : (Int64(113) | 1))
public let var_1743341905737_3451: Struct_1743341905737_2754 = Struct_1743341905737_2754()
@Deprecated
public const var_1743341905737_3487: Float64 = -23.0
public var var_1743341905737_3492: Class_1743341905737_867 = Class_1743341905737_867()
@Deprecated
internal var var_1743341905737_4020: UInt8 = UInt8(153)
@Deprecated
internal let var_1743341905737_4054: (UInt8, Bool) = (UInt8(UInt8(179)), false)
internal var var_1743341905737_4104: Range<Int32> = ((Int32(Int32(82)) & 127)..(Int32(Int32(13)) & 127) : (Int64(Int32(21)) |
    1))
public var var_1743341905737_4347: Bool = (match (r'a') {
    case _: Option<((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
            Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))> => true
    case _ => false
})
public const var_1743341905737_4662: Float32 = -51.0
var var_1743341905737_4698: Option<Int32> = Option<Int32>.None
let var_1743341905737_4755: UInt32 = UInt32(UInt16(54))
let var_1743341905737_4779: Range<Int32> = ((Int32(Int32(-127)) & 127)..=(Int32(Int32(UInt8(UInt8(Int8(56))))) & 127) : (Int64(23) |
    1))
public let var_1743341905737_4788: Option<Int32> = Option<Int32>.None
var var_1743341905737_5038: UInt8 = UInt8(89)
var var_1743341905737_5116: Option<Option<UInt8>> = (match (r'x') {
    case newVar: Option<UInt8> => Option<Option<UInt8>>.Some(newVar)
    case _ => Option<Option<UInt8>>.None
})
let var_1743341905737_5145: Array<UInt64> = [UInt64(3), UInt64(Int16(Int8(67))), UInt64(Int16(79)),
    UInt64(UInt64(UInt64(235))), UInt64(UInt8(Int8(Int8(-44)))), UInt64(169), UInt64(223),
    UInt64(Int64(Int16(Int16(-37)))), UInt64(Int64(Int32(-38))), UInt64(246)]
const var_1743341905737_5179: Unit = ()

public sealed interface Interface_1743341905737_47 {}

public sealed interface Interface_1743341905737_48<T0> <: Interface_1743341905737_47 {
    @Frozen
    static func func_1743341905737_667(
        namedParam_1743341905737_668!: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
            Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
            Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
            (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32),
        namedParam_1743341905737_669!: Option<Int32>,
        namedParam_1743341905737_670!: Option<(Option<(UInt8, Bool)>, Int32)>,
        namedParam_1743341905737_671!: (UInt8, Bool)): ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
        UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) { // block id: 672
        var var_1743341905737_674: Array<String> = ["GbjaH&Mk^t", "&d@XI));}:", "Ga{N39hY[Vu", ###"Y9;uU'7?D/"###,
            """
~q<O?
|7:*\\
""", "0.6Y;h'ZEC", ###"4UU`!00'=z"###, ###"&aD(4Da1u2"###, """
+h0JG
J?G|?
""",
            """
&3rRL
}5T7\"
"""];
        var_1743341905737_674;
        let var_1743341905737_709: Range<UInt8> = ((UInt8(UInt8(UInt8(Int8(-20)))) & 127)..(UInt8(UInt8(104)) & 127) : (Int64(-46) |
            1));
        var var_1743341905737_806: UInt16 = UInt16(78);
        let var_1743341905737_816: UInt32 = UInt32(UInt8(UInt8(151)));
        const var_1743341905737_823: Int16 = -108;
        if ([false, false, var_1743341905737_693, var_1743341905737_693, true, true, false, var_1743341905737_80, false,
            var_1743341905737_693][7]) { // block id: 707
            var_1743341905737_709;
            var var_1743341905737_721: Array<Option<Int32>> = [(match ([(match (Float64(-60.0)) {
                case _: Range<Int16> => true
                case _ => false
            }),
                (match (Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                    VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                    Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                    (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None) {
                case _: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                        (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                        UInt32) => true
                case _ => false
            }), true, true, true, true, true, true,
                (match ([Option<Int32>.Some(Int32(-70)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(0)), Option<Int32>.None,
                Option<Int32>.Some(Int32(9)), Option<Int32>.None]) {
                case _: Array<UInt64> => true
                case _ => false
            }), (match ((UInt8(107), false)) {
                case _: String => true
                case _ => false
            })]) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match ((Option<(UInt8, Bool)>.Some((UInt8(82), true)), Int32(Int16(84)))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, Option<Int32>.None,
                (match (([Option<Int32>.None, Option<Int32>.Some(Int32(120)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(-67)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(60)), Option<Int32>.Some(Int32(-111)), Option<Int32>.None], r'j', (match (Option<(UInt8, 
                        Bool)>.None) {
                    case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                    case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
                }))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, Option<Int32>.None, (match ((match (Option<Int32>.Some(Int32(-102))) {
                case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                case _ => Option<(UInt8, Bool)>.None
            })) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None];
            var var_1743341905737_798: UInt8 = UInt8(80);
            ((var_1743341905737_721, var_1743341905737_470, Option<(Option<(UInt8, Bool)>, Int32)>.None), ((UInt8(UInt8(27)) &
                    127)..=(UInt8(UInt8(129)) & 127) : (Int64(111) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.None, (var_1743341905737_798,
                    var_1743341905737_693), Int64(-26))[4]
        } else if ((var_1743341905737_806, false, var_1743341905737_810, Float64(-5.0), Int32(-70), var_1743341905737_816,
            Float64(98.0), Float64(-93.0), var_1743341905737_823)[1]) { // block id: 826
            if (var_1743341905737_693) {
                Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                        (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                        UInt32)>.None
            } else {
                Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                        (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                        UInt32)>.None
            };
            var var_1743341905737_835: Option<(UInt8, Bool)> = (match ([UInt64(Int16(-51)), UInt64(57), UInt64(11),
                UInt64(Int64(UInt16(110))), UInt64(83), UInt64(UInt64(Int32(42))), UInt64(173), UInt64(249),
                UInt64(Int8(123)), UInt64(47)]) {
                case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                case _ => Option<(UInt8, Bool)>.None
            });
            try { // block id: 832
                (var_1743341905737_835, var_1743341905737_855)
            } finally { // block id: 857
                ();
                var_1743341905737_244
            };
            Int64(74) / ((var_1743341905737_863) | 1)
        } else { // block id: 865
            var_1743341905737_871.var_1743341905737_874;
            (match (["tA0tnMpI%9", """
_@|b!
OvdFB
""", """
c=L;}
Vkcjz
""", ###"!| AjK$}PG"###, """
PZ(T~
@4sL<
""",
                ###">;|'~ ?c8="###, ###"VT@YY$uB^5"###, """
7hn3Q
k$AS%
""", "9JP~ha{RYq_", ###"aSWFj?`ym~"###]) {
                case _: Option<Option<(Option<(UInt8, Bool)>, Int32)>> => true
                case _ => false
            });
            (match (Option<Int64>.None) {
                case Some(num) => num
                case None => var_1743341905737_863
            })
        };
        let var_1743341905737_1098: (UInt8, Bool) = (UInt8(93), true);
        var var_1743341905737_1107: Range<UInt32> = ((UInt32(UInt32(91)) & 127)..=(UInt32(UInt32(203)) & 127) : (Int64(92) |
            1));
        let var_1743341905737_1519: Array<Option<Int32>> = [(match (Float32(-73.0)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }),
            (match (([UInt64(87), UInt64(230), UInt64(134), UInt64(132), UInt64(59), UInt64(8), UInt64(111), UInt64(82),
                UInt64(143), UInt64(36)], ([Option<Int32>.None, Option<Int32>.Some(Int32(33)),
                    Option<Int32>.Some(Int32(44)), Option<Int32>.Some(Int32(-26)), Option<Int32>.Some(Int32(-73)),
                    Option<Int32>.Some(Int32(-67)), Option<Int32>.Some(Int32(4)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(68)), Option<Int32>.None], r'4',
                Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(98)))), UInt16(229))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }),
            (match ([UInt64(Int8(-57)), UInt64(133), UInt64(UInt16(89)), UInt64(Int32(48)), UInt64(91),
            UInt64(UInt16(48)), UInt64(Int16(53)), UInt64(UInt8(90)), UInt64(65), UInt64(Int8(0))]) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match ((match (Int8(88)) {
            case newVar: Int64 => Option<Int64>.Some(newVar)
            case _ => Option<Int64>.None
        })) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (Float64(-114.0)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }),
            (match ((((UInt32(UInt32(30)) & 127)..(UInt32(UInt32(154)) & 127) : (Int64(16) | 1)), Option<(Range<Int32>, 
                    String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
                    UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                    ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None, (([Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(-93)), Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(27)), Option<Int32>.Some(Int32(-41)),
                        Option<Int32>.None, Option<Int32>.None], r'0', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                        (Option<(UInt8, Bool)>.Some((UInt8(191), false)), Int32(24)))), ((UInt8(UInt8(179)) & 127)..(UInt8(UInt8(103)) &
                    127) : (Int64(92) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.None, (UInt8(137), false), Int64(-87)),
            (([Option<Int32>.Some(Int32(43)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(46)),
                        Option<Int32>.None, Option<Int32>.Some(Int32(-118)), Option<Int32>.Some(Int32(-23)),
                        Option<Int32>.None, Option<Int32>.Some(Int32(23)), Option<Int32>.Some(Int32(-55))], r'p',
                    Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                        (Option<(UInt8, Bool)>.Some((UInt8(141), false)), Int32(39)))), ((UInt8(UInt8(224)) & 127)..(UInt8(UInt8(169)) &
                    127) : (Int64(-62) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                    (Option<(UInt8, Bool)>.None, Int32(-46))), (UInt8(218), false), Int64(-98)), Int16(-30))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, Option<Int32>.Some(Int32(120)),
            (match ([UInt64(49), UInt64(29), UInt64(94), UInt64(UInt32(253)), UInt64(UInt64(26)), UInt64(78),
            UInt64(UInt32(30)), UInt64(200), UInt64(147), UInt64(33)]) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (Float32(87.0)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        })];
        let var_1743341905737_1673: VArray<Unit, $3> = [(), (), ()];
        var var_1743341905737_1677: (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
            UInt16) = ([UInt64(68), UInt64(32), UInt64(32), UInt64(15), UInt64(148), UInt64(251), UInt64(153),
                UInt64(214), UInt64(249), UInt64(103)], ([Option<Int32>.Some(Int32(-27)), Option<Int32>.Some(Int32(-10)),
                    (match (([Option<Int32>.Some(Int32(-108)), Option<Int32>.Some(Int32(-15)),
                        Option<Int32>.Some(Int32(105)), Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.Some(Int32(-77)), Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.Some(Int32(-73)), Option<Int32>.Some(Int32(12))], r'q', Option<(Option<(UInt8, 
                            Bool)>, Int32)>.None)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }),
                    (match (Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, 
                        Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
                        Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), UInt32)>.None) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), (match (Int32(73)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }),
                    (match (["|qm-qM(dGY", "Br5mCy-}]Q", """
 s;pe
VZ0lS
""", """
8%NxR
ld,Uy
""", ###"}KN|/%omHV"###,
                    "m_\\_m4PxN[", """
Zfj}f
*2:)G
""", "7*J(n2QJB&", "/D7K+L!%UX", ###"\"r$tR51~xp"###]) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }),
                    (match (([Option<Int32>.Some(Int32(55)), Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.Some(Int32(-71)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'T', Option<(Option<(UInt8, Bool)>, 
                            Int32)>.None)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), (match (UInt32(207)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }),
                    (match (([Option<Int32>.Some(Int32(-98)), Option<Int32>.Some(Int32(62)),
                        Option<Int32>.Some(Int32(108)), Option<Int32>.Some(Int32(66)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(-39)), Option<Int32>.Some(Int32(-86)), Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(12))], r'G', Option<(Option<(UInt8, Bool)>, Int32)>
                        .None)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), Option<Int32>.Some(Int32(-83))], r'X', (match (((UInt32(UInt32(33)) & 127)..(UInt32(UInt32(120)) &
                    127) : (Int64(-60) | 1))) {
                    case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                    case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
                })), UInt16(Int16(54)));
        let var_1743341905737_2156: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
            (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) = ((UInt8(Int8(120)), (match ((((Int32(Int32(-102)) &
                        127)..(Int32(Int32(117)) & 127) : (Int64(14) | 1)), "N'7b}6.l}M", UInt8(169), (Option<(UInt8, 
                                Bool)>.Some((UInt8(79), false)), Int32(18)), ((UInt8(51), true), Int8(-55), [Option<Int32>
                            .Some(Int32(-86)), Option<Int32>.None, Option<Int32>.Some(Int32(-58)),
                            Option<Int32>.Some(Int32(-102)), Option<Int32>.Some(Int32(-37)),
                            Option<Int32>.Some(Int32(117)), Option<Int32>.Some(Int32(123)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(-7)), Option<Int32>.Some(Int32(119))], VArray<Unit, $3>({i => ()}),
                        UInt8(68), ([UInt64(112), UInt64(221), UInt64(200), UInt64(113), UInt64(184), UInt64(169),
                                UInt64(90), UInt64(63), UInt64(196), UInt64(26)], ([Option<Int32>.Some(Int32(7)),
                                    Option<Int32>.Some(Int32(125)), Option<Int32>.None, Option<Int32>.Some(Int32(-37)),
                                    Option<Int32>.Some(Int32(-26)), Option<Int32>.Some(Int32(-77)),
                                    Option<Int32>.Some(Int32(25)), Option<Int32>.Some(Int32(86)), Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-77))], r'l', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                    (Option<(UInt8, Bool)>.Some((UInt8(207), false)), Int32(-107)))), UInt16(94))), ((UInt8(251),
                            false), Int8(58), [Option<Int32>.None, Option<Int32>.Some(Int32(72)),
                            Option<Int32>.Some(Int32(119)), Option<Int32>.Some(Int32(-64)),
                            Option<Int32>.Some(Int32(-81)), Option<Int32>.Some(Int32(-43)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(-55)), Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({
                                i => ()
                            }), UInt8(112), ([UInt64(101), UInt64(41), UInt64(164), UInt64(26), UInt64(69), UInt64(86),
                                UInt64(208), UInt64(175), UInt64(20), UInt64(31)], ([Option<Int32>.Some(Int32(-11)),
                                    Option<Int32>.None, Option<Int32>.Some(Int32(-110)), Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-88)), Option<Int32>.Some(Int32(117)), Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.Some(Int32(-39)), Option<Int32>.None], r'w',
                                Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                    (Option<(UInt8, Bool)>.Some((UInt8(188), true)), Int32(-12)))), UInt16(189))),
                    UInt32(108))) {
                    case _: Class_1743341905737_44 => true
                    case _ => false
                })), Int8(-14), [(match (UInt8(Int8(4))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.Some(Int32(UInt32(19))),
                (match (((UInt32(UInt32(178)) & 127)..=(UInt32(UInt32(99)) & 127) : (Int64(-13) | 1))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match (Float64(Float64(10.0))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (Int8(UInt8(238))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.Some(Int32(84)), (match (###"jaqGUyee9k"###) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, Option<Int32>.Some(Int32(-77))], VArray<Unit, $3>(repeat: ()), UInt8(228), ([UInt64(159),
                    UInt64(125), UInt64(58), UInt64(188), UInt64(46), UInt64(238), UInt64(129), UInt64(254), UInt64(156),
                    UInt64(184)], ([Option<Int32>.Some(Int32(115)), Option<Int32>.None, Option<Int32>.Some(Int32(52)),
                        Option<Int32>.Some(Int32(112)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'A', (match ((UInt16(48), true,
                        UInt64(123), Float64(-121.0), Int32(125), UInt32(40), Float64(8.0), Float64(123.0), Int16(15))) {
                        case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                            newVar)
                        case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
                    })), UInt16(111)));
        throw Exception("demangle test");
        try { // block id: 894
            let var_1743341905737_897: (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>) = ([Option<Int32>
                    .None, (match (UInt64(37)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), (match (Option<Int32>.None) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }),
                    (match (((UInt8(84), true), Int8(-52), [Option<Int32>.Some(Int32(-90)),
                        Option<Int32>.Some(Int32(-85)), Option<Int32>.Some(Int32(-10)), Option<Int32>.Some(Int32(96)),
                        Option<Int32>.Some(Int32(122)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(-112))], VArray<Unit, $3>({i => ()}), UInt8(11), ([UInt64(169),
                            UInt64(20), UInt64(106), UInt64(62), UInt64(201), UInt64(29), UInt64(135), UInt64(70),
                            UInt64(133), UInt64(85)], ([Option<Int32>.Some(Int32(-23)), Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(54)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(-88)), Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.None], r'M', Option<(Option<(UInt8, Bool)>, Int32)>
                                .None), UInt16(6)))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(Int16(-87))), Option<Int32>.None,
                    (match ((match ((Int32(-33), ((Int32(Int32(-128)) & 127)..(Int32(Int32(0)) & 127) : (Int64(-72) | 1)),
                    ((Int16(Int16(40)) & 127)..=(Int16(Int16(28)) & 127) : (Int64(-79) | 1)), Option<Option<(Option<(UInt8, 
                            Bool)>, Int32)>>.None, (((Int32(Int32(-83)) & 127)..=(Int32(Int32(44)) & 127) : (Int64(13) |
                            1)), "<JthYD3&aK", UInt8(200), (Option<(UInt8, Bool)>.Some((UInt8(77), false)), Int32(-8)), ((UInt8(37),
                                true), Int8(-77), [Option<Int32>.Some(Int32(-92)), Option<Int32>.None,
                                Option<Int32>.Some(Int32(-74)), Option<Int32>.Some(Int32(59)),
                                Option<Int32>.Some(Int32(58)), Option<Int32>.None, Option<Int32>.Some(Int32(-125)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(29)), Option<Int32>.Some(Int32(-125))],
                            VArray<Unit, $3>(repeat: ()), UInt8(35), ([UInt64(212), UInt64(140), UInt64(142),
                                    UInt64(243), UInt64(212), UInt64(206), UInt64(20), UInt64(97), UInt64(41),
                                    UInt64(214)], ([Option<Int32>.None, Option<Int32>.Some(Int32(89)),
                                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                        Option<Int32>.Some(Int32(88)), Option<Int32>.None, Option<Int32>.Some(Int32(39)),
                                        Option<Int32>.None], r'F', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                        (Option<(UInt8, Bool)>.None, Int32(100)))), UInt16(226))), ((UInt8(175), true),
                            Int8(18), [Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-15)),
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.Some(Int32(-47)), Option<Int32>.Some(Int32(-66)),
                                Option<Int32>.Some(Int32(-67)), Option<Int32>.Some(Int32(-79))], VArray<Unit, $3>(repeat: ()),
                            UInt8(45), ([UInt64(15), UInt64(238), UInt64(217), UInt64(92), UInt64(28), UInt64(240),
                                    UInt64(40), UInt64(243), UInt64(181), UInt64(67)], ([Option<Int32>.None,
                                        Option<Int32>.Some(Int32(-36)), Option<Int32>.None,
                                        Option<Int32>.Some(Int32(32)), Option<Int32>.None, Option<Int32>.None,
                                        Option<Int32>.Some(Int32(21)), Option<Int32>.None, Option<Int32>.Some(Int32(33)),
                                        Option<Int32>.None], r's', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                        (Option<(UInt8, Bool)>.None, Int32(7)))), UInt16(143))), UInt32(34)))) {
                    case newVar: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, 
                            Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
                            Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                            VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                            Bool)>, Int32)>), UInt16)), UInt32) => Option<(Range<Int32>, String, UInt8, (Option<(UInt8, 
                            Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                            (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, 
                            Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                            Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.Some(newVar)
                    case _ => Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, 
                            Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
                            Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                            VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                            Bool)>, Int32)>), UInt16)), UInt32)>.None
                })) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), Option<Int32>.None], r'y', Option<(Option<(UInt8, Bool)>, Int32)>.None);
            (var_1743341905737_897, var_1743341905737_709, Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                    var_1743341905737_244), var_1743341905737_1098, var_1743341905737_863);
            let var_1743341905737_1111: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
                Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) = (((Int32(Int32(91)) &
                    127)..(Int32(Int32(-89)) & 127) : (Int64(76) | 1)), """
nIdS8
NUOr=
""", UInt8(UInt8(136)), (Option<(UInt8, 
                            Bool)>.None, Int32(1)), ((UInt8(98), (match (Option<(UInt8, Bool)>.None) {
                            case _: Bool => true
                            case _ => false
                        })), Int8(Int8(-91)), [(match (r'l') {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (((UInt64(UInt64(69)) & 127)..(UInt64(UInt64(152)) & 127) : (Int64(-93) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.Some(Int32(-113)), Option<Int32>.None,
                        (match (((Int8(Int8(4)) & 127)..(Int8(Int8(-93)) & 127) : (Int64(-98) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.Some(Int32(-120)), Option<Int32>.Some(Int32(-127)),
                        (match (((Int32(Int32(-47)) & 127)..=(Int32(Int32(54)) & 127) : (Int64(-92) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.Some(Int32(69)), (match (VArray<Unit, $3>({i => ()})) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    })], VArray<Unit, $3>({i => ()}), UInt8(UInt8(195)), ([UInt64(15), UInt64(215), UInt64(250),
                            UInt64(175), UInt64(163), UInt64(7), UInt64(204), UInt64(121), UInt64(25), UInt64(106)], ([Option<Int32>
                                .Some(Int32(-89)), Option<Int32>.Some(Int32(109)), Option<Int32>.Some(Int32(-51)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(-76)), Option<Int32>.None,
                                Option<Int32>.Some(Int32(-69)), Option<Int32>.None, Option<Int32>.Some(Int32(108)),
                                Option<Int32>.Some(Int32(80))], r'8', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                (Option<(UInt8, Bool)>.Some((UInt8(89), false)), Int32(-88)))), UInt16(236))), ((UInt8(181),
                        true), Int8(36), [(match ((((Int32(Int32(-44)) & 127)..(Int32(Int32(67)) & 127) : (Int64(-72) | 1)),
                        "gq`gcPCvjG", UInt8(111), (Option<(UInt8, Bool)>.None, Int32(78)), ((UInt8(242), true), Int8(-54),
                            [Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-38)),
                                Option<Int32>.Some(Int32(108)), Option<Int32>.Some(Int32(125)),
                                Option<Int32>.Some(Int32(-70)), Option<Int32>.None, Option<Int32>.Some(Int32(-27)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(-3))], VArray<Unit, $3>({i => ()}), UInt8(159),
                            ([UInt64(12), UInt64(91), UInt64(245), UInt64(248), UInt64(124), UInt64(169), UInt64(74),
                                    UInt64(117), UInt64(172), UInt64(128)], ([Option<Int32>.None, Option<Int32>.None,
                                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                        Option<Int32>.Some(Int32(112)), Option<Int32>.Some(Int32(62)),
                                        Option<Int32>.Some(Int32(-114)), Option<Int32>.Some(Int32(48))], r'f', Option<(Option<(UInt8, 
                                            Bool)>, Int32)>.None), UInt16(12))), ((UInt8(156), true), Int8(-86), [Option<Int32>
                                .Some(Int32(103)), Option<Int32>.None, Option<Int32>.Some(Int32(116)),
                                Option<Int32>.Some(Int32(85)), Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.Some(Int32(-90)), Option<Int32>.None,
                                Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(124), ([UInt64(121), UInt64(228),
                                    UInt64(111), UInt64(6), UInt64(141), UInt64(251), UInt64(219), UInt64(47),
                                    UInt64(158), UInt64(83)], ([Option<Int32>.None, Option<Int32>.Some(Int32(42)),
                                        Option<Int32>.Some(Int32(-88)), Option<Int32>.Some(Int32(-121)),
                                        Option<Int32>.Some(Int32(-12)), Option<Int32>.None,
                                        Option<Int32>.Some(Int32(-114)), Option<Int32>.Some(Int32(-109)),
                                        Option<Int32>.None, Option<Int32>.None], r'o', Option<(Option<(UInt8, Bool)>, 
                                            Int32)>.None), UInt16(19))), UInt32(51))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }),
                        (match ([Option<Int32>.None, Option<Int32>.Some(Int32(-40)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(-110)), Option<Int32>.Some(Int32(48)), Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-20)), Option<Int32>.None]) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (((Int64(Int64(29)) & 127)..=(Int64(Int64(89)) & 127) : (Int64(-87) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (r'i') {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.Some(Int32(-6)),
                        (match ([UInt64(113), UInt64(246), UInt64(209), UInt64(125), UInt64(106), UInt64(199),
                        UInt64(182), UInt64(120), UInt64(111), UInt64(157)]) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.None, (match ("""
.Z\"*c
Nt7Aw
""") {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.Some(Int32(-88)),
                        (match ([UInt64(37), UInt64(169), UInt64(129), UInt64(187), UInt64(54), UInt64(174), UInt64(27),
                        UInt64(158), UInt64(68), UInt64(147)]) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    })], VArray<Unit, $3>({i => ()}), UInt8(UInt8(UInt8(161))), ([UInt64(140), UInt64(165), UInt64(88),
                            UInt64(167), UInt64(39), UInt64(143), UInt64(163), UInt64(202), UInt64(176), UInt64(202)], ([Option<Int32>
                                .Some(Int32(34)), Option<Int32>.Some(Int32(-3)), Option<Int32>.Some(Int32(-55)),
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.Some(Int32(-39)), Option<Int32>.None, Option<Int32>.Some(Int32(1)),
                                Option<Int32>.None], r'n', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(Int8(-16)))),
                UInt32(105));
            let var_1743341905737_1387: Option<Int32> = Option<Int32>.None;
            let var_1743341905737_1402: Byte = UInt8(Int8(-83));
            var var_1743341905737_1408: ?(Option<(UInt8, Bool)>, Int32) = (match ((Option<(UInt8, Bool)>.Some(
                    (UInt8(236), true)), Int32(39))) {
                case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
            });
            (var_1743341905737_1107,
                Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                        (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                        UInt32)>.Some(var_1743341905737_1111), (([var_1743341905737_118, var_1743341905737_1387,
                            var_1743341905737_108, var_1743341905737_108, var_1743341905737_108, Option<Int32>.None,
                            var_1743341905737_1387, var_1743341905737_108, Option<Int32>.None,
                            Option<Int32>.Some(Int32(-61))], var_1743341905737_470, Option<(Option<(UInt8, Bool)>, Int32)>
                            .None), ((UInt8(var_1743341905737_1402) & 127)..=(UInt8(UInt8(120)) & 127) : (var_1743341905737_863 |
                        1)), var_1743341905737_1408, var_1743341905737_1098, Int64(-125)), var_1743341905737_1419,
                var_1743341905737_823)[1];
            (var_1743341905737_1098, Int8(14), var_1743341905737_1519, var_1743341905737_1673, UInt8(228),
                var_1743341905737_1677)
        } catch (e: Exception) { // block id: 1771
            if (var_1743341905737_80) { // block id: 1774
                var_1743341905737_810 & UInt64(147);
                var_1743341905737_1779;
                var_1743341905737_1779
            } else if (false) { // block id: 1783
                UInt64(61) % ((UInt64(170)) | 1);
                var_1743341905737_1779
            };
            var_1743341905737_1779;
            var var_1743341905737_1796: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) = ((UInt8(Int8(Int8(-12))),
                    false), Int8(-63), [Option<Int32>.Some(Int32(UInt16(188))),
                    (match ((Option<(UInt8, Bool)>.None, Int32(-49))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), Option<Int32>.Some(Int32(-9)), (match (Int64(-92)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), Option<Int32>.Some(Int32(UInt8(104))), Option<Int32>.None, Option<Int32>.Some(Int32(Int16(-52))),
                    (match (((Int16(Int16(2)) & 127)..(Int16(Int16(67)) & 127) : (Int64(-32) | 1))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), (match (Int8(UInt8(195))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                }), (match (((UInt64(UInt64(51)) & 127)..(UInt64(UInt64(94)) & 127) : (Int64(-25) | 1))) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                })], VArray<Unit, $3>({i => ()}), UInt8(48), ([UInt64(91), UInt64(53), UInt64(196), UInt64(104),
                        UInt64(157), UInt64(137), UInt64(234), UInt64(139), UInt64(195), UInt64(17)], ([Option<Int32>
                            .None, Option<Int32>.Some(Int32(-30)), Option<Int32>.Some(Int32(95)),
                            Option<Int32>.Some(Int32(-48)), Option<Int32>.None, Option<Int32>.Some(Int32(83)),
                            Option<Int32>.Some(Int32(38)), Option<Int32>.Some(Int32(89)), Option<Int32>.Some(Int32(-16)),
                            Option<Int32>.None], r'2', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                            (Option<(UInt8, Bool)>.None, Int32(125)))), UInt16(UInt8(42))));
            (match (Option<((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))>.Some(var_1743341905737_1796)) {
                case Some(num) => num
                case None => var_1743341905737_1796
            })
        } finally { // block id: 1864
            if (true) { // block id: 1867
                ();
                if (var_1743341905737_693) {
                    r'N'
                } else {
                    r'w'
                }
            } else if (var_1743341905737_80) { // block id: 1874
                (var_1743341905737_1877, Int32(15));
                var_1743341905737_470
            } else { // block id: 1881
                var_1743341905737_806 = var_1743341905737_806
                var_1743341905737_470
            };
            var var_1743341905737_2144: Float64 = Float64(Float32(Float32(24.0)));
            try { // block id: 1887
                UInt32(62);
                var_1743341905737_1779;
                let var_1743341905737_1891: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                    (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) = ((UInt8(56), (match (UInt16(3)) {
                            case _: Int8 => true
                            case _ => false
                        })), Int8(Int8(-27)), [(match ([UInt64(191), UInt64(200), UInt64(147), UInt64(107), UInt64(250),
                        UInt64(212), UInt64(182), UInt64(131), UInt64(197), UInt64(38)]) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }),
                        (match (((UInt8(191), false), Int8(-46), [Option<Int32>.Some(Int32(-29)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(-103)), Option<Int32>.Some(Int32(42)), Option<Int32>.None,
                            Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-102)),
                            Option<Int32>.Some(Int32(86)), Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(36), ([UInt64(82),
                                UInt64(232), UInt64(161), UInt64(153), UInt64(158), UInt64(48), UInt64(175), UInt64(202),
                                UInt64(162), UInt64(64)], ([Option<Int32>.None, Option<Int32>.Some(Int32(-4)),
                                    Option<Int32>.Some(Int32(50)), Option<Int32>.Some(Int32(108)),
                                    Option<Int32>.Some(Int32(89)), Option<Int32>.Some(Int32(-105)),
                                    Option<Int32>.Some(Int32(-27)), Option<Int32>.None, Option<Int32>.Some(Int32(73)),
                                    Option<Int32>.None], r'k', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(121)))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.None, Option<Int32>.None, (match ((match (false) {
                        case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                            newVar)
                        case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
                    })) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }),
                        (match (Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
                            Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                            Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                            VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                            Bool)>, Int32)>), UInt16)), UInt32)>.Some(
                        (((Int32(Int32(114)) & 127)..=(Int32(Int32(-88)) & 127) : (Int64(-80) | 1)), "1E*:4_ wWt", UInt8(40),
                            (Option<(UInt8, Bool)>.None, Int32(48)), ((UInt8(8), false), Int8(5), [Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.Some(Int32(-81)), Option<Int32>.None,
                                    Option<Int32>.Some(Int32(35)), Option<Int32>.None, Option<Int32>.Some(Int32(35)),
                                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({
                                        i => ()
                                    }), UInt8(178), ([UInt64(25), UInt64(3), UInt64(101), UInt64(191), UInt64(177),
                                        UInt64(96), UInt64(128), UInt64(126), UInt64(65), UInt64(232)], ([Option<Int32>
                                            .None, Option<Int32>.Some(Int32(-39)), Option<Int32>.None,
                                            Option<Int32>.Some(Int32(55)), Option<Int32>.None,
                                            Option<Int32>.Some(Int32(24)), Option<Int32>.Some(Int32(16)),
                                            Option<Int32>.Some(Int32(-32)), Option<Int32>.None, Option<Int32>.None], r'7',
                                        Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                            (Option<(UInt8, Bool)>.Some((UInt8(173), true)), Int32(17)))), UInt16(91))),
                            ((UInt8(103), true), Int8(-17), [Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-23)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.Some(Int32(35)), Option<Int32>.Some(Int32(-98)),
                                    Option<Int32>.Some(Int32(49)), Option<Int32>.Some(Int32(-60))], VArray<Unit, $3>({
                                        i => ()
                                    }), UInt8(90), ([UInt64(205), UInt64(218), UInt64(135), UInt64(191), UInt64(37),
                                        UInt64(37), UInt64(35), UInt64(232), UInt64(215), UInt64(227)], ([Option<Int32>
                                            .Some(Int32(-73)), Option<Int32>.None, Option<Int32>.Some(Int32(-52)),
                                            Option<Int32>.None, Option<Int32>.Some(Int32(-69)), Option<Int32>.None,
                                            Option<Int32>.None, Option<Int32>.Some(Int32(-46)), Option<Int32>.None,
                                            Option<Int32>.None], r'R', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                            (Option<(UInt8, Bool)>.None, Int32(-18)))), UInt16(47))), UInt32(110)))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (((Int32(Int32(41)) & 127)..(Int32(Int32(-105)) & 127) : (Int64(-23) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.None, Option<Int32>.Some(Int32(UInt16(209))),
                        (match (Option<(Option<(UInt8, Bool)>, Int32)>.None) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    })], VArray<Unit, $3>({i => ()}), UInt8(8), ([UInt64(93), UInt64(0), UInt64(190), UInt64(15),
                            UInt64(63), UInt64(247), UInt64(166), UInt64(104), UInt64(38), UInt64(171)], ([Option<Int32>
                                .Some(Int32(-6)), Option<Int32>.Some(Int32(108)), Option<Int32>.Some(Int32(-13)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(-67)), Option<Int32>.Some(Int32(-8)),
                                Option<Int32>.Some(Int32(21)), Option<Int32>.Some(Int32(43)), Option<Int32>.None,
                                Option<Int32>.Some(Int32(-88))], r'L', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                (Option<(UInt8, Bool)>.Some((UInt8(193), true)), Int32(14)))), UInt16(Int16(69))));
                var_1743341905737_1891
            } finally { // block id: 2141
                var_1743341905737_2144 = var_1743341905737_2144 * (Float64(-106.0))
                var_1743341905737_2151 = var_1743341905737_2151 + (var_1743341905737_2151)
                var_1743341905737_2156
            }
        }
    }
}

public open class Class_1743341905737_44 <: Interface_1743341905737_47 & Interface_1743341905737_48<UInt8> {
    @Frozen
    public Class_1743341905737_44() { // block id: 46

    }

    static var var_1743341905737_312: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
        (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))

    @Frozen
    static mut prop var_1743341905737_364: Int8 { // block id: 365
        get() { // block id: 367
            Int8(UInt8(253))
        }
        set(Value) { // block id: 372
            r'R';
            ();
            ()
        }
    }
    public static var var_1743341905737_429: Unit

    @Frozen
    public static prop var_1743341905737_438: Array<Option<Int32>> { // block id: 439
        get() { // block id: 441
            UInt8(93);
            ();
            [(match ("~[kiWNG^uy") {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (((UInt16(UInt16(133)) & 127)..=(UInt16(UInt16(207)) & 127) : (Int64(-88) | 1))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match (Int64(UInt32(240))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match (Int16(Int8(56))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match (UInt32(Int32(-126))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (UInt16(Int16(-17))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (((Int64(Int64(-75)) & 127)..=(Int64(Int64(75)) & 127) : (Int64(-40) | 1))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            })]
        }
    }

    @Frozen
    public mut prop var_1743341905737_874: Unit { // block id: 875
        get() { // block id: 877
            ();
            ()
        }
        set(Value) { // block id: 882
            ()
        }
    }
    private static var var_1743341905737_2702: Int
    static func func_1743341905737_301<T0>(param_1743341905737_302: (Option<(UInt8, Bool)>, Int32)): Range<UInt16> { // block id: 303
        var var_1743341905737_383: Bool = (match (VArray<Unit, $3>({i => ()})) {
            case _: String => true
            case _ => false
        });
        let var_1743341905737_399: Option<Int32> = (match (((UInt16(UInt16(104)) & 127)..=(UInt16(UInt16(UInt8(UInt8(110)))) &
            127) : (Int64(82) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        });
        let var_1743341905737_423: Int32 = Int32(Int32(103));
        try { // block id: 309
            ();
            var_1743341905737_312
        } catch (e: Exception) { // block id: 361
            var_1743341905737_364 *= var_1743341905737_364
            var_1743341905737_364--;
            var_1743341905737_312
        } finally { // block id: 380
            var_1743341905737_383 = var_1743341905737_383 && (true)
            var var_1743341905737_393: Byte = UInt8(218);
            var var_1743341905737_473: ?(Option<(UInt8, Bool)>, Int32) = (match (Int8(Int8(-101))) {
                case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
            });
            ((var_1743341905737_393, true), Int8(22), [var_1743341905737_399, var_1743341905737_408,
                    Option<Int32>.Some(Int32(-96)), Option<Int32>.None, var_1743341905737_118, var_1743341905737_118,
                    var_1743341905737_408, var_1743341905737_108, Option<Int32>.Some(var_1743341905737_423),
                    var_1743341905737_399], VArray<Unit, $3>(repeat: var_1743341905737_429), UInt8(162), ([UInt64(250),
                        UInt64(211), UInt64(149), UInt64(57), UInt64(142), UInt64(69), UInt64(68), UInt64(94),
                        UInt64(110), UInt64(209)], (var_1743341905737_438, var_1743341905737_470, var_1743341905737_473),
                    UInt16(107)))
        }[3][2];
        var var_1743341905737_2582: Array<UInt64> = [UInt64(91), UInt64(12), UInt64(Int8(Int8(UInt8(119)))),
            UInt64(Int64(Int32(Int8(26)))), UInt64(66), UInt64(Int16(UInt16(157))), UInt64(UInt64(Int64(39))),
            UInt64(23), UInt64(UInt16(Int8(Int8(110)))), UInt64(Int16(-91))];
        func_1743341905737_483((var_1743341905737_2582, var_1743341905737_2609, UInt16(236)))[3];
        let var_1743341905737_2671: Range<UInt16> = ((UInt16(UInt16(UInt8(103))) & 127)..=(UInt16(UInt16(Int8(UInt8(13)))) &
            127) : (Int64(2) | 1));
        var var_1743341905737_2731: Int64 = Int64(Int32(-62));
        var var_1743341905737_2780: ?(Option<(UInt8, Bool)>, Int32) = Option<(Option<(UInt8, Bool)>, Int32)>.None;
        try { // block id: 2658
            if (true) { // block id: 2661
                ((UInt16(UInt16(59)) & 127)..(UInt16(var_1743341905737_2151) & 127) : (Int64(91) | 1))
            } else if (true) { // block id: 2667
                ();
                var_1743341905737_429;
                var_1743341905737_2671
            } else { // block id: 2679
                ((UInt16(UInt16(179)) & 127)..(UInt16(UInt16(147)) & 127) : (Int64(71) | 1))
            }
        } catch (_) { // block id: 2681
            match (var_1743341905737_2686) {
                case defaultValue => var_1743341905737_1779

                case defaultValue =>
                    var_1743341905737_2702 = var_1743341905737_863
                    ()

                case enumValue_1743341905737_2688((caseVar_1743341905737_2708: Range<Int64>, caseVar_1743341905737_2709: Array<Bool>)) => var_1743341905737_1779

                case _ =>
                    var_1743341905737_2702 = var_1743341905737_2702 + 1
                    var var_1743341905737_2718: Range<Int8> = ((Int8(Int8(Int8(-57))) & 127)..=(Int8(Int8(Int8(65))) &
                        127) : (Int64(9) | 1));
                    var_1743341905737_2718;
                    ()
            };
            var var_1743341905737_2743: VArray<Unit, $3> = [(), (), ()];
            try { // block id: 2727
                var_1743341905737_2702 = var_1743341905737_2702 ^ (var_1743341905737_2731)
                UInt16(143) | UInt16(254);
                ((UInt16(var_1743341905737_2151) & 127)..=(UInt16(var_1743341905737_2151) & 127) : (var_1743341905737_863 |
                    1))
            } finally { // block id: 2741
                var_1743341905737_2743;
                if (false) {
                    ((UInt16(UInt16(42)) & 127)..=(UInt16(UInt16(235)) & 127) : (Int64(-117) | 1))
                } else {
                    ((UInt16(UInt16(96)) & 127)..(UInt16(UInt16(198)) & 127) : (Int64(-127) | 1))
                }
            }
        } finally { // block id: 2752
            var var_1743341905737_2758: Struct_1743341905737_2754 = Struct_1743341905737_2754();
            var_1743341905737_2758.var_1743341905737_2761;
            (match (Option<Unit>.Some(var_1743341905737_1779)) {
                case Some(num) => num
                case None => ()
            });
            if (var_1743341905737_80) { // block id: 2776
                ();
                Option<Option<(Option<(UInt8, Bool)>, Int32)>>.Some(var_1743341905737_2780);
                ((UInt16(UInt16(186)) & 127)..=(UInt16(UInt16(130)) & 127) : (Int64(114) | 1))
            } else if (true) { // block id: 2787
                ((Int32(Int32(-89)) & 127)..=(Int32(Int32(30)) & 127) : (Int64(88) | 1));
                ((UInt16(UInt16(27)) & 127)..(UInt16(UInt16(120)) & 127) : (Int64(-81) | 1))
            } else { // block id: 2790
                ((UInt16(UInt16(191)) & 127)..=(UInt16(var_1743341905737_2151) & 127) : (Int64(-72) | 1))
            }
        }
    };

    public let var_1743341905737_3039: (Option<(UInt8, Bool)>, Int32) = (Option<(UInt8, Bool)>.None, Int32(126));

    @Frozen
    private static prop var_1743341905737_3924: (Option<(UInt8, Bool)>, Int32) { // block id: 3925
        get() { // block id: 3927
            ((match ((match (UInt64(55)) {
                    case newVar: Int32 => Option<Int32>.Some(newVar)
                    case _ => Option<Int32>.None
                })) {
                    case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                    case _ => Option<(UInt8, Bool)>.None
                }), Int32(UInt32(79)))
        }
    }

    @Frozen
    static mut prop var_1743341905737_3937: ?(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, 
        Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
        (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) { // block id: 3938
        get() { // block id: 3940
            ((UInt32(UInt32(0)) & 127)..=(UInt32(UInt32(5)) & 127) : (Int64(-14) | 1));
            ();
            Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                    VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                    Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                    (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None;
            var_1743341905737_4632
        }
        set(Value) { // block id: 3949
            ();
            ();
            var_1743341905737_4632 = Value
        }
    }
    private static const var_1743341905737_3958: String = "YjO}HIwz$(";
    private static let var_1743341905737_4079: Unit
    public static func func_1743341905737_301(param_1743341905737_52: Unit): Unit { // block id: 53
        let var_1743341905737_3913: (UInt64) -> (UInt16, Bool, UInt64, Float64, Int32, UInt32, Float64, Float64, Int16) = func_1743341905737_57;
        (var_1743341905737_3913(var_1743341905737_810))[4];
        var var_1743341905737_3921: ?(Option<(UInt8, Bool)>, Int32) = Option<(Option<(UInt8, Bool)>, Int32)>.None;
        let var_1743341905737_3967: VArray<Unit, $3> = [(), (), ()];
        try { // block id: 3918
            (match (var_1743341905737_3921) {
                case Some(num) => num
                case None => var_1743341905737_3924
            });
            var_1743341905737_3424;
            let var_1743341905737_4004: Array<UInt64> = [UInt64(140), UInt64(31), UInt64(54), UInt64(62), UInt64(178),
                UInt64(97), UInt64(54), UInt64(112), UInt64(5), UInt64(223)];
            let var_1743341905737_4008: UInt16 = UInt16(UInt8(Int8(Int8(Int8(-56)))));
            (match (var_1743341905737_3937) {
                case Some(num) => num
                case None => (((Int32(Int32(-4)) & 127)..=(Int32(var_1743341905737_2982) & 127) : (var_1743341905737_2702 |
                        1)), var_1743341905737_3958, var_1743341905737_2828, var_1743341905737_3924, (var_1743341905737_2518,
                        var_1743341905737_364, var_1743341905737_438, var_1743341905737_3967, var_1743341905737_2828, ([UInt64(207),
                                UInt64(241), UInt64(177), UInt64(191), UInt64(56), UInt64(248), UInt64(168), UInt64(46),
                                UInt64(119), UInt64(88)], ([var_1743341905737_408, Option<Int32>.Some(Int32(-111)),
                                    var_1743341905737_108, Option<Int32>.Some(Int32(81)), Option<Int32>.Some(Int32(-22)),
                                    Option<Int32>.Some(Int32(-61)), var_1743341905737_118, var_1743341905737_408,
                                    Option<Int32>.None, Option<Int32>.None], r't', var_1743341905737_3921),
                            var_1743341905737_2151)), ((UInt8(223), false), Int8(59), var_1743341905737_438,
                        var_1743341905737_3967, var_1743341905737_2828, (var_1743341905737_4004, var_1743341905737_2609,
                            var_1743341905737_4008)), UInt32(21))
            })
        } catch (e: Exception) { // block id: 4015
            (((Int32(Int32(-21)) & 127)..(Int32(Int32(-50)) & 127) : (Int64(-81) | 1)), var_1743341905737_3958,
                var_1743341905737_4020, (Option<(UInt8, Bool)>.Some(var_1743341905737_2518), Int32(-3)),
                var_1743341905737_2891, var_1743341905737_312, var_1743341905737_2577)
        };
        match ((match ([var_1743341905737_2686,
            Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518),
            Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(125), true)),
            Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518),
            Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518), var_1743341905737_2686,
            Enum_1743341905737_2683.enumValue_1743341905737_2688((var_1743341905737_4020, var_1743341905737_80)),
            var_1743341905737_2686, var_1743341905737_2686,
            Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_4054)][6]) {
            case newVar: Unit => Option<Unit>.Some(newVar)
            case _ => Option<Unit>.None
        })) {
            case _: Range<UInt64> =>
                UInt16(32);
                var_1743341905737_2351;
                var_1743341905737_3066 = var_1743341905737_3066 + (Int32(-60))

            case _ =>
                var_1743341905737_1779;
                var_1743341905737_2518;
                ()

            case _ =>
                ();
                var_1743341905737_4079;
                var_1743341905737_4020 = var_1743341905737_4020 - (UInt8(137))

            case caseVar_1743341905737_4086 =>
                ();
                var_1743341905737_4020 = var_1743341905737_4020 - 1
                var var_1743341905737_4094: Int8 = Int8(-128);
                var_1743341905737_364 <<= ((var_1743341905737_4094) & 7)

            case _ =>
                var_1743341905737_810 = var_1743341905737_810 - 1
                let var_1743341905737_4113: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
                    Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
                    Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                    VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                    Int32)>), UInt16)), UInt32) = (((Int32(Int32(Int8(-26))) & 127)..=(Int32(Int32(UInt32(205))) & 127) : (Int64(-95) |
                        1)), "KODKa{zu[jh", UInt8(63), (Option<(UInt8, Bool)>.None, Int32(Int32(Int8(44)))), ((UInt8(74),
                            (match ([Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(114)),
                                Option<Int32>.Some(Int32(14)), Option<Int32>.None, Option<Int32>.Some(Int32(-95)),
                                Option<Int32>.Some(Int32(83)), Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.Some(Int32(39))]) {
                                case _: Enum_1743341905737_2683 => true
                                case _ => false
                            })), Int8(-94), [(match ([UInt64(0), UInt64(29), UInt64(62), UInt64(93), UInt64(200),
                            UInt64(196), UInt64(79), UInt64(105), UInt64(100), UInt64(220)]) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), (match (Option<Range<Int8>>.None) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(83)),
                            Option<Int32>.Some(Int32(54)), Option<Int32>.Some(Int32(-125)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(-120))], VArray<Unit, $3>({i => ()}), UInt8(UInt8(46)), ([UInt64(11),
                                UInt64(165), UInt64(85), UInt64(177), UInt64(203), UInt64(96), UInt64(38), UInt64(32),
                                UInt64(240), UInt64(253)], ([Option<Int32>.Some(Int32(0)), Option<Int32>.Some(Int32(71)),
                                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-73)),
                                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None], r'1', Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                    (Option<(UInt8, Bool)>.None, Int32(109)))), UInt16(203))), ((UInt8(199), false),
                        Int8(-82), [(match (Option<(UInt8, Bool)>.Some((UInt8(38), false))) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), (match (((UInt8(UInt8(230)) & 127)..=(UInt8(UInt8(135)) & 127) : (Int64(-31) | 1))) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(45)),
                            (match (Option<Option<(Option<(UInt8, Bool)>, Int32)>>.None) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), (match (UInt64(89)) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }),
                            (match (((UInt8(189), true), Int8(0), [Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.Some(Int32(75)), Option<Int32>.None,
                                Option<Int32>.Some(Int32(-4))], VArray<Unit, $3>({i => ()}), UInt8(22), ([UInt64(75),
                                    UInt64(114), UInt64(12), UInt64(209), UInt64(62), UInt64(165), UInt64(22),
                                    UInt64(192), UInt64(82), UInt64(180)], ([Option<Int32>.Some(Int32(71)),
                                        Option<Int32>.Some(Int32(61)), Option<Int32>.Some(Int32(-128)),
                                        Option<Int32>.Some(Int32(-82)), Option<Int32>.None,
                                        Option<Int32>.Some(Int32(-125)), Option<Int32>.Some(Int32(29)),
                                        Option<Int32>.Some(Int32(-119)), Option<Int32>.None,
                                        Option<Int32>.Some(Int32(-110))], r'N',
                                    Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                        (Option<(UInt8, Bool)>.Some((UInt8(212), true)), Int32(49)))), UInt16(217)))) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), (match (Option<Int64>.Some(Int64(116))) {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        }), (match ("H.GWbb2+^9") {
                            case newVar: Int32 => Option<Int32>.Some(newVar)
                            case _ => Option<Int32>.None
                        })], VArray<Unit, $3>({i => ()}), UInt8(UInt8(85)), ([UInt64(174), UInt64(148), UInt64(254),
                                UInt64(81), UInt64(123), UInt64(122), UInt64(27), UInt64(209), UInt64(108), UInt64(1)], ([Option<Int32>
                                    .Some(Int32(-43)), Option<Int32>.None, Option<Int32>.Some(Int32(-38)),
                                    Option<Int32>.Some(Int32(51)), Option<Int32>.Some(Int32(109)),
                                    Option<Int32>.Some(Int32(91)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.Some(Int32(95))], r'H',
                                Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(119)))),
                            UInt16(UInt16(73)))), UInt32(UInt8(140)));
                (var_1743341905737_855, var_1743341905737_4104, ((Int16(Int16(-40)) & 127)..(Int16(Int16(-60)) & 127) : (Int64(11) |
                        1)), var_1743341905737_238, var_1743341905737_4113);
                var_1743341905737_1779
        }
        return
    };

    static var var_1743341905737_4632: ?(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
        Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
        (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) = Option<(Range<Int32>, 
            String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
            UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, 
            Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
            Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None;
    private static var var_1743341905737_4671: Int16 = Int16(119);
    public static var var_1743341905737_4770: Option<Int32> = Option<Int32>.None;
    static let var_1743341905737_5173: Bool = true;
    public static func func_1743341905737_667(
        namedParam_1743341905737_668!: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
            Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
            Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
            (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32),
        namedParam_1743341905737_669!: Option<Int32>,
        namedParam_1743341905737_670!: Option<(Option<(UInt8, Bool)>, Int32)>,
        namedParam_1743341905737_671!: (UInt8, Bool)): ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
        UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) { // block id: 4639
        let var_1743341905737_4690: Option<Int32> = Option<Int32>.Some(Int32(-91));
        let var_1743341905737_4733: UInt8 = UInt8(49);
        const var_1743341905737_4741: UInt8 = 115;
        var var_1743341905737_4796: Option<Int32> = (match (((UInt8(Int8(61)), false), Int8(-59), [(match (["5sTR?Zy8L0",
                """
zb(%k
`!|F)
""", ###"aGhr$\\=@`b"###, """
z)0op
'C!rC
""", "pb/^>lwg\"y", """
gr7!u
v2X*8
""",
                "|FvN)a{ y|}", "s`2HoJdI.X", """
ZVS~ 
N1N[a{
""", "F31oO4>:w("]) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match ([true, true, false, false, true, true, false, true, true, false]) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, (match ((Option<(UInt8, Bool)>.Some((UInt8(58), false)), Int32(1))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (Int32(-118)) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (UInt16(143)) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-93))], VArray<Unit, $3>({
                    i => ()
                }), UInt8(Int8(UInt8(70))), ([UInt64(114), UInt64(201), UInt64(120), UInt64(61), UInt64(8), UInt64(137),
                    UInt64(65), UInt64(198), UInt64(234), UInt64(204)], ([Option<Int32>.Some(Int32(-59)),
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-77)),
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(101)),
                        Option<Int32>.Some(Int32(16)), Option<Int32>.None], r'K',
                    Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                        (Option<(UInt8, Bool)>.Some((UInt8(6), false)), Int32(-63)))), UInt16(74)))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        });
        var var_1743341905737_5078: VArray<Unit, $3> = [(), (), ()];
        var var_1743341905737_5189: ?(Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>) = Option<(Array<Option<Int32>>, 
                Rune, Option<(Option<(UInt8, Bool)>, Int32)>)>.None;
        ((UInt8(216), false), match (Float64(6.0)) {
                case 116.0 =>
                    ();
                    var_1743341905737_429;
                    var_1743341905737_364

                case 111.0 | 0.0 | -94.0 | 24.0 => Int8(13)

                case -101.0 | -62.0 =>
                    Option<((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                            Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))>.None;
                    var_1743341905737_4662 - Float32(78.0);
                    Int8(49)

                case 83.0 =>
                    var_1743341905737_4671 = var_1743341905737_4671 >> ((var_1743341905737_4671) & 7)
                    var_1743341905737_364

                case _ => var_1743341905737_364
            }, [[Option<Int32>.None, var_1743341905737_408, Option<Int32>.Some(Int32(-6)), Option<Int32>.None,
                Option<Int32>.Some(Int32(33)), var_1743341905737_4690, Option<Int32>.Some(var_1743341905737_2982),
                Option<Int32>.Some(Int32(-32)), var_1743341905737_4698, var_1743341905737_4698][4],
                match ([var_1743341905737_3487, Float64(113.0), Float64(-6.0), var_1743341905737_3487,
                var_1743341905737_3487, Float64(-56.0), Float64(-51.0), var_1743341905737_3487, var_1743341905737_3487,
                Float64(107.0)]) {
                case _ =>
                    Option<Int64>.None;
                    Option<Int32>.None
            },
                match ([Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(236), var_1743341905737_693)),
                Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518),
                Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518), var_1743341905737_2686,
                Enum_1743341905737_2683.enumValue_1743341905737_2688((var_1743341905737_4733, var_1743341905737_693)),
                var_1743341905737_2686, var_1743341905737_2686,
                Enum_1743341905737_2683.enumValue_1743341905737_2688((var_1743341905737_4741, var_1743341905737_693)),
                Enum_1743341905737_2683.enumValue_1743341905737_2688((var_1743341905737_4733, true)),
                Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_2518)]) {
                case caseVar_1743341905737_4752 =>
                    var_1743341905737_4755;
                    var_1743341905737_693;
                    var_1743341905737_4698

                case caseVar_1743341905737_4762 =>
                    var_1743341905737_438;
                    let var_1743341905737_4766: Option<(UInt8, Bool)> = (match ([true, false, false, true, true, true,
                        false, false, true, true]) {
                        case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                        case _ => Option<(UInt8, Bool)>.None
                    });
                    var_1743341905737_4766;
                    var_1743341905737_4770

                case _ =>
                    var_1743341905737_2151 = var_1743341905737_2151 | (UInt16(254))
                    var_1743341905737_4779;
                    var_1743341905737_4788
            }, Option<Int32>.Some(var_1743341905737_2982), if (var_1743341905737_693) {
                var_1743341905737_4770
            } else {
                var_1743341905737_4796
            }, match (Float32(8.0)) {
                case caseVar_1743341905737_4874: Option<Unit> =>
                    var var_1743341905737_4877: Array<Enum_1743341905737_2683> = [Enum_1743341905737_2683
                        .enumValue_1743341905737_2688((UInt8(170), false)),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(UInt8(180)), false)),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688(
                        (UInt8(Int8(64)), (match (Option<Option<(Option<(UInt8, Bool)>, Int32)>>.None) {
                                case _: Array<String> => true
                                case _ => false
                            }))),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688(
                        (UInt8(Int8(-78)), (match ((((UInt32(UInt32(161)) & 127)..(UInt32(UInt32(236)) & 127) : (Int64(35) |
                                    1)), Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, 
                                        Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                                        Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, 
                                        Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                                        Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None, (([Option<Int32>
                                            .Some(Int32(-39)), Option<Int32>.Some(Int32(13)), Option<Int32>.None,
                                            Option<Int32>.None, Option<Int32>.Some(Int32(-46)),
                                            Option<Int32>.Some(Int32(-27)), Option<Int32>.None, Option<Int32>.None,
                                            Option<Int32>.None, Option<Int32>.Some(Int32(-61))], r'P', Option<(Option<(UInt8, 
                                                Bool)>, Int32)>.None), ((UInt8(UInt8(210)) & 127)..=(UInt8(UInt8(33)) &
                                        127) : (Int64(116) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.None, (UInt8(193),
                                        true), Int64(-118)), (([Option<Int32>.Some(Int32(27)),
                                            Option<Int32>.Some(Int32(-20)), Option<Int32>.Some(Int32(-2)),
                                            Option<Int32>.Some(Int32(-109)), Option<Int32>.None,
                                            Option<Int32>.Some(Int32(76)), Option<Int32>.None, Option<Int32>.None,
                                            Option<Int32>.Some(Int32(90)), Option<Int32>.None], r'q', Option<(Option<(UInt8, 
                                                Bool)>, Int32)>.None), ((UInt8(UInt8(228)) & 127)..(UInt8(UInt8(65)) &
                                        127) : (Int64(40) | 1)), Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                        (Option<(UInt8, Bool)>.None, Int32(35))), (UInt8(126), true), Int64(22)), Int16(-79))) {
                                case _: Option<UInt32> => true
                                case _ => false
                            }))),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(21), (match (Option<Unit>.None) {
                            case _: Range<UInt8> => true
                            case _ => false
                        }))), Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(UInt8(24)), false)),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(234), (match (Float64(103.0)) {
                            case _: (UInt8, Bool) => true
                            case _ => false
                        }))), Enum_1743341905737_2683.enumValue_1743341905737_2688((UInt8(170), false)),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688(
                        (UInt8(Int8(86)), (match (Option<Int64>.None) {
                                case _: String => true
                                case _ => false
                            }))),
                        Enum_1743341905737_2683.enumValue_1743341905737_2688(
                        (UInt8(208), (match (((UInt32(UInt32(209)) & 127)..(UInt32(UInt32(10)) & 127) : (Int64(-122) | 1))) {
                                case _: Option<(Option<(UInt8, Bool)>, Int32)> => true
                                case _ => false
                            })))];
                    var_1743341905737_4877;
                    Option<Int32>.None

                case caseVar_1743341905737_4998: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, 
                        Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                        Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), UInt32) =>
                    var_1743341905737_429;
                    var_1743341905737_4698

                case _ =>
                    var_1743341905737_1779;
                    Float64(4.0);
                    if (var_1743341905737_693) {
                        var_1743341905737_118
                    } else {
                        Option<Int32>.None
                    }
            }, if (true) {
                Option<Int32>.Some(Int32(-93))
            } else {
                Option<Int32>.Some(Int32(23))
            }, (match (Option<Option<Int32>>.Some(Option<Int32>.Some(var_1743341905737_2982))) {
                case Some(num) => num
                case None => var_1743341905737_408
            }), var_1743341905737_438[7], if (true) {
                var_1743341905737_4690
            } else {
                var_1743341905737_4690
            }], match (try { // block id: 5035
                var_1743341905737_5038 = var_1743341905737_5038 ^ (var_1743341905737_4733)
                var_1743341905737_438
            } finally { // block id: 5042
                var_1743341905737_3451;
                var_1743341905737_438
            }) {
                case _: Option<Range<Int8>> => VArray<Unit, $3>(repeat: ())

                case caseVar_1743341905737_5054: (Range<UInt32>, Option<(Range<Int32>, String, UInt8, (Option<(UInt8, 
                        Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                        (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, Bool), 
                        Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                        Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>, ((Array<Option<Int32>>, Rune, 
                        Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, Option<(Option<(UInt8, Bool)>, Int32)>, (UInt8, 
                        Bool), Int64), ((Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, 
                        Option<(Option<(UInt8, Bool)>, Int32)>, (UInt8, Bool), Int64), Int16) =>
                    var_1743341905737_2609;
                    VArray<Unit, $3>({i => ()})

                case caseVar_1743341905737_5063: Int32 =>
                    if (var_1743341905737_693) {
                        "IAHVs:,VJ|"
                    } else {
                        var_1743341905737_3958
                    };
                    var_1743341905737_3924;
                    VArray<Unit, $3>({i => ()})

                case _ => var_1743341905737_5078

                case _ =>
                    var_1743341905737_1779;
                    [Option<Int32>.None, var_1743341905737_408, Option<Int32>.Some(Int32(33)), var_1743341905737_4796,
                        Option<Int32>.None, var_1743341905737_4698, var_1743341905737_108,
                        Option<Int32>.Some(Int32(-116)), Option<Int32>.Some(Int32(-97)), Option<Int32>.None];
                    VArray<Unit, $3>({i => ()})
            }, (match ((match (var_1743341905737_5116) {
                case Some(num) => num
                case None => Option<UInt8>.None
            })) {
                case Some(num) => num
                case None => try { // block id: 5121
                    var_1743341905737_2151 | var_1743341905737_2151;
                    UInt8(192)
                } finally { // block id: 5126
                    UInt8(191)
                }
            }), (try { // block id: 5130
                    if (var_1743341905737_693) {
                        [var_1743341905737_810, var_1743341905737_810, UInt64(152), UInt64(141), var_1743341905737_810,
                            UInt64(5), UInt64(66), var_1743341905737_810, UInt64(157), UInt64(123)]
                    } else {
                        var_1743341905737_5145
                    }
                } catch (e: Exception) { // block id: 5170
                    if (var_1743341905737_5173) {
                        var_1743341905737_5145
                    } else {
                        [UInt64(164), UInt64(121), UInt64(219), UInt64(100), UInt64(91), UInt64(242), UInt64(119),
                            UInt64(61), UInt64(82), UInt64(1)]
                    }
                } finally { // block id: 5177
                    var_1743341905737_5179;
                    var_1743341905737_429;
                    var_1743341905737_5145
                }, (match (var_1743341905737_5189) {
                    case Some(num) => num
                    case None => var_1743341905737_2609
                }), var_1743341905737_2151))
    }

    static init() {
        var_1743341905737_312 = ((UInt8(106), true), Int8(113), [Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(41), ([UInt64(138),
                    UInt64(191), UInt64(145), UInt64(160), UInt64(20), UInt64(127), UInt64(71), UInt64(62), UInt64(194),
                    UInt64(20)], ([Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None], r'j', Option<(Option<(UInt8, Bool)>, Int32)>.None),
                UInt16(19)))
        var_1743341905737_429 = ()
        var_1743341905737_2702 = Int64(67)
        var_1743341905737_4079 = ()
    }
}

@Frozen
@Deprecated
func func_1743341905737_75(param_1743341905737_76: Int32): (Option<(UInt8, Bool)>, Int32) { // block id: 77
    let var_1743341905737_91: Int32 = Int32(-118);
    var loopTimeVar_1743341905737_123: Array<UInt64> = [UInt64(UInt32(164)), UInt64(Int32(UInt32(Int16(40)))),
        UInt64(36), UInt64(169), UInt64(Int64(-86)), UInt64(114), UInt64(Int64(UInt16(Int16(-21)))), UInt64(199),
        UInt64(Int64(Int64(95))), UInt64(UInt16(18))];
    let iter78 = loopTimeVar_1743341905737_123.iterator()
    while (true) {
        match (iter78.next()) {
            case None => break
            case Some(v) => match (v) {
                case i where (var_1743341905737_80) =>
                    (match (Option<Int32>.Some(Int32(-117))) {
                        case Some(num) => num
                        case None => var_1743341905737_91
                    });
                    [Option<Int32>.Some(var_1743341905737_91), var_1743341905737_108,
                        Option<Int32>.Some(var_1743341905737_91), Option<Int32>.Some(Int32(-91)), Option<Int32>.None,
                        var_1743341905737_108, Option<Int32>.None, var_1743341905737_118, var_1743341905737_108,
                        var_1743341905737_108][6]
                case _ => continue
            }
        }
    };

    let var_1743341905737_158: (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>) = ([(match (([Option<Int32>
                .None, Option<Int32>.None, Option<Int32>.Some(Int32(-9)), Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.Some(Int32(-29)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.Some(Int32(-107))], r'h', Option<(Option<(UInt8, Bool)>, Int32)>.None)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(Int16(-60))), Option<Int32>.Some(Int32(Int32(96))), Option<Int32>.Some(Int32(7)),
            (match (([UInt64(78), UInt64(12), UInt64(201), UInt64(238), UInt64(157), UInt64(118), UInt64(252),
                UInt64(250), UInt64(234), UInt64(124)], ([Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(-91)), Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(-4)), Option<Int32>.None, Option<Int32>.Some(Int32(94)),
                    Option<Int32>.Some(Int32(-18)), Option<Int32>.Some(Int32(102))], r'1',
                Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.Some((UInt8(2), false)), Int32(116)))),
            UInt16(203))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(-64)),
            (match (((Int32(Int32(-27)) & 127)..(Int32(Int32(-121)) & 127) : (Int64(58) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(-107)), (match (r'J') {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None], r'8', (match (Int64(57)) {
            case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
            case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
        }));
    let var_1743341905737_254: Option<(UInt8, Bool)> = Option<(UInt8, Bool)>.Some((UInt8(101), false));
    const var_1743341905737_260: Int32 = 47;
    (match (([UInt64(37), UInt64(177), UInt64(83), UInt64(64), UInt64(252), UInt64(229), UInt64(119), UInt64(138),
            UInt64(93), UInt64(176)], var_1743341905737_158, UInt16(103))[1][2]) {
        case Some(num) => num
        case None => (match ((match (var_1743341905737_238) {
            case Some(num) => num
            case None => Option<(Option<(UInt8, Bool)>, Int32)>.None
        })) {
            case Some(num) => num
            case None => (match (Option<(Option<(UInt8, Bool)>, Int32)>.Some(var_1743341905737_244)) {
                case Some(num) => num
                case None => (var_1743341905737_254, var_1743341905737_260)
            })
        })
    })
}

public open class Class_1743341905737_867 <: Class_1743341905737_44 & Interface_1743341905737_48<UInt8> & Interface_1743341905737_47 {
    @Frozen
    public init() { // block id: 869

    }

    public static let var_1743341905737_2527: ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
        (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16))
    public static func func_1743341905737_667(
        namedParam_1743341905737_668!: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
            Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
            Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
            (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32),
        namedParam_1743341905737_669!: Option<Int32>,
        namedParam_1743341905737_670!: Option<(Option<(UInt8, Bool)>, Int32)>,
        namedParam_1743341905737_671!: (UInt8, Bool)): ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
        UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)) { // block id: 5194
        let var_1743341905737_5207: Option<Unit> = Option<Unit>.None;
        try { // block id: 5196
            var_1743341905737_5038
        } catch (e: Exception) { // block id: 5198
            (match (var_1743341905737_2686) {
                case newVar: Int64 => Option<Int64>.Some(newVar)
                case _ => Option<Int64>.None
            });
            (match (var_1743341905737_5207) {
                case Some(num) => num
                case None => var_1743341905737_429
            });
            try { // block id: 5211
                var_1743341905737_5038 ^ var_1743341905737_5038
            } finally { // block id: 5215
                var_1743341905737_1779;
                var_1743341905737_5038
            }
        } finally { // block id: 5218
            var_1743341905737_364;
            ();
            [UInt8(45), UInt8(184), UInt8(176), UInt8(47), UInt8(215), UInt8(52), UInt8(185), UInt8(189), UInt8(84),
                UInt8(250)][3]
        };
        var_1743341905737_2527
    }

    static init() {
        var_1743341905737_2527 = ((UInt8(222), false), Int8(-81), [Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(139), ([UInt64(93),
                    UInt64(198), UInt64(212), UInt64(119), UInt64(207), UInt64(199), UInt64(82), UInt64(61), UInt64(154),
                    UInt64(178)], ([Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.None], r'v', Option<(Option<(UInt8, Bool)>, Int32)>.None),
                UInt16(230)))
    }
}

public func func_1743341905737_483(
    param_1743341905737_484: (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
        UInt16)): (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
    VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
    UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) { // block id: 485
    let var_1743341905737_499: (Int32, Range<Int32>, Range<Int16>, Option<Option<(Option<(UInt8, Bool)>, Int32)>>, (Range<Int32>, 
        String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
        UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, 
        Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
        Bool)>, Int32)>), UInt16)), UInt32)) = (Int32(40), ((Int32(Int32(123)) & 127)..(Int32(Int32(-100)) & 127) : (Int64(54) |
            1)), ((Int16(Int16(-70)) & 127)..(Int16(Int16(-62)) & 127) : (Int64(18) | 1)), Option<Option<(Option<(UInt8, 
                Bool)>, Int32)>>.None, (((Int32(Int32(-65)) & 127)..(Int32(Int32(-37)) & 127) : (Int64(-22) | 1)),
            """
HG:/H
g%VYp
""", UInt8(Int8(-107)), ((match (Option<Option<(Option<(UInt8, Bool)>, Int32)>>.Some(
                    Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                        (Option<(UInt8, Bool)>.Some((UInt8(153), true)), Int32(-128))))) {
                    case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                    case _ => Option<(UInt8, Bool)>.None
                }), Int32(12)), ((UInt8(254), false), Int8(-85), [Option<Int32>.Some(Int32(27)),
                    Option<Int32>.Some(Int32(97)), Option<Int32>.Some(Int32(-54)), Option<Int32>.Some(Int32(72)),
                    Option<Int32>.None, Option<Int32>.Some(Int32(35)), Option<Int32>.Some(Int32(6)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(-50)), Option<Int32>.None], VArray<Unit, $3>(repeat: ()), UInt8(Int8(-115)),
                ([UInt64(21), UInt64(238), UInt64(135), UInt64(153), UInt64(26), UInt64(247), UInt64(79), UInt64(4),
                        UInt64(1), UInt64(103)], ([Option<Int32>.None, Option<Int32>.Some(Int32(45)),
                            Option<Int32>.Some(Int32(-81)), Option<Int32>.None, Option<Int32>.None,
                            Option<Int32>.Some(Int32(-20)), Option<Int32>.Some(Int32(52)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(-18)), Option<Int32>.None], r'd', Option<(Option<(UInt8, Bool)>, 
                                Int32)>.None), UInt16(228))), ((UInt8(121), true), Int8(-128), [Option<Int32>.None,
                    Option<Int32>.Some(Int32(35)), Option<Int32>.None, Option<Int32>.Some(Int32(51)),
                    Option<Int32>.Some(Int32(-95)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(UInt8(37)), ([UInt64(253),
                        UInt64(9), UInt64(246), UInt64(222), UInt64(173), UInt64(231), UInt64(239), UInt64(162),
                        UInt64(202), UInt64(47)], ([Option<Int32>.Some(Int32(3)), Option<Int32>.Some(Int32(90)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(23)), Option<Int32>.Some(Int32(-69)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(8)), Option<Int32>.Some(Int32(-103)),
                            Option<Int32>.Some(Int32(95)), Option<Int32>.None], r'I',
                        Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(-96)))), UInt16(82))),
            UInt32(241)));
    var var_1743341905737_646: String = """
T2*c5
!o6M]
""";
    const var_1743341905737_660: UInt8 = 118;
    let var_1743341905737_2515: ?(Option<(UInt8, Bool)>, Int32) = Option<(Option<(UInt8, Bool)>, Int32)>.None;
    (match ((match ((UInt8(202), var_1743341905737_80)) {
        case newVar: (Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) => Option<(Range<Int32>, 
                String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
                UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), ((UInt8, 
                Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, 
                Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.Some(newVar)
        case _ => Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.None
    })) {
        case Some(num) => num
        case None => (var_1743341905737_499[1], [var_1743341905737_646, var_1743341905737_646,
                """
s$0${var_1743341905737_646}<l
M`-L${var_1743341905737_646} 
""", var_1743341905737_646,
                var_1743341905737_646, var_1743341905737_646, "Mag1z${var_1743341905737_646}uHx!n",
                "L//5A*I${var_1743341905737_646}16C", "7rDyvj.${var_1743341905737_646}vd${var_1743341905737_646}4",
                var_1743341905737_646][7], var_1743341905737_660 * UInt8(213), var_1743341905737_244,
            Interface_1743341905737_48<UInt8>.func_1743341905737_667(
                namedParam_1743341905737_668: var_1743341905737_2351,
                namedParam_1743341905737_669: var_1743341905737_108,
                namedParam_1743341905737_670: var_1743341905737_2515,
                namedParam_1743341905737_671: var_1743341905737_2518), Class_1743341905737_867.var_1743341905737_2527,
            var_1743341905737_2577)
    })
}

public enum Enum_1743341905737_2683 {
    defaultValue
    | enumValue_1743341905737_2688((UInt8, Bool))
}

@Deprecated
public struct Struct_1743341905737_2754 {
    @Frozen
    public Struct_1743341905737_2754() { // block id: 2756

    }

    public let var_1743341905737_2761: Range<UInt32> = ((UInt32(UInt32(156)) & 127)..=(UInt32(UInt32(71)) & 127) : (Int64(-46) |
        1))
}

@Deprecated
public func func_1743341905737_288<T0, T1>(param_1743341905737_289: Range<Int16>): Class_1743341905737_44 { // block id: 290
    var var_1743341905737_292: Unit = ();
    var_1743341905737_292;
    func func_1743341905737_295(param_1743341905737_296: Float32): Class_1743341905737_44 { // block id: 297
        var var_1743341905737_2806: Byte = UInt8(UInt8(244));
        var var_1743341905737_2813: Range<Int32> = ((Int32(Int32(-36)) & 127)..=(Int32(Int32(108)) & 127) : (Int64(Int16(-69)) |
            1));
        let var_1743341905737_2820: Range<Int16> = ((Int16(Int16(-122)) & 127)..(Int16(Int16(39)) & 127) : (Int64(-32) |
            1));
        let var_1743341905737_2855: VArray<Unit, $3> = [(), (), ()];
        Class_1743341905737_44.func_1743341905737_301<Range<UInt16>>(try { // block id: 2796
            if (true) {
                Option<(UInt8, Bool)>.Some(var_1743341905737_2518)
            } else {
                var_1743341905737_1877
            };
            var_1743341905737_244
        } finally { // block id: 2803
            var_1743341905737_2806 = var_1743341905737_2806 << ((UInt8(187)) & 7)
            var var_1743341905737_2851: Option<Int32> = Option<Int32>.Some(Int32(-74));
            let var_1743341905737_2859: (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                Int32)>), UInt16) = ([UInt64(129), UInt64(181), UInt64(172), UInt64(248), UInt64(88), UInt64(93),
                    UInt64(164), UInt64(1), UInt64(157), UInt64(217)], ([Option<Int32>.Some(Int32(-38)),
                        Option<Int32>.None, Option<Int32>.Some(Int32(41)), Option<Int32>.Some(Int32(-18)),
                        Option<Int32>.None,
                        (match (((UInt16(UInt16(208)) & 127)..(UInt16(UInt16(69)) & 127) : (Int64(-76) | 1))) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (r'5') {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), (match (true) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    }), Option<Int32>.None, (match (Int16(25)) {
                        case newVar: Int32 => Option<Int32>.Some(newVar)
                        case _ => Option<Int32>.None
                    })], r'h', Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(-66)))),
                UInt16(145));
            (Int32(82), var_1743341905737_2813, var_1743341905737_2820,
                Option<Option<(Option<(UInt8, Bool)>, Int32)>>.Some(Option<(Option<(UInt8, Bool)>, Int32)>.None), (var_1743341905737_2813,
                    "QfKx|c-?q~", var_1743341905737_2828, var_1743341905737_244, ((UInt8(97), var_1743341905737_80),
                        Int8(106), [var_1743341905737_408, Option<Int32>.Some(var_1743341905737_855), Option<Int32>.None,
                            var_1743341905737_118, Option<Int32>.Some(var_1743341905737_855), var_1743341905737_118,
                            Option<Int32>.Some(var_1743341905737_855), var_1743341905737_118,
                            Option<Int32>.Some(Int32(-15)), var_1743341905737_2851], var_1743341905737_2855,
                        var_1743341905737_2806, var_1743341905737_2859), var_1743341905737_2891, var_1743341905737_2577));
            var_1743341905737_244
        });
        (match (try { // block id: 2963
            Option<Class_1743341905737_44>.Some(Class_1743341905737_867())
        } finally { // block id: 2966
            var_1743341905737_2968
        }) {
            case Some(num) => num
            case None => Class_1743341905737_867()
        })
    };

    func_1743341905737_295(Float32(-103.0))
}

@Frozen
internal func func_1743341905737_65(): (UInt16, Bool, UInt64, Float64, Int32, UInt32, Float64, Float64, Int16) { // block id: 66
    const var_1743341905737_3014: Bool = true;
    (match (({
        lambdaParameter_1743341905737_264: Int32 =>
            let var_1743341905737_277: Range<Int8> = ((Int8(Int8(69)) & 127)..=(Int8(Int8(Int8(UInt8(Int8(100))))) & 127) : (Int64(Int8(UInt8(89))) |
                1));
            const var_1743341905737_3018: Int16 = 62;
            let var_1743341905737_3023: Range<Int16> = ((Int16(Int16(39)) & 127)..(Int16(Int16(34)) & 127) : (Int64(-106) |
                1));
            func func_1743341905737_268(
                optionalParam_1743341905737_269!: UInt32 = UInt32(UInt8(Int8(UInt8(UInt8(199)))))): Class_1743341905737_44 { // block id: 275
                var_1743341905737_277;
                func_1743341905737_288<Option<(UInt8, Bool)>, Range<Int64>>(
                    match ((var_1743341905737_1877, var_1743341905737_855)) {
                        case (_: Range<Int8>, _: (Range<UInt32>, Option<(Range<Int32>, String, UInt8, (Option<(UInt8, 
                                    Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                                    (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
                                    UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                                    (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                                    UInt32)>, ((Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), 
                                    Range<UInt8>, Option<(Option<(UInt8, Bool)>, Int32)>, (UInt8, Bool), Int64), ((Array<Option<Int32>>, 
                                    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, Option<(Option<(UInt8, 
                                    Bool)>, Int32)>, (UInt8, Bool), Int64), Int16)) =>
                            var_1743341905737_2982 = var_1743341905737_2982 & (Int32(73))
                            var var_1743341905737_2986: Range<Int16> = ((Int16(Int16(UInt8(Int8(Int8(-31))))) & 127)..=(Int16(Int16(UInt16(UInt8(Int8(-122))))) &
                                127) : (Int64(99) | 1));
                            var_1743341905737_2986

                        case (caseVar_1743341905737_2999, caseVar_1743341905737_3000) =>
                            Option<Int32>.None;
                            if (true) {
                                ((Int16(Int16(11)) & 127)..=(Int16(Int16(-61)) & 127) : (Int64(2) | 1))
                            } else {
                                ((Int16(Int16(-81)) & 127)..(Int16(Int16(-45)) & 127) : (Int64(123) | 1))
                            }

                        case (_, _) =>
                            ((UInt8(UInt8(11)) & 127)..(UInt8(UInt8(103)) & 127) : (Int64(87) | 1));
                            var_1743341905737_1779;
                            if (var_1743341905737_3014) {
                                ((Int16(var_1743341905737_3018) & 127)..=(Int16(Int16(-119)) & 127) : (Int64(15) | 1))
                            } else {
                                var_1743341905737_3023
                            }

                        case _ =>
                            var_1743341905737_1779;
                            var_1743341905737_3023
                    })
            };
            func_1743341905737_268(optionalParam_1743341905737_269: (match (Option<UInt32>.Some(UInt32(186))) {
                case Some(num) => num
                case None => UInt32(169)
            })).var_1743341905737_3039
    }(var_1743341905737_855))[0]) {
        case Some(num) => num
        case None => try { // block id: 3046
            (UInt8(115), false)
        } finally { // block id: 3050
            var_1743341905737_3053 = var_1743341905737_3053 >> ((var_1743341905737_3053) & 7)
            ();
            var_1743341905737_2518
        }
    });
    var var_1743341905737_3083: String = "V1Qw*P8F1z";
    try { // block id: 3060
        Option<Unit>.None
    } catch (e: Exception) { // block id: 3062
        var_1743341905737_2982 = var_1743341905737_2982 | (var_1743341905737_3066)
        var var_1743341905737_3078: Int8 = Int8(-108);
        (match (Option<Range<Int8>>.Some(((Int8(Int8(-48)) & 127)..(Int8(Int8(-104)) & 127) : (Int64(-92) | 1)))) {
            case Some(num) => num
            case None => ((Int8(Int8(5)) & 127)..=(Int8(var_1743341905737_3078) & 127) : (Int64(21) | 1))
        });
        match (var_1743341905737_3083) {
            case _ =>
                var var_1743341905737_3090: UInt64 = UInt64(212);
                var_1743341905737_3090 = var_1743341905737_3090 | (UInt64(182))
                var var_1743341905737_3097: ?Unit = (match (UInt32(UInt8(UInt8(134)))) {
                    case newVar: Unit => Option<Unit>.Some(newVar)
                    case _ => Option<Unit>.None
                });
                if (var_1743341905737_3014) {
                    Option<Unit>.None
                } else {
                    var_1743341905737_3097
                }

            case "fT]ifj2MNE" | ###"sCI9~w>#A7"### | "\\3ly+Ra{hT:" | "Ov3<+-vtn?" =>
                var_1743341905737_3078 = var_1743341905737_3078 & (var_1743341905737_3078)
                let var_1743341905737_3113: ?Unit = Option<Unit>.Some(());
                if (var_1743341905737_693) {
                    Option<Unit>.Some(())
                } else {
                    var_1743341905737_3113
                }

            case """
([1V:
+<H~r
""" =>
                var_1743341905737_2518;
                var_1743341905737_1779;
                let var_1743341905737_3122: ?Unit = Option<Unit>.Some(());
                var_1743341905737_3122

            case _ =>
                let var_1743341905737_3131: ?Unit = (match (((Int16(Int16(Int8(52))) & 127)..(Int16(Int16(UInt16(212))) &
                    127) : (Int64(UInt32(130)) | 1))) {
                    case newVar: Unit => Option<Unit>.Some(newVar)
                    case _ => Option<Unit>.None
                });
                if (false) {
                    var_1743341905737_3131
                } else {
                    Option<Unit>.None
                }
        }
    } finally { // block id: 3141
        if (false) {
            var_1743341905737_3145
        } else {
            var_1743341905737_3145
        }
    };
    let var_1743341905737_3180: Class_1743341905737_44 = Class_1743341905737_44();
    let var_1743341905737_3214: (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>) = ([(match ((((Int32(Int32(-123)) &
                127)..=(Int32(Int32(-59)) & 127) : (Int64(-117) | 1)), "~xV<ewefcW${var_1743341905737_3083}", UInt8(239),
            (Option<(UInt8, Bool)>.Some((UInt8(172), true)), Int32(-71)), ((UInt8(164), true), Int8(-32), [Option<Int32>
                    .Some(Int32(90)), Option<Int32>.Some(Int32(-78)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(-106)), Option<Int32>.Some(Int32(50)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(107)), Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(125))], VArray<Unit, $3>({i => ()}), UInt8(156), ([UInt64(55), UInt64(229),
                        UInt64(131), UInt64(13), UInt64(194), UInt64(74), UInt64(221), UInt64(175), UInt64(248),
                        UInt64(122)], ([Option<Int32>.Some(Int32(94)), Option<Int32>.Some(Int32(50)),
                            Option<Int32>.Some(Int32(-11)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                            Option<Int32>.None, Option<Int32>.Some(Int32(87)), Option<Int32>.Some(Int32(42)),
                            Option<Int32>.Some(Int32(-72))], r'U', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(10))),
            ((UInt8(161), false), Int8(-60), [Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(36)), Option<Int32>.Some(Int32(8)), Option<Int32>.Some(Int32(75)),
                    Option<Int32>.Some(Int32(-120)), Option<Int32>.Some(Int32(-47)), Option<Int32>.None,
                    Option<Int32>.None], VArray<Unit, $3>({i => ()}), UInt8(161), ([UInt64(158), UInt64(240), UInt64(26),
                        UInt64(158), UInt64(151), UInt64(104), UInt64(154), UInt64(122), UInt64(212), UInt64(19)], ([Option<Int32>
                            .None, Option<Int32>.None, Option<Int32>.Some(Int32(-55)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(101)), Option<Int32>.Some(Int32(7)), Option<Int32>.Some(Int32(-32)),
                            Option<Int32>.Some(Int32(64)), Option<Int32>.None, Option<Int32>.None], r'l',
                        Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                            (Option<(UInt8, Bool)>.Some((UInt8(112), false)), Int32(-107)))), UInt16(106))), UInt32(193))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, Option<Int32>.None, (match (Int8(-55)) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(-99)),
            (match (([UInt64(72), UInt64(200), UInt64(49), UInt64(168), UInt64(86), UInt64(129), UInt64(166),
                UInt64(118), UInt64(77), UInt64(117)], ([Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(-78)), Option<Int32>.None, Option<Int32>.Some(Int32(-2)),
                    Option<Int32>.None, Option<Int32>.Some(Int32(-5)), Option<Int32>.Some(Int32(-64)),
                    Option<Int32>.Some(Int32(-23)), Option<Int32>.None], r'1',
                Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(83)))), UInt16(169))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match ((match (Option<Int32>.Some(Int32(-56))) {
            case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
            case _ => Option<(UInt8, Bool)>.None
        })) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(UInt32(85))), Option<Int32>.None, Option<Int32>.None], r'H', (match (UInt8(UInt8(31))) {
            case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
            case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
        }));
    const var_1743341905737_3436: UInt32 = 210;
    const var_1743341905737_3455: Float64 = -108.0;
    const var_1743341905737_3458: Float64 = 99.0;
    ((match (Option<UInt16>.None) {
            case Some(num) => num
            case None => UInt16(Int8(-118))
        }), false, if (match (Option<Class_1743341905737_44>.None) {
            case _ =>
                var var_1743341905737_3175: String = """
E+r*J
qH~yJ
""";
                ["""
>7cCv
Z3q=H
""", var_1743341905737_3083, var_1743341905737_3083, "oAdZI+HHUn",
                    var_1743341905737_3083, ###"%r\\]I87;sG"###, var_1743341905737_3083, var_1743341905737_3083,
                    """
^K/bY
x_+ca
""", var_1743341905737_3175];
                true
        }) { // block id: 3178
            var_1743341905737_3180;
            ();
            UInt64(66)
        } else { // block id: 3184
            [UInt64(14), UInt64(207), UInt64(162), UInt64(215), UInt64(63), UInt64(114), UInt64(152), UInt64(157),
                UInt64(116), UInt64(160)];
            UInt64(76) / ((var_1743341905737_810) | 1)
        }, match (try { // block id: 3191
            (var_1743341905737_3194, var_1743341905737_2609, UInt16(192));
            var_1743341905737_3214
        } finally { // block id: 3388
            var_1743341905737_2609
        }) {
            case (_, caseVar_1743341905737_3392, caseVar_1743341905737_3393) =>
                ();
                if (true) {
                    var_1743341905737_108
                } else {
                    var_1743341905737_108
                };
                const var_1743341905737_3402: Float64 = 68.0;
                var_1743341905737_3402 ** var_1743341905737_863

            case caseVar_1743341905737_3407 => Float64(-106.0)

            case _ =>
                if (var_1743341905737_3014) {
                    Option<Int32>.None
                } else {
                    var_1743341905737_118
                };
                var_1743341905737_1779;
                const var_1743341905737_3419: Float64 = 124.0;
                var_1743341905737_3419
        }, try { // block id: 3422
            var_1743341905737_3424;
            var_1743341905737_1779;
            Int32(17) - var_1743341905737_3066
        } finally { // block id: 3430
            ();
            Int32(-62) ^ Int32(-36)
        }, var_1743341905737_3436, Float64(try { // block id: 3440
            let var_1743341905737_3442: Option<Int64> = (match (((UInt8(UInt8(UInt8(Int8(105)))) & 127)..=(UInt8(UInt8(223)) &
                127) : (Int64(-112) | 1))) {
                case newVar: Int64 => Option<Int64>.Some(newVar)
                case _ => Option<Int64>.None
            });
            var_1743341905737_3442;
            var_1743341905737_3451;
            var_1743341905737_3455 ** var_1743341905737_3458
        } catch (e: Exception) { // block id: 3460
            var_1743341905737_3458
        } finally { // block id: 3462
            var_1743341905737_2982;
            var_1743341905737_3455
        }), match (try { // block id: 3467
            var var_1743341905737_3469: Range<UInt64> = ((UInt64(UInt64(UInt64(232))) & 127)..=(UInt64(UInt64(UInt64(63))) &
                127) : (Int64(28) | 1));
            var_1743341905737_3469;
            (Option<(UInt8, Bool)>.None, var_1743341905737_3066);
            Class_1743341905737_867()
        } finally { // block id: 3480
            var_1743341905737_3180
        }) {
            case _ =>
                var_1743341905737_2151;
                var_1743341905737_3487
        }, if ((match (var_1743341905737_3492) {
            case _: ((Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), Range<UInt8>, Option<(Option<(UInt8, 
                    Bool)>, Int32)>, (UInt8, Bool), Int64) => true
            case _ => false
        })) { // block id: 3494
            var var_1743341905737_3497: Array<Option<Int32>> = [(match (((UInt8(87), true), Int8(UInt8(76)), [Option<Int32>
                    .Some(Int32(79)), Option<Int32>.None, Option<Int32>.Some(Int32(61)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(-7)), Option<Int32>.None, Option<Int32>.None,
                    Option<Int32>.Some(Int32(-97)), Option<Int32>.Some(Int32(49)), Option<Int32>.None], VArray<Unit, $3>({
                        i => ()
                    }), UInt8(Int8(-110)), ([UInt64(128), UInt64(90), UInt64(158), UInt64(54), UInt64(55), UInt64(37),
                        UInt64(163), UInt64(68), UInt64(24), UInt64(250)], ([Option<Int32>.Some(Int32(-106)),
                            Option<Int32>.Some(Int32(33)), Option<Int32>.Some(Int32(-13)), Option<Int32>.Some(Int32(-2)),
                            Option<Int32>.Some(Int32(120)), Option<Int32>.None, Option<Int32>.Some(Int32(-91)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(-34)), Option<Int32>.None], r'p', Option<(Option<(UInt8, 
                                Bool)>, Int32)>.None), UInt16(83)))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }),
                (match ([UInt64(171), UInt64(123), UInt64(206), UInt64(73), UInt64(137), UInt64(65), UInt64(171),
                UInt64(140), UInt64(163), UInt64(132)]) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), (match (Int32(30)) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.Some(Int32(97)), Option<Int32>.Some(Int32(86)),
                (match (((UInt8(UInt8(155)) & 127)..(UInt8(UInt8(68)) & 127) : (Int64(-1) | 1))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }),
                (match (([Option<Int32>.Some(Int32(26)), Option<Int32>.Some(Int32(125)), Option<Int32>.None,
                    Option<Int32>.Some(Int32(-66)), Option<Int32>.None, Option<Int32>.Some(Int32(-110)),
                    Option<Int32>.None, Option<Int32>.Some(Int32(-117)), Option<Int32>.Some(Int32(26)),
                    Option<Int32>.Some(Int32(-48))], r'X', (match (true) {
                    case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                    case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
                }))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }),
                (match (([UInt64(3), UInt64(72), UInt64(2), UInt64(166), UInt64(216), UInt64(234), UInt64(162),
                    UInt64(36), UInt64(175), UInt64(125)], ([Option<Int32>.None, Option<Int32>.Some(Int32(-28)),
                        Option<Int32>.Some(Int32(-26)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(98)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(-64))], r'X', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(UInt8(2)))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }),
                (match (Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                    VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, 
                    Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                    (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.Some(
                (((Int32(Int32(-104)) & 127)..(Int32(Int32(39)) & 127) : (Int64(63) | 1)), "fYL\"^,//y`", UInt8(83), (Option<(UInt8, 
                                Bool)>.None, Int32(-49)), ((UInt8(193), true), Int8(7), [Option<Int32>.None,
                            Option<Int32>.Some(Int32(-96)), Option<Int32>.Some(Int32(-19)),
                            Option<Int32>.Some(Int32(-28)), Option<Int32>.None, Option<Int32>.None,
                            Option<Int32>.Some(Int32(74)), Option<Int32>.None, Option<Int32>.None, Option<Int32>.None],
                        VArray<Unit, $3>(repeat: ()), UInt8(182), ([UInt64(225), UInt64(151), UInt64(251), UInt64(100),
                                UInt64(38), UInt64(21), UInt64(169), UInt64(119), UInt64(179), UInt64(122)], ([Option<Int32>
                                    .None, Option<Int32>.Some(Int32(30)), Option<Int32>.Some(Int32(-61)),
                                    Option<Int32>.Some(Int32(14)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(-9)),
                                    Option<Int32>.None], r'r', Option<(Option<(UInt8, Bool)>, Int32)>.None), UInt16(251))),
                    ((UInt8(95), true), Int8(-26), [Option<Int32>.Some(Int32(54)), Option<Int32>.Some(Int32(25)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(-1)), Option<Int32>.None, Option<Int32>.None,
                            Option<Int32>.Some(Int32(-84)), Option<Int32>.Some(Int32(-21)),
                            Option<Int32>.Some(Int32(24)), Option<Int32>.Some(Int32(13))], VArray<Unit, $3>({i => ()}),
                        UInt8(182), ([UInt64(252), UInt64(158), UInt64(168), UInt64(235), UInt64(139), UInt64(27),
                                UInt64(75), UInt64(206), UInt64(7), UInt64(186)], ([Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-44)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-99)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.Some(Int32(-43)), Option<Int32>.None], r'G',
                                Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                    (Option<(UInt8, Bool)>.Some((UInt8(214), true)), Int32(-16)))), UInt16(202))),
                    UInt32(235)))) {
                case newVar: Int32 => Option<Int32>.Some(newVar)
                case _ => Option<Int32>.None
            }), Option<Int32>.Some(Int32(UInt8(252)))];
            var var_1743341905737_3736: ?(Option<(UInt8, Bool)>, Int32) = (match (((Int16(Int16(80)) & 127)..(Int16(Int16(17)) &
                127) : (Int64(-17) | 1))) {
                case newVar: (Option<(UInt8, Bool)>, Int32) => Option<(Option<(UInt8, Bool)>, Int32)>.Some(newVar)
                case _ => Option<(Option<(UInt8, Bool)>, Int32)>.None
            });
            (var_1743341905737_3497, r'a', var_1743341905737_3736);
            Int16(-77)
        } else if (var_1743341905737_2151 > UInt16(86)) { // block id: 3743
            ();
            var_1743341905737_3053 ^ Int16(4)
        } else { // block id: 3748
            var_1743341905737_1779;
            var var_1743341905737_3754: ?(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), 
                Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, 
                (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32) = Option<(Range<Int32>, 
                    String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, 
                    UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                    ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, 
                    Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), UInt32)>.Some(
                (((Int32(Int32(-16)) & 127)..(Int32(Int32(68)) & 127) : (Int64(89) | 1)), """
VZ2Da
3t?!N
""", UInt8(234),
                    ((match (Int16(-14)) {
                            case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
                            case _ => Option<(UInt8, Bool)>.None
                        }), Int32(Int32(120))), ((UInt8(131), false), Int8(69), [Option<Int32>.Some(Int32(-27)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(56)), Option<Int32>.Some(Int32(36)),
                            Option<Int32>.None, Option<Int32>.Some(Int32(-80)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(117)), Option<Int32>.Some(Int32(-80)),
                            Option<Int32>.Some(Int32(108))], VArray<Unit, $3>({i => ()}), UInt8(151), ([UInt64(132),
                                UInt64(112), UInt64(153), UInt64(254), UInt64(169), UInt64(5), UInt64(22), UInt64(93),
                                UInt64(203), UInt64(212)], ([Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.Some(Int32(26)), Option<Int32>.None, Option<Int32>.Some(Int32(69)),
                                    Option<Int32>.Some(Int32(125)), Option<Int32>.Some(Int32(-24)), Option<Int32>.None,
                                    Option<Int32>.Some(Int32(-87)), Option<Int32>.Some(Int32(-98))], r'G', Option<(Option<(UInt8, 
                                        Bool)>, Int32)>.None), UInt16(53))), ((UInt8(66), true), Int8(-61), [Option<Int32>
                            .None, Option<Int32>.None, Option<Int32>.Some(Int32(-120)), Option<Int32>.None,
                            Option<Int32>.None, Option<Int32>.Some(Int32(73)), Option<Int32>.None,
                            Option<Int32>.Some(Int32(62)), Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({
                                i => ()
                            }), UInt8(UInt8(188)), ([UInt64(174), UInt64(212), UInt64(113), UInt64(167), UInt64(116),
                                UInt64(237), UInt64(139), UInt64(179), UInt64(26), UInt64(17)], ([Option<Int32>.Some(
                                    Int32(37)), Option<Int32>.None, Option<Int32>.Some(Int32(9)),
                                    Option<Int32>.Some(Int32(2)), Option<Int32>.Some(Int32(3)),
                                    Option<Int32>.Some(Int32(117)), Option<Int32>.None, Option<Int32>.None,
                                    Option<Int32>.None, Option<Int32>.None], r'P',
                                Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                    (Option<(UInt8, Bool)>.Some((UInt8(105), false)), Int32(54)))), UInt16(76))), UInt32(85)));
            if (false) {
                Option<(Range<Int32>, String, UInt8, (Option<(UInt8, Bool)>, Int32), ((UInt8, Bool), Int8, Array<Option<Int32>>, 
                        VArray<Unit, $3>, UInt8, (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, 
                        Bool)>, Int32)>), UInt16)), ((UInt8, Bool), Int8, Array<Option<Int32>>, VArray<Unit, $3>, UInt8, 
                        (Array<UInt64>, (Array<Option<Int32>>, Rune, Option<(Option<(UInt8, Bool)>, Int32)>), UInt16)), 
                        UInt32)>.None
            } else {
                var_1743341905737_3754
            };
            Int16(-127)
        })
}

func func_1743341905737_61(param_1743341905737_62: Float64): (UInt16, Bool, UInt64, Float64, Int32, UInt32, Float64, 
    Float64, Int16) { // block id: 63
    func_1743341905737_65()
}

@Frozen
func func_1743341905737_57(param_1743341905737_58: UInt64): (UInt16, Bool, UInt64, Float64, Int32, UInt32, Float64, 
    Float64, Int16) { // block id: 59
    let var_1743341905737_3882: (Float64) -> (UInt16, Bool, UInt64, Float64, Int32, UInt32, Float64, Float64, Int16) = func_1743341905737_61;
    var_1743341905737_3882(try { // block id: 3887
        var_1743341905737_1779;
        var var_1743341905737_3891: String = "kxv48#6h_t";
        var_1743341905737_3891 = var_1743341905737_3891
        if (var_1743341905737_693) {
            [Float64(-102.0), var_1743341905737_3487, var_1743341905737_3487, var_1743341905737_3487,
                var_1743341905737_3487, Float64(13.0), Float64(21.0), Float64(111.0), Float64(10.0), Float64(75.0)]
        } else {
            [Float64(58.0), Float64(-2.0), Float64(96.0), Float64(87.0), Float64(-75.0), Float64(56.0), Float64(-51.0),
                Float64(-12.0), Float64(25.0), Float64(16.0)]
        }
    } finally { // block id: 3908
        ();
        [Float64(125.0), Float64(110.0), Float64(-35.0), Float64(-1.0), Float64(84.0), Float64(57.0), Float64(64.0),
            Float64(-50.0), Float64(111.0), Float64(-41.0)]
    }[2])
}

main(): Int64 {
    try {
        var loopTimeVar_1743341905737_42: Int = 0;
        (match ((match (Option<(UInt64, UInt64, Float32, Option<Unit>)>.None) {
            case Some(num) => num
            case None => var_1743341905737_23
        })[3]) {
            case Some(num) => num
            case None => do {
                loopTimeVar_1743341905737_42++;
            } while ((var_1743341905737_35[1]) && loopTimeVar_1743341905737_42 < 100)
        });
        Class_1743341905737_44.func_1743341905737_301(if (var_1743341905737_4347) { // block id: 4350
            var_1743341905737_3451;
            [UInt64(156), var_1743341905737_810, var_1743341905737_810, UInt64(60), var_1743341905737_810, UInt64(32),
                UInt64(89), UInt64(185), UInt64(145), var_1743341905737_810];
            var_1743341905737_2982 = var_1743341905737_2982 << ((Int32(82)) & 7)
        } else if (true) { // block id: 4367

        });
        var var_1743341905737_4381: Option<Array<Option<Int32>>> = (match ((UInt8(Int8(57)), (match ([UInt64(120),
                UInt64(55), UInt64(38), UInt64(23), UInt64(72), UInt64(23), UInt64(40), UInt64(89), UInt64(55),
                UInt64(216)]) {
                case _: Range<UInt32> => true
                case _ => false
            }))) {
            case newVar: Array<Option<Int32>> => Option<Array<Option<Int32>>>.Some(newVar)
            case _ => Option<Array<Option<Int32>>>.None
        });
        var var_1743341905737_4401: Array<Option<Int32>> = [(match (Option<Int32>.Some(Int32(-25))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(Int32(62))), (match (Class_1743341905737_44()) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }),
            (match ((match ((Int32(48), ((Int32(Int32(-108)) & 127)..=(Int32(Int32(-111)) & 127) : (Int64(111) | 1)), ((Int16(Int16(-46)) &
                127)..(Int16(Int16(-79)) & 127) : (Int64(56) | 1)), Option<Option<(Option<(UInt8, Bool)>, Int32)>>
                .Some(
                    Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                        (Option<(UInt8, Bool)>.Some((UInt8(222), true)), Int32(-9)))), (((Int32(Int32(3)) & 127)..(Int32(Int32(-127)) &
                    127) : (Int64(-2) | 1)), """
\".M\"/
b:i|2
""", UInt8(226), (Option<(UInt8, Bool)>.Some(
                        (UInt8(26), false)), Int32(-43)), ((UInt8(194), false), Int8(-116), [Option<Int32>.Some(
                        Int32(77)), Option<Int32>.Some(Int32(-41)), Option<Int32>.Some(Int32(8)), Option<Int32>.None,
                        Option<Int32>.None, Option<Int32>.Some(Int32(6)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(-17)), Option<Int32>.None, Option<Int32>.None], VArray<Unit, $3>({
                            i => ()
                        }), UInt8(207), ([UInt64(132), UInt64(71), UInt64(126), UInt64(179), UInt64(124), UInt64(44),
                            UInt64(11), UInt64(243), UInt64(84), UInt64(60)], ([Option<Int32>.Some(Int32(89)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(-69)), Option<Int32>.Some(Int32(73)),
                                Option<Int32>.None, Option<Int32>.Some(Int32(68)), Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(61))], r'L',
                            Option<(Option<(UInt8, Bool)>, Int32)>.Some(
                                (Option<(UInt8, Bool)>.Some((UInt8(189), false)), Int32(124)))), UInt16(174))), ((UInt8(32),
                        false), Int8(-19), [Option<Int32>.None, Option<Int32>.None, Option<Int32>.Some(Int32(60)),
                        Option<Int32>.Some(Int32(122)), Option<Int32>.Some(Int32(-107)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(96)), Option<Int32>.Some(Int32(-68)), Option<Int32>.None,
                        Option<Int32>.Some(Int32(-75))], VArray<Unit, $3>(repeat: ()), UInt8(159), ([UInt64(215),
                            UInt64(105), UInt64(123), UInt64(202), UInt64(2), UInt64(80), UInt64(226), UInt64(107),
                            UInt64(223), UInt64(68)], ([Option<Int32>.None, Option<Int32>.Some(Int32(-41)),
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None,
                                Option<Int32>.None, Option<Int32>.None, Option<Int32>.None, Option<Int32>.None], r'X',
                            Option<(Option<(UInt8, Bool)>, Int32)>.Some((Option<(UInt8, Bool)>.None, Int32(-38)))),
                        UInt16(95))), UInt32(239)))) {
            case newVar: (UInt8, Bool) => Option<(UInt8, Bool)>.Some(newVar)
            case _ => Option<(UInt8, Bool)>.None
        })) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (((UInt32(UInt32(16)) & 127)..=(UInt32(UInt32(2)) & 127) : (Int64(37) | 1))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.None, Option<Int32>.Some(Int32(-119)), (match (UInt16(Int16(UInt8(22)))) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), (match (Option<UInt16>.None) {
            case newVar: Int32 => Option<Int32>.Some(newVar)
            case _ => Option<Int32>.None
        }), Option<Int32>.Some(Int32(57))];
        let var_1743341905737_4612: Int64 = Int64(UInt64(UInt16(86)));
        match ((match ((match (Option<Option<Array<Option<Int32>>>>.None) {
            case Some(num) => num
            case None => var_1743341905737_4381
        })) {
            case Some(num) => num
            case None => try { // block id: 4399
                var_1743341905737_4401
            } catch (e: Exception) { // block id: 4577
                var_1743341905737_4401
            } finally { // block id: 4579
                ();
                [Option<Int32>.None, var_1743341905737_408, var_1743341905737_408, Option<Int32>.None,
                    Option<Int32>.None, Option<Int32>.Some(Int32(-1)), Option<Int32>.Some(Int32(96)),
                    var_1743341905737_408, var_1743341905737_408, Option<Int32>.None]
            }
        })) {
            case _ => Int64(106) ** var_1743341905737_810

            case caseVar_1743341905737_4602 =>
                ();
                var_1743341905737_863

            case _: Range<UInt8> => Int64(-121) / ((var_1743341905737_4612) | 1)

            case _: Array<Option<Int32>> =>
                ();
                var_1743341905737_863

            case _ =>
                if (true) {
                    var_1743341905737_2686
                } else {
                    Enum_1743341905737_2683.enumValue_1743341905737_2688(var_1743341905737_35)
                };
                ();
                var_1743341905737_863
        }
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1743341905737_4612 * var_1743341905737_4612), 64)
        crcCheck.crcCheck()
        crcCheck.getCrcOutput()
        ()
    } catch (e: NoneValueException) {
        println("Exception: NoneValueException")
    }

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
        crc_output = Array<Int64>(crc_output_n, {i => 0})
        buffer = Array<Int64>(buffer_n, {i => 0})
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
        var byteArray = Array<Int64>(byte_n, {i => 0})
        var byte_c = 1
        var byte_index = 0
        while (value != 0) {
            if (value % 2 == 1) {
                byte_index = byte_n - byte_c
                byteArray[byte_index] = 1
            }
            byte_c++
            value = value >> 1
        }
        var i = 0
        while (i + byte_index < byte_n) {
            buffer[(i + buffer_index) % buffer.size] = byteArray[i + byte_index]
            i++
        }
        buffer_index = (buffer_index + i) % buffer.size
    }

    func updateBuffer(input: Bool, byte_n: Int64): Unit {
        if (input == true) {
            updateBuffer(1, byte_n)
        } else {
            updateBuffer(0, byte_n)
        }
    }

    func updateBuffer(input: Rune, byte_n: Int64): Unit {
        updateBuffer(UInt64(UInt32(input)), byte_n)
    }

    func updateBuffer(input: String, byte_n: Int64): Unit {
        for (c in input) {
            updateBuffer(c, byte_n)
        }
    }

    func updateBuffer(input: Unit, byte_n: Int64): Unit {
        updateBuffer(input.toString(), byte_n)
    }

    func updateBuffer(input: Any, byte_n: Int64): Unit {
        if (input is Hashable) {
            match (input as Hashable) {
                case Some(v) => updateBuffer(UInt64(v.hashCode()), byte_n)
                case _ => updateBuffer(1, byte_n)
            }
        } else if (input is ToString) {
            match (input as ToString) {
                case Some(v) => updateBuffer(v.toString(), byte_n)
                case _ => updateBuffer(1, byte_n)
            }
        } else {
            updateBuffer(1, byte_n)
        }
    }
    func crcCheck(): Unit {
        crc_output_n = buffer_index + poly_n - 1
        var crc_buffer = Array<Int64>(crc_output_n, {i => 0})
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
        crc_output = Array<Int64>(crc_output_n, {i => 0})
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
            var hex_value = 2 ** 2 * crc_output[i] + 2 ** 1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
        print("\n")
    }
}

extend Int8 {
    operator func ()(x: Int8): Int8 {
        return this - x
    }
}

extend Struct_1743341905737_2754 {}
