/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package myType

// 字符类型
public let c_0: Rune = 'a'
// 转义字符
public let c_1: Rune = '\\'
public let c_2: Rune = '\b'
// unicode字符
public let c_3: Rune = '\u{4f60}'
public let c_4: Rune = '\u{597d}'
// 浮点类型

// 16位浮点数.
public let f16_0: Float16 = 1.2

// 32位浮点数.
public let f32_0: Float32 = 1.2

// 64位浮点数.
public let f64_0: Float64 = 1.2


public let f_0: () -> Unit = { => }
public let f_1: (Int8) -> Int16 = { p0: Int8 => Int16(p0) }
public let f_2: (Int16, Int32) -> Int64 = { p0: Int16, p1: Int32 => Int64(p0) + Int64(p1) }

// 基本数据类型

// 整数类型
// 有符号整数类型
// Int8
public let i8_0: Int8 = 12
public let i8_1: Int8 = -128
public let i8_2: Int8 = 127
// Int16
public let i16_0: Int16 = 12
// Int32
public let i32_0: Int32 = 12
// Int64
public let i64_0: Int64 = 12
// IntNative
public let in_0: IntNative = 12

// 无符号整数类型
// UInt8
public let u8_0: UInt8 = 12
// UInt16
public let u16_0: UInt16 = 12
// UInt32
public let u32_0: UInt32 = 12
// UInt64
public let u64_0: UInt64 = 12
// UIntNative
public let un_0: UIntNative = 12

// 区间类型
// public let r_0: 

// 字符串类型
public let s_0: String = ""
public let s_1: String = "abc"
public let s_2: String = """
Hello
World
"""

// 元组类型
public let t_0: (Int8, Int16) = (1, 2)
public let t_1: (Int32, Bool) = (3, true)

// Unit类型
public let u_0: Unit = ()
public let u_1: Unit = { => println("hello") }()

public let rune_0: Rune = 'a'
public let int_0: Int = 12

public let b_0: Bool = true
public let b_1: Bool = false

public let c1_0: C1 = C1()
public let c1_1: Any = C1()
public let c1_2: Object = C1()
let c1_3: C1 = C1()

public let c4_0: C4 = C4()
public let c4_1: C2 = C4()

public let s1_0: C1 = C1()
let s1_1: C1 = C1()

public let c5_0: C5 = C5()
public let c5_1: I1 = C5()

public type T0 = C7<Int64, Float64, C2, C1>


