/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-1: %compiler %cmp_opt %f -o %output 2>&1 

// random seed:1629702927167

// All global variable need to be defined before use!
public let var14 : Bool = true
public let var18 : Unit = ()
public var var50 : Rune = 'e'
public var var64 : Result<Bool> = Result<Bool>.Ok(var14)
public var var74 : Int64 = (-53)
public var var112 : Class31 = Class31()
public var var118 : Int8 = Int8(UInt8(220))
 var var147 : Int32 = Int32(Float64(UInt8(245)))
public let var156 : UInt32 = UInt32((-27.0))
public let var194 : Int16 = Int16(Int16(1))
public var var208 : UInt8 = UInt8(128)
public var var263 : UInt64 = UInt64(Int32(-125))
public var var348 : (Class31,Range<Int8>) = (Class31(), (Int8(UInt8(180))..=Int8(UInt32(225)):((-74)|1)))
public var var412 : Int64 = 124
 var var427 : Range<Int64> = ((-80)..=(-8):126|1)
 var var482 : Range<Int32> = (Int32(25)..=Int32(-56):(Int64(124)|1))
public let var498 : (Range<UInt8>,UInt8,Option<Range<Int32>>) = ((UInt8(Float32(-104.0))..UInt8(UInt16(189)):(Int64(Int32(UInt64(251)))|1)), UInt8(88.0), ((Int8(UInt32(189))..=Int8(-77):((-60)|1)) as Range<Int32>))
public let var530 : String = "z)rpC!w;$G"
 let var570 : Array<Bool> = [true, false, false, true, true]
public let var618 : (Int16,Bool,Range<Int16>,Rune) = (Int16(11), ((Int16(-42), (Option<Range<Int32>>.Some(var482) is UInt32), (Int16(20)..Int16(30):(12|1)), 'X') is Float64), (Int16(14)..Int16(Float32(Float32(9.0))):(Int64(UInt16(64))|1)), 'v')
public var var650 : Option<(Int16,Bool,Range<Int16>,Rune)> = Option<(Int16,Bool,Range<Int16>,Rune)>.None
 var var659 : Result<Option<(Int16,Bool,Range<Int16>,Rune)>> = Result<Option<(Int16,Bool,Range<Int16>,Rune)>>.Ok(var650)
public let var701 : (Rune,Range<Int16>,(Int16,Bool,Range<Int16>,Rune),Array<Bool>,UInt8) = ('K', (Int16(93)..Int16(11):(-105)|1), (Int16(Int16(UInt16(91))), false, (Int16(UInt32(184))..Int16(117):(Int64(Int16(-124))|1)), 'C'), [true, true, true, true, true], UInt8(UInt16(114)))
public var var727 : Unit = ()
public var var734 : (Int16,Bool,Range<Int16>,Rune) = (Int16(-28), true, (Int16(52)..=Int16(-109):54|1), 'j')
 let var771 : Float32 = Float32(51.0)
public let var774 : Option<Float32> = Option<Float32>.Some(var771)
public let var791 : Result<Unit> = Result<Unit>.Err(Exception())
public var var807 : Float64 = Float64(UInt8(Int32(UInt32(198))))
public var var814 : UInt16 = UInt16(Float32(Float64(UInt64(10))))
public let var878 : Range<Int16> = (Int16(UInt16(48))..Int16(UInt8(91)):(Int64(Int32(-62))|1))
main(): Int64 {
    var var9 : UInt64 = UInt64(52);
    if (match (var9) {
        case _ =>
            var14

    }) { // block id: 16
        var18;
        UInt16(34)
    } else if (func22((-36), namedParam24 : (), optionalParam25 : var194, namedParam27 : var807)) { // block id: 812
        var814
    } else { // block id: 819
        var18;
        var814
    };
    var650;
    let var828 : Aggregate824<UInt8, Bool, Result<Unit>> = Aggregate824<UInt8, Bool, Result<Unit>>();
    var828.func831([false, true, true, true, true], Enum454<Int8, Range<UInt32>, Float32>.defaultValue, namedParam836 : var791)
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var9), 64)
    crccheck.updateBuffer(UInt64(var194), 64)
    crccheck.updateBuffer(UInt64(var208), 64)
    crccheck.updateBuffer(UInt64(var412), 64)
    crccheck.updateBuffer(UInt64(var814), 64)
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
func func22(param23 : Int64, namedParam24 ! : Unit, optionalParam25 ! : Int16 = Int16(-114), namedParam27 ! : Float64) : Bool { // block id: 28
    if (func35().func125()) { // block id: 778
        match (UInt64(193)) {
            case _ =>
                UInt64(145)

        };
        (var791 ?? namedParam24);
        ((UInt16(174)..UInt16(219):((-83)|1)) is Range<UInt32>)
    } else { // block id: 799
        [false, false, true, false, true][0]
    }
}

