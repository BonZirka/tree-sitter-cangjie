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

var var_1689289534564_37 : UInt64 = UInt64(7)
public var var_1689289534564_86 : Int16 = Int16(27)
public var var_1689289534564_97 : Interface_1689289534564_67 = Class_1689289534564_63()
public let var_1689289534564_147 : String = "QzJz]3,qsf"
public var var_1689289534564_150 : UInt32 = UInt32(Int32(-122))
public var var_1689289534564_188 : Bool = false
public let var_1689289534564_195 : Unit = ()
public var var_1689289534564_208 : UInt16 = UInt16(UInt16(208))
public var var_1689289534564_219 : Unit = ()
public let var_1689289534564_255 : (String, UInt32, UInt32, Int32, UInt16) = (###"E/-^1Dvq${var_1689289534564_147}o|"###, UInt32(UInt8(188)), UInt32(239), Int32(UInt32(Int16(Int8(-124)))), UInt16(Int8(5)))
public var var_1689289534564_276 : Int32 = Int32(-84)
public var var_1689289534564_279 : Interface_1689289534564_66 = Class_1689289534564_63()
let var_1689289534564_322 : UInt64 = UInt64(195)
public var var_1689289534564_332 : Option<(String, UInt32, UInt32, Int32, UInt16)> = (Float32(Float32(89.0)) as (String, UInt32, UInt32, Int32, UInt16))
public var var_1689289534564_369 : Float64 = Float64((-62.0))
public var var_1689289534564_497 : Bool = false
public let var_1689289534564_522 : Class_1689289534564_63 = Class_1689289534564_63()
public var var_1689289534564_574 : Range<Int8> = ((Int8(Int8(-93))&127)..=(Int8(Int8(-1))&127):((-121)|1))
public var var_1689289534564_584 : Array<UInt64> = [UInt64(Int16(8)), UInt64(60), UInt64(26), UInt64(152), UInt64(UInt16(98)), UInt64(UInt64(Int32(-31))), UInt64(UInt64(37)), UInt64(UInt16(UInt16(118))), UInt64(UInt64(Int16(UInt8(173)))), UInt64(UInt64(206))]
public let var_1689289534564_624 : Bool = (((UInt16(UInt16(108))&127)..=(UInt16(UInt16(UInt16(183)))&127):((-65)|1)) is Interface_1689289534564_70)
public var var_1689289534564_730 : Int64 = Int64(UInt64(42))
public interface Interface_1689289534564_47 {
    func func_1689289534564_466(param_1689289534564_467 : Option<UInt32>, param_1689289534564_468 : (Float64) -> Class_1689289534564_63, namedParam_1689289534564_471 ! : Unit) : Int32 { // block id: 472
        var_1689289534564_276
    }

}

public open class Class_1689289534564_44 <: Interface_1689289534564_47 & Resource {
    public init() { // block id: 46

    }
;
    public open override func func_1689289534564_466(param_1689289534564_467 : Option<UInt32>, param_1689289534564_468 : (Float64) -> Class_1689289534564_63, namedParam_1689289534564_471 ! : Unit) : Int32 { // block id: 472
        var_1689289534564_276
    }

    public func isClosed(): Bool { return false }
    public func close(): Unit {}
}


public interface Interface_1689289534564_68 {

}

public interface Interface_1689289534564_69 {

}

sealed public interface Interface_1689289534564_67 <: Interface_1689289534564_68 & Interface_1689289534564_69 {

}

sealed public interface Interface_1689289534564_70 {

}

sealed public interface Interface_1689289534564_66 <: Interface_1689289534564_67 & Interface_1689289534564_70 {

}

public interface Interface_1689289534564_71 <: Interface_1689289534564_70 {

}

public open class Class_1689289534564_63 <: Interface_1689289534564_66 & Interface_1689289534564_71 {
    init() { // block id: 65

    }
;
    public init(param_1689289534564_165 : UInt16, namedParam_1689289534564_166 ! : Int32) { // block id: 167
        let var_1689289534564_174 : UInt16 = UInt16(49);
        match (if (var_1689289534564_174 <= var_1689289534564_174) { // block id: 177
            var var_1689289534564_179 : Enum_1689289534564_169 = Enum_1689289534564_169.defaultValue;
            var_1689289534564_179
        } else if ((Option<Bool>.Some(var_1689289534564_188) ?? true)) { // block id: 191
            Enum_1689289534564_169.defaultValue
        } else { // block id: 193
            var_1689289534564_195;
            let var_1689289534564_200 : Enum_1689289534564_169 = Enum_1689289534564_169.defaultValue;
            if (false) { var_1689289534564_200 } else { var_1689289534564_200 } 
        }) {
            case _ => 
                var_1689289534564_208 ^= UInt16(114)
            
            case defaultValue => 
                var_1689289534564_195
            
            case _ => 
                var_1689289534564_219
            
        };
        var_1689289534564_97
    }
;
    static mut prop var_1689289534564_310 : Interface_1689289534564_66 { // block id: 311
        get() { // block id: 313
            ();
            Class_1689289534564_63()
        }

        set(Value) { // block id: 318
            ()
        }

    };
    mut prop var_1689289534564_378 : Option<(String, UInt32, UInt32, Int32, UInt16)> { // block id: 379
        get() { // block id: 381
            UInt64(UInt32(103));
            ();
            (UInt8(29) as (String, UInt32, UInt32, Int32, UInt16));
            var_1689289534564_766
        }

        set(Value) { // block id: 389
            (UInt8(Int8(-92)) as Bool);
            (###"J[)r\"T:u=?"###, UInt32(UInt32(223)), UInt32(Int8(Int8(64))), Int32(124), UInt16(UInt8(167)));
            ();
            var_1689289534564_766 = Value
        }

    };
    var var_1689289534564_766 : Option<(String, UInt32, UInt32, Int32, UInt16)> = Option<(String, UInt32, UInt32, Int32, UInt16)>.None
}



public enum Enum_1689289534564_169 {
    defaultValue
}


func func_1689289534564_288(param_1689289534564_289 : Int8) : Bool { // block id: 290
    var_1689289534564_195;
    try { // block id: 293
        let var_1689289534564_300 : Float64 = (-58.0);
        try { // block id: 295
            var_1689289534564_195;
            ();
            var_1689289534564_300 > var_1689289534564_300
        } finally { // block id: 303
            Enum_1689289534564_169.defaultValue;
            var_1689289534564_188
        }
    } catch (_) { // block id: 306
        Class_1689289534564_63.var_1689289534564_310;
        match (var_1689289534564_322) {
            case _ => 
                var_1689289534564_219;
                UInt16(123) << ((UInt16(155)) & 7);
                var_1689289534564_332
            
            case 172 | 110 | 230 => 
                Class_1689289534564_63();
                if (var_1689289534564_188) { Option<(String, UInt32, UInt32, Int32, UInt16)>.Some((var_1689289534564_147, UInt32(106), var_1689289534564_150, var_1689289534564_276, var_1689289534564_208)) } else { var_1689289534564_332 } 
            
            case _ => 
                var_1689289534564_208 & var_1689289534564_208;
                ();
                Option<(String, UInt32, UInt32, Int32, UInt16)>.None
            
        };
        true
    }
}

public func func_1689289534564_73(namedParam_1689289534564_74 ! : Float64) : Class_1689289534564_63 { // block id: 75
    ();
    let var_1689289534564_90 : Interface_1689289534564_70 = Class_1689289534564_63();
    let var_1689289534564_125 : Unit = ();
    let var_1689289534564_131 : Option<UInt32> = ((###"&cupJ/Lh:&"###, UInt32(UInt32(Int16(46))), UInt32(198), Int32(UInt8(UInt8(167))), UInt16(Int8(118))) as UInt32);
    let var_1689289534564_160 : UInt16 = UInt16(49);
    func func_1689289534564_101(param_1689289534564_102 : Interface_1689289534564_66, param_1689289534564_103 : Interface_1689289534564_70, optionalParam_1689289534564_104 ! : Bool = (() is Unit), optionalParam_1689289534564_107 ! : Interface_1689289534564_67 = Class_1689289534564_63()) : Class_1689289534564_63 { // block id: 109
        var var_1689289534564_155 : Int32 = Int32(UInt32(UInt32(165)));
        (if (try { // block id: 117
            false
        } catch (_) { // block id: 119
            let var_1689289534564_121 : Bool = ("""
|EK0,
/AU?9
""" is UInt8);
            var_1689289534564_121;
            var_1689289534564_125;
            !true
        }) { Option<UInt32>.None } else { var_1689289534564_131 }  ?? (var_1689289534564_147, var_1689289534564_150, UInt32(160), var_1689289534564_155, var_1689289534564_160)[2]);
        let var_1689289534564_230 : ?(UInt16, String) = (Int16(-49) as (UInt16, String));
        let var_1689289534564_234 : (UInt16, String) = (UInt16(UInt8(Int8(UInt8(254)))), """
r+b&a
0%5j^
""");
        Class_1689289534564_63((var_1689289534564_230 ?? var_1689289534564_234)[0], namedParam_1689289534564_166 : try { // block id: 243
            Int32(-54) / ((Int32(-40)) | 1)
        } catch (e: Exception) { // block id: 247
            Int32(11)
        })
    }
;
    let var_1689289534564_359 : (Int8) -> Bool = func_1689289534564_288;
    (try { // block id: 83
        var_1689289534564_86 ^ Int16(98);
        var_1689289534564_90;
        Option<Class_1689289534564_63>.Some(Class_1689289534564_63())
    } catch (_) { // block id: 94
        ();
        var_1689289534564_97;
        Option<Class_1689289534564_63>.None
    } ?? func_1689289534564_101(try { // block id: 250
        if (var_1689289534564_188) { Option<(String, UInt32, UInt32, Int32, UInt16)>.Some(var_1689289534564_255) } else { Option<(String, UInt32, UInt32, Int32, UInt16)>.None } ;
        var var_1689289534564_269 : Unit = ();
        var_1689289534564_269;
        Class_1689289534564_63()
    } catch (e: Exception) { // block id: 272
        Class_1689289534564_63(UInt16(160), namedParam_1689289534564_166 : var_1689289534564_276);
        var_1689289534564_279
    } finally { // block id: 281
        ();
        var var_1689289534564_284 : Interface_1689289534564_66 = Class_1689289534564_63();
        var_1689289534564_284
    }, var_1689289534564_90, optionalParam_1689289534564_104 : (Int8(80)|>var_1689289534564_359)))
}

public func func_1689289534564_59(param_1689289534564_60 : Bool) : Option<(String, UInt32, UInt32, Int32, UInt16)> { // block id: 61
    func_1689289534564_73(namedParam_1689289534564_74 : if (false) { // block id: 364
        (-79.0)
    } else if (false) { // block id: 367
        var_1689289534564_369
    } else { // block id: 372
        ();
        var_1689289534564_369 + var_1689289534564_369
    }).var_1689289534564_378
}


func func_1689289534564_49() : Class_1689289534564_44 { // block id: 50
    let var_1689289534564_405 : (Bool) -> Option<(String, UInt32, UInt32, Int32, UInt16)> = func_1689289534564_59;
    ((false|>var_1689289534564_405) ?? var_1689289534564_255)[0];
    var var_1689289534564_418 : Option<Class_1689289534564_44> = (Class_1689289534564_63(UInt16(128), namedParam_1689289534564_166 : Int32(-122)) as Class_1689289534564_44);
    let var_1689289534564_452 : Int8 = Int8(UInt8(UInt8(16)));
    let var_1689289534564_463 : Class_1689289534564_44 = Class_1689289534564_44();
    try { // block id: 411
        var_1689289534564_418.getOrThrow()
    } finally { // block id: 423
        var var_1689289534564_427 : Interface_1689289534564_68 = Class_1689289534564_63();
        try { // block id: 425
            var_1689289534564_427
        } catch (_) { // block id: 429
            Float32(80.0) / Float32((Int32(Float32(65.0))) | 1);
            Class_1689289534564_63()
        } finally { // block id: 434
            var_1689289534564_427
        };
        VArray<Int8, $7>(repeat: Int8(27))[0];
        (Option<Class_1689289534564_44>.None ?? var_1689289534564_463)
    }
}

public func func_1689289534564_41() : Int32 { // block id: 42
    func_1689289534564_49().func_1689289534564_466(Option<UInt32>.None, func_1689289534564_73, namedParam_1689289534564_471 : try (resource = Class_1689289534564_44()) { // block id: 477
        var var_1689289534564_479 : Bool = false;
        var_1689289534564_479;
        Class_1689289534564_63(var_1689289534564_208, namedParam_1689289534564_166 : Int32(78));
        ()
    } finally { // block id: 485
        ();
        var_1689289534564_219;
        var_1689289534564_219
    })
}

func func_1689289534564_27(param_1689289534564_28 : UInt16) : Unit { // block id: 29
    try { // block id: 31
        try (resource = Class_1689289534564_44()) { // block id: 33

        } finally { // block id: 34
            var_1689289534564_37 ^= UInt64(197)
        };
        func_1689289534564_41()
    } catch (e: Exception) { // block id: 489
        Int32(Int8(120))
    };
    let var_1689289534564_525 : Option<(String, UInt32, UInt32, Int32, UInt16)> = Option<(String, UInt32, UInt32, Int32, UInt16)>.None;
    if (true) { // block id: 494
        if (var_1689289534564_497) { // block id: 499
            ();
            ()
        } else if (var_1689289534564_497) { // block id: 503
            var var_1689289534564_506 : Rune = 'k';
            var_1689289534564_506 = var_1689289534564_506
        };
        if (var_1689289534564_497) { // block id: 511
            Option<(UInt16, String)>.None;
            var_1689289534564_150 ^= var_1689289534564_150;
            if (var_1689289534564_497) { var_1689289534564_332 } else { var_1689289534564_332 } 
        } else { // block id: 520
            var_1689289534564_522;
            var_1689289534564_525
        };
        var loopTimeVar_1689289534564_530 : Array<UInt64> = [UInt64(Int32(Int16(-4))), UInt64(140), UInt64(UInt16(UInt8(214))), UInt64(UInt8(UInt8(UInt8(37)))), UInt64(22), UInt64(186), UInt64(74), UInt64(UInt64(179)), UInt64(84), UInt64(84)];
        for (i in loopTimeVar_1689289534564_530 where var_1689289534564_497) {

        }
    }
}



func func_1689289534564_14(optionalParam_1689289534564_15 ! : UInt32 = UInt32(101)) : Bool { // block id: 17
    let var_1689289534564_559 : ?Class_1689289534564_63 = (UInt16(30) as Class_1689289534564_63);
    func func_1689289534564_20(param_1689289534564_21 : UInt64) : Bool { // block id: 22
        var var_1689289534564_551 : (UInt16) -> Unit = func_1689289534564_27;
        try { // block id: 24
            UInt64(18);
            UInt16(229)|>var_1689289534564_551;
            var_1689289534564_497
        } finally { // block id: 555
            ();
            (var_1689289534564_559 ?? var_1689289534564_522);
            var_1689289534564_497 && false
        }
    }
;
    var loopTimeVar_1689289534564_615 : Int64 = 0;
    do {
        loopTimeVar_1689289534564_615++;
        if (true) { // block id: 571
            Class_1689289534564_44();
            var_1689289534564_574;
            var_1689289534564_195
        } else if (true) { // block id: 578
            var_1689289534564_219
        };
        let var_1689289534564_609 : Range<Int64> = ((Int64((-99))&127)..=(Int64((-122))&127):((-61)|1));
        (var_1689289534564_584, 76.0, var_1689289534564_609, var_1689289534564_195, ((UInt32(UInt32(251))&127)..=(UInt32(UInt32(73))&127):((-26)|1)))[3]
    } while ((func_1689289534564_20(UInt64(UInt32(34)))) && loopTimeVar_1689289534564_615 < 100 ) ;
    let var_1689289534564_639 : Rune = 'v';
    var var_1689289534564_653 : (Int8, Range<Int16>, UInt32, Array<UInt64>, Option<Bool>, VArray<Int8, $7>) = (Int8(Int8(-116)), ((Int16(Int16(-17))&127)..(Int16(Int16(105))&127):(68|1)), UInt32(127), [UInt64(UInt8(86)), UInt64(84), UInt64(UInt16(UInt16(130))), UInt64(30), UInt64(UInt32(Int8(36))), UInt64(UInt16(27)), UInt64(UInt32(159)), UInt64(251), UInt64(188), UInt64(149)], (([UInt64(40), UInt64(43), UInt64(36), UInt64(90), UInt64(205), UInt64(216), UInt64(135), UInt64(58), UInt64(61), UInt64(82)], (-39.0), ((Int64(112)&127)..(Int64(21)&127):(12|1)), (), ((UInt32(UInt32(21))&127)..(UInt32(UInt32(56))&127):(86|1))) as Bool), VArray<Int8, $7>(repeat: Int8(Int8(-102))));
    if (match ((((UInt8(UInt8(203))&127)..(UInt8(UInt8(137))&127):(8|1)) as UInt32)) {
        case _ => 
            !var_1689289534564_624
        
    }) { // block id: 631
        (Option<Rune>.None ?? var_1689289534564_639);
        var_1689289534564_497 &&= false;
        false
    } else if ((var_1689289534564_653[4] ?? false && var_1689289534564_497)) { // block id: 705
        (true, ((Int32(Int32(-64))&127)..=(Int32(Int32(-45))&127):(96|1)))[0]
    } else { // block id: 712
        var var_1689289534564_720 : Int8 = Int8(-94);
        var var_1689289534564_734 : VArray<Int8, $7> = [Int8(-80), Int8(Int8(118)), Int8(89), Int8(Int8(120)), Int8(Int8(-63)), Int8(58), Int8(-44)];
        (UInt16(153), ((Int8(Int8(-73))&127)..=(Int8(var_1689289534564_720)&127):(88|1)), Int8(-50), var_1689289534564_369, ((Int16(Int16(110))&127)..(Int16(Int16(-22))&127):((-39)|1)), ((Int8(var_1689289534564_720)&127)..=(Int8(var_1689289534564_720)&127):(var_1689289534564_730|1)), var_1689289534564_734)[3];
        !true
    }
}

main(): Int64 {
    try {
        try { // block id: 8
            Int32(91)
        } finally { // block id: 10
            Int32(14)
        };
        var var_1689289534564_751 : Interface_1689289534564_68 = Class_1689289534564_63();
        let var_1689289534564_757 : Class_1689289534564_44 = Class_1689289534564_44();
        if (func_1689289534564_14()) { // block id: 749
            var_1689289534564_751;
            ();
            var_1689289534564_730
        } else { // block id: 755
            var_1689289534564_757;
            let var_1689289534564_760 : (UInt16, String) = (UInt16(45), "*5sgN\\&Uwn");
            var_1689289534564_760;
            28
        }
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1689289534564_37*var_1689289534564_37), 64)
        crccheck.updateBuffer(UInt64(var_1689289534564_730*var_1689289534564_730), 64)
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
extend Class_1689289534564_63 {

}

