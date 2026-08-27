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



var var_1700428901533_19 : ?UInt8 = Option<UInt8>.None
public let var_1700428901533_50 : Class_1700428901533_44 = Class_1700428901533_44()
const var_1700428901533_84 : Float32 = 20.0
const var_1700428901533_166 : Int16 = -91
var var_1700428901533_210 : Class_1700428901533_206<UInt16, Range<UInt8>> = Class_1700428901533_206<UInt16, Range<UInt8>>()
public var var_1700428901533_229 : Class_1700428901533_224<Unit> = Class_1700428901533_224<Unit>()
public var var_1700428901533_286 : (Int8, Option<UInt8>, Bool, Bool) = (Int8(23), (((UInt16(UInt16(UInt8(190)))&127)..=(UInt16(UInt16(Int16(104)))&127):(Int64(125)|1)) as UInt8), (UInt32(UInt32(122)) is Range<Int8>), (((UInt32(UInt32(42))&127)..(UInt32(UInt32(135))&127):(Int64(-119)|1)) is Rune))
var var_1700428901533_304 : ?(Int8, Option<UInt8>, Bool, Bool) = Option<(Int8, Option<UInt8>, Bool, Bool)>.None
public var var_1700428901533_343 : UInt16 = UInt16(UInt8(UInt8(Int8(UInt8(25)))))
public var var_1700428901533_369 : VArray<Bool, $6> = [false, true, false, false, true, true]
public const var_1700428901533_384 : Bool = true
public var var_1700428901533_436 : Int32 = Int32(81)

sealed public interface Interface_1700428901533_47 {
    static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

}

sealed public interface Interface_1700428901533_48<T0, T1> <: Interface_1700428901533_47 {
    static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

}

public open class Class_1700428901533_44 <: Interface_1700428901533_47 & Interface_1700428901533_48<Int16, UInt16> {
    public init() { // block id: 46

    }
;
    public var var_1700428901533_53 : UInt8 = UInt8(192);
    public static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    public open override func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

    static init() {
    }
}

const func func_1700428901533_59<T0>(param_1700428901533_60 : Int64) : Unit { // block id: 61
    ();
    ()
}

func func_1700428901533_78() : Bool { // block id: 79
    true
}

public struct Struct_1700428901533_109 {
    public init() { // block id: 111

    }
;
    mut prop var_1700428901533_409 : Interface_1700428901533_47 { // block id: 410
        get() { // block id: 412
            ();
            ();
            Class_1700428901533_206<UInt16, Range<UInt8>>();
            var_1700428901533_438
        }

        set(Value) { // block id: 418
            var_1700428901533_438 = Value
        }

    };
    var var_1700428901533_438 : Interface_1700428901533_47 = Class_1700428901533_44()
}

const func func_1700428901533_160<T0, T1>() : UInt64 { // block id: 161
    const var_1700428901533_163 : UInt64 = 132;
    var_1700428901533_163
}

const func func_1700428901533_174<T0, T1, T2>(param_1700428901533_175 : Rune, param_1700428901533_176 : Int64, namedParam_1700428901533_177 ! : Float64) : Int16 { // block id: 178
    var_1700428901533_166
}

public const func func_1700428901533_146(param_1700428901533_147 : Int8) : Unit { // block id: 148
    const var_1700428901533_171 : Int64 = 2;
    const func func_1700428901533_151<T0, T1, T2>(param_1700428901533_152 : Int16, param_1700428901533_153 : Int16, optionalParam_1700428901533_154 ! : Rune = r'l') : Int64 { // block id: 156
        209 | func_1700428901533_160<String, Rune>();
        var_1700428901533_166;
        8 >> ((var_1700428901533_171) & 7)
    }
;
    const var_1700428901533_181 : Rune = r'e';
    const var_1700428901533_185 : Float64 = 36.0;
    func_1700428901533_59<UInt32>(func_1700428901533_151<Int32, Float32, UInt64>(func_1700428901533_174<Int32, Float64, UInt64>(var_1700428901533_181, var_1700428901533_171, namedParam_1700428901533_177 : var_1700428901533_185), var_1700428901533_166, optionalParam_1700428901533_154 : var_1700428901533_181))
}

