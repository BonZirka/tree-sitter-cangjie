/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


// random seed:1628991860980

// All global variable need to be defined before use!
public var var13 : Class8 = Class8()
public var var26 : Interface9<Int32, Int64> = Class8()
public let var29 : Option<Interface9<Int32, Int64>> = ((Option<Interface9<Int32, Int64>>.Some(var26) as Interface9<Int32, Int64>) as Interface9<Int32, Int64>)
public var var65 : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = (((-2), UInt8(176), ((), UInt32(76), Int32(23), Int16(8)), (-83.0)), ())
public var var126 : Rune = 'V'
 var var146 : ((((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit),Unit),Bool) = ((((40, UInt8(207), ((), UInt32(31), Int32(28), Int16(60)), (-24.0)), ()), ()), ((false is ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit)) is UInt32))
public var var206 : Bool = false
 let var209 : Option<Bool> = (Option<Bool>.Some(var206) as Bool)
public var var217 : Int64 = 15
public var var226 : Aggregate222 = Aggregate222()
public let var243 : UInt8 = UInt8(121)
public var var247 : Unit = ()
public let var295 : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = (((-32), UInt8(67), ((), UInt32(143), Int32(64), Int16(-27)), (-114.0)), ())
public let var317 : Int16 = Int16(-116)
public var var335 : UInt16 = UInt16(40)
public var var383 : Enum369<Int64> = Enum369<Int64>.defaultValue
public var var394 : (Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64) = ((-28), UInt8(106), ((), UInt32(67), Int32(39), Int16(-7)), (-57.0))
public var var420 : Aggregate34 = Aggregate34()
public var var428 : Float32 = Float32(11.0)
public var var449 : UInt32 = UInt32(27)
public let var493 : Unit = ()
public let var519 : (Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64) = (9, UInt8(0), ((), UInt32(197), Int32(117), Int16(-29)), (-41.0))
public var var578 : Option<Aggregate34> = ((Option<Aggregate34>.None as Aggregate34) as Aggregate34)
public let var624 : (((((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit),Unit),Bool),((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit),Bool) = (((((125, UInt8(39), ((), UInt32(190), Int32(-4), Int16(-76)), (-58.0)), ()), ()), false), ((67, UInt8(153), ((), UInt32(104), Int32(64), Int16(-49)), (-123.0)), ()), false)
main(): Int64 {
    var13.func16('x')
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(var317), 64)
    crccheck.updateBuffer(UInt64(var335), 64)
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
public open class Class8 <: Interface9<Int32, Int64> {
    public init() { // block id: 11

    }
;
    public let var132 : Option<Interface9<Int32, Int64>> = (Option<Interface9<Int32, Int64>>.Some(var26) as Interface9<Int32, Int64>);
    public let var168 : Unit = ();
    public static var var345 : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = (((-29), UInt8(131), ((), UInt32(241), Int32(-40), Int16(116)), 52.0), ());
    public static var var366 : Unit = ();
    public static let var375 : Bool = (((false is Float64) is Int16) is Option<Rune>);
    public static let var38 : Aggregate34 = Aggregate34((true is Bool), namedParam42 : UInt8(94), namedParam43 : ());
    public static var var608 : Int8 = Int8(35)
}

public interface Interface9<T1, T2> {
    func func358(param359 : Option<Interface9<Int32, Int64>>, namedParam360 ! : Float32) : Bool { // block id: 361
        ();
        Class8.var366;
        match (match {
                case Class8.var375 => 
                var247;
                var383
                case _ => 
                var var391 : Int16 = Int16(-109);
                ((), UInt32(50), Int32(86), var391);
                var394;
                var383
            }) {
            case defaultValue => 
                var65;
                var243;
                var206
            
            case _ => 
                var206
            
            case defaultValue => 
                ();
                var420;
                true
            
            case _ => 
                var206
            
        }
    }

}


public struct Aggregate34 {
    public init() { // block id: 36

    }
;
    private static let var83 : (((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit),Unit) = ((((-120), UInt8(163), ((), UInt32(77), Int32(-96), Int16(14)), (-62.0)), ()), ());
    private static let var457 : Unit = ();
    public static var var556 :  (Unit,UInt32,Int32,Int16) = ((), UInt32(92), Int32(64), Int16(98));
    private static var var583 : Bool = false;
    private static let var594 : Aggregate34 = Aggregate34();
    public init(param41 : Bool, namedParam42 ! : UInt8, namedParam43 ! : Unit) { // block id: 44
        let var454 : Float64 = 39.0;
        let var482 :  (Unit,UInt32,Int32,Int16) = ((), UInt32(239), Int32(-73), Int16(-100));
        func func50(param51 : Class8) : (Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64) { // block id: 52
            match (var29) {
                case caseVar61 => 
                    Int32(52);
                    var65;
                    (var65, ())
                
                case _ => 
                    var83
                
            }[0][1];
            var var471 : Int32 = Int32(83);
            var loopTimeVar496 : Int64 = 0;
            while (func101(match {
                case true => 
                ();
                ((var394, ()), var247)
                case _ => 
                ();
                ((((-61), UInt8(185), ((), var449, Int32(-51), var317), var454), var457), ())
            }, namedParam103 : if (true) { // block id: 462
                (((-88), UInt8(18), (var457, UInt32(125), var471, var317), var454), var457)
            } else { // block id: 476
                ((73, UInt8(192), var482, var454), var247)
            }) && loopTimeVar496 < 100 ) {
                loopTimeVar496++;
                var247;
                var493
            };
            var var506 : Option<Int64> = (Option<Int64>.Some(var217) as Int64);
            (((var506 as Int64) ?? if (true) { var217 } else { var217 } ), var243, match ((var519, ())[1]) {
                case var493 | var457 | namedParam43 => 
                    false;
                    ();
                    ((), UInt32(97), Int32(126), var317)
                
                case _ => 
                    (83, UInt8(195), (var493, var449, Int32(14), Int16(-105)), var454);
                    var556
                
            }, 34.0)
        }
;
        func50(var13)[2][2];
        (if (var146[1]) { // block id: 576
            var578
        } else if (var583) { // block id: 585
            Aggregate222();
            Option<Bool>.Some(var206);
            Option<Aggregate34>.Some(var420)
        } else { // block id: 590
            ();
            Option<Aggregate34>.None
        } ?? var594)
    }
;
    public var var601 : Interface9<Int32, Int64> = Class8()
}

func func101(param102 : (((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit),Unit), namedParam103 ! : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit)) : Bool { // block id: 104
    func func106(optionalParam107 ! : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = ((69, UInt8(163), ((), UInt32(231), Int32(46), Int16(-89)), (-9.0)), ())) : Unit { // block id: 119
        (match (var13.var132) {
            case _ => 
                let var138 : Option<Rune> = ((Option<Rune>.None as Rune) as Rune);
                var138
            
        } ?? var126);
        var146[0];
        var13.var168
    }
;
    func106();
    func func172(optionalParam173 ! : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = (((-60), UInt8(11), ((), UInt32(129), Int32(48), Int16(-77)), (-3.0)), ()), optionalParam185 ! : (Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64) = ((-103), UInt8(100), ((), UInt32(243), Int32(72), Int16(-38)), 1.0), namedParam195 ! : UInt16, namedParam196 ! : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit)) : Interface9<Int32, Int64> { // block id: 197
        var loopTimeVar220 : Int64 = 0;
        if (((var209 ?? var206) is Interface9<Int32, Int64>)) { do {
            loopTimeVar220++;
            var217
        } while (var206 && loopTimeVar220 < 100 )  } else { (var226.var230) } ;
        ();
        var26
    }
;
    let var255 : Float64 = (-82.0);
    var var286 : UInt32 = UInt32(73);
    let var289 : Int32 = Int32(-64);
    let var338 : Option<UInt16> = Option<UInt16>.Some(var335);
    func172(optionalParam173 : if (var206) { // block id: 236
        let var252 : Int16 = Int16(-58);
        ((((var217, var243, (var247, UInt32(47), Int32(-106), var252), var255), var247), var247), var206);
        var var261 : ((Int64,UInt8, (Unit,UInt32,Int32,Int16),Float64),Unit) = (((-85), UInt8(187), ((), UInt32(54), Int32(95), Int16(-120)), (-126.0)), ());
        var261
    } else if (var206) { // block id: 274
        var247;
        UInt8(155);
        var65
    } else { // block id: 278
        ((var217, var243, ((), var286, var289, Int16(-63)), 116.0), var247);
        var295
    }, optionalParam185 : if (true) { (var217, UInt8(199), ((), UInt32(115), Int32(-13), var317), 56.0) } else { (95, UInt8(220), (var247, var286, var289, Int16(-72)), var255) } , namedParam195 : (var338 ?? UInt16(182)), namedParam196 : Class8.var345).func358(Option<Interface9<Int32, Int64>>.Some(var26), namedParam360 : var428)
}



public struct Aggregate222 {
    public init() { // block id: 224

    }
;
    public var var230 : Unit = ()
}


public enum Enum369<T1> {
    defaultValue
}




extend Aggregate222 {

}

extend Aggregate34 {

}

extend Class8 {
    public func func16(param17 : Rune) : Int64 { // block id: 18
        match ((var29 ?? var38.var601)) {
            case _ => 
                ();
                var608
            
            case _ => 
                var366;
                ();
                var608
            
        };
        var loopTimeVar656 : Int64 = 0;
        while (if ((false is Option<Bool>)) { (var206 is Option<Int64>) } else { var624[2] }  && loopTimeVar656 < 100 ) {
            loopTimeVar656++;

        };
        var var680 : Option<Unit> = (Option<Unit>.Some(var493) as Unit);
        if (if ((true is Float32)) { (true is Bool) } else { (if (var206) { false } else { var206 } ) } ) { // block id: 667
            var loopTimeVar672 : Int64 = 0;
            do {
                loopTimeVar672++;

            } while (true && loopTimeVar672 < 100 ) ;
            (var680 ?? var247);
            (Option<Int64>.Some(var217) ?? var217)
        } else { // block id: 688
            (Option<Int16>.Some(var317) ?? Int16(13));
            var loopTimeVar702 : Int64 = 0;
            while (var206 && loopTimeVar702 < 100 ) {
                loopTimeVar702++;

            };
            if (var206) { 20 } else { 100 } 
        }
    }

}


/*
return code: 139
*/
// ASSERT: scan sema_cannot_convert_literal
// ASSERT: scan sema_global_var_used_before_initialization
// ASSERT: scan sema_unreachable_pattern
// ASSERT: scan sema_var_in_or_pattern
