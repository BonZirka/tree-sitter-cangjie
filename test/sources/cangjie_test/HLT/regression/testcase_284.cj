/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 

let var_1680723430979_47 : Unit = ()
public var var_1680723430979_51 : UInt16 = UInt16(207)
var var_1680723430979_71 : Array<Enum_1680723430979_23> = [Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue]
let var_1680723430979_139 : (Range<UInt8>, Array<Enum_1680723430979_23>, Rune, Range<Int16>, Unit) = (((UInt8(Int8(UInt8(171)))&127)..(UInt8(Int8(UInt8(208)))&127):(((-10)|1))), [Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue], r'o', ((Int16(-60)&127)..=(Int16(55)&127):((Int64(Int8(Int8(36)))|1))), ())
var var_1680723430979_182 : Int32 = Int32(Int16(Int8(-18)))
let var_1680723430979_209 : String = "&(b184KQ=I"
public let var_1680723430979_254 : UInt8 = UInt8(221)
public var var_1680723430979_272 : Int8 = Int8(UInt8(UInt8(UInt8(249))))
let var_1680723430979_357 : Option<(String, Bool)> = Option<(String, Bool)>.None
let var_1680723430979_374 : Bool = (Int8(Int8(-111)) is Int16)
var var_1680723430979_452 : ?Class_1680723430979_6 = Option<Class_1680723430979_6>.None
public var var_1680723430979_455 : Class_1680723430979_6 = Class_1680723430979_6()
public var var_1680723430979_458 : Array<Class_1680723430979_6> = [Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6()]
let var_1680723430979_536 : (Int64, Range<UInt64>) = (Int64(Int16(-12)), ((UInt64(Int32(UInt16(48)))&127)..=(UInt64(Int16(-81))&127):((Int64(UInt8(32))|1))))
var var_1680723430979_556 : UInt64 = UInt64(18)
public interface Interface_1680723430979_9 {

}

public open class Class_1680723430979_6 <: Interface_1680723430979_9 {
    public init() { // block id: 8

    }
;
    public init(param_1680723430979_410 : Range<Int32>, namedParam_1680723430979_411 ! : Bool, optionalParam_1680723430979_412 ! : Int64 = 97, optionalParam_1680723430979_414 ! : String = "Mx_i3?&6ow") { // block id: 416
        var var_1680723430979_426 : Range<Int8> = ((Int8(-111)&127)..=(Int8(-119)&127):(58|1));
        var var_1680723430979_436 : Bool = (r'p' is String);
        match (true) {
            case caseVar_1680723430979_421 : Int64 => 
                if (var_1680723430979_374) { var_1680723430979_426 } else { ((Int8(62)&127)..=(Int8(-58)&127):((-27)|1)) } ;
                var_1680723430979_272--
            
            case _ => 
                var_1680723430979_47;
                var_1680723430979_436 &&= var_1680723430979_436
            
        }
    }
;
    protected mut prop var_1680723430979_509 : UInt32 { // block id: 510
        get() { // block id: 512
            ();
            UInt32(Int8(-81));
            var_1680723430979_567
        }

        set(Value) { // block id: 518
            ((Int32(68)&127)..(Int32(-5)&127):((-32)|1));
            ();
            var_1680723430979_567 = Value
        }

    };
    public open func func_1680723430979_503(namedParam_1680723430979_504 ! : (Range<UInt8>, Array<Enum_1680723430979_23>, Rune, Range<Int16>, Unit), namedParam_1680723430979_505 ! : Range<Int8>) : UInt32 { // block id: 506
        var_1680723430979_47;
        var_1680723430979_509
    }
;
    mut prop var_1680723430979_567 : UInt32 { // block id: 568
        get() { // block id: 570
            ();
            ((Int32(103)&127)..=(Int32(-89)&127):(68|1));
            UInt32(97)
        }

        set(Value) { // block id: 576
            ()
        }

    }
}

public enum Enum_1680723430979_23 {
    defaultValue
}