public open class Class_1700428901533_206<T0, T1> <: Class_1700428901533_44 {
    public init() { // block id: 208

    }
;
    public let var_1700428901533_213 : VArray<Bool, $6> = [false, false, false, true, true, true];
    mut prop var_1700428901533_232 : Range<UInt16> { // block id: 233
        get() { // block id: 235
            ((UInt16(UInt16(47))&127)..(UInt16(UInt16(181))&127):(Int64(Int64(67))|1))
        }

        set(Value) { // block id: 243
            ()
        }

    };
    public static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    public open override func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

}

sealed public interface Interface_1700428901533_227<T0, T1, T2> <: Interface_1700428901533_48<Int16, UInt16> {
    static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

}

public open class Class_1700428901533_224<T0> <: Class_1700428901533_206<UInt16, Range<UInt8>> & Interface_1700428901533_48<Int16, UInt16> & Interface_1700428901533_227<Bool, Class_1700428901533_44, Range<Int8>> {
    public init() { // block id: 226

    }
;
    static var var_1700428901533_406 : Struct_1700428901533_109 = Struct_1700428901533_109();
    public static func func_1700428901533_121() : (Int8, Option<UInt8>, Bool, Bool) { // block id: 122
        var var_1700428901533_127 : (Unit, Int8, UInt64, UInt16, Bool) = ((), Int8(UInt8(UInt8(173))), UInt64(154), UInt16(232), (Int64(-34) is Int32));
        if (var_1700428901533_127[4]) { // block id: 138
            var var_1700428901533_141 : Int = Int64(-36);
            func_1700428901533_59<UInt32>(var_1700428901533_141);
            Int8(39)
        } else { // block id: 144
            Int8(-52)|>{ lambdaParameter_1700428901533_191 : Int8 => var loopTimeVar_1700428901533_245 : Array<UInt64> = [UInt64(192), UInt64(UInt64(UInt32(Int16(47)))), UInt64(249), UInt64(UInt8(19)), UInt64(Int8(Int8(58))), UInt64(31), UInt64(101), UInt64(125), UInt64(UInt32(Int8(34))), UInt64(40)]; for (i in loopTimeVar_1700428901533_245 where var_1700428901533_210.var_1700428901533_213[5]) {
                var_1700428901533_229.var_1700428901533_232
            } };
            var var_1700428901533_274 : Int8 = Int8(-50);
            (Option<Int8>.Some(Int8(54)) ?? var_1700428901533_274)
        };
        (try { // block id: 282
            ();
            Option<(Int8, Option<UInt8>, Bool, Bool)>.Some(var_1700428901533_286)
        } finally { // block id: 301
            Int8(-126);
            var_1700428901533_304
        } ?? var_1700428901533_286)
    }
;
    public open override func func_1700428901533_431(param_1700428901533_432 : Int32) : Int64 { // block id: 433
        Int64(-98)
    }

}



public func func_1700428901533_105(param_1700428901533_106 : UInt8) : Interface_1700428901533_47 { // block id: 107
    let var_1700428901533_320 : Bool = (((), Int8(Int8(Int8(-14))), UInt64(16), UInt16(138), (((), Int8(83), UInt64(139), UInt16(54), true) is (UInt64, Bool, Interface_1700428901533_47))) is Class_1700428901533_44);
    let var_1700428901533_377 : Bool = (UInt64(Int64(Int16(UInt8(17)))) is (Int64) -> Unit);
    let var_1700428901533_394 : Struct_1700428901533_109 = Struct_1700428901533_109();
    func func_1700428901533_113() : Struct_1700428901533_109 { // block id: 114
        var loopTimeVar_1700428901533_310 : Int64 = 0;
        while ((Interface_1700428901533_47.func_1700428901533_121()[3]) && loopTimeVar_1700428901533_310 < 100 ) {
            loopTimeVar_1700428901533_310++;

        };
        try { // block id: 312
            var var_1700428901533_315 : UInt8 = UInt8(182);
            var_1700428901533_315 |= var_1700428901533_315;
            if (var_1700428901533_320) { // block id: 336
                UInt16(149)
            } else if (var_1700428901533_320) { // block id: 339
                ();
                var_1700428901533_343 ^ UInt16(121)
            } else { // block id: 350
                UInt16(170)
            };
            var_1700428901533_229
        } finally { // block id: 353
            if (true) { // block id: 356

            } else if (false) { // block id: 358
                var_1700428901533_286;
                let var_1700428901533_361 : Unit = ();
                var_1700428901533_361
            };
            Class_1700428901533_224<Unit>()
        };
        if (if (true) { var_1700428901533_369 } else { VArray<Bool, $6>(repeat: false) } [4]) { [Struct_1700428901533_109(), Struct_1700428901533_109(), Struct_1700428901533_109(), var_1700428901533_394, var_1700428901533_394, Struct_1700428901533_109(), Struct_1700428901533_109(), Struct_1700428901533_109(), Struct_1700428901533_109(), Struct_1700428901533_109()][3] } else { (Class_1700428901533_224<Unit>.var_1700428901533_406) } 
    }
;
    func_1700428901533_113().var_1700428901533_409
}

