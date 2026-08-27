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

public const var_1713120576391_52 : UInt16 = 4
public const var_1713120576391_82 : Rune = 'x'
public let var_1713120576391_103 : UInt = UInt64(132)
public var var_1713120576391_111 : UInt = UInt64(123)
public var var_1713120576391_138 : Float32 = Float32(34.0)
public let var_1713120576391_164 : Bool = false
const func func_1713120576391_24<T0>(param_1713120576391_25 : Float32) : Bool { // block id: 26
    167;
    const var_1713120576391_29 : Bool = false;
    var_1713120576391_29
}

func func_1713120576391_37<T0, T1>(param_1713120576391_38 : Array<UInt64>) : Bool { // block id: 39
    (try { // block id: 42
        var var_1713120576391_45 : UInt16 = UInt16(93);
        var_1713120576391_45--;
        ((UInt16(UInt16(203))&127)..=(UInt16(UInt16(239))&127):(Int64(-92)|1))
    } finally { // block id: 48
        ();
        const var_1713120576391_56 : Int64 = -78;
        ((UInt16(var_1713120576391_52)&127)..(UInt16(var_1713120576391_52)&127):(var_1713120576391_56|1))
    } is Float64)
}



public open class Class_1713120576391_85<T0, T1> {
    public init() { // block id: 87

    }
;
    public static let var_1713120576391_90 : Option<Array<UInt64>>
    static init() {
        var_1713120576391_90 = Option<Array<UInt64>>.None
    }
}

func func_1713120576391_67(param_1713120576391_68 : Float32) : Array<UInt64> { // block id: 69
    const var_1713120576391_95 : Unit = ();
    var var_1713120576391_116 : Array<UInt64> = [UInt64(UInt8(70)), UInt64(78), UInt64(90), UInt64(53), UInt64(41), UInt64(Int8(UInt8(Int8(-128)))), UInt64(Int64(Int64(Int16(-120)))), UInt64(197), UInt64(73), UInt64(220)];
    (((var_1713120576391_82 as Option<Array<UInt64>>) ?? Class_1713120576391_85<Int8, Int16>.var_1713120576391_90) ?? try { // block id: 93
        var_1713120576391_95;
        var_1713120576391_95;
        [UInt64(167), UInt64(244), UInt64(77), var_1713120576391_103, UInt64(41), var_1713120576391_103, UInt64(23), UInt64(183), UInt64(170), var_1713120576391_111]
    } finally { // block id: 113
        false;
        var_1713120576391_116
    })
}

public func func_1713120576391_19<T0, T1>(param_1713120576391_20 : Range<Int32>) : Array<Unit> { // block id: 21
    var loopTimeVar_1713120576391_147 : Int64 = 0;
    while (((Float32(-3.0)|>{ lambdaParameter_1713120576391_33 : Float32 => var_1713120576391_138 / Float32((Int32(Float32(-93.0))) | 1)|>(func_1713120576391_67~>{ lambdaParameter_1713120576391_60 : Array<UInt64> => func_1713120576391_24<Int32>(-(Float32(-20.0) * Float32(-121.0))) }) })) && loopTimeVar_1713120576391_147 < 100 ) {
        loopTimeVar_1713120576391_147++;
        var_1713120576391_138 += Float32(-84.0)
    };
    [(), (), (), (), (), (), (), (), (), ()]
}

main(): Int64 {
    try {
        "wa{.ad2)R\"w";
        let var_1713120576391_150 : (Range<Int32>) -> Array<Unit> = func_1713120576391_19<Class_1713120576391_85<Int8, Int16>, Int16>;
        (if (true) { ((Int32(Int32(103))&127)..=(Int32(Int32(86))&127):(Int64(19)|1)) } else { ((Int32(Int32(-123))&127)..(Int32(Int32(15))&127):(Int64(-103)|1)) } |>var_1713120576391_150)[2];
        let var_1713120576391_172 : Unit = ();
        Int64((if (false) { // block id: 161
            var_1713120576391_52
        } else if (var_1713120576391_164) { // block id: 166
            ();
            ();
            var_1713120576391_52
        } else { // block id: 170
            var_1713120576391_172;
            var_1713120576391_52
        } & if (false) { // block id: 177
            ();
            var_1713120576391_52
        } else { // block id: 180
            !true;
            UInt16(238) % ((var_1713120576391_52) | 1)
        }))
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1713120576391_103*var_1713120576391_103), 64)
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

extend<T0, T1> Class_1713120576391_85<T0, T1> {

}

