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

public var var_1731939976983_24: UInt16 = UInt16(UInt8(UInt8(87)))
public var var_1731939976983_34: Int32 = Int32(UInt8(Int8(-48)))
@Deprecated
public let var_1731939976983_46: Rune = r'J'
var var_1731939976983_51: Int16 = Int16(-126)
public const var_1731939976983_109: Float64 = -59.0
@Deprecated
internal const var_1731939976983_116: Int64 = -125
@Deprecated
public const var_1731939976983_119: Bool = true
internal let var_1731939976983_134: String = "@7X_*``hzK"
public const var_1731939976983_146: Unit = ()
internal let var_1731939976983_186: ?Range<UInt32> = (Float32(Float32(Float32(Float32(-22.0)))) as Range<UInt32>)
@Deprecated
public let var_1731939976983_193: Range<UInt32> = ((UInt32(UInt32(16)) & 127)..=(UInt32(UInt32(172)) & 127) : (Int64(26) |
    1))
public let var_1731939976983_198: (UInt32, UInt8, Int64, Range<UInt64>) = (UInt32(Int8(73)), UInt8(Int8(Int8(15))),
    Int64(Int32(UInt8(237))), ((UInt64(UInt64(58)) & 127)..=(UInt64(UInt64(40)) & 127) : (Int64(-41) | 1)))

public struct Struct_1731939976983_65 {
    public init() { // block id: 67

    }

    public let var_1731939976983_112: Bool = false
}

@Frozen
internal func func_1731939976983_87<T0>(): (Int32, Int8, Array<Struct_1731939976983_65>) { // block id: 88
    let var_1731939976983_90: (Int32, Int8, Array<Struct_1731939976983_65>) = (Int32(Int32(-6)), Int8(105), [Struct_1731939976983_65(),
            Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(),
            Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(),
            Struct_1731939976983_65()]);
    var_1731939976983_90
}

@Frozen
@Deprecated
public func func_1731939976983_69<T0>(optionalParam_1731939976983_70!: Float64 = Float64(119.0)): Struct_1731939976983_65 { // block id: 72
    func_1731939976983_87<Array<Struct_1731939976983_65>>()[2][0]
}

public enum Enum_1731939976983_123<T0, T1> {
    defaultValue
    | enumValue_1731939976983_126(String, (Float64) -> Struct_1731939976983_65, Range<Int64>, Rune)
}

main(): Int64 {
    try {
        const var_1731939976983_10: Int = -128;
        match (var_1731939976983_10) {
            case _ =>
                var var_1731939976983_17: Int32 = Int32(38);
                var_1731939976983_17--

            case _ => var_1731939976983_24 %= ((UInt16(124)) | 1)

            case _: String =>
                var_1731939976983_34 | var_1731939976983_34;
                let var_1731939976983_41: Bool = ((() is Float64) is Bool);
                if (var_1731939976983_41) {
                    var_1731939976983_46
                } else {
                    r'W'
                };
                var_1731939976983_51 &= Int16(100)

            case _ =>
                UInt8(92) - UInt8(137);
                const var_1731939976983_61: Unit = ();
                var_1731939976983_61
        };
        var var_1731939976983_153: Array<Struct_1731939976983_65> = [Struct_1731939976983_65(),
            Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(),
            Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(), Struct_1731939976983_65(),
            Struct_1731939976983_65()];
        if (func_1731939976983_69<Float64>(optionalParam_1731939976983_70: var_1731939976983_109).var_1731939976983_112) { // block id: 114
            var_1731939976983_116
        } else if (var_1731939976983_119) { // block id: 121
            match (Enum_1731939976983_123<Bool, Int32>.enumValue_1731939976983_126(var_1731939976983_134,
                func_1731939976983_69<Float64>,
                ((Int64(Int64(-66)) & 127)..=(Int64(Int64(-61)) & 127) : (var_1731939976983_116 | 1)),
                var_1731939976983_46)) {
                case _ =>
                    var_1731939976983_146;
                    Int64(-32)

                case defaultValue =>
                    var_1731939976983_153;
                    Int64(106)

                case _ => Int64(68)
            }
        } else { // block id: 178
            var_1731939976983_146;
            (var_1731939976983_186 ?? var_1731939976983_193);
            var_1731939976983_198[2]
        }
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1731939976983_10 * var_1731939976983_10), 64)
        crcCheck.updateBuffer(UInt64(var_1731939976983_51 * var_1731939976983_51), 64)
        crcCheck.updateBuffer(UInt64(var_1731939976983_116 * var_1731939976983_116), 64)
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

extend Struct_1731939976983_65 {}

extend<T0, T1> Enum_1731939976983_123<T0, T1> {}
