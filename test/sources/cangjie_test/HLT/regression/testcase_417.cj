/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

public let var13 : Unit = ()
public var var41 : String = "FD0i<OT,\"X"
public let var61 : Int8 = Int8(39)
public let var96 : Interface28 = Class27()
public let var115 : Bool = (UInt8(Float32(-85.0)) is Range<Int32>)
public var var125 : Enum120<Int64, Option<String>, Option<Option<Unit>>> = Enum120<Int64, Option<String>, Option<Option<Unit>>>.defaultValue
public let var152 : Option<Bool> = Option<Bool>.None
public var var187 : Range<Int64> = ((82)..=(Int64(Int8(UInt8(Int8(-33))))):((Int64(UInt64(Float32(Float32(1.0))))|1)))
 let var250 : Rune = r'e'
public var var267 : Int8 = Int8(-98)
public let var285 : Int64 = Int64(Int16(69.0))
public var var306 : UInt8 = UInt8(242)
public var var309 : Unit = ()
public let var314 : Range<UInt64> = ((UInt64(Float32(41.0)))..=(UInt64(249)):((Int64(0.0)|1)))
public let var370 : Array<Bool> = [true, false, true, false, false]
public let var393 : Bool = (UInt32(Int16(93)) is Range<UInt8>)
public let var405 : String = "6aVD1*o8VU"
public let var420 : (UInt16,Bool,Float64,Range<UInt8>) = (UInt16(214), ((((-102))..=((-101)):(86|1)) is Option<Bool>), 57.0, ((UInt8(UInt8(114)))..(UInt8(42)):((Int64(UInt8(8.0))|1))))
public var var474 : Option<String> = Option<String>.None
public let var500 : Int32 = Int32((-125))
public var var627 : Int32 = Int32(43)
public var var654 : (Bool,String) = ((((UInt32(99))..(UInt32(167)):(31|1)) is Unit), "\"(?20e<`(Q")
public var var692 : UInt16 = UInt16(184)
public var var696 : Float64 = Float64(Int8(71.0))
public let var726 : Bool = true
public let var824 : Range<Int8> = ((Int8(UInt16(167)))..=(Int8(-5)):((94|1)))
public var var836 : Enum120<Int64, Option<String>, Option<Option<Unit>>> = Enum120<Int64, Option<String>, Option<Option<Unit>>>.defaultValue
public let var839 : (Bool,String) = (((((((-50))..=((-76)):((-74)|1)) is Int16), "@m_}0)Dw[o") is Int8), "Rh/j}y~BG}")
public var var861 : Int16 = Int16(-66)
public let var872 : Aggregate868 = Aggregate868()
 let var890 : Unit = ()
public let var914 : Range<Int16> = ((Int16(-32))..(Int16(-28)):(53|1))
 var var986 : Range<UInt8> = ((UInt8(69))..=(UInt8(106)):((-26)|1))
public let var995 : Enum992 = Enum992.defaultValue
 var var1022 : Enum322 = Enum322.defaultValue
public let var1032 : Unit = ()
 var var1045 : Option<Range<Int16>> = Option<Range<Int16>>.None
 var var1087 : Rune = r'e'
public let var1106 : Array<Unit> = [(), (), (), (), ()]
public let var1122 : Option<Unit> = Option<Unit>.Some(var309)
public var var1135 : Option<Option<Unit>> = Option<Option<Unit>>.None
public let var1170 : Option<(UInt16,Bool,Float64,Range<UInt8>)> = Option<(UInt16,Bool,Float64,Range<UInt8>)>.None
public var var1191 : Unit = ()
public let var1199 : Class27 = Class27()
public var var1214 : Int8 = Int8(UInt8(51))
 let var1332 : Range<Int8> = ((Int8(44))..(Int8(UInt8(UInt64(Float32(-122.0))))):((Int64(Float32(55))|1)))
