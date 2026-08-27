/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f


// random seed:1629978801732

// All global variable need to be defined before use!
public let var17 : UInt32 = UInt32(201)
public let var22 : Unit = ()
 var var71 : List<Unit> = [(), (), (), (), ()]
public var var159 : Result<Unit> = Result<Unit>.Ok(var22)
 var var176 : Int8 = Int8(Int8(78))
 var var184 : Bool = true
public var var194 : Enum180<Range<Int16>, Unit, Int8> = Enum180<Range<Int16>, Unit, Int8>.enumValue196(UInt8(UInt16(29)), Class26<UInt64, Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>, String>())
public var var214 : Result<Int8> = Result<Int8>.Err(Exception())
public var var230 : Bool = false
public var var315 : (Int16*Float32*Unit*Int32*UInt32) = (Int16(Int16(95)), Float32(32.0), (), Int32(3), UInt32(80))
main(): Int64 {
    var var8 : String = "S{bvjE\"Pk1";
    if ((var8 is Int16)) { // block id: 10
        var var12 : Unit = ();
        var12;
        var12
    } else if ((var17 is UInt64)) { // block id: 19
        UInt64(234);
        var22;
        var22
    };
    var var483 : UInt8 = UInt8(12);
    Class26<UInt64, Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>, String>.func33<Int64, UInt8>((), var483, namedParam36 : var176);
    52
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var483), 64)
    crccheck.updateBuffer(UInt64(var17), 64)
    crccheck.updateBuffer(UInt64(var176), 64)
    crccheck.crcCheck()
    crccheck.getCrcOutput()

    return 0;
}

class CrcCheck {
    public var buffer: Array<Int64>
    public var poly: Array<Int64>
    public var crc_output: Array<Int64>
    public var poly_n: Int64
    public var buffer_index: Int64
    public var crc_output_n: Int64

