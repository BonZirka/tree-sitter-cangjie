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

public var var_1664281175816_55 : Int8 = Int8(UInt8(Int8(-27)))
public let var_1664281175816_118 : ?Unit = Option<Unit>.None
let var_1664281175816_145 : Class_1664281175816_9<Int16, Int32> = Class_1664281175816_9<Int16, Int32>()
var var_1664281175816_153 : Unit = ()
public var var_1664281175816_210 : (Range<Int16>, Bool, Range<UInt8>, Float64, UInt8, UInt32, Range<Int64>, Range<Int32>) = (((Int16(-78)&127)..=(Int16(-27)&127):((-116)|1)), true, ((UInt8(199)&127)..=(UInt8(Int8(UInt8(188)))&127):((Int64(UInt64(8))|1))), Float64(Float64(Float32(Float32(-124.0)))), UInt8(Int8(-128)), UInt32(UInt16(151)), (((-21)&127)..(38&127):(27|1)), ((Int32(-69)&127)..=(Int32(100)&127):(35|1)))
public var var_1664281175816_284 : Int16 = Int16(86)
public open class Class_1664281175816_9<T0, T1> {
    public init() { // block id: 11

    }
;
    public static var var_1664281175816_62 : (String, Int32, Float64, Int32, Unit) = (###"3xS/ H+s?'"###, Int32(56), 81.0, Int32(83), ());
    public static var var_1664281175816_91 : Int64 = 67;
    public var var_1664281175816_171 : Array<Int32> = [Int32(94), Int32(-22), Int32(81), Int32(44), Int32(-46), Int32(-8), Int32(-119), Int32(30), Int32(2), Int32(-90)]
}

public func func_1664281175816_71(namedParam_1664281175816_72 ! : UInt32, namedParam_1664281175816_73 ! : Int8) : Int64 { // block id: 74
    try { // block id: 76
        var var_1664281175816_85 : Int64 = (-2);
        if (true) { // block id: 79
            102 ^ (-105)
        } else { // block id: 83
            var_1664281175816_85
        }
    } finally { // block id: 87
        Class_1664281175816_9<Int16, Int32>.var_1664281175816_91
    }
}





public struct Struct_1664281175816_239<T0> {
    public init() { // block id: 241

    }
;
    public mut prop var_1664281175816_246 : Rune { // block id: 247
        get() { // block id: 249
            ();
            ();
            r'S';
            var_1664281175816_292
        }

        set(Value) { // block id: 255
            [Int32(-126), Int32(Int32(UInt8(154))), Int32(100), Int32(UInt16(UInt16(211))), Int32(UInt8(187)), Int32(UInt16(Int8(6))), Int32(UInt32(UInt32(242))), Int32(Int16(-103)), Int32(-122), Int32(Int16(UInt16(8)))];
            ();
            ();
            (var_1664281175816_292 = Value)
        }

    };
    mut prop var_1664281175816_292 : Rune { // block id: 293
        get() { // block id: 295
            r'W'
        }

        set(Value) { // block id: 299
            ((UInt64(78)&127)..=(UInt64(UInt64(129))&127):((Int64(UInt16(18))|1)));
            ()
        }

    }
}

public func func_1664281175816_71() : Int64 { // block id: 7
    let var_1664281175816_94 : UInt32 = UInt32(138);
    Class_1664281175816_9<Int16, Int32>.func_1664281175816_14<Int16>(optionalParam_1664281175816_15 : func_1664281175816_71(namedParam_1664281175816_72 : var_1664281175816_94, namedParam_1664281175816_73 : Int8(-30)));
    let var_1664281175816_115 : ??Unit = Option<Option<Unit>>.None;
    var var_1664281175816_138 : Bool = (Option<Bool>.Some(true) is Option<Option<Option<Unit>>>);
    (((Option<Option<Option<Unit>>>.Some(Option<Option<Unit>>.None) ?? var_1664281175816_115) ?? var_1664281175816_118) ?? if ((Option<Bool>.Some(true) ?? true)) { // block id: 129
        ()
    } else if ((Int8(124) is (UInt32, Int8) -> Int64)) { // block id: 133
        ();
        "SA'6S:XCkC";
        var_1664281175816_138 &&= true
    });
    let var_1664281175816_287 : ???Unit = (((Int32(46)&127)..(Int32(107)&127):((-32)|1)) as Option<Option<Unit>>);
    var_1664281175816_145.func_1664281175816_148(UInt32(var_1664281175816_284), var_1664281175816_287)
}

main(): Int64 {
    try {
        func_1664281175816_71()
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1664281175816_55*var_1664281175816_55), 64)
        crccheck.updateBuffer(UInt64(var_1664281175816_284*var_1664281175816_284), 64)
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
extend<T0, T1> Class_1664281175816_9<T0, T1> {
    static func func_1664281175816_14<T0>(optionalParam_1664281175816_15 ! : Int64 = Int64(Int8(UInt8(69)))) : Int32 { // block id: 19
        var var_1664281175816_49 : Int32 = Int32(-61);
        try { // block id: 21
            UInt8(Int8(-27));
            let var_1664281175816_26 : Bool = true;
            var loopTimeVar_1664281175816_31 : Int64 = 0;
            do {
                loopTimeVar_1664281175816_31++;
                ()
            } while ((var_1664281175816_26) && loopTimeVar_1664281175816_31 < 100 ) ;
            try { // block id: 33
                var var_1664281175816_36 : Bool = false;
                var_1664281175816_36 ||= false;
                var_1664281175816_36 &&= true;
                Int32(-106)
            } catch (_) { // block id: 43
                let var_1664281175816_45 : Int16 = Int16(95);
                var_1664281175816_45;
                var_1664281175816_49 - var_1664281175816_49
            }
        } finally { // block id: 52
            Int32(var_1664281175816_55);
            var_1664281175816_62[1]
        }
    }
;
    public func func_1664281175816_148(param_1664281175816_149 : UInt32, param_1664281175816_150 : Option<Option<Option<Unit>>>) : Int64 { // block id: 151
        var_1664281175816_153;
        if (Int32(Int32(-55)) < var_1664281175816_171[7]) { // block id: 174
            var loopTimeVar_1664281175816_183 : Array<Int32> = [Int32(UInt32(213)), Int32(87), Int32(-74), Int32(-69), Int32(UInt16(Int16(UInt8(22)))), Int32(102), Int32(13), Int32(Int8(69)), Int32(Int8(Int8(Int8(-14)))), Int32(UInt16(175))];
            for (i in loopTimeVar_1664281175816_183 where false) {
                var var_1664281175816_180 : Bool = false;
                var_1664281175816_180 &&= var_1664281175816_180
            };
            (-52)
        } else if (false) { // block id: 206
            var_1664281175816_210[3];
            Int64(UInt16(8))
        } else { // block id: 234
            var_1664281175816_91 % ((var_1664281175816_91) | 1);
            let var_1664281175816_243 : Struct_1664281175816_239<Float32> = Struct_1664281175816_239<Float32>();
            var_1664281175816_243.var_1664281175816_246;
            (-57)
        }
    }

}

extend<T0> Struct_1664281175816_239<T0> {

}