func func_1680723430979_37(namedParam_1680723430979_38 ! : Int64, optionalParam_1680723430979_39 ! : UInt64 = UInt64(172), namedParam_1680723430979_41 ! : Range<UInt32>) : Array<Enum_1680723430979_23> { // block id: 42
    var loopTimeVar_1680723430979_64 : Int64 = 0;
    while ((try { // block id: 45
        var_1680723430979_47;
        var_1680723430979_51 * UInt16(208);
        false
    } catch (e: Exception) { // block id: 55
        false
    } finally { // block id: 57
        var_1680723430979_47;
        true || true
    }) && loopTimeVar_1680723430979_64 < 100 ) {
        loopTimeVar_1680723430979_64++;

    };
    ();
    var var_1680723430979_84 : Bool = true;
    let var_1680723430979_99 : Enum_1680723430979_23 = Enum_1680723430979_23.defaultValue;
    var var_1680723430979_111 : Option<Enum_1680723430979_23> = (Class_1680723430979_6() as Enum_1680723430979_23);
    if (try { // block id: 68
        var_1680723430979_47;
        var_1680723430979_71;
        var_1680723430979_84
    } finally { // block id: 86
        115 == 58
    }) { [Enum_1680723430979_23.defaultValue, (Option<Enum_1680723430979_23>.Some(var_1680723430979_99) ?? Enum_1680723430979_23.defaultValue), var_1680723430979_71[8], try { // block id: 106
        var_1680723430979_84 ||= false;
        var_1680723430979_111;
        if (var_1680723430979_84) { Enum_1680723430979_23.defaultValue } else { Enum_1680723430979_23.defaultValue } 
    } catch (_) { // block id: 118
        if (true) { var_1680723430979_99 } else { Enum_1680723430979_23.defaultValue } 
    }, if (true) { Enum_1680723430979_23.defaultValue } else { Enum_1680723430979_23.defaultValue } , var_1680723430979_71[0], var_1680723430979_99, Enum_1680723430979_23.defaultValue, Enum_1680723430979_23.defaultValue, (Option<Enum_1680723430979_23>.None ?? var_1680723430979_99)] } else { var_1680723430979_139[1] } 
}

public func func_1680723430979_19<T0, T1, T2>(param_1680723430979_20 : Unit) : (UInt32, String, UInt8, Unit, UInt8) { // block id: 21
    var var_1680723430979_172 : UInt32 = UInt32(122);
    match (func_1680723430979_37(namedParam_1680723430979_38 : (-77), namedParam_1680723430979_41 : ((var_1680723430979_172&127)..=(var_1680723430979_172&127):((66|1))))[2]) {
        case _ => 
            var_1680723430979_182 ^= var_1680723430979_182;
            var var_1680723430979_189 : Bool = true;
            var_1680723430979_189 ||= var_1680723430979_189;
            var var_1680723430979_193 : (UInt32, String, UInt8, Unit, UInt8) = (UInt32(Int32(Int8(103))), "$`b4[pBJW7", UInt8(UInt8(208)), (), UInt8(71));
            var_1680723430979_193
        
        case _ => 
            ();
            let var_1680723430979_212 : UInt8 = UInt8(193);
            (var_1680723430979_172, var_1680723430979_209, var_1680723430979_212, var_1680723430979_47, UInt8(111))
        
    }
}

public func func_1680723430979_236(param_1680723430979_237 : String) : Interface_1680723430979_9 { // block id: 238
    var var_1680723430979_247 : Int64 = Int64(UInt32(UInt8(UInt8(100))));
    let var_1680723430979_259 : (UInt32, String, UInt8, Unit, UInt8) = (UInt32(UInt32(199)), "g<w<!x:gI#", UInt8(Int8(-35)), (), UInt8(148));
    (((Int8(-99)&127)..(Int8(-37)&127):((var_1680723430979_247|1))), ((var_1680723430979_254&127)..(var_1680723430979_254&127):((var_1680723430979_247|1))), var_1680723430979_259, [(), (), (), (), (), (), (), (), (), ()], ((Int8(53)&127)..(var_1680723430979_272&127):((var_1680723430979_247|1))), var_1680723430979_47)[3][4];
    let var_1680723430979_282 : Interface_1680723430979_9 = Class_1680723430979_6();
    var_1680723430979_282
}


func func_1680723430979_345(param_1680723430979_346 : Range<Int16>, namedParam_1680723430979_347 ! : Bool) : String { // block id: 348
    var var_1680723430979_362 : (String, Bool) = ("""
 nJ3e
!%Fe6
""", false);
    var var_1680723430979_369 : Bool = true;
    (var_1680723430979_357 ?? if (true) { var_1680723430979_362 } else { (var_1680723430979_209, var_1680723430979_369) } )[0]
}


func func_1680723430979_393(param_1680723430979_394 : Class_1680723430979_6) : Option<Array<Class_1680723430979_6>> { // block id: 395
    var var_1680723430979_397 : Option<Array<Class_1680723430979_6>> = Option<Array<Class_1680723430979_6>>.Some([Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(), Class_1680723430979_6(((Int32(-99)&127)..=(Int32(-65)&127):((-89)|1)), namedParam_1680723430979_411 : false), Class_1680723430979_6()]);
    var_1680723430979_397
}