public open class Class31 {
    public init() { // block id: 33

    }
;
    public static let var313 : UInt64 = UInt64(49);
    public static var var358 : Option<(Class31,Range<Int8>)> = ((Class31(), (Int8(11)..Int8(Int32(-50)):(Int64(Int32(-103))|1))) as (Class31,Range<Int8>));
    public open func func384(param385 : Int64, namedParam386 ! : Range<Int8>, namedParam387 ! : UInt64) : Float32 { // block id: 388
        try { // block id: 390
            throw Exception()
        } finally { // block id: 392
            if (true) { // block id: 395

            };
            [Float32(13.0), Float32(100.0), Float32(3.0), Float32(42.0), Float32(56.0)][3]
        }
    }
;
    public static var var457 : Enum454<Int8, Range<UInt32>, Float32> = Enum454<Int8, Range<UInt32>, Float32>.defaultValue;
    public static let var464 : Unit = ();
    public let var538 : Aggregate534<Float64, Float64, Result<Unit>> = Aggregate534<Float64, Float64, Result<Unit>>([UInt8(UInt8(UInt64(252))), UInt8(205), UInt8(190), UInt8(UInt16(27)), UInt8(Int16(-94))], Float32(-62.0), Enum454<Int8, Range<UInt32>, Float32>.defaultValue);
    public open func func125() : Bool { // block id: 126
        func128(namedParam129 : if ((var538.var757)) { (var774 ?? Float32(96.0)) } else { Float32(85.0) } )
    }
;
    public let var843 : Int8 = Int8(120);
    public open func func848(param849 : (Int16,Bool,Range<Int16>,Rune), namedParam850 ! : Bool, namedParam851 ! : Range<UInt64>) : Int64 { // block id: 852
        ();
        let var860 : Aggregate534<Float64, Float64, Result<Unit>> = Aggregate534<Float64, Float64, Result<Unit>>([UInt8(188), UInt8(243), UInt8(189), UInt8(123), UInt8(134)], Float32(-123.0), Enum454<Int8, Range<UInt32>, Float32>.defaultValue);
        if (namedParam850) { // block id: 858
            var860;
            var464;
            [(-117), 57, (-55), 11, 91]
        } else { // block id: 867
            var var869 : Array<Int64> = [(-39), (-24), 92, 100, (-70)];
            var869
        }[1]
    }

}

public func func35() : Class31 { // block id: 36
    var var55 : Array<Unit> = [(), (), (), (), ()];
    let var70 : UInt32 = UInt32(238);
    if ((var50 is Rune)) { // block id: 52
        ();
        var55
    } else if ((var64 ?? false)) { // block id: 67
        (var70..=UInt32(234):(var74|1));
        ();
        [(), (), (), (), ()]
    } else { // block id: 78
        var18;
        var18;
        [(), (), var18, var18, var18]
    }[0];
    var var98 : (Class31,Range<Int8>) = (Class31(), (Int8(116)..=Int8(104):116|1));
    if (if (var14) { var14 } else { false } ) { // block id: 95
        ();
        var98
    } else if (false) { // block id: 103
        UInt64(181);
        let var107 : Class31 = Class31();
        (var107, (Int8(77)..=Int8(-97):45|1))
    } else { // block id: 110
        var112;
        (Class31(), (var118..=Int8(99):((-85)|1)))
    }[0]
}


