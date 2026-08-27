/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f

/* SCAN
Two BoolType instances are equal: true
BoolType == IntType: false
BoolType == FloatType: false
BoolType == UnitType: false
BoolType == NothingType: false
BoolType == RuneType: false
*/

import stdx.chir.*

main() {
    let boolType1 = BoolType.get()
    let boolType2 = BoolType.get()
    println("Two BoolType instances are equal: ${boolType1 == boolType2}")
    
    // Compare with other types
    let intType = IntType.getInt32()
    let floatType = FloatType.getFloat32()
    let unitType = UnitType.get()
    let nothingType = NothingType.get()
    let runeType = RuneType.get()
    
    println("BoolType == IntType: ${boolType1 == intType}")
    println("BoolType == FloatType: ${boolType1 == floatType}")
    println("BoolType == UnitType: ${boolType1 == unitType}")
    println("BoolType == NothingType: ${boolType1 == nothingType}")
    println("BoolType == RuneType: ${boolType1 == runeType}")
}