public let var1452 : Array<Int64> = [Int64(UInt16(UInt16(155))), Int64(UInt32(173)), 119, 97, (-49)]
main(): Int64 {
    func7(try { // block id: 472
        var474;
        "mJ))3Wd4Dg"
    } catch (e: Exception) { // block id: 477
        let var479 : (Range<Int32>,Range<Int8>,Unit,Array<String>,String) = (((Int32(96))..(Int32(97)):((-98)|1)), ((Int8(70))..=(Int8(-14)):(51|1)), (), ["*6GW@vL2IX", "Bfkcz}vT]P", "91:4MK:%dC", "QEV3jN+@]P", ".F?frVgb v"], "XB~TVjsUf~");
        var479;
        var41
    }, var96.func490(), namedParam10 : try { // block id: 1423
        ((-44.0), var370, [[false, true, true, true, true], [true, true, false, false, false], [true, false, false, true, false], [false, false, false, true, false], [false, true, false, false, true]], ((var306)..=(var306):(((-96)|1))));
        "mZzq~@x!x7"
    } catch (_) { // block id: 1433
        var309;
        var309;
        var41
    } finally { // block id: 1437
        var1199;
        var41
    });
    match (((Int32(21))..=(var500):((var285|1)))) {
        case caseVar1449 =>
            var1452

        case _ =>
            UInt64(150);
            UInt8(24);
            [var285, 15, var285, var285, (-123)]

    }[0]
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var61), 64)
    crccheck.updateBuffer(UInt64(var267), 64)
    crccheck.updateBuffer(UInt64(var285), 64)
    crccheck.updateBuffer(UInt64(var627), 64)
    crccheck.updateBuffer(UInt64(var1214), 64)
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
        crc_output = Array<Int64> (crc_output_n, repeat:0)
        buffer = Array<Int64> (buffer_n, repeat:0)
        poly_n = crc_n + 1
        poly = Array<Int64> (poly_n, repeat:0)
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
        var byteArray = Array<Int64> (byte_n, repeat:0)
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
        var crc_buffer = Array<Int64> (crc_output_n, repeat:0)
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
        crc_output = Array<Int64> (crc_output_n, repeat:0)
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
public func func7(param8 : String, param9 : Float64, namedParam10 ! : String) : Unit { // block id: 11
    var13;
    let var341 : Range<UInt16> = ((UInt16(57))..=(UInt16(164)):((21|1)));
    func func47(param48 : Option<String>, param49 : UInt16) : String { // block id: 50
        var loopTimeVar80 : Int64 = 0;
        while ((Class27.var56 is Range<UInt32>) && loopTimeVar80 < 100 ) {
            loopTimeVar80++;
            UInt64(var61);
            let var70 : Array<String> = ["zKln%$;$kq", "kt,Ofo%ta(", "[/\"SrC({z&", "H^G\"akJC1n", "E.=6;w4Y^r"];
            (((Int32(27))..(Int32(54)):((-90)|1)), ((Int8(103))..(Int8(-54)):((-119)|1)), var13, var70, "R__nz@iel}")[2]
        };
        if (true) { () } else { () } ;
        let var325 : Enum322 = Enum322.defaultValue;
        [try { // block id: 88
            var41
        } catch (_) { // block id: 90
            "92N]M>^lx5"
        } finally { // block id: 92
            namedParam10
        }, var96.func99(((Int16(22))..(Int16(49)):(36|1)), var314), match (var325) {
            case defaultValue =>
                var13;
                var13;
                param8

            case defaultValue =>
                "HSa!>j|g_)"

            case defaultValue =>
                var341;
                "8=@oYz85_u"

            case _ =>
                ();
                "9_cT]<Va;5"

        }, match {
            case var115 =>
            ",]BDc3t5`>"
            case _ =>
            ();
            namedParam10
        }, ">%t@Tt2qOc"][3]
    }
;
    var var361 : Option<String> = Option<String>.None;
    [Class27.var33, (Option<String>.Some(var41) ?? "mu>BG/4\\Ij"), func47(var361, UInt16(82)), if (false) { // block id: 366
        var var387 : Bool = false;
        (param9, var370, [var370, [false, false, false, true, true], [true, false, true, true, true], [false, true, var115, var115, true], [true, true, var115, var387, true]], ((UInt8(227))..=(UInt8(196)):(75|1)));
        "Kn DdPDIQ="
    } else if (var393) { // block id: 397
        var309;
        var309;
        namedParam10
    } else { // block id: 401
        var309;
        Class27();
        var405
    }, (var361 ?? "\\,pl[/ vdD")][2];
    var var436 : UInt16 = UInt16(44);
    var var442 : Range<UInt8> = ((UInt8(Int16(-93)))..=(UInt8(Int8(Int32(-14)))):((83|1)));
    var loopTimeVar464 : Range<UInt64> = ((UInt64(UInt64(Float32(70.0))))..(UInt64(83)):(((-41)|1)));
    for (i in loopTimeVar464 where ((Option<(UInt16,Bool,Float64,Range<UInt8>)>.Some(var420) ?? var420))[1]) {
        if (var115) { var309 } else { var13 } ;
        var loopTimeVar463 : Int64 = 0;
        while (false && loopTimeVar463 < 100 ) {
            loopTimeVar463++;
            Option<String>.Some(var41)
        }
    }
}