func func128(namedParam129 ! : Float32, optionalParam130 ! : Array<Unit> = [(), (), (), (), ()]) : Bool { // block id: 132
    var var143 : Unit = ();
    let var169 : Range<Int8> = (Int8(73)..Int8(-36):96|1);
    UInt64(match ((UInt32(33)..=UInt32(190):(var74|1))) {
        case _ =>
            var143;
            ();
            var147

        case _ : Range<Int64> =>
            ();
            var156;
            var147

        case caseVar162 : (Class31,Range<Int8>) =>
            var147

        case _ : UInt16 =>
            var169;
            Int32(122)

        case _ =>
            var147

    });
    let var181 : (Int16,Bool,Range<Int16>,Rune) = (Int16(UInt64(76)), true, (Int16(-54)..=Int16(-119):(-97)|1), 'j');
    let var215 : Array<UInt8> = [UInt8(186), UInt8(UInt64(Int32(UInt16(56)))), UInt8(Float32(UInt8(72))), UInt8(81), UInt8(213)];
    func func202<T0, T1, T2>(param203 : Range<Int64>, param204 : Array<Unit>) : UInt16 { // block id: 205
        (var208..=var208:(Int64(var215[3])|1));
        UInt16(if (match (var18) {
            case _ : Int32 =>
                var14

            case () | () | () | () =>
                ();
                var14

            case () =>
                false

            case () | () | () | () =>
                true

            case _ =>
                false

        }) { // block id: 261
            var263
        } else { // block id: 266
            var var268 : String = "=}nv!.sPIu";
            var268;
            UInt64(242)
        })
    }
;
    let var277 : Unit = ();
    match {
        case if (false) { var181 } else { (Int16(25), false, (Int16(-15)..var194:(40|1)), var50) } [1] =>
        func202<UInt64, Result<Unit>, Aggregate603<Range<UInt32>, Result<Bool>, Int64>>((121..(-126):(9|1)), [var277, var18, (), (), ()])
        case _ =>
        UInt16(var147)
    };
    func func287<T0, T1>(optionalParam288 ! : (Int16,Bool,Range<Int16>,Rune) = (Int16(Int64(Float32(UInt32(184)))), (Int64(UInt8(16)) is Range<UInt32>), (Int16(-70)..=Int16(-41):(-44)|1), 'X'), namedParam299 ! : Range<Int32>, namedParam300 ! : String) : Bool { // block id: 301
        var112.func305((Option<Range<Int32>>.Some(var482) ?? (Int32(35)..=Int32(-29):(81|1))));
        var14
    }
;
    func287<Int32, Range<UInt16>>(namedParam299 : (var498[2] ?? (Int32(25)..Int32(46):(-70)|1)), namedParam300 : try { // block id: 519
        (var112, var169);
        ();
        "HI-D61k.mJ"
    } catch (e: Exception) { // block id: 525
        var277;
        "`(+dS}A!jq"
    } finally { // block id: 528
        var530
    })
}


public enum Enum454<T0, T1, T2> {
    defaultValue
}

public struct Aggregate534<T0, T1, T2> where T0 <: Float64, T1 <: Float64, T2 <: Result<Unit> {
    public init() { // block id: 536

    }
;
    public init(param541 : Array<UInt8>, param542 : Float32, param543 : Enum454<Int8, Range<UInt32>, Float32>) { // block id: 544
        let var596 : UInt16 = UInt16(182);
        let var607 : Aggregate603<Range<UInt32>, Result<Bool>, Int64> = Aggregate603<Range<UInt32>, Result<Bool>, Int64>();
        if (if (try { // block id: 548
            var14
        } catch (e: Exception) { // block id: 550
            ();
            var263;
            var14
        } finally { // block id: 554
            var18;
            true
        }) { (var194, var14, (Int16(10)..var194:(var412|1)), 'u')[1] } else { var570[4] } ) { // block id: 573
            match ((Int32(-10)..=Int32(27):79|1)) {
                case _ : Range<UInt8> =>
                    Float32(-22.0)

                case caseVar582 : Array<Unit> =>
                    param542

                case _ =>
                    var570;
                    param542

            }
        } else { // block id: 589
            try { // block id: 591
                ();
                (UInt16(208)..=var596:(73|1))
            } finally { // block id: 599
                var112;
                (UInt16(106)..=UInt16(63):3|1)
            };
            var607.var610
        };
        var var682 : (Array<Bool>,Int32,Option<(Int16,Bool,Range<Int16>,Rune)>,Unit,Int64) = ([true, false, true, false, false], Int32(101), Option<(Int16,Bool,Range<Int16>,Rune)>.None, (), Int64(UInt16(6)));
        let var698 : Option<(Class31,Range<Int8>)> = Option<(Class31,Range<Int8>)>.None;
        ((match (Option<(Class31,Range<Int8>)>.Some(var348)) {
            case _ : Range<UInt64> =>
                var208;
                var659

            case caseVar673 : Array<Float32> =>
                Result<Option<(Int16,Bool,Range<Int16>,Rune)>>.Ok(var650)

            case _ =>
                Result<Option<(Int16,Bool,Range<Int16>,Rune)>>.Err(Exception())

        } ?? var682[2]) ?? if (var14) { // block id: 695
            var50;
            var698;
            var701
        } else if (var14) { // block id: 722
            ();
            var701
        } else { // block id: 725
            var727;
            [false, false, false, false, true];
            ('E', (Int16(-106)..Int16(120):(-103)|1), var734, var570, UInt8(179))
        }[2]);
        Aggregate534<Float64, Float64, Result<Unit>>()
    }
;
    public let var757 : Bool = ([(), (), (), (), ()] is Aggregate534<Float64, Float64, Result<Unit>>)
}

 struct Aggregate603<T0, T1, T2> where T0 <: Range<UInt32>, T1 <: Result<Bool>, T2 <: Int64 {
    public init() { // block id: 605

    }
;
    public let var610 : Float32 = Float32(-127.0)
}





