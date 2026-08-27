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

@Deprecated
public const var_1730900160166_18: Unit = ()
@Deprecated
public const var_1730900160166_60: Int16 = -53
@Deprecated
public var var_1730900160166_63: String = "W%-W6:aM%A"
@Deprecated
const var_1730900160166_124: Rune = r'W'
@Deprecated
public let var_1730900160166_152: Bool = ("""
m;smY
V)FOo
""" is Interface_1730900160166_93<Float32, String>)
@Deprecated
public var var_1730900160166_167: Int64 = Int64(112)
public let var_1730900160166_172: Option<String> = (Enum_1730900160166_51.enumValue_1730900160166_175(UInt64(28),
    Float32(Float32(-29.0)), Int32(110)) as String)
public var var_1730900160166_207: UInt = UInt64(Int16(-123))
@Deprecated
public let var_1730900160166_236: Enum_1730900160166_51 = Enum_1730900160166_51.enumValue_1730900160166_238(
    (Option<String>.None, (Int64(97) as String), Float32(Float32(Float32(101.0))), Option<String>.None,
        Class_1730900160166_84(), (((UInt16(UInt16(237)) & 127)..(UInt16(UInt16(120)) & 127) : (Int64(-115) | 1)) is Option<Enum_1730900160166_51>)),
    ((Int32(Int32(124)) & 127)..(Int32(Int32(-95)) & 127) : (Int64(-52) | 1)))
@Deprecated
public const var_1730900160166_273: Int64 = 61
@Deprecated
public let var_1730900160166_284: (Bool, Class_1730900160166_84, Interface_1730900160166_92, Unit) = (((Int16(51), ([UInt64(23),
            UInt64(4), UInt64(88), UInt64(209), UInt64(42), UInt64(158), UInt64(82), UInt64(109), UInt64(42), UInt64(98)] is (Int8, 
            UInt16, UInt32, Rune, String, String, Float64, Bool)), (), Int16(-119), Float32(-94.0), Float32(Float32(-39.0))) is Bool),
    Class_1730900160166_84(), Class_1730900160166_84(), ())
public var var_1730900160166_319: Range<Int64> = ((Int64(Int64(125)) & 127)..=(Int64(Int64(-37)) & 127) : (Int64(-78) | 1))

@Deprecated
public struct Struct_1730900160166_6 {
    public init() { // block id: 8

    }

    static const var_1730900160166_22: Bool = false
}

public enum Enum_1730900160166_51 {
    defaultValue
    | enumValue_1730900160166_54(Int16, String, UInt16, String)
    | enumValue_1730900160166_175(UInt64, Float32, Int32)
    | enumValue_1730900160166_238(
        (Option<String>, Option<String>, Float32, Option<String>, Class_1730900160166_84, Bool), Range<Int32>)
}

public sealed interface Interface_1730900160166_92 {}

public interface Interface_1730900160166_95 <: Interface_1730900160166_92 {}