public open class Class27 <: Interface28 {
    public init() { // block id: 30

    }
;
    public static let var33 : String = ">K|CumnBz]";
    public static var var56 : Range<UInt64> = ((UInt64(201))..(UInt64(240)):(67|1));
    public static var var743 : Unit = ();
    public static let var793 : Bool = ((Class27() as Bool) is UInt64);
    public init(param1250 : (Unit,Range<Int64>)) { // block id: 1251
        (var1122 ?? if (if (true) { // block id: 1257
            false
        } else if (false) { // block id: 1260
            ();
            ();
            true
        } else { // block id: 1264
            var13;
            var726
        }) { // block id: 1267
            var267;
            ();
            var743
        } else if (match (UInt8(127)) {
            case _ =>
                Option<Enum322>.None;
                true

            case caseVar1280 : Float64 =>
                false

            case _ =>
                Enum322.defaultValue;
                Option<(UInt16,Bool,Float64,Range<UInt8>)>.Some(var420);
                var393

        }) { // block id: 1288
            ();
            ()
        });
        match (var872) {
            case _ =>
                ();
                ((var285)..(34):(((-108)|1)));
                var1199

        }
    }

}

public interface Interface28 {
    func func99(param100 : Range<Int16>, param101 : Range<UInt64>) : String { // block id: 102
        let var140 : Option<Bool> = (((UInt16(185))..=(UInt16(89)):((119|1))) as Bool);
        func func105(optionalParam106 ! : Unit = ()) : Bool { // block id: 108
            var var130 : Float32 = Float32((-108));
            let var169 : UInt8 = UInt8(Float64(UInt16(UInt8(160))));
            let var177 : UInt64 = UInt64(231);
            let var180 : Int64 = Int64(Int8(-48));
            func func200<T0, T1>(namedParam201 ! : Class27, optionalParam202 ! : Rune = r'f') : Bool { // block id: 204
                let var214 : Array<Bool> = [false, false, (5.0 is (Range<Int32>,Range<Int8>,Unit,Array<String>,String)), (Enum120<Int64, Option<String>, Option<Option<Unit>>>.defaultValue is Enum120<Int64, Option<String>, Option<Option<Unit>>>), ((((Int32(89))..(Int32(51)):(((-117)|1))), ((Int8(-78))..=(Int8(124)):((29|1))), (), ["A01b;w{2Se", ",\\QglP@sf7", ">Gq>e~gXV&", "9=;WQ'EI92", "M0na7Z^JEn"], "=mcF[=U2^3") is (Range<Int32>,Range<Int8>,Unit,Array<String>,String))];
                (50.0, var214, [[false, true, false, true, false], [true, true, false, false, true], [true, false, true, false, false], [true, true, false, false, true], [false, false, false, true, false]], ((UInt8(117))..(var169):((112|1))))[2][2][3]
            }
;
            (match (try { // block id: 123
                    var125
                } finally { // block id: 127
                    var13;
                    var130;
                    var125
                }) {
                case caseVar136 =>
                    ();
                    var140

                case caseVar148 =>
                    UInt64(253);
                    var152

                case caseVar156 : UInt8 =>
                    ();
                    Enum120<Int64, Option<String>, Option<Option<Unit>>>.enumValue160(((Int16(-37))..(Int16(104)):(47|1)));
                    var140

                case caseVar166 =>
                    var169;
                    ((UInt64(80))..(var177):((var180|1)));
                    var152

                case _ =>
                    var187;
                    var140

            } ?? func200<Option<Enum322>, Range<UInt8>>(namedParam201 : Class27(), optionalParam202 : var250))
        }
;
        var loopTimeVar270 : Int64 = 0;
        while (func105() && loopTimeVar270 < 100 ) {
            loopTimeVar270++;
            let var264 : Class27 = Class27();
            match (UInt64(88)) {
                case caseVar257 =>
                    Int8(-93)

                case _ =>
                    var125;
                    var264;
                    var267

            }
        };
        var var272 : UInt32 = UInt32(Int8(UInt64(Int64(UInt32(96)))));
        var272;
        let var298 : Int64 = (-90);
        match (Int64(Int8(Int8(-43)))) {
            case 69 =>
                ();
                Int8(-119);
                let var293 : String = "/+fXrpwzrW";
                var293

            case -90 | 35 =>
                var13;
                "gFvVwa]?[Q"

            case _ =>
                var306;
                var309;
                var41

        }
    }
;
    func func784(namedParam785 ! : Range<Int16>) : Bool { // block id: 786
        ();
        var loopTimeVar817 : Int64 = 0;
        while (if ((Class27.var793)) { try { // block id: 798
            true
        } finally { // block id: 800
            var13;
            false
        } } else { var393 }  && loopTimeVar817 < 100 ) {
            loopTimeVar817++;
            let var812 : Option<Int8> = Option<Int8>.Some(var267);
            (var812 ?? Int8(-104))
        };
        match (try { // block id: 820
                (((Int32(67))..(Int32(-38)):(38|1)), var824, var13, ["%.QSuGg.82", "c'iDtafF43", "4U#t'hJsk~", "~0|+5~l/H!", "OyeeVr{A_V"], "wPynew7:'2");
                var654
            } finally { // block id: 834
                var836;
                var839
            }) {
            case caseVar849 : Range<UInt16> =>
                var96;
                ();
                var726

            case _ =>
                var13;
                ();
                true

        }
    }
;
    func func881(namedParam882 ! : Int8) : Range<UInt64> { // block id: 883
        var var922 : Enum322 = Enum322.defaultValue;
        try { // block id: 885
            (var890, ((var285)..=(var285):((41|1))))[0]
        } finally { // block id: 897
            try { // block id: 899
                var696
            } catch (_) { // block id: 901
                ();
                var285;
                (-15.0)
            } finally { // block id: 905
                ();
                var696
            };
            (Option<Range<Int16>>.Some(var914) ?? var914);
            var loopTimeVar924 : Range<UInt64> = ((UInt64(Int32(UInt8(221))))..=(UInt64(Int8(99))):((Int64(Int32(Int8(-122)))|1)));
            for (i in loopTimeVar924 where (true)) {
                var922
            }
        };
        var var945 : (Range<UInt64>,Range<UInt16>) = (((UInt64(4))..(UInt64(8)):((-107)|1)), ((UInt16(Int32(101)))..=(UInt16(Int16(-9))):((78|1))));
        match ((var285 as Bool)) {
            case caseVar941 =>
                ();
                var945

            case _ =>
                ();
                ();
                (((UInt64(236))..=(UInt64(49)):(121|1)), ((UInt16(178))..(var692):((var285|1))))

        }[0]
    }
;
    func func774(namedParam775 ! : (UInt16,Bool,Float64,Range<UInt8>), namedParam776 ! : Rune, namedParam777 ! : Range<UInt16>, namedParam778 ! : Class27) : Enum322 { // block id: 779
        if (var96.func784(namedParam785 : ((var861)..(var861):(((-27)|1))))) { // block id: 865
            ((UInt64(53))..=(UInt64(210)):((-46)|1))
        } else if (var872.var875) { // block id: 877
            this.func881(namedParam882 : Int8(77))
        } else { // block id: 966
            let var969 : Option<(UInt16,Bool,Float64,Range<UInt8>)> = Option<(UInt16,Bool,Float64,Range<UInt8>)>.Some(var420);
            match (var969) {
                case _ : Enum322 =>
                    var314

                case _ =>
                    var986;
                    ();
                    var314

            }
        };
        var loopTimeVar1008 : Int64 = 0;
        var loopTimeVar1015 : Int64 = 0;
        if (match (var995) {
            case _ =>
                var839;
                ();
                false

        }) { do {
            loopTimeVar1008++;
            ();
            ()
        } while (true && loopTimeVar1008 < 100 )  } else { while ((var152 ?? var115) && loopTimeVar1015 < 100 ) {
            loopTimeVar1015++;

        } } ;
        var var1052 : Option<Enum322> = Option<Enum322>.Some(var1022);
        (match (match (Option<Bool>.Some(var115)) {
                case caseVar1029 =>
                    var1032;
                    var var1035 : Option<Range<Int16>> = Option<Range<Int16>>.Some(var914);
                    var1035

                case _ : Float32 =>
                    var696;
                    Option<Range<Int16>>.None

                case _ =>
                    var1045

            }) {
            case caseVar1049 =>
                var1052

            case _ =>
                ();
                var1052

            case _ : UInt8 =>
                ((UInt8(70))..(UInt8(50)):(101|1));
                var890;
                var1052

            case _ =>
                ((UInt8(72))..=(UInt8(165)):((12|1)));
                Option<Enum322>.None

        } ?? Enum322.defaultValue)
    }
;
    func func1092(param1093 : Int64, param1094 : Range<UInt16>) : Range<UInt16> { // block id: 1095
        try { // block id: 1097
            var loopTimeVar1102 : Int64 = 0;
            while (var726 && loopTimeVar1102 < 100 ) {
                loopTimeVar1102++;

            };
            var1106[4]
        } finally { // block id: 1109

        };
        ((try { // block id: 1126
            var13;
            Option<Option<Unit>>.Some(var1122)
        } catch (e: Exception) { // block id: 1131
            Option<(UInt16,Bool,Float64,Range<UInt8>)>.Some(var420);
            UInt32(77);
            var1135
        } ?? try { // block id: 1138
            Option<Bool>.None;
            ();
            var1122
        } finally { // block id: 1142
            var474;
            var1032;
            var1122
        }) ?? ());
        var loopTimeVar1153 : Range<UInt64> = ((UInt64(29))..=(UInt64(83)):((112|1)));
        if ((for (i in loopTimeVar1153 where (var115)) {
            (((-102))..=((-95)):(42|1))
        } is Unit)) { (match {
            case var393 =>
            ();
            UInt16(175)
            case false =>
            ();
            UInt16(169)
            case _ =>
            var1170;
            var692
        })..(Aggregate1174.var1179):((Int64(Int32(50))|1)) } else { try { // block id: 1184
            var var1186 : Unit = ();
            var1186;
            ((UInt16(210))..=(UInt16(0)):(73|1))
        } finally { // block id: 1189
            var1191;
            param1094
        } }
    }
;
    func func490() : Float64 { // block id: 491
        var var1364 : Range<UInt32> = ((UInt32(Int16(UInt64(Int16(50)))))..(UInt32(28)):((67|1)));
        var var1374 : (Unit,Range<Int64>) = ((), (((-82))..=(93):((-8)|1)));
        try { // block id: 493
            match {
                case var115 =>
                ();
                ();
                var500
                case _ =>
                var500
            };
            var13
        } finally { // block id: 506
            func508(var1364, Class27(var1374), namedParam511 : var696);
            if (false) { // block id: 1381
                var13;
                ()
            };
            var13
        };
        let var1419 : Array<Float64> = [105.0, 6.0, (-82.0), (-80.0), (-65.0)];
        match (Option<Rune>.None) {
            case caseVar1391 =>
                ();
                [109.0, 16.0, 12.0, 84.0, (-117.0)]

            case _ =>
                [var696, var696, (-93.0), 28.0, var696]

            case caseVar1406 =>
                ();
                var41;
                [44.0, (-40.0), var696, (-55.0), 69.0]

            case _ =>
                var1419

        }[2]
    }

}



