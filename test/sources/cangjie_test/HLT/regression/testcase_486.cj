/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


let myLongField : Int64 = 0x41
let myOtherLongField : Int64 = 0x123456789abcdef

let myField : Int32 = 0xFFF
let myOtherField : Int32 = 0x1

func testIntShiftLeft(): Unit {
  try {
    var a : Int32 = myField
    var b : Int32 = myOtherField << a
    if (b != -2147483648) {
      throw Exception("Expected -2147483648, got " + b.toString())
    }
    if (a != 0xFFF) {
      throw Exception("Expected 0xFFF, got " + a.toString())
    }
  } catch (e: ArithmeticException) {}
}

func testIntShiftRight(): Unit {
  try {
    var a : Int32 = myField
    var b : Int32 = myOtherField >> a
    if (b != 0) {
      throw Exception("Expected 0, got " + b.toString())
    }
    if (a != 0xFFF) {
      throw Exception("Expected 0xFFF, got " + a.toString())
    }
  } catch (e: ArithmeticException) {}
}

func testLongShiftLeft(): Unit {
  try {
    var a : Int64 = myLongField
    var b : Int64 = myOtherLongField << a
    if (b != 0x2468ACF13579BDE) {
      throw Exception("Expected 0x2468ACF13579BDE, got " + b.toString())
    }
    if (Int32(a) != 0x41) {
      throw Exception("Expected 0x41, got " + a.toString())
    }
  } catch (e: ArithmeticException) {}
}

func testLongShiftRight(): Unit {
  try {
    var a : Int64 = myLongField
    var b : Int64 = myOtherLongField >> a
    if (b != 0x91A2B3C4D5E6F7) {
      throw Exception("Expected 0x91A2B3C4D5E6F7, got " + b.toString())
    }
    if (Int32(a) != 0x41) {
      throw Exception("Expected 0x41, got " + a.toString())
    }
  } catch (e: ArithmeticException) {}
}

main(): Int64 {
  testIntShiftRight()
  testIntShiftLeft()
  testLongShiftRight()
  testLongShiftLeft()
  print("passed")
  return 0
}
// ASSERT: scan chir_shift_length_overflow


