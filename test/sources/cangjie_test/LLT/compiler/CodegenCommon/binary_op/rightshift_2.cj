// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-PIPE: %run %run_opt %output %run_args

/* Test condition: Testing right shift operation when bitwidth of right operand(unsigned int) is larger than the bitwidth of left operand(signed int).*/
func int8ToUInt16() {
    var a: Int8 = 12
    var c: UInt16 = 1
    return (a >> c) - 6
}

func int8ToUInt32() {
    var a: Int8 = 12
    var c: UInt32 = 1
    return (a >> c) - 6
}

func int8ToUInt64() {
    var a: Int8 = 12
    var c: UInt64 = 1
    return (a >> c) - 6
}

func int16ToUInt32() {
    var a: Int16 = 12
    var c: UInt32 = 1
    return (a >> c) - 6
}

func int16ToUInt64() {
    var a: Int16 = 12
    var c: UInt64 = 1
    return (a >> c) - 6
}

func int32ToUInt64() {
    var a: Int32 = 12
    var c: UInt64 = 1
    return (a >> c) - 6
}

main() {
    if (int8ToUInt16() != 0) {
        return 1
    }
    if (int8ToUInt32() != 0) {
        return 2
    }
    if (int8ToUInt64() != 0) {
        return 3
    }
    if (int16ToUInt32() != 0) {
        return 4
    }
    if (int16ToUInt64() != 0) {
        return 5
    }
    if (int32ToUInt64() != 0) {
        return 6
    }
    return 0
}
