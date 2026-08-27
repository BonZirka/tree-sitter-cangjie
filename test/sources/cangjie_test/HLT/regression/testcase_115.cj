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

public let var_1659980185236_38 : Class_1659980185236_22 = Class_1659980185236_22()
public let var_1659980185236_49 : Rune = 'i'
public interface Interface_1659980185236_34 {

}

public interface Interface_1659980185236_33 <: Interface_1659980185236_34 {

}

public interface Interface_1659980185236_35 {

}

public interface Interface_1659980185236_32 <: Interface_1659980185236_33 & Interface_1659980185236_35 {

}

public interface Interface_1659980185236_31 <: Interface_1659980185236_32 {

}

public interface Interface_1659980185236_30 <: Interface_1659980185236_31 & Interface_1659980185236_32 {

}

public interface Interface_1659980185236_29 <: Interface_1659980185236_30 & Interface_1659980185236_33 {

}

public interface Interface_1659980185236_28 <: Interface_1659980185236_29 & Interface_1659980185236_30 {

}

public interface Interface_1659980185236_27 <: Interface_1659980185236_28 & Interface_1659980185236_31 {

}

public interface Interface_1659980185236_26 <: Interface_1659980185236_27 & Interface_1659980185236_35 {

}

public interface Interface_1659980185236_36 <: Interface_1659980185236_30 & Interface_1659980185236_34 {

}

public interface Interface_1659980185236_25 <: Interface_1659980185236_26 & Interface_1659980185236_36 {

}

public open class Class_1659980185236_22 <: Interface_1659980185236_25 & Resource {
    public init() { // block id: 24

    }
;
    public let var_1659980185236_41 : Bool = false
    public func isClosed(): Bool { return false }
    public func close(): Unit {}
}

main(): Int64 {
    try {
        var var_1659980185236_6 : Bool = true;
        var_1659980185236_6;
        let var_1659980185236_52 : Int32 = Int32(UInt32(160));
        func func_1659980185236_9(namedParam_1659980185236_10 ! : Bool, optionalParam_1659980185236_11 ! : Int64 = Int64(Int32(Int8(37))), optionalParam_1659980185236_15 ! : Unit = (), optionalParam_1659980185236_17 ! : UInt64 = UInt64(95)) : Int64 { // block id: 19
            var loopTimeVar_1659980185236_64 : Int64 = 0;
            while ((var_1659980185236_38.var_1659980185236_41) && loopTimeVar_1659980185236_64 < 100 ) {
                loopTimeVar_1659980185236_64++;
                let var_1659980185236_56 : Int8 = Int8(UInt8(UInt8(185)));
                (Int32(-9), var_1659980185236_49, var_1659980185236_52, var_1659980185236_56, Class_1659980185236_22(), var_1659980185236_56)[4]
            };
            var var_1659980185236_72 : Interface_1659980185236_28 = Class_1659980185236_22();
            try (resource = Class_1659980185236_22()) { // block id: 66

            } finally { // block id: 67
                var loopTimeVar_1659980185236_75 : Range<UInt64> = ((UInt64(137)&127)..(UInt64(Int32(Int16(-82)))&127):((27|1)));
                for (i in loopTimeVar_1659980185236_75 where false) {
                    var_1659980185236_72;
                    ()
                };
                try (resource = Class_1659980185236_22()) { // block id: 91
                    optionalParam_1659980185236_15;
                    ();
                    ()
                } finally { // block id: 95
                    ()
                };
                ()
            };
            8
        }
;
        let var_1659980185236_102 : Array<Bool> = [false, true, true, true, false, true, false, false, true, false];
        var var_1659980185236_108 : Unit = ();
        func_1659980185236_9(namedParam_1659980185236_10 : var_1659980185236_102[3], optionalParam_1659980185236_11 : func_1659980185236_9(namedParam_1659980185236_10 : false, optionalParam_1659980185236_15 : var_1659980185236_108, optionalParam_1659980185236_17 : UInt64(11)))
        // CRC Check All Variables
        var crccheck = CrcCheck(5000, 32)
        crccheck.updateBuffer(UInt64(var_1659980185236_52*var_1659980185236_52), 64)
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
extend Class_1659980185236_22 {

}

