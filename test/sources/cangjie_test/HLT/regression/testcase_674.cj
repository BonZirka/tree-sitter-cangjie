/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


public let var17 : UInt64 = UInt64(Int16(UInt8(191)))
public var var42 : Unit = ()
 var var112 : Int64 = 123
public var var123 : (Float64,Option<Unit>,Range<Int16>) = ((-81.0), Option<Unit>.Some(var42), ((Int16(Int8(Int8(-62))))..=(Int16(UInt32(171))):(((-13)|1))))
 var var191 : Option<(Float64,Option<Unit>,Range<Int16>)> = Option<(Float64,Option<Unit>,Range<Int16>)>.None
 var var197 : Rune = r'o'
 var var222 : Rune = r'4'
public let var233 : Bool = (Int16(Int16(42)) is Int8)
 var var290 : (Int16,Float32,Class254,Range<UInt64>,Range<UInt16>) = (Int16(UInt32(Int64(Int16(-2)))), Float32(Int8(-29)), Class254(), ((UInt64(70))..=(UInt64(70)):(((-65)|1))), ((UInt16((-106)))..(UInt16(116)):((89|1))))
public let var313 : Class254 = Class254()
public let var373 : UInt32 = UInt32(141)
 let var422 : Range<UInt16> = ((UInt16(178))..=(UInt16(131)):((-66)|1))
public let var470 : (Range<UInt32>,Unit,(Bool,UInt32,Range<Int64>)) = (((UInt32(136))..(UInt32(151)):(25|1)), (), ((Class254() is Float64), UInt32(UInt8(Int8(96))), (((-23))..=((-5)):(63|1))))
public var var484 : Option<(Range<UInt32>,Unit,(Bool,UInt32,Range<Int64>))> = Option<(Range<UInt32>,Unit,(Bool,UInt32,Range<Int64>))>.None
public let var494 : Array<(Float64,Option<Unit>,Range<Int16>)> = [(104.0, Option<Unit>.None, ((Int16(33))..(Int16(-63)):((-65)|1))), (Float64(61), Option<Unit>.Some(var42), ((Int16(113))..=(Int16(2)):((-85)|1))), (Float64(Int32(Float32(-36.0))), Option<Unit>.None, ((Int16(7))..=(Int16(-14)):((-19)|1))), (Float64(Int8(UInt8(240))), Option<Unit>.None, ((Int16(-88))..(Int16(-64)):(111|1))), (Float64(Int8(Int32(105))), Option<Unit>.Some(var42), ((Int16(-118))..(Int16(32)):(93|1)))]
 let var525 : Option<Array<(Float64,Option<Unit>,Range<Int16>)>> = Option<Array<(Float64,Option<Unit>,Range<Int16>)>>.Some(var494)
 let var591 : Float64 = Float64(Int64(UInt64(Int16(-42))))
 let var597 : Option<Unit> = Option<Unit>.None
 var var718 : Array<(Bool,UInt32,Range<Int64>)> = [(true, UInt32(212), (((-114))..(39):((-125)|1))), ((false is Interface256<Range<UInt64>, Array<(Float64,Option<Unit>,Range<Int16>)>, Rune>), UInt32(122), ((Int64(UInt16(163)))..=(Int64(UInt32(93))):((Int64(UInt8(134))|1)))), (true, UInt32(125), ((91)..(Int64(Int16(-3))):((52|1)))), ((Option<(Float64,Option<Unit>,Range<Int16>)>.None is Range<Int8>), UInt32(163), ((72)..(62):((-84)|1))), (true, UInt32(45), ((Int64(UInt64(73)))..((-2)):(((-125)|1))))]
