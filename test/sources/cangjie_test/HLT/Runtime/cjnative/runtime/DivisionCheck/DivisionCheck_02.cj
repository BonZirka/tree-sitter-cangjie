/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

var temp: Int64 = 1
var count: Int64 = 0

func f1() {
    return temp - 1
}

func Int8Div() {
    try {
        var a: Int8 = -126
        var b: Int8 = Int8(f1())
        var c = a / b;
        print("Int8Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int8Div:Div 0\n");
        count++
    }
}

func Int8Rem() {
    try {
        var a: Int8 = -126
        var b: Int8 = Int8(f1())
        var c = a % b;
        print("Int8Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int8Rem:Div 0\n");
        count++
    }
}

func Int16Div() {
    try {
        var a: Int16 = -126
        var b: Int16 = Int16(f1())
        var c = a / b;
        print("Int16Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int16Div:Div 0\n");
        count++
    }
}

func Int16Rem() {
    try {
        var a: Int16 = -126
        var b: Int16 = Int16(f1())
        var c = a % b;
        print("Int16Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int16Rem:Div 0\n");
        count++
    }
}

func Int32Div() {
    try {
        var a: Int32 = -126
        var b: Int32 = Int32(f1())
        var c = a / b;
        print("Int32Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int32Div:Div 0\n");
        count++
    }
}

func Int32Rem() {
    try {
        var a: Int32 = -126
        var b: Int32 = Int32(f1())
        var c = a % b;
        print("Int32Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int32Rem:Div 0\n");
        count++
    }
}

func Int64Div() {
    try {
        var a: Int64 = -126
        var b: Int64 = Int64(f1())
        var c = a / b;
        print("Int64Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int64Div:Div 0\n");
        count++
    }
}

func Int64Rem() {
    try {
        var a: Int64 = -126
        var b: Int64 = Int64(f1())
        var c = a % b;
        print("Int64Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("Int64Rem:Div 0\n");
        count++
    }
}

func UInt8Div() {
    try {
        var a: UInt8 = 126
        var b: UInt8 = UInt8(f1())
        var c = a / b;
        print("UInt8Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt8Div:Div 0\n");
        count++
    }
}

func UInt8Rem() {
    try {
        var a: UInt8 = 126
        var b: UInt8 = UInt8(f1())
        var c = a % b;
        print("UInt8Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt8Rem:Div 0\n");
        count++
    }
}

func UInt16Div() {
    try {
        var a: UInt16 = 126
        var b: UInt16 = UInt16(f1())
        var c = a / b;
        print("UInt16Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt16Div:Div 0\n");
        count++
    }
}

func UInt16Rem() {
    try {
        var a: UInt16 = 126
        var b: UInt16 = UInt16(f1())
        var c = a % b;
        print("UInt16Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt16Rem:Div 0\n");
        count++
    }
}

func UInt32Div() {
    try {
        var a: UInt32 = 126
        var b: UInt32 = UInt32(f1())
        var c = a / b;
        print("UInt32Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt32Div:Div 0\n");
        count++
    }
}

func UInt32Rem() {
    try {
        var a: UInt32 = 126
        var b: UInt32 = UInt32(f1())
        var c = a % b;
        print("UInt32Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt32Rem:Div 0\n");
        count++
    }
}

func UInt64Div() {
    try {
        var a: UInt64 = 126
        var b: UInt64 = UInt64(f1())
        var c = a / b;
        print("UInt64Div:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt64Div:Div 0\n");
        count++
    }
}

func UInt64Rem() {
    try {
        var a: UInt64 = 126
        var b: UInt64 = UInt64(f1())
        var c = a % b;
        print("UInt64Rem:" + c.toString() + "\n")
    } catch (e: ArithmeticException) {
        print("UInt64Rem:Div 0\n");
        count++
    }
}

main(): Int64 {
    Int8Div()
    Int8Rem()
    Int16Div()
    Int16Rem()
    Int32Div()
    Int32Rem()
    Int64Div()
    Int64Rem()
    UInt8Div()
    UInt8Rem()
    UInt16Div()
    UInt16Rem()
    UInt32Div()
    UInt32Rem()
    UInt64Div()
    UInt64Rem()

    if (count == 16) {
        return 0
    }
    return 1
}