main(): Int64 {
    try {
        let var_1700428901533_12 : Bool = (Float32(-24.0) is Int32);
        var var_1700428901533_28 : Unit = ();
        var var_1700428901533_56 : UInt8 = UInt8(1);
        (match (var_1700428901533_12) {
            case _ : UInt32 => 
                var_1700428901533_19
            
            case true => 
                var var_1700428901533_25 : Float64 = Float64(99.0);
                var_1700428901533_25;
                var_1700428901533_28;
                if (false) { Option<UInt8>.Some(UInt8(244)) } else { Option<UInt8>.Some(UInt8(190)) } 
            
            case _ => 
                if (false) { var_1700428901533_19 } else { Option<UInt8>.None } 
            
        } ?? var_1700428901533_50.var_1700428901533_53) / ((var_1700428901533_56) | 1);
        let var_1700428901533_65 : (Int64) -> Unit = func_1700428901533_59<UInt32>;
        if ((UInt64(171), true, Class_1700428901533_44())[1]) { // block id: 75
            Int64(-17)
        } else if (func_1700428901533_78()) { // block id: 81
            var_1700428901533_84 * Float32(-26.0);
            var_1700428901533_28;
            Int64(-57)
        } else { // block id: 89
            Int64(107) - Int64(-88)
        }|>var_1700428901533_65;
        let var_1700428901533_425 : UInt8 = UInt8(Int8(UInt8(UInt8(41))));
        func func_1700428901533_95(optionalParam_1700428901533_96 ! : Unit = (), optionalParam_1700428901533_98 ! : Int32 = Int32(97), optionalParam_1700428901533_100 ! : UInt32 = UInt32(221)) : Interface_1700428901533_47 { // block id: 102
            ();
            let var_1700428901533_420 : (UInt8) -> Interface_1700428901533_47 = func_1700428901533_105;
            UInt8(Int8(var_1700428901533_425))|>var_1700428901533_420
        }
;
        func_1700428901533_95().func_1700428901533_431(var_1700428901533_436)
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1700428901533_56*var_1700428901533_56), 64)
        crcCheck.updateBuffer(UInt64(var_1700428901533_166*var_1700428901533_166), 64)
        crcCheck.updateBuffer(UInt64(var_1700428901533_343*var_1700428901533_343), 64)
        crcCheck.updateBuffer(UInt64(var_1700428901533_425*var_1700428901533_425), 64)
        crcCheck.updateBuffer(UInt64(var_1700428901533_436*var_1700428901533_436), 64)
        crcCheck.crcCheck()
        crcCheck.getCrcOutput()
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

    func updateBuffer(input: Any, byte_n: Int64) : Unit {
        if (input is Hashable) {
            match(input as Hashable) {
                case Some(v) => updateBuffer(UInt64(v.hashCode()), byte_n)
                case _=> updateBuffer(1, byte_n)
            }
            
        } else if (input is ToString) {
            match(input as ToString) {
                case Some(v) => updateBuffer(v.toString(), byte_n)
                case _=> updateBuffer(1, byte_n)
            }
        } else {
            updateBuffer(1, byte_n)
        }
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
// ASSERT: scan-1 sema_varray_cjvm_in_ref_type