public func func_1680723430979_381(param_1680723430979_382 : Range<Int16>) : Array<Class_1680723430979_6> { // block id: 383
    if (var_1680723430979_374) { // block id: 386

    };
    let var_1680723430979_444 : (Class_1680723430979_6) -> Option<Array<Class_1680723430979_6>> = func_1680723430979_393;
    (((var_1680723430979_452 ?? var_1680723430979_455)|>var_1680723430979_444) ?? var_1680723430979_458)
}

main(): Int64 {
    try {
        let var_1680723430979_479 : Int16 = Int16(-4);
        func func_1680723430979_11<T0, T1>(param_1680723430979_12 : Rune, param_1680723430979_13 : Unit, namedParam_1680723430979_14 ! : Rune) : Class_1680723430979_6 { // block id: 15
            ([(), (), (), (), (), (), (), (), (), ()][8]|>{ lambdaParameter_1680723430979_218 : Unit => let var_1680723430979_221 : (UInt32, String, UInt8, Unit, UInt8) = (UInt32(Int8(-62)), "sV!:n#C&ld", UInt8(129), (), UInt8(UInt8(164))); var_1680723430979_221 })[3];
            let var_1680723430979_316 : Interface_1680723430979_9 = Class_1680723430979_6();
            if (true) { (if (false) { var_1680723430979_209 } else { "8Uc9&7o:af" } ) } else { func_1680723430979_345(((Int16(74)&127)..(Int16(-8)&127):(35|1)), namedParam_1680723430979_347 : var_1680723430979_374) } |>{ lambdaParameter_1680723430979_286 : String => match (try { // block id: 290
                (-111.0);
                Int16(56) << ((Int16(69)) & 7)
            } finally { // block id: 295
                ();
                Int16(-122)
            }) {
                case -77 | -105 => 
                    [UInt64(242), UInt64(95), UInt64(168), UInt64(98), UInt64(47), UInt64(238), UInt64(147), UInt64(16), UInt64(183), UInt64(219)];
                    let var_1680723430979_303 : Interface_1680723430979_9 = Class_1680723430979_6();
                    var_1680723430979_303
                
                case _ => 
                    var_1680723430979_47;
                    (UInt32(23), ###"a{|*z7?9$7e"###, UInt8(94), (), var_1680723430979_254);
                    var_1680723430979_316
                
                case 53 => 
                    UInt64(174) << ((UInt64(1)) & 7);
                    Class_1680723430979_6()
                
                case _ => 
                    var var_1680723430979_329 : Int64 = Int64(28);
                    var_1680723430979_329 *= 80;
                    if (true) { Class_1680723430979_6() } else { var_1680723430979_316 } ;
                    Class_1680723430979_6()
                
            } };
            var var_1680723430979_485 : UInt32 = UInt32(UInt8(56));
            (try { // block id: 472
                var_1680723430979_182 >>= ((var_1680723430979_182) & 7);
                ((Int16(-67)&127)..(var_1680723430979_479&127):((111|1)))
            } finally { // block id: 482
                ((var_1680723430979_485&127)..=(UInt32(164)&127):((42|1)));
                let var_1680723430979_494 : Int64 = (-7);
                ((Int16(-68)&127)..(var_1680723430979_479&127):((var_1680723430979_494|1)))
            }|>func_1680723430979_381)[4]
        }
;
        let var_1680723430979_498 : Rune = r'Q';
        let var_1680723430979_523 : Range<Int8> = ((Int8(11)&127)..(Int8(54)&127):((-13)|1));
        func_1680723430979_11<Range<UInt32>, Range<UInt32>>(var_1680723430979_498, var_1680723430979_47, namedParam_1680723430979_14 : var_1680723430979_498).func_1680723430979_503(namedParam_1680723430979_504 : var_1680723430979_139, namedParam_1680723430979_505 : var_1680723430979_523);
        match (var_1680723430979_357) {
            case _ => 
                ();
                Option<Enum_1680723430979_23>.Some(Enum_1680723430979_23.defaultValue);
                var_1680723430979_536
            
            case _ => 
                ();
                ((-61), ((var_1680723430979_556&127)..(UInt64(133)&127):((73|1))))
            
            case _ => 
                var_1680723430979_182 |= var_1680723430979_182;
                var_1680723430979_536
            
        }[0]
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1680723430979_51*var_1680723430979_51), 64)
        crccheck.updateBuffer(UInt64(var_1680723430979_182*var_1680723430979_182), 64)
        crccheck.updateBuffer(UInt64(var_1680723430979_254*var_1680723430979_254), 64)
        crccheck.updateBuffer(UInt64(var_1680723430979_272*var_1680723430979_272), 64)
        crccheck.updateBuffer(UInt64(var_1680723430979_479*var_1680723430979_479), 64)
        crccheck.updateBuffer(UInt64(var_1680723430979_556*var_1680723430979_556), 64)
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