public struct Aggregate824<T0, T1, T2> where T0 <: UInt8, T1 <: Bool, T2 <: Result<Unit> {
    public init() { // block id: 826

    }
;
    public static var var840 : Class31 = Class31();
    public func func831(param832 : Array<Bool>, param833 : Enum454<Int8, Range<UInt32>, Float32>, optionalParam834 ! : Unit = (), namedParam836 ! : Result<Unit>) : Int64 { // block id: 837
        var840.var843;
        var112.func848(try { // block id: 873
            (var194, var14, var878, 'r')
        } catch (_) { // block id: 887
            (UInt8(198)..UInt8(55):(var412|1));
            ();
            var618
        }, namedParam850 : match {
            case true =>
            ();
            var14
            case var14 =>
            (Class31(), (Int8(80)..=Int8(14):69|1));
            [Float32(-126.0), Float32(21.0), Float32(-128.0), Float32(95.0), Float32(-8.0)];
            var14
            case _ =>
            [(), (), (), (), ()];
            optionalParam834;
            var14
        }, namedParam851 : (UInt64(81)..var263:((-32)|1)))
    }

}

extend<T0, T1, T2> Enum454<T0, T1, T2> where T0 <: Int8, T1 <: Range<UInt32>, T2 <: Float32 {

}

extend Class31 {
    public func func305(param306 : Range<Int32>) : Range<Int16> { // block id: 307
        match (UInt64(76)) {
            case 5 | 49 | 49 | 49 =>
                Class31()

            case 16 =>
                ();
                var18;
                var112

            case _ : Rune =>
                ();
                Class31()

            case caseVar332 : Unit =>
                ();
                var313;
                var112

            case _ =>
                Class31()

        };
        func func373<T0>(namedParam374 ! : UInt32, namedParam375 ! : Option<(Class31,Range<Int8>)>, namedParam376 ! : Float32, optionalParam377 ! : UInt16 = UInt16(Int32(92))) : Float32 { // block id: 380
            var112.func384(Int64(6.0), namedParam386 : (Int8(73)..Int8(-62):(-52)|1), namedParam387 : (var412, var263, (var156..=UInt32(244):(var74|1)))[1])
        }
;
        if (((var358 ?? (Class31(), (Int8(-66)..Int8(-113):53|1))) is Range<Int8>)) { // block id: 371
            func373<Int16>(namedParam374 : var156, namedParam375 : var358, namedParam376 : Float32(-54.0), optionalParam377 : UInt16(41));
            try { // block id: 425
                var427;
                var147
            } finally { // block id: 430
                Int32(87)
            }
        } else { // block id: 432
            ();
            try { // block id: 435
                var348;
                (var412, var313, (var156..=UInt32(224):(var74|1)))
            } finally { // block id: 444
                (var74, UInt64(115), (UInt32(195)..var156:(var412|1)))
            };
            var147
        };
        match (var457) {
            case defaultValue => 
                ();
                var464;
                (Int16(-7)..Int16(18):(-26)|1)
            
            case _ => 
                let var470 : Range<Int16> = (Int16(-66)..Int16(33):(Int64(UInt16(224))|1));
                var470
            
        }
    }

}

extend<T0, T1, T2> Aggregate534<T0, T1, T2> where T0 <: Float64, T1 <: Float64, T2 <: Result<Unit> {

}


/*
[CHIR CodeGen Error]: aborting due to previous error of Enum handle
return code: 139
*/
// ASSERT: regex-not no position error occurred