public enum Enum120<T0, T1, T2> {
    defaultValue |
    enumValue160(Range<Int16>)
}
public enum Enum322 {
    defaultValue
}

func func508(param509 : Range<UInt32>, param510 : Interface28, namedParam511 ! : Float64, optionalParam512 ! : Option<Bool> = ("=6Ub+hv]b(" as Bool)) : Int32 { // block id: 515
    let var523 : Array<Array<Bool>> = [[(Int16(Int16(109)) is String), false, true, ((-69.0) is Enum322), false], [true, false, (((UInt16(31))..(UInt16(35)):((60|1))) is UInt8), (Enum120<Int64, Option<String>, Option<Option<Unit>>>.enumValue160(((Int16(56))..=(Int16(19)):(68|1))) is Range<UInt64>), (Class27() is Range<Int16>)], [(["wk[zTbm?+2", "9E8:ixl\\|@", "62uT;{AxDn", "#qrP{8Mhz$", "e*K.K<??V)"] is Int16), true, false, (((UInt16(194))..=(UInt16(209)):((-43)|1)) is Unit), (["8:+'OZH~r:", "us_[*|.a8}", "*psU0x.Kc<", "+n9`A\"b,_h", "+@Pp|Rp9gm"] is UInt64)], [true, false, true, true, false], [(Enum322.defaultValue is Float64), ([[true, true, true, false, true], [false, false, false, true, false], [true, false, false, true, true], [true, true, true, false, false], [true, true, true, false, false]] is Array<Array<Bool>>), (UInt8(Int16(77)) is UInt8), true, (UInt32(92) is UInt16)]];
    if ((match ((namedParam511, [true, true, false, false, false], var523, ((UInt8(244))..(UInt8(247)):((-102)|1)))) {
        case (-79.0,caseVar576,caseVar577,caseVar578 : Float32) =>
            ();
            "=\\^gvj@41&"

        case (62.0,_ : UInt8,_,_) | (89.0,_ : UInt8,_,_) =>
            ();
            var420;
            "%YbQ[]e'$y"

        case _ =>
            var var593 : Range<Int32> = ((Int32(88))..(Int32(66)):(((-32)|1)));
            (var593, ((var61)..(var267):((73|1))), (), ["~s(XeV>wyM", "q0n3bm{R*,", "71Z5gbeO(V", "tBx3a@*4qn", "uN?kT-ru[G"], var405);
            var13;
            "KMrAXC;`e2"

    } is Float32)) { match (try { // block id: 609
            Option<(UInt16,Bool,Float64,Range<UInt8>)>.None
        } finally { // block id: 611
            ();
            var var614 : Option<(UInt16,Bool,Float64,Range<UInt8>)> = Option<(UInt16,Bool,Float64,Range<UInt8>)>.Some(var420);
            var614
        }) {
        case caseVar618 =>
            var13;
            Int32(41)

        case _ =>
            ();
            ();
            var627

    } } else { (if (func631(namedParam632 : var1332, optionalParam633 : var824, optionalParam640 : var523)) { (if (false) { var627 } else { var627 } ) } else { try { // block id: 1349
        UInt8(246);
        var309;
        Int32(39)
    } catch (_) { // block id: 1353
        var627
    } finally { // block id: 1355
        (var314, ((UInt16(109))..(var692):((var285|1))));
        Int32(-19)
    } } ) }
}