    public init(buffer_n: Int64, crc_n: Int64) {
        buffer_index = 0
        crc_output_n = 0
        crc_output = Array<Int64> (crc_output_n, 0)
        buffer = Array<Int64> (buffer_n, 0)
        poly_n = crc_n + 1
        poly = Array<Int64> (poly_n, 0)
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

    public func updateBuffer(input: UInt64, byte_n: Int64): Unit {
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
        var byteArray = Array<Int64> (byte_n, 0)
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

    public func crcCheck(): Unit {
        crc_output_n = buffer_index + poly_n - 1
        var crc_buffer = Array<Int64> (crc_output_n, 0)
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
        crc_output = Array<Int64> (crc_output_n, 0)
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

    public func getCrcOutput(): Unit {
        var i = 0
        while (i < crc_output_n) {
            var hex_value = 2**2 * crc_output[i] + 2**1 * crc_output[i + 1] + 1 * crc_output[i + 2]
            print(hex_value.toString())
            i = i + 3
        }
    }
}
 open class Class26<T0, T1, T2> <: Interface27<Range<Int8>, Int32, Range<Int16>> & Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool> where T0 <: UInt64, T1 <: Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>, T2 <: String {
    public init() { // block id: 30

    }
;
    public static let var233 : UInt64 = UInt64(UInt16(3));
    public static var var274 : Range<Int64> = (Int64(Int64(UInt16(UInt32(102))))..=50:(Int64(Int32(Int16(UInt32(32))))|1));
    public static let var292 : String = "]W;Xgm\\U(i";
    public static var var295 : UInt16 = UInt16(UInt64(189));
    public static let var359 : Float32 = Float32(-44.0);
    public static let var389 : Float32 = Float32(-58.0)
}

 interface Interface27<T0, T1, T2> where T0 <: Range<Int8>, T1 <: Int32, T2 <: Range<Int16> {
    func func168() : Int8 { // block id: 169
        let var188 : Int16 = Int16(97);
        let var191 : Range<Int16> = (Int16(111)..Int16(52):(-26)|1);
        (match (if (var184) { // block id: 186
                var188;
                var191;
                var194
            } else if (true) { // block id: 203
                UInt64(92);
                Enum180<Range<Int16>, Unit, Int8>.defaultValue
            } else { // block id: 206
                var22;
                (Int8(-72)..Int8(-98):(-35)|1);
                Enum180<Range<Int16>, Unit, Int8>.defaultValue
            }) {
            case defaultValue =>
                var214

            case _ =>
                UInt32(21);
                Result<Int8>.Ok(var176)

        } ?? try { // block id: 222
            var22;
            Int8(84)
        } finally { // block id: 225
            Int8(42)
        })
    }

}

interface Interface28<T0, T1, T2> <: Interface27<Range<Int8>, Int32, Range<Int16>> where T0 <: Interface27<Range<Int8>, Int32, Range<Int16>>, T1 <: Int32, T2 <: Bool {
    static func func58<T0, T1>(namedParam59 ! : UInt64) : List<List<Unit>> { // block id: 60
        let var65 : Bool = false;
        let var165 : Interface27<Range<Int8>, Int32, Range<Int16>> = Class26<UInt64, Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>, String>();
        try { // block id: 62
            let var79 : List<Unit> = [(), (), (), (), ()];
            var var92 : UInt8 = UInt8(Float64(Int32(22)));
            if (var65) { // block id: 67
                ();
                [var71, var79, [(), var22, var22, var22, ()], var71, [(), (), (), (), ()]]
            } else if (var65) { // block id: 90
                var92;
                var22;
                var var99 : List<Unit> = [(), (), (), (), ()];
                [var99, var79, [(), (), (), (), ()], [var22, (), var22, (), ()], [(), var22, (), (), ()]]
            } else { // block id: 120
                var22;
                [[(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()]];
                let var124 : List<List<Unit>> = [[(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()]];
                var124
            }
        } finally { // block id: 151
            (var159 ?? var22);
            var165.func168();
            [[(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()], [(), (), (), (), ()]]
        }
    }

}



 enum Enum180<T0, T1, T2> where T0 <: Range<Int16>, T1 <: Unit, T2 <: Int8 {
    defaultValue |
    enumValue196(UInt8, Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>)
}
extend<T0, T1, T2> Enum180<T0, T1, T2> where T0 <: Range<Int16>, T1 <: Unit, T2 <: Int8 {

}

extend<T0, T1, T2> Class26<T0, T1, T2> where T0 <: UInt64, T1 <: Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>, T2 <: String {
    public static func func33<T0, T1>(param34 : Unit, param35 : UInt8, namedParam36 ! : Int8) : Unit { // block id: 37
        ();
        let var240 : Rune = 'Z';
        var var256 : Int64 = (-11);
        func50<Interface28<Interface27<Range<Int8>, Int32, Range<Int16>>, Int32, Bool>>(namedParam51 : match (var240) {
            case var240 | 'z' =>
                var176;
                var22;
                ((-91)..=(-84):30|1)

            case var240 =>
                var176;
                (var256..=79:(116|1))

            case caseVar262 : Range<Int32> =>
                let var265 : UInt16 = UInt16(Float32(7.0));
                var265;
                let var269 : Range<Int64> = (125..(-64):(-95)|1);
                var269

            case _ =>
                var274

        }, namedParam52 : Int64(UInt64(192)), namedParam53 : if (true) { // block id: 289
            ();
            var292;
            var295
        } else { // block id: 298
            var176;
            var22;
            var295
        })[1];
        var var324 : (Int16*Float32*Unit*Int32*UInt32) = (Int16(33), Float32(19.0), (), Int32(Int8(UInt32(Int16(-77)))), UInt32(UInt32(41)));
        var var355 : Int16 = Int16(UInt16(187));
        var var363 : Int32 = Int32(UInt64(Int8(-68)));
        let var427 : List<(Int16*Float32*Unit*Int32*UInt32)> = [(Int16(Int32(Int16(-78))), Float32(91.0), (), Int32((-92.0)), UInt32(148)), (Int16(-121), Float32(-72.0), (), Int32(-100), UInt32(43)), (Int16(UInt8((-50.0))), Float32(Float32(Float32(22.0))), (), Int32(14), UInt32(UInt8(214))), (Int16(Float64(Float32(-13.0))), Float32(7.0), (), Int32(112), UInt32(UInt8((-121)))), (Int16(UInt16(Float32(-101.0))), Float32(UInt64(82)), (), Int32(89), UInt32(Float64(UInt64(218))))];
        match (var71) {
            case caseVar311 =>
                var var337 : Int16 = Int16(113);
                var var340 : Float32 = Float32(-36.0);
                [var315, var324, (var337, var340, param34, Int32(120), UInt32(239)), var315, var315]

            case _ =>
                (UInt8(148)..=UInt8(55):15|1);
                param35;
                [(var355, var359, var22, var363, var17), (Int16(-19), var359, (), var363, UInt32(22)), (Int16(-47), Float32(-69.0), (), Int32(96), UInt32(84)), (Int16(-122), Float32(43.0), param34, Int32(27), UInt32(81)), (var355, var389, (), var363, UInt32(39))]

            case _ =>
                let var406 : (Int16*Float32*Unit*Int32*UInt32) = (Int16(-52), Float32(Float32(Int8((-102)))), (), Int32(UInt64(Int64(Int16(57)))), UInt32(UInt8(0)));
                [var324, (var355, var359, var22, Int32(-14), var17), var406, var324, var315]

            case _ : Int8 =>
                Int16(-71);
                var427

            case _ =>
                var427

        }[4][2]
    }
;
    private static func func50<T0>(namedParam51 ! : Range<Int64>, namedParam52 ! : Int64, namedParam53 ! : UInt16) : List<Unit> { // block id: 54
        func58<UInt16, Range<Int8>>(namedParam59 : if (var230) { var233 } else { var233 } )[0]
    }

}

// ASSERT: scan parse_expected_right_delimiter
