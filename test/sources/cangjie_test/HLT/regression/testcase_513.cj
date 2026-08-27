/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



main() {

    var arrayInt8 : Array<Int8> = [8]
    var arrayInt16 : Array<Int16> = [161, 162]
    var arrayInt32 : Array<Int32> = [321, 322, 323]
    var arrayInt64 : Array<Int64> =[641, 642, 643, 644]

    var arrayUInt8 : Array<UInt8> = [11, 12, 13, 14, 15]
    var arrayUInt16 : Array<UInt16> = [21, 22, 23, 24, 25, 26]
    var arrayUInt32 : Array<UInt32> = [31, 32, 33, 34, 35, 36, 37]
    var arrayUInt64 : Array<UInt64> = [41, 42, 43, 44, 45, 46, 47, 48]

    var arrayFloat16 : Array<Float16> = [1.1, 2.2]
    var arrayFloat32 : Array<Float32> = [32.1, 32.2, 32.3]
    var arrayFloat64 : Array<Float64> = [64.1, 64.2, 64.3, 64.4]

    var arrayChar : Array<Rune> =['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
    var arrayBool : Array<Bool> = [true, true, false, true, true, false, true, true, false, true]

    arrayBool.set(0, false)
    var arrayBool_0 = arrayBool[0]

    var slicing1 = Array<Bool>[3..]
    var slicing2 = arrayUInt64[3..-1:-1]


    var a: Array<Int8> = []
    var arraynone : Array<Int8> = Array<Int8>(a)

    return 1
}
// ASSERT: scan sema_illegal_access_non_static_member