public let var791 : Option<Bool> = Option<Bool>.None
public var var798 : Bool = ([(Float64(UInt8(61)), Option<Unit>.None, ((Int16(125))..=(Int16(-80)):(122|1))), (118.0, Option<Unit>.Some(var42), ((Int16(-29))..=(Int16(69)):(79|1))), ((-9.0), Option<Unit>.Some(var42), ((Int16(-115))..=(Int16(-93)):((0|1)))), (Float64(UInt8(208)), Option<Unit>.None, ((Int16(119))..(Int16(34)):((-124)|1))), (Float64(Int32(23)), Option<Unit>.None, ((Int16(121))..=(Int16(-30)):((-124)|1)))] is Int64)
 var var864 : Range<Int32> = ((Int32(66))..(Int32(104)):(33|1))
public var var890 : Array<Unit> = [(), (), (), (), ()]
public var var917 : UInt8 = UInt8(47)
main(): Int64 {
    let var630 : Array<Option<UInt64>> = [Option<UInt64>.Some(var17), (Option<UInt64>.None as UInt64), Option<UInt64>.Some(var17), Option<UInt64>.None, Option<UInt64>.None];
    func func8(param9 : Int64) : Unit { // block id: 10
        var var653 : Interface255<Range<Int64>, Option<Bool>, Bool> = Class254(namedParam263 : false);
        (if (func23(namedParam24 : true, optionalParam27 : Int32(-66))) { var630[4] } else { try { // block id: 643
            var42;
            var var646 : Option<UInt64> = Option<UInt64>.Some(var17);
            var646
        } finally { // block id: 649
            Option<UInt64>.None
        } }  ?? var653.func657(namedParam658 : "?B-v5@GW@I", namedParam659 : Class557<UInt64, Option<Class254>, Int32>()));
        match (match (var718[4]) {
                case _ =>
                    var42;
                    Option<(Range<UInt32>,Unit,(Bool,UInt32,Range<Int64>))>.None

            }) {
            case caseVar763 : Int64 =>
                var42;
                var42

            case _ =>
                var42

            case caseVar773 : Range<Int32> =>
                "`iIB)THp0H";
                ()

            case _ =>
                ();
                ()

        };
        var loopTimeVar868 : Int64 = 0;
        if ((try { // block id: 789
            var791
        } finally { // block id: 793
            var791
        } ?? if (var233) { var798 } else { var233 } )) { () } else { while (match {
            case var233 =>
            ();
            false
            case _ =>
            (var233, var373, (((-13))..(18):((-91)|1)));
            Option<Bool>.None;
            false
        } && loopTimeVar868 < 100 ) {
            loopTimeVar868++;
            Class254(UInt64(171), namedParam848 : UInt8(100), optionalParam849 : var864);
            var42
        } }
    }
;
    func8(28);
    if (false) { // block id: 874
        ();
        [(), (), (), (), ()]
    } else if (false) { // block id: 878
        [var42, (), (), var42, ()];
        [(), (), (), (), ()]
    } else { // block id: 886
        var630;
        "H7b9__7aFU";
        var890
    }[3];
    Aggregate894<UInt8, Range<Int32>, Array<(Float64,Option<Unit>,Range<Int16>)>>.func899<Range<UInt8>, Int64>(optionalParam903 : ((UInt32(250))..=(UInt32(39)):(91|1)))
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
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
        crc_output = Array<Int64>(crc_output_n, repeat:0)
        buffer = Array<Int64>(buffer_n, repeat:0)
        poly_n = crc_n + 1
        poly = Array<Int64>(poly_n, repeat:0)
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
        var byteArray = Array<Int64>(byte_n, repeat:0)
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
        var crc_buffer = Array<Int64>(crc_output_n, repeat:0)
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
        crc_output = Array<Int64>(crc_output_n, repeat:0)
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

public func func23(namedParam24 ! : Bool, optionalParam25 ! : Int16 = Int16(-15), optionalParam27 ! : Int32 = Int32(UInt16(43)), optionalParam30 ! : UInt8 = UInt8(Int16(Int8(UInt64(83))))) : Bool { // block id: 35
    let var83 : Unit = ();
    let var147 : Array<(Float64,Option<Unit>,Range<Int16>)> = [(Float64(Int8(Int8(47))), Option<Unit>.None, ((Int16((-42.0)))..(Int16(-96)):((Int64(Int16(-32))|1)))), (Float64(UInt8((-49))), Option<Unit>.None, ((Int16(-45))..(Int16(14)):((-42)|1))), (91.0, Option<Unit>.None, ((Int16(-39))..=(Int16(40)):(9|1))), (Float64(Float64(UInt32(36))), Option<Unit>.Some(var42), ((Int16(23))..(Int16(55)):((-36)|1))), ((-109.0), Option<Unit>.None, ((Int16(Int8(67)))..(Int16(Float32(-22.0))):((Int64(UInt64(48))|1))))];
    func func48(param49 : Rune, param50 : Bool) : Option<Unit> { // block id: 51
        var loopTimeVar57 : Range<UInt64> = ((UInt64(197))..=(UInt64(131)):((17|1)));
        let var80 : Unit = ();
        var var89 : Float32 = Float32(Float32(Int32(-100)));
        UInt8(match (for (i in loopTimeVar57 where (param50))  {

            }) {
            case caseVar72 : Range<UInt16> =>
                var17;
                "Lb|ycgI.~h";
                Float32(-53.0)

            case () | () | () | () =>
                var89;
                var83;
                Float32(94.0)

            case () | () | () | () =>
                ();
                Float32(-93.0)

            case _ : Range<Int32> =>
                Float32(-109.0)

            case _ =>
                var42;
                var112;
                var89

        });
        (try { // block id: 136
            Option<(Float64,Option<Unit>,Range<Int16>)>.None;
            var var139 : Option<(Float64,Option<Unit>,Range<Int16>)> = Option<(Float64,Option<Unit>,Range<Int16>)>.None;
            var139
        } finally { // block id: 141
            var123;
            Option<(Float64,Option<Unit>,Range<Int16>)>.Some(var123)
        } ?? var147[4])[1]
    }
;
    let var238 : Option<Bool> = Option<Bool>.None;
    func func45() : Option<Unit> { // block id: 46
        var var242 : Bool = (Float32(Int8(17)) is Range<Int16>);
        func48(match (var191) {
            case _ : Option<(Float64,Option<Unit>,Range<Int16>)> =>
                var197

            case _ =>
                r'W'

            case caseVar205 : Option<Unit> =>
                var42;
                let var209 : Unit = ();
                var209;
                r'M'

            case caseVar214 : Float32 =>
                ();
                ();
                var197

            case _ =>
                var222

        }, if ((true is UInt64)) { (var238 ?? namedParam24) } else { var242 } )
    }
;
    var var260 : Class254 = Class254(namedParam263 : false);
    let var334 : Float64 = 5.0;
    var var337 : Option<Unit> = Option<Unit>.Some(var42);
    var var364 : Range<Int16> = ((Int16(-82))..(Int16(-4)):((-9)|1));
    (func45() ?? func247(var260.var320, (UInt16(166), (var334, var337, ((optionalParam25)..(optionalParam25):(((-37)|1)))))[1], try { // block id: 346
        ();
        ((var17)..(UInt64(227)):((11|1)));
        ((UInt64(164))..=(UInt64(128)):(36|1))
    } finally { // block id: 353
        ((85)..(82):((-12)|1));
        ((UInt64(147))..=(UInt64(153)):((var112|1)))
    }, namedParam251 : match ((var334, var337, var364)) {
        case (5.0,caseVar369,_) =>
            ((var373)..=(UInt32(106)):(((-31)|1)));
            var83

        case (caseVar380,_,_ : UInt64) =>
            var42

        case (_,_ : (Float64,Option<Unit>,Range<Int16>),caseVar385) =>
            ()

        case _ =>
            ();
            var83;
            var83

    }));
    let var530 : Float64 = Float64(Float32(-106.0));
    var var542 : Option<Unit> = Option<Unit>.None;
    func396((var525 ?? [(var530, var337, ((Int16(-102))..(Int16(5)):(((-61)|1)))), var123, ((-112.0), var542, var364), (var530, Option<Unit>.None, ((optionalParam25)..(Int16(32)):((var112|1)))), ((-84.0), var542, var364)]), namedParam398 : Class557<UInt64, Option<Class254>, Int32>.var562, namedParam399 : try { // block id: 620
        optionalParam30
    } catch (e: Exception) { // block id: 622
        UInt8(194)
    })[0]
}




func func247(param248 : Range<UInt8>, param249 : (Float64,Option<Unit>,Range<Int16>), param250 : Range<UInt64>, namedParam251 ! : Unit) : Unit { // block id: 252

}

public open class Class254 <: Interface255<Range<Int64>, Option<Bool>, Bool> & Interface256<Range<UInt64>, Array<(Float64,Option<Unit>,Range<Int16>)>, Rune> {
    public init() { // block id: 258

    }
;
    public static var var280 : Class254 = Class254();
    public init(namedParam263 ! : Bool) { // block id: 264
        let var270 : Bool = (((Int16(-54))..(Int16(70)):((-33)|1)) is Int16);
        if (if (if (var233) { var270 } else { var233 } ) { // block id: 274
            ();
            true
        } else { // block id: 277
            var270
        }) { var280 } else { (Option<(Int16,Float32,Class254,Range<UInt64>,Range<UInt16>)>.None ?? (Int16(93), Float32(-120.0), var313, ((UInt64(109))..(UInt64(42)):(98|1)), ((UInt16(185))..(UInt16(93)):((-102)|1))))[2] }
    }
;
    public var var320 : Range<UInt8> = ((UInt8(UInt64(Float64(Int16(53)))))..(UInt8(171)):((68|1)));
    public static let var601 : Int16 = Int16(Int8(UInt8(UInt8(UInt16(21)))));
    public static var var613 : Class557<UInt64, Option<Class254>, Int32> = Class557<UInt64, Option<Class254>, Int32>();
    public init(param847 : UInt64, namedParam848 ! : UInt8, optionalParam849 ! : Range<Int32> = ((Int32(-108))..(Int32(-98)):((-66)|1)), optionalParam851 ! : UInt16 = UInt16(Int8(94))) { // block id: 854
        Class557<UInt64, Option<Class254>, Int32>.var858
    }

    public func func657(namedParam658 ! : String, namedParam659 ! : Class254) : UInt64 { // block id: 660
        (Class557<UInt64, Option<Class254>, Int32>.var666[1] ?? try { // block id: 691
            let var693 : Int32 = Int32(-41);
            var693;
            var17
        } catch (_) { // block id: 696
            var var701 : Option<UInt64> = Option<UInt64>.None;
            [Option<UInt64>.None, Option<UInt64>.None, var701, var701, Option<UInt64>.None];
            Option<Bool>.None;
            var17
        } finally { // block id: 707
            ();
            var42;
            UInt64(233)
        })
    }

}

public interface Interface255<T0, T1, T2> {
    func func657(namedParam658 ! : String, namedParam659 ! : Class254) : UInt64 { // block id: 660
        (Class557<UInt64, Option<Class254>, Int32>.var666[1] ?? try { // block id: 691
            let var693 : Int32 = Int32(-41);
            var693;
            var17
        } catch (_) { // block id: 696
            var var701 : Option<UInt64> = Option<UInt64>.None;
            [Option<UInt64>.None, Option<UInt64>.None, var701, var701, Option<UInt64>.None];
            Option<Bool>.None;
            var17
        } finally { // block id: 707
            ();
            var42;
            UInt64(233)
        })
    }

}

public interface Interface256<T0, T1, T2> <: Interface255<Range<Int64>, Option<Bool>, Bool> {

}


public func func396(param397 : Array<(Float64,Option<Unit>,Range<Int16>)>, namedParam398 ! : (Int16,Float32,Class254,Range<UInt64>,Range<UInt16>), namedParam399 ! : UInt8) : (Bool,UInt32,Range<Int64>) { // block id: 400
    var var432 : (String,Bool,UInt32) = ("5fsFL$C2Zg", (((Int8(33))..=(Int8(-66)):(48|1)) is Float32), UInt32(215));
    var loopTimeVar440 : Range<UInt64> = ((UInt64(UInt32(182)))..(UInt64(106)):(((-18)|1)));
    for (i in loopTimeVar440 where ((match ((Int16(93), Float32(-105.0), Class254(), ((UInt64(114))..=(UInt64(152)):((-93)|1)), var422)) {
        case _ =>
            ();
            ((UInt16(138))..=(UInt16(213)):(116|1));
            Option<Bool>.None

    } ?? var432[1]))) {

    };
    let var454 : Range<Int16> = ((Int16(74))..=(Int16(79)):((-79)|1));
    if (false) { var191 } else { match ((73.0, Option<Unit>.None, var454)) {
        case _ =>
            Option<Unit>.Some(var42);
            var42;
            Option<(Float64,Option<Unit>,Range<Int16>)>.None

    } } ;
    (Option<(Range<UInt32>,Unit,(Bool,UInt32,Range<Int64>))>.Some(var470) ?? (var484 ?? var470))[2]
}




public open class Class557<T0, T1, T2> <: Class254 {
    public init() { // block id: 559

    }
;
    private static var var582 : Option<Class254> = Option<Class254>.None;
    public init(param569 : Option<Bool>, optionalParam570 ! : String = "WQ.Zdm\\}yD") { // block id: 572
        try { // block id: 574
            (var582 ?? var280)
        } finally { // block id: 585
            match ((UInt16(177), (var591, var597, ((var601)..(var601):(((-88)|1)))))) {
                case _ =>
                    ();
                    var613;
                    var313

            }
        }
    }
;
    public static var var562 : (Int16,Float32,Class254,Range<UInt64>,Range<UInt16>) = (Int16(Float32(-5.0)), Float32(65.0), Class557<UInt64, Option<Class254>, Int32>(Option<Bool>.None), ((UInt64(158))..=(UInt64(168)):(3|1)), ((UInt16(2))..=(UInt16(101)):((-45)|1)));
    public static let var666 : Array<Option<UInt64>> = [(Class557<UInt64, Option<Class254>, Int32>(Option<Bool>.None) as UInt64), (Class557<UInt64, Option<Class254>, Int32>() as UInt64), ((((UInt32(56))..=(UInt32(244)):((-54)|1)), (), (true, UInt32(166), ((87)..((-4)):((97|1))))) as UInt64), (Float32(UInt32(Int8(-68))) as UInt64), Option<UInt64>.Some(var17)];
    public static let var858 : Interface256<Range<UInt64>, Array<(Float64,Option<Unit>,Range<Int16>)>, Rune> = Class557<UInt64, Option<Class254>, Int32>(Option<Bool>.None)
}



struct Aggregate894<T0, T1, T2> {
    public init() { // block id: 896

    }
;
    public static func func899<T0, T1>(optionalParam900 ! : Option<Bool> = (Option<(Int16,Float32,Class254,Range<UInt64>,Range<UInt16>)>.Some(var290) as Bool), optionalParam903 ! : Range<UInt32> = ((UInt32(UInt64(33)))..(UInt32(221)):((3|1)))) : Int64 { // block id: 909
        var var929 : Unit = ();
        Int64((match {
            case var233 =>
            var42;
            ();
            let var925 : Option<UInt8> = Option<UInt8>.Some(var917);
            var925
            case _ =>
            var929;
            var var932 : Option<UInt8> = Option<UInt8>.None;
            var932
        } ?? UInt8(71)))
    }

}


extend Class254 {

}


/*
return code: 139
*/
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_dce_unused_variable


