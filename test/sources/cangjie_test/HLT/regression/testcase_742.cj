/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan-not input parameter error

@Deprecated
var var_1742035315706_39: Bool = (match (Int16(74)) {
    case _: Range<UInt16> => true
    case _ => false
})
public var var_1742035315706_47: UInt32 = UInt32(76)
public let var_1742035315706_71: Array<Unit> = [(), (), (), (), (), (), (), (), (), ()]
public let var_1742035315706_94: VArray<Int64, $4> = VArray<Int64, $4>(repeat: Int64(-10))
public const var_1742035315706_130: UInt64 = 201
@Deprecated
let var_1742035315706_193: Option<Range<Int32>> = (match (((Int16(Int16(22)) & 127)..(Int16(Int16(-60)) & 127) : (Int64(125) |
    1))) {
    case newVar: Range<Int32> => Option<Range<Int32>>.Some(newVar)
    case _ => Option<Range<Int32>>.None
})
internal const var_1742035315706_198: Int32 = 69

@Deprecated
public open class Class_1742035315706_18<T0> <: Resource {
    @Frozen
    public Class_1742035315706_18() { // block id: 20

    }

    public static const var_1742035315706_205: Int = -50
    static init() {
    }
    public func isClosed(): Bool {
        return false
    }
    public func close(): Unit {}
}

func func_1742035315706_32<T0, T1>(param_1742035315706_33: Range<Int32>): VArray<Int64, $4> { // block id: 34
    var var_1742035315706_83: Int64 = Int64(UInt8(UInt8(UInt8(UInt8(191)))));
    let var_1742035315706_108: Array<UInt64> = [UInt64(Int64(-63)), UInt64(19), UInt64(185), UInt64(101), UInt64(146),
        UInt64(UInt64(UInt8(Int8(-54)))), UInt64(UInt8(UInt8(Int8(22)))), UInt64(Int64(21)), UInt64(184), UInt64(13)];
    const var_1742035315706_171: Int32 = -115;
    throw Exception("demangle test");
    try { // block id: 36
        var_1742035315706_39 = var_1742035315706_39 && (var_1742035315706_39)
        try (resource = Class_1742035315706_18<Bool>()) { // block id: 44
            var_1742035315706_47 = var_1742035315706_47 & (var_1742035315706_47)
        } catch (_) { // block id: 50

        } finally { // block id: 51
            ()
        };
        var var_1742035315706_56: VArray<Int64, $4> = VArray<Int64, $4>(repeat: Int64(Int16(Int8(-82))));
        if (var_1742035315706_39) {
            var_1742035315706_56
        } else {
            var_1742035315706_56
        }
    } catch (_) { // block id: 67
        var_1742035315706_71[9];
        var var_1742035315706_136: UInt = UInt64(12);
        try { // block id: 75
            var_1742035315706_47 = var_1742035315706_47 - (var_1742035315706_47)
            ();
            VArray<Int64, $4>({i => Int64(-17)})
        } catch (_) { // block id: 91
            UInt64(107);
            var_1742035315706_94
        } finally { // block id: 104
            if (var_1742035315706_39) {
                var_1742035315706_108
            } else {
                [var_1742035315706_130, UInt64(22), var_1742035315706_130, var_1742035315706_130, var_1742035315706_136,
                    UInt64(253), UInt64(159), UInt64(129), var_1742035315706_130, UInt64(17)]
            };
            UInt64(247) << ((var_1742035315706_136) & 7);
            if (var_1742035315706_39) {
                var_1742035315706_94
            } else {
                VArray<Int64, $4>(repeat: var_1742035315706_83)
            }
        }
    } finally { // block id: 154
        try (resource = Class_1742035315706_18<Bool>()) { // block id: 156
            var var_1742035315706_159: Int16 = Int16(41);
            var_1742035315706_159 = var_1742035315706_159 & (var_1742035315706_159)
            var var_1742035315706_163: Unit = ();
            var_1742035315706_163;
            var_1742035315706_163
        } catch (_) { // block id: 166

        } finally { // block id: 167
            Int32(-16) - var_1742035315706_171;
            ();
            var_1742035315706_39 = var_1742035315706_39 || (true)
        };
        var var_1742035315706_182: Int = Int64(UInt64(UInt8(171)));
        VArray<Int64, $4>(repeat: var_1742035315706_83)
    }
}

main(): Int64 {
    try {
        Class_1742035315706_18<Bool>.func_1742035315706_23<Range<UInt64>, UInt16>()[1]
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
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

extend UInt8 {
    operator func ()(x: UInt8): UInt8 {
        return this - x
    }
}

extend<T0> Class_1742035315706_18<T0> {
    public static func func_1742035315706_23<T0, T1>(): VArray<Int64, $4> { // block id: 24
        var var_1742035315706_201: Int32 = Int32(UInt16(138));
        (match (Option<VArray<Int64, $4>>.None) {
            case Some(num) => num
            case None => (func_1742035315706_32<Range<UInt16>, Float64>((match (var_1742035315706_193) {
                case Some(num) => num
                case None => ((Int32(var_1742035315706_198) & 127)..=(Int32(var_1742035315706_201) & 127) : (var_1742035315706_205 |
                    1))
            })))
        })
    }
}
