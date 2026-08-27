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
public const var_1735836330769_36: Int64 = 70
public const var_1735836330769_57: UInt64 = 236
public var var_1735836330769_67: Int8 = Int8(Int8(UInt8(251)))
public var var_1735836330769_80: Int = Int64(Int16(124))
var var_1735836330769_87: Bool = (UInt16(124) is UInt64)

@Frozen
public const func func_1735836330769_8(param_1735836330769_9: Int8): Unit { // block id: 10

}

@Frozen
public const func func_1735836330769_16<T0, T1>(param_1735836330769_17: Int64, namedParam_1735836330769_18!: String,
    namedParam_1735836330769_19!: Int64): Unit { // block id: 20
    126;
    ();
    const var_1735836330769_24: Unit = ();
    var_1735836330769_24
}

@Deprecated
public const func func_1735836330769_27<T0, T1>(param_1735836330769_28: Unit, namedParam_1735836330769_29!: UInt64,
    optionalParam_1735836330769_30!: Float32 = 50.0, namedParam_1735836330769_32!: Float32): Int64 { // block id: 33
    -110;
    var_1735836330769_36
}

const func func_1735836330769_12(param_1735836330769_13: UInt64): Unit { // block id: 14
    const var_1735836330769_41: Float32 = -21.0;
    func_1735836330769_16<UInt64, Int64>(
        func_1735836330769_27<Int64, String>((), namedParam_1735836330769_29: 19,
            optionalParam_1735836330769_30: var_1735836330769_41, namedParam_1735836330769_32: var_1735836330769_41),
        namedParam_1735836330769_18: "TUo2Xr9J*t", namedParam_1735836330769_19: 16);
    ()
}

const func func_1735836330769_53(param_1735836330769_54: Int8): UInt64 { // block id: 55
    var_1735836330769_57
}

main(): Int64 {
    try {
        let var_1735836330769_48: (UInt64) -> Unit = {lambdaParameter_1735836330769_51: UInt64 =>};
        var var_1735836330769_60: (Int8) -> UInt64 = {lambdaParameter_1735836330769_63: Int8 => UInt64(233)};
        var_1735836330769_67 |> (var_1735836330769_60 ~> var_1735836330769_48);
        Int64(try { // block id: 73
            Float64(-92.0);
            Float64(-65.0);
            Int64(-16)
        } catch (e: Exception) { // block id: 77
            true;
            var_1735836330769_80
        } finally { // block id: 83
            UInt32(205);
            var_1735836330769_87 &&= var_1735836330769_87
            var_1735836330769_80 / ((Int64(-2)) | 1)
        })
        // CRC Check All Variables
        var crcCheck = CrcCheck(5000, 32)
        crcCheck.updateBuffer(UInt64(var_1735836330769_67 * var_1735836330769_67), 64)
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
