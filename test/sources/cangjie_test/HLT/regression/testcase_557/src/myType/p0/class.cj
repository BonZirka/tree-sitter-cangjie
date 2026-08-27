/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package myType.p0
// class 数据类型。

// 非公开 class 类型。
class non_public_class {}

// 空的类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C0 {}
// 标准普通公开类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C1 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c1_public_mutable_instance_member_variable_0: String = "kiki"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c1_public_mutable_instance_member_variable_1: Int64 = 12
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c1_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c1_public_mutable_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c1_public_mutable_static_member_variable_1: Int64 = 12
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c1_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c1_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Int64
	) {
		throw Exception("init exception.")
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Bool,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Rune
	) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c1_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c1_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c1_public_instance_member_function_0(p0: Float32, p1: C1, p2: C1, p3: Float64): Int16 { 12 }
	public func c1_public_instance_member_function_0(p0: Float32, p1: C2, p2: I1, p3: Float64): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c1_public_instance_member_function_1(): Int16 { throw Exception("exception from instance member function") }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c1_public_instance_member_function_2(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: UInt32,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p2: Float32
	): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_0(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: UInt16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p2: Float16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p3: C1
	): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_0(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: UInt16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1!: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p2!: Float16
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_0(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: UInt16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1!: Rune
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_1(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: String,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: UInt32,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p2: C1
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_1(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: String,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: UInt32
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_1(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: String
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c1_public_static_member_function_2(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: String
	): Float64 { throw Exception("exception from instance member function") }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c1_static_member_function_0(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Float64,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: C1
	): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c1_static_member_function_1(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Float64
	): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c1_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	private var _c1_public_mutable_instance_member_property_0: Int8 = 12
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c1_public_mutable_instance_member_property_0: Int8 {
		get() { _c1_public_mutable_instance_member_property_0 }
		set(v) { _c1_public_mutable_instance_member_property_0 = v }
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open mut prop c1_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c1_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open prop c1_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	private static var shadow: Int8 = 12
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c1_public_mutable_static_member_property_0: Int8 { get() { shadow } set(v) { shadow = v } }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c1_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 可被继承的类，但不是抽象类，所以里面不能定义任何抽象成员函数或抽象成员属性。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public sealed open class C2 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c2_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c2_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c2_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c2_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，C1 被 open 修饰，所以可被继承，其中可以定义 open 成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c2_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c2_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c2_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c2_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c2_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	static func c2_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	static func c2_static_member_function_1(p0: Float64): Float64 { 1.2 }
	static func c2_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	public mut prop c2_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	public prop c2_public_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	public mut static prop c2_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c2_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 标准抽象类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public abstract class C3 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c3_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c3_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c3_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c3_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(
		p0: Int64
	) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(
		p0: Bool,
		p1: Rune
	) {}

	// 成员函数。
	// 实例成员函数。
	// C5 是抽象类，所以可被继承，其中可以定义开放成员函数和抽象成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c3_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c3_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开抽象实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c3_public_abstract_instance_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c3_public_abstract_instance_member_function_1(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c3_public_abstract_instance_member_function_2(): Int16

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c3_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c3_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c3_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c3_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c3_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	public static func c3_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	public static func c3_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	public static func c3_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。
	// 静态成员函数不能是抽象的。

	// 静态成员函数。
	static func c3_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	static func c3_static_member_function_1(p0: Float64): Float64 { 1.2 }
	static func c3_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	// 公开可变实例成员属性。
	public mut prop c3_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 公开开放可变实例成员属性。
	public open mut prop c3_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 公开抽象可变实例成员属性。
	public mut prop c3_public_abstract_mutable_instance_member_property_0: Int8
	// 只读实例成员属性。
	// 公开只读实例成员属性。
	public prop c3_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开开放只读实例成员属性。
	public open prop c3_public_open_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	public prop c3_public_abstract_readonly_instance_member_property_0: String

	// 静态成员属性。
	// 可变静态成员属性。
	public mut static prop c3_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c3_public_readonly_static_member_property_0: String { get() { "hello" } }
	// 静态成员属性不能是开放的。
	// 静态成员属性不能是抽象的。
}

// 继承自开放类的类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public open class C4 <: C2 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	public var c4_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	public let c4_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	public static var c4_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	public static let c4_public_readonly_static_member_variable_0 = 13

	// 构造器
	public init() {}
	public init(p0: Int64) {}
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A1[12]
	public open func c4_public_open_instance_member_function_0(): Int16 { 12 }
	@A1[12]
	public open func c4_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A1[12]
	public func c4_public_instance_member_function_0(): Int16 { 12 }
	@A1[12]
	public func c4_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A1[12]
	public static func c4_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A1[12]
	public static func c4_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A1[12]
	public static func c4_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A1[12]
	public static func c4_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A1[12]
	public static func c4_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A1[12]
	public static func c4_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A1[12]
	static func c4_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A1[12]
	static func c4_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A1[12]
	static func c4_static_member_function_1(): Float64 { 1.2 }

	// C4 作为子类使用 override 覆盖父类 C2 中的实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public override func c2_public_open_instance_member_function_0(): Int16 { 13 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public override func c2_public_open_instance_member_function_1(): Int16 { 13 }

	// C4 作为子类使用 redef 重定义父类 C2 中的静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public redef static func c2_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 13 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public redef static func c2_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 13 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	public mut prop c4_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	public open mut prop c4_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	public prop c4_public_readonly_instance_member_property_0: String { get() { "hello" } }
	public open prop c4_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	public mut static prop c4_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c4_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 实现了一个接口的类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C5 <: I1 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	public var c5_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	public let c5_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	public static var c5_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	public static let c5_public_readonly_static_member_variable_0 = 13

	// 构造器
	public init() {}
	public init(p0: Int64) {}
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	public open func c5_public_open_instance_member_function_0(): Int16 { 12 }
	public open func c5_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	public func c5_public_instance_member_function_0(): Int16 { 12 }
	public func c5_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	public static func c5_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	public static func c5_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	public static func c5_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	public static func c5_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	public static func c5_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	public static func c5_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	static func c5_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	static func c5_static_member_function_1(p0: Float64): Float64 { 1.2 }
	static func c5_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	public mut prop c5_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	public open mut prop c5_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	public prop c5_public_readonly_instance_member_property_0: String { get() { "hello" } }
	public open prop c5_public_open_readonly_instance_member_property_0: String { get() { "hello" } }
	// 实现自 I1 的实例成员属性。
	public mut prop i1_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	public mut prop i1_public_abstract_mutable_instance_member_property_1: Int8 { get() { 12 } set(v) {} }
	public prop i1_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }
	public prop i1_public_abstract_readonly_instance_member_property_1: String { get() { "world" } }
	public prop i1_public_abstract_readonly_instance_member_property_2: String { get() { "kiki" } }

	// 静态成员属性。
	// 可变静态成员属性。
	public static mut prop c5_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c5_public_readonly_static_member_property_0: String { get() { "hello" } }
	// 实现自 I1 的静态成员属性。
	public static mut prop i1_public_abstract_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	public static prop i1_public_abstract_readonly_static_member_property_0: Int64 { get() { 12 } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i1_public_abstract_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i1_public_abstract_instance_member_function_1(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_1(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Int64,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Bool
	): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_2(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_3(p0: Rune, p1: Float64): Int16 { 12 }
}
// 继承自抽象类的类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C6 <: C3 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	public var c6_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	public let c6_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	public static var c6_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	public static let c6_public_readonly_static_member_variable_0 = 13

	// 构造器
	public init() {}
	public init(p0: Int64) {}
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	public open func c6_public_open_instance_member_function_0(): Int16 { 12 }
	public open func c6_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	public func c6_public_instance_member_function_0(): Int16 { 12 }
	public func c6_public_instance_member_function_1(): Int16 { 12 }

	// C6 作为抽象类 C3 的非抽象类子类，实现的公开实例成员函数。
	public func c3_public_abstract_instance_member_function_0(): Int16 { 12 }
	public func c3_public_abstract_instance_member_function_1(): Int16 { 12 }
	public open func c3_public_abstract_instance_member_function_2(): Int16 { 12 }

	// 公开静态成员函数
	public static func c6_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	public static func c6_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	public static func c6_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	public static func c6_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	public static func c6_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	public static func c6_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	static func c6_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	static func c6_static_member_function_1(p0: Float64): Float64 { 1.2 }
	static func c6_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	public mut prop c6_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	public open mut prop c6_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// C6 作为抽象类 C3 的非抽象子类，实现的可变实例成员属性。
	public mut prop c3_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }

	// 只读实例成员属性。
	public prop c6_public_readonly_instance_member_property_0: String { get() { "hello" } }
	public open prop c6_public_open_readonly_instance_member_property_0: String { get() { "hello" } }
	// C6 作为抽象类 C3 的非抽象子类，实现的只读实例成员属性。
	public prop c3_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	public mut static prop c6_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c6_public_readonly_static_member_property_0: String { get() { "hello" } }
}
// 拥有泛型的普通公开类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C7<G1, G2, G3, G4> {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	public var c7_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	public let c7_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	public static var c7_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	public static let c7_public_readonly_static_member_variable_0 = 13

	// 构造器
	public init() {}
	public init(p0: Int64) {}
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	public open func c7_public_open_instance_member_function_0(): Int16 { 12 }
	public open func c7_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	public func c7_public_instance_member_function_0(): Int16 { 12 }
	public func c7_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	public static func c7_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	public static func c7_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	public static func c7_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	public static func c7_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	public static func c7_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	public static func c7_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	static func c7_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	static func c7_static_member_function_1(p0: Float64): Float64 { 1.2 }
	static func c7_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	public mut prop c7_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	public open mut prop c7_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	public prop c7_public_readonly_instance_member_property_0: String { get() { "hello" } }
	public open prop c7_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	public mut static prop c7_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	public static prop c7_public_readonly_static_member_property_0: String { get() { "hello" } }
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C8 <: I1 & I2 & I3 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c8_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c8_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c8_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c8_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c8_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c8_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c8_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c8_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c8_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c8_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c8_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c8_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c8_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open mut prop c8_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c8_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open prop c8_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c8_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c8_public_readonly_static_member_property_0: String { get() { "hello" } }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_1(p0: Int64, p1: Bool): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_2(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i1_public_abstract_static_member_function_3(p0: Rune, p1: Float64): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i1_public_abstract_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i1_public_abstract_instance_member_function_1(): Float64 { 1.2 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static mut prop i1_public_abstract_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop i1_public_abstract_readonly_static_member_property_0: Int64 { get() { 12 } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i1_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i1_public_abstract_mutable_instance_member_property_1: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i1_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i1_public_abstract_readonly_instance_member_property_1: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i1_public_abstract_readonly_instance_member_property_2: String { get() { "hello" } }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i2_public_abstract_static_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i2_public_abstract_static_member_function_1(p0: Int64, p1: Bool): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i2_public_abstract_static_member_function_2(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i2_public_abstract_static_member_function_3(p0: Rune, p1: Float64): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i2_public_abstract_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i2_public_abstract_instance_member_function_1(): Float64 { 1.2 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static mut prop i2_public_abstract_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop i2_public_abstract_readonly_static_member_property_0: Int64 { get() { 12 } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i2_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i2_public_abstract_mutable_instance_member_property_1: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i2_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i2_public_abstract_readonly_instance_member_property_1: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i2_public_abstract_readonly_instance_member_property_2: String { get() { "hello" } }
	
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i3_public_abstract_static_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i3_public_abstract_static_member_function_1(p0: Int64, p1: Bool): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i3_public_abstract_static_member_function_2(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func i3_public_abstract_static_member_function_3(p0: Rune, p1: Float64): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i3_public_abstract_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func i3_public_abstract_instance_member_function_1(): Float64 { 1.2 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static mut prop i3_public_abstract_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop i3_public_abstract_readonly_static_member_property_0: Int64 { get() { 12 } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i3_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop i3_public_abstract_mutable_instance_member_property_1: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i3_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i3_public_abstract_readonly_instance_member_property_1: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop i3_public_abstract_readonly_instance_member_property_2: String { get() { "hello" } }	
}

@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public open class C9 <: C4 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public var c9_public_mutable_instance_member_variable_0: String = "kiki"
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c9_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开可变静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static var c9_public_mutable_static_member_variable_0 = "do you love me"
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c9_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c9_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c9_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c9_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c9_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c9_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c9_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c9_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c9_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c9_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open mut prop c9_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c9_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open prop c9_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c9_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c9_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 常量 class 类型。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public class C10 {
	// 成员变量。
	// 实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c10_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c10_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c10_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c10_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c10_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c10_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c10_public_instance_member_function_1(): Int16 { throw Exception("exception from instance member function") }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c10_public_instance_member_function_2(p0: UInt32, p1: Rune, p2: Float32): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_1(p0: String): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c10_public_static_member_function_2(p0: String): Float64 { throw Exception("exception from instance member function") }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c10_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c10_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c10_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c10_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open mut prop c10_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c10_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open prop c10_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c10_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c10_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 常量抽象类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public abstract class C11 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c11_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c11_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// C5 是抽象类，所以可被继承，其中可以定义开放成员函数和抽象成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c11_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c11_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开抽象实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c11_public_abstract_instance_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c11_public_abstract_instance_member_function_1(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c11_public_abstract_instance_member_function_2(): Int16

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c11_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c11_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c11_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。
	// 静态成员函数不能是抽象的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c11_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c11_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c11_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	// 公开可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c11_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 公开开放可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open mut prop c11_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 公开抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c11_public_abstract_mutable_instance_member_property_0: Int8
	// 只读实例成员属性。
	// 公开只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c11_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开开放只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open prop c11_public_open_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c11_public_abstract_readonly_instance_member_property_0: String

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c11_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c11_public_readonly_static_member_property_0: String { get() { "hello" } }
	// 静态成员属性不能是开放的。
	// 静态成员属性不能是抽象的。
}

// 常量开放的类。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public sealed open class C12 {
	// 成员变量。
	// 实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public let c12_public_readonly_instance_member_variable_0: Int64 = 12
	// 静态成员变量。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static let c12_public_readonly_static_member_variable_0 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init() {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Int64) {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public const init(p0: Bool, p1: Rune) {}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，C1 被 open 修饰，所以可被继承，其中可以定义 open 成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c12_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public open func c12_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c12_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public func c12_public_instance_member_function_1(): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static func c12_public_static_member_function_1(p0: String): Float64 { 12.9 }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c12_static_member_function_0(p0: Float64, p1: C1): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c12_static_member_function_1(p0: Float64): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func c12_static_member_function_1(): Float64 { 1.2 }

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut prop c12_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public prop c12_public_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public mut static prop c12_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	public static prop c12_public_readonly_static_member_property_0: String { get() { "hello" } }
}