public interface Interface_1730900160166_94 <: Interface_1730900160166_92 & Interface_1730900160166_95 {
    @Frozen
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public interface Interface_1730900160166_93<T0, T1> <: Interface_1730900160166_92 & Interface_1730900160166_94 {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public interface Interface_1730900160166_91 <: Interface_1730900160166_92 & Interface_1730900160166_93<Float32, String> {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public interface Interface_1730900160166_90 <: Interface_1730900160166_91 {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public interface Interface_1730900160166_89 <: Interface_1730900160166_90 {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public interface Interface_1730900160166_88 <: Interface_1730900160166_89 & Interface_1730900160166_94 {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public sealed interface Interface_1730900160166_87 <: Interface_1730900160166_88 {
    func func_1730900160166_110(param_1730900160166_111: String, namedParam_1730900160166_112!: UInt32,
        namedParam_1730900160166_113!: Enum_1730900160166_51, namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public open class Class_1730900160166_84 <: Interface_1730900160166_87 {
    public init() { // block id: 86

    }

    public static let var_1730900160166_98: Rune = r'J';
    public open override func func_1730900160166_110(param_1730900160166_111: String,
        namedParam_1730900160166_112!: UInt32, namedParam_1730900160166_113!: Enum_1730900160166_51,
        namedParam_1730900160166_114!: String): Bool { // block id: 115
        true
    }
}

public func func_1730900160166_147(param_1730900160166_148: Enum_1730900160166_51): Unit { // block id: 149
    var loopTimeVar_1730900160166_158: Int = 0;
    while ((var_1730900160166_152) && loopTimeVar_1730900160166_158 < 100) {
        loopTimeVar_1730900160166_158++;
        var_1730900160166_18
    };
    var var_1730900160166_164: Int64 = Int64(88);
    var loopTimeVar_1730900160166_203: Int64 = 0;
    while ((try { // block id: 161
            var_1730900160166_164 -= var_1730900160166_167
            if (false) {
                var_1730900160166_172
            } else {
                var_1730900160166_172
            };
            true
        } finally { // block id: 185
            var_1730900160166_152
        }) && loopTimeVar_1730900160166_203 < 100) {
        loopTimeVar_1730900160166_203++;
        let var_1730900160166_197: Class_1730900160166_84 = Class_1730900160166_84();
        (Option<String>.Some(var_1730900160166_63), var_1730900160166_172, Float32(-54.0), Option<String>.None,
            var_1730900160166_197, false)[2];
        break
    }
}

@Frozen
@Deprecated
public func func_1730900160166_103(): Bool { // block id: 104
    var var_1730900160166_107: Interface_1730900160166_88 = Class_1730900160166_84();
    let var_1730900160166_127: String = "W+8@}+|G%t";
    func func_1730900160166_134<T0, T1>(namedParam_1730900160166_135!: UInt16, namedParam_1730900160166_136!: Float64): UInt32 { // block id: 137
        try { // block id: 139
            const var_1730900160166_142: UInt32 = 238;
            var_1730900160166_142 * var_1730900160166_142
        } catch (e: Exception) { // block id: 145
            Enum_1730900160166_51.enumValue_1730900160166_175(var_1730900160166_207, Float32(-92.0), Int32(-121)) |>
                func_1730900160166_147;
            [UInt32(218), UInt32(228), UInt32(93), UInt32(184), UInt32(13), UInt32(251), UInt32(5), UInt32(172),
                UInt32(78), UInt32(43)][6]
        }
    };

    let var_1730900160166_227: Float64 = Float64(68.0);
    var_1730900160166_107.func_1730900160166_110(
        (Int8(112), UInt16(199), UInt32(21), var_1730900160166_124, var_1730900160166_127,
            ###"9%${var_1730900160166_127}f${var_1730900160166_127}e3$l${var_1730900160166_127}Za{C"###, Float64(72.0),
            false)[4],
        namedParam_1730900160166_112: func_1730900160166_134<UInt16, String>(namedParam_1730900160166_135: UInt16(22),
            namedParam_1730900160166_136: var_1730900160166_227),
        namedParam_1730900160166_113: (Option<Enum_1730900160166_51>.Some(var_1730900160166_236) ??
            Enum_1730900160166_51.enumValue_1730900160166_175(var_1730900160166_207, Float32(75.0), Int32(-66))),
        namedParam_1730900160166_114: ["""
EHU!R
(zvT${var_1730900160166_127}B
""", "u7/${var_1730900160166_127}GOvUdW@",
            ###"w&${var_1730900160166_127}8${var_1730900160166_127}Y${var_1730900160166_127}D75rrb"###,
            """
m_;.F
 L|[W
""",
            """
L${var_1730900160166_127}7D${var_1730900160166_127}D;
&${var_1730900160166_127}Xox<${var_1730900160166_127}
""",
            """
(k${var_1730900160166_127}J[y
s``${var_1730900160166_127}E${var_1730900160166_127}g
""",
            ":o${var_1730900160166_127}RkuJ${var_1730900160166_127}`RkB",
            "L${var_1730900160166_127}j${var_1730900160166_127}bw${var_1730900160166_127}PNB}}${var_1730900160166_127}'",
            "7=pX|}${var_1730900160166_127}Pc|2${var_1730900160166_127}",
            ###"qdQ${var_1730900160166_127}+%@WmT7${var_1730900160166_127}"###][0])
}

public const func func_1730900160166_263(param_1730900160166_264: Int8, namedParam_1730900160166_265!: Int8,
    optionalParam_1730900160166_266!: Bool = true, namedParam_1730900160166_268!: Rune): Int64 { // block id: 269
    var_1730900160166_18;
    ();
    var_1730900160166_273
}

main(): Int64 {
    try {
        const var_1730900160166_66: UInt16 = 106;
        Struct_1730900160166_6.func_1730900160166_11(
            namedParam_1730900160166_12: match (Enum_1730900160166_51.enumValue_1730900160166_54(var_1730900160166_60,
                var_1730900160166_63, var_1730900160166_66, ###"+-)H6rtkf#"###)) {
                case _ =>
                    var_1730900160166_18;
                    -Int64(58)
            }, optionalParam_1730900160166_13: (Option<String>.Some(###"frx_32]@L*"###) ?? var_1730900160166_63),
            namedParam_1730900160166_15: Class_1730900160166_84.var_1730900160166_98);
        var var_1730900160166_326: Bool = false;
        if (!func_1730900160166_103()) { // block id: 261
            var var_1730900160166_277: Int8 = Int8(-71);
            func_1730900160166_263(Int8(-22), namedParam_1730900160166_265: var_1730900160166_277,
                namedParam_1730900160166_268: r'e')
        } else if (match (var_1730900160166_284[2]) {
            case _: Rune =>
                ();
                false

            case _ =>
                var_1730900160166_319;
                !var_1730900160166_326
        }) { // block id: 328
            false;
            var var_1730900160166_337: Float64 = Float64(Float64(Float32(-63.0)));
            var var_1730900160166_343: Interface_1730900160166_95 = Class_1730900160166_84();
            if (var_1730900160166_326) { // block id: 332
                Int64(-23)
            } else { // block id: 334
                var_1730900160166_337 += Float64(-13.0)
                var_1730900160166_343;
                Int64(87)
            }
        } else { // block id: 346
            Int64(45)
        }
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1730900160166_60 * var_1730900160166_60), 64)
        crcCheck.updateBuffer(UInt64(var_1730900160166_66 * var_1730900160166_66), 64)
        crcCheck.updateBuffer(UInt64(var_1730900160166_167 * var_1730900160166_167), 64)
        crcCheck.updateBuffer(UInt64(var_1730900160166_207 * var_1730900160166_207), 64)
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

extend Struct_1730900160166_6 {
    public static func func_1730900160166_11(namedParam_1730900160166_12!: Int64,
        optionalParam_1730900160166_13!: String = "J]xb&U:0\\5", namedParam_1730900160166_15!: Rune): Unit { // block id: 16
        var_1730900160166_18;
        if (var_1730900160166_22) { // block id: 24
            var loopTimeVar_1730900160166_34: Int = 0;
            while ((true) && loopTimeVar_1730900160166_34 < 100) {
                loopTimeVar_1730900160166_34++;
                var var_1730900160166_30: Float64 = Float64(-46.0);
                var_1730900160166_30 += Float64(84.0)
            };
            var var_1730900160166_38: (Int16, Bool, Unit, Int16, Float32, Float32) = (Int16(Int8(Int8(-52))), false, (),
                Int16(-110), Float32(119.0), Float32(Float32(48.0)));
            var_1730900160166_38[2]
        }
    }
}

extend Enum_1730900160166_51 {}

extend Class_1730900160166_84 {}
