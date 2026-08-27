/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



// random seed:1628869109592

// All global variable need to be defined before use!
public let var57 : Unit = ()
public let var71 : UInt64 = UInt64(85)
public let var105 : Option<Unit> = Option<Unit>.None
public let var125 : (Float64*Bool*Rune) = ((-34.0), (((true is Interface23<Int16, Float64>) is Int16) is Bool), 'L')
public var var199 : Bool = (true is Bool)
 var var206 : Class22<Class244, Rune> = Class22<Class244, Rune>()
 var var231 : Bool = (true is Unit)
public var var275 : Interface23<Int16, Float64> = Class22<Class244, Rune>()
public let var289 : Int64 = 125
public var var354 : Bool = ((true is UInt16) is Unit)
 var var405 : Int32 = Int32(47)
 var var408 : Rune = '7'
public var var449 : UInt8 = UInt8(227)
public var var502 : (UInt8*(Bool*UInt8*Int8*Int16*Unit)*Bool*(Float64*Bool*Rune)) = (UInt8(102), (((true is Int8) is UInt16), UInt8(228), Int8(-76), Int16(-18), ()), (true is Int8), ((-47.0), false, 'N'))
public var var580 : Bool = false
 let var654 : Enum651<Rune, UInt32> = Enum651<Rune, UInt32>.enumValue656