public func func631(namedParam632 ! : Range<Int8>, optionalParam633 ! : Range<Int8> = ((Int8(81))..(Int8(-103)):((Int64(Int16(Int32(17)))|1))), optionalParam640 ! : Array<Array<Bool>> = [[true, false, false, true, true], [true, true, false, false, false], [false, false, true, false, true], [true, true, true, true, false], [true, false, true, false, false]], optionalParam642 ! : Range<Int64> = ((Int64(UInt32(182)))..=((-39)):((Int64(UInt32(27))|1)))) : Bool { // block id: 649
    var var684 : Range<Int32> = ((Int32(-96))..=(Int32(-70)):(((-76)|1)));
    var var753 : UInt32 = UInt32(Float64(UInt16(182)));
    if (var654[0]) { // block id: 660
        var309;
        UInt32(var267)
    } else if (match (namedParam632) {
        case caseVar669 =>
            var var675 : Float64 = Float64(UInt8(52));
            (UInt16(226), var115, var675, ((UInt8(179))..=(UInt8(133)):(25|1)))

        case caseVar681 : Class27 =>
            var684;
            var115;
            (var692, true, var696, ((UInt8(24))..(UInt8(96)):((-77)|1)))

        case _ =>
            let var709 : Range<UInt8> = ((UInt8(Int8(Int32(40))))..(UInt8(235)):((Int64(Float64(UInt64(Int16(-97))))|1)));
            (var692, true, (-116.0), var709)

        case _ : Unit =>
            var13;
            (UInt16(233), var726, (-66.0), ((UInt8(181))..=(var306):(((-68)|1))))

        case _ =>
            var309;
            var309;
            var420

    }[1]) { // block id: 739
        Class27.var743;
        func7(var405, 113.0, namedParam10 : "q}y TeMh!)");
        let var761 : Int16 = Int16(86);
        try { // block id: 750
            var13;
            var753
        } catch (e: Exception) { // block id: 757
            ((Int16(-89))..=(var761):((29|1)));
            var13;
            UInt32(152)
        } finally { // block id: 766
            var96;
            UInt32(40)
        }
    } else { // block id: 769
        UInt32(102)
    };
    var96.func774(namedParam775 : (UInt16(246), var726, var696, ((UInt8(39))..(UInt8(30)):(58|1))), namedParam776 : (Option<Rune>.None ?? var1087), namedParam777 : var96.func1092(var285, ((UInt16(223))..=(UInt16(241)):((-106)|1))), namedParam778 : if (var115) { var1199 } else { var1199 } );
    match (match (try { // block id: 1205
                var314;
                ((Int8(103))..=(Int8(74)):((var285|1)))
            } finally { // block id: 1211
                ((var1214)..(Int8(-29)):((var285|1)))
            }) {
            case caseVar1221 : (UInt16,Bool,Float64,Range<UInt8>) =>
                let var1224 : Range<UInt16> = ((UInt16(199))..(UInt16(UInt8(UInt64(92)))):((Int64(Int16(UInt8(58)))|1)));
                var1224;
                ();
                Aggregate868()

            case _ =>
                Aggregate868()

            case caseVar1241 : Option<Option<Unit>> =>
                ();
                Aggregate868()

            case _ =>
                var13;
                var var1302 : (Unit,Range<Int64>) = ((), (((-64))..=((-99)):((-35)|1)));
                Class27(var1302);
                Aggregate868()

        }) {
        case _ =>
            var var1311 : Option<Int8> = (Enum992.defaultValue as Int8);
            var1311;
            var13;
            var var1316 : Bool = (62.0 is (Range<UInt64>,Range<UInt16>));
            var1316

        case _ =>
            (var393, var405);
            ();
            var726

        case _ =>
            ();
            false

    }
}


public struct Aggregate868 {
    public init() { // block id: 870

    }
;
    public let var875 : Bool = false
}


public enum Enum992 {
    defaultValue
}




public struct Aggregate1174 {
    public init() { // block id: 1176

    }
;
    public static let var1179 : UInt16 = UInt16(56)
}

extend Class27 {

}

extend Aggregate868 {

}


/*
return code: 139
*/
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_expression
// ASSERT: scan chir_dce_unused_variable