public let var673 : Option<Bool> = Option<Bool>.Some(var199)
public var var676 : Option<Option<Bool>> = (Option<Option<Bool>>.None as Option<Bool>)
public var var718 : Int8 = Int8(-21)
main(): Int64 {
    var loopTimeVar14 : Int64 = 0;
    while ((true is Int16) && loopTimeVar14 < 100 ) {
        loopTimeVar14++;
        let var11 : Unit = ();
        var11
    };
    if (func17(true)) { (Option<Int8>.None ?? Int8(-49)) } else { (if (var231) { var718 } else { var718 } ) } ;
    117
    // CRC Check All Variables
    var crccheck = CrcCheck(5000, 32)
    crccheck.updateBuffer(UInt64(loopTimeVar14), 64)
    crccheck.updateBuffer(UInt64(var71), 64)
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
func func17(param18 : Bool) : Bool { // block id: 19
    var var260 : Int16 = Int16(100);
    match {
        case func27(var260, Int16(-75), Float32(-87.0)).var265 => 
        ();
        if (var231) { // block id: 272
            var260;
            var275;
            UInt32(182)
        } else if (param18) { // block id: 279
            UInt32(252)
        } else { // block id: 281
            UInt32(20)
        };
        (Option<Int64>.Some(var289) ?? (-5))
        case match {
            case match (param18) {
                case _ => 
                    false
                
            } => 
            Int16(-97);
            false
            case (Option<Bool>.Some(var199) ?? var231) => 
            false
            case _ => 
            var57;
            var275;
            param18
        } => 
        func319(namedParam322 : UInt32(130))
        case _ => 
        let var613 : ((Float64*Bool*Rune)*(UInt8*(Bool*UInt8*Int8*Int16*Unit)*Bool*(Float64*Bool*Rune))*Rune) = ((69.0, ((true is Option<Int64>) is Int8), 'C'), (UInt8(135), ((true is Int64), UInt8(194), Int8(27), Int16(-99), ()), true, (68.0, false, 'X')), 'b');
        if (var354) { // block id: 605
            (var354, var449, Int8(102), Int16(-105), var57);
            var613
        } else { // block id: 636
            UInt64(163);
            var613
        };
        if (true) { 'K' } else { 'w' } ;
        (var289, var260, UInt16(87))[0]
    };
    var var661 : UInt32 = UInt32(161);
    match (var654) {
        case _ => 
            var57;
            var661;
            Option<Rune>.None
        
    };
    (if (true) { (var676 ?? var673) } else { var673 }  ?? if (if (false) { // block id: 684
        ();
        var673;
        false
    } else { // block id: 688
        true
    }) { if (true) { // block id: 692
        param18
    } else if (false) { // block id: 695
        ();
        var199
    } else { // block id: 698
        var57;
        var354
    } } else { if (true) { // block id: 703
        var580
    } else if (var199) { // block id: 706
        var354
    } else { // block id: 708
        ();
        var231
    } } )
}

public open class Class22<T1, T2> <: Interface23<Int16, Float64> {
    public init() { // block id: 25

    }
;
    public var var145 : Unit = ();
    public let var265 : Bool = (false is UInt16)
}

public interface Interface23<T1, T2> {
    func func119() : Unit { // block id: 120

    }

}

public func func27(param28 : Int16, param29 : Int16, param30 : Float32) : Class22<Class244, Rune> { // block id: 31
    match (func34(namedParam35 : if (false) { // block id: 193
            var57;
            var var196 : Class22<Class244, Rune> = Class22<Class244, Rune>();
            var196
        } else if (var199) { // block id: 202
            var57;
            var57;
            var206
        } else { // block id: 208
            ();
            Class22<Class244, Rune>()
        }, namedParam40 : if (false) { // block id: 213
            true
        } else { // block id: 215
            ();
            let var218 : Bool = ((false is Option<Unit>) is Int64);
            var218
        })) {
        case _ => 
            ();
            var57;
            var57
        
    };
    if ((if (var231) { var199 } else { true }  is Int64)) { Class22<Class244, Rune>() } else { (Class244.var250 ?? match ((-23.0)) {
        case _ => 
            Class22<Class244, Rune>();
            Class22<Class244, Rune>()
        
    }) } 
}

public func func34(namedParam35 ! : Class22<Class244, Rune>, optionalParam36 ! : UInt8 = UInt8(217), optionalParam38 ! : Int64 = 109, namedParam40 ! : Bool) : Int8 { // block id: 41
    let var62 : Unit = ();
    var var109 : Interface23<Int16, Float64> = Class22<Class244, Rune>();
    if ((if ((if (true) { namedParam40 } else { false } )) { if (false) { // block id: 50
        'Y';
        namedParam40
    } else if (false) { // block id: 54
        ();
        var57;
        true
    } else { // block id: 60
        var62;
        var62;
        namedParam40
    } } else { match (UInt64(29)) {
        case 96 | var71 => 
            ();
            var57;
            namedParam40
        
        case _ => 
            Int8(-111);
            let var81 : UInt16 = UInt16(148);
            var81;
            namedParam40
        
    } } )) { (match (Int32(-70)) {
        case -114 => 
            ();
            Option<Unit>.None
        
        case _ => 
            Option<Unit>.Some(var57)
        
        case _ => 
            ();
            var105
        
    } ?? var109.func119()) } else { (if (var125[1]) { if (false) { // block id: 136
        var62
    } else if (namedParam40) { // block id: 139
        ();
        ()
    } } else { (namedParam35.var145) } ) } ;
    var loopTimeVar164 : Int64 = 0;
    do {
        loopTimeVar164++;

    } while (if (namedParam40) { match {
        case true => 
        optionalParam36;
        var109;
        namedParam40
        case _ => 
        namedParam40
    } } else { (if (namedParam40) { true } else { namedParam40 } ) }  && loopTimeVar164 < 100 ) ;
    var var179 : Int8 = Int8(-28);
    if (if (namedParam40) { false } else { namedParam40 } ) { // block id: 172
        var57;
        ();
        (true, UInt8(165), var179, Int16(-11), var57)
    } else { // block id: 183
        (namedParam40, optionalParam36, var179, Int16(-115), var62)
    }[2]
}



public open class Class244 <: Interface245 {
    public init() { // block id: 247

    }
;
    public static var var250 : Option<Class22<Class244, Rune>> = (Option<Class22<Class244, Rune>>.Some(var206) as Class22<Class244, Rune>)
}

 interface Interface245 {

}



public func func319(optionalParam320 ! : UInt8 = UInt8(24), namedParam322 ! : UInt32, optionalParam323 ! : UInt8 = UInt8(16)) : Int64 { // block id: 325
    let var332 : UInt16 = UInt16(50);
    var var360 : Option<Bool> = (Option<Bool>.Some(var199) as Bool);
    let var375 : Int16 = Int16(-13);
    if (match (UInt16(30)) {
        case var332 | 11 => 
            ();
            UInt16(251);
            true
        
        case _ => 
            UInt64(201);
            var199
        
    }) { // block id: 342
        if (false) { // block id: 345
            ();
            (-53)
        } else { // block id: 348
            UInt64(120);
            var289
        }
    } else if ((if (var354) { // block id: 358
        var360
    } else if (true) { // block id: 364
        ();
        var360
    } else { // block id: 367
        var var372 : Int8 = Int8(-104);
        (var354, optionalParam320, var372, var375, ());
        var360
    } ?? func380())) { // block id: 593
        var289
    } else { // block id: 595
        if (var354) { // block id: 598

        };
        ();
        62
    }
}

public func func380() : Bool { // block id: 381
    var var573 : Int16 = Int16(102);
    if (func384()) { // block id: 549
        let var551 : Bool = true;
        var551
    } else { // block id: 553
        (-30.0);
        var var567 : UInt8 = UInt8(16);
        var var570 : Int8 = Int8(-110);
        (((-69.0), true, '4'), (UInt8(160), (false, var567, var570, var573, var57), true, (14.0, var580, 'T')), 'A')[1];
        (false, var567, Int8(98), Int16(37), var57)[0]
    }
}

func func384(optionalParam385 ! : Int16 = Int16(-106)) : Bool { // block id: 387
    var var392 : Option<Bool> = Option<Bool>.None;
    var loopTimeVar419 : Int64 = 0;
    do {
        loopTimeVar419++;
        var loopTimeVar417 : Int64 = 0;
        do {
            loopTimeVar417++;
            UInt16(114);
            var289
        } while (var354 && loopTimeVar417 < 100 ) 
    } while (((var392 as Bool) ?? func395(optionalParam385, optionalParam397 : var405, namedParam399 : var408)) && loopTimeVar419 < 100 ) ;
    let var430 : Class22<Class244, Rune> = Class22<Class244, Rune>();
    func func422(optionalParam423 ! : UInt64 = UInt64(115), optionalParam425 ! : Int64 = 98, namedParam427 ! : UInt8) : Class22<Class244, Rune> { // block id: 428
        var430
    }
;
    func422(optionalParam425 : if (var354) { // block id: 434
        105
    } else { // block id: 436
        var57;
        58
    }, namedParam427 : match (var392) {
        case _ : Unit => 
            var var445 : Float32 = Float32(99.0);
            var445;
            ();
            var449
        
        case _ => 
            var57;
            var405;
            UInt8(41)
        
        case _ => 
            UInt64(184);
            var57;
            var449
        
        case _ : Int16 => 
            UInt8(135)
        
        case _ => 
            Int32(25);
            UInt8(170)
        
    }).func472(optionalParam475 : (var392 ?? var199), namedParam478 : if (var199) { var199 } else { true } )
}

func func395(param396 : Int16, optionalParam397 ! : Int32 = Int32(13), namedParam399 ! : Rune) : Bool { // block id: 400
    Int32(90);
    var199
}


public enum Enum651<T1, T2> {
    defaultValue |
    enumValue656
}


extend<T1, T2> Class22<T1, T2> {
    public func func472(optionalParam473 ! : Rune = 'k', optionalParam475 ! : Bool = (false is Option<Int64>), namedParam478 ! : Bool, optionalParam479 ! : Unit = ()) : Bool { // block id: 481
        var var535 : (Option<Rune>*Int16) = ((Option<Rune>.None as Rune), Int16(-80));
>>>>>>> [test]: adapt testcases for new extend syntax
            var57;
            false
        } else if (true) { // block id: 491
            ();
            var199
        } else { // block id: 494
            false
        }) { // block id: 496
            ();
            var405
        } else if (var502[2]) { // block id: 520
            var405
        } else { // block id: 522
            var125;
            ();
            Int32(-113)
        }, namedParam399 : (var535[0] ?? var408))
    }

}

extend<T1, T2> Class22<T1, T2> {

}


/*
return code: 139
*/
// ASSERT: scan parse_expected_right_delimiter
