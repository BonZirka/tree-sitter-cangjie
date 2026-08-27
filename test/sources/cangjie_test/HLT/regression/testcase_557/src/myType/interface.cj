/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package myType

// 非公开 interface 类型。
interface non_public_interface {}

// interface 数据类型。
// 空 interface 类型。
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public interface I0 {}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public interface I1 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_abstract_static_member_function_1(
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
	): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_abstract_static_member_function_3(
		p0: Rune,
		p1: Float64
	): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_open_static_member_function_0(): Int64 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i1_public_open_static_member_function_1(): Int64 { 12 }

	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i1_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i1_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i1_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i1_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i1_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i1_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i1_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i1_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i1_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i1_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i1_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i1_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i1_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i1_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i1_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i1_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i1_public_abstract_readonly_instance_member_property_2: String
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public open sealed interface I2 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_abstract_static_member_function_1(
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
	): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_abstract_static_member_function_3(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Float64
	): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_open_static_member_function_0(): Int64 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i2_public_open_static_member_function_1(): Int64 { 12 }


	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i2_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i2_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i2_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i2_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i2_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i2_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i2_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i2_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i2_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i2_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i2_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i2_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i2_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i2_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i2_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i2_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i2_public_abstract_readonly_instance_member_property_2: String
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public sealed interface I3 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i3_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i3_public_abstract_static_member_function_1(p0: Int64, p1: Bool): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i3_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i3_public_abstract_static_member_function_3(
		p0: Rune,
		p1: Float64
	): Int16

	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i3_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i3_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i3_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i3_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i3_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i3_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i3_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i3_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i3_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i3_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i3_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i3_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i3_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i3_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i3_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i3_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i3_public_abstract_readonly_instance_member_property_2: String
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public interface I4 <: I1 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i4_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i4_public_abstract_static_member_function_1(
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
	): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i4_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i4_public_abstract_static_member_function_3(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Float64
	): Int16

	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i4_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i4_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i4_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i4_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i4_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i4_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i4_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i4_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i4_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i4_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i4_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i4_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i4_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i4_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i4_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i4_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i4_public_abstract_readonly_instance_member_property_2: String
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public interface I5 <: I1 & I2 & I3 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i5_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i5_public_abstract_static_member_function_1(
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
	): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i5_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i5_public_abstract_static_member_function_3(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p0: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 3.4f16, p2: true, p3: C10()]
		p1: Float64
	): Int16

	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i5_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i5_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i5_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i5_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i5_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i5_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i5_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i5_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i5_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i5_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i5_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i5_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i5_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i5_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i5_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i5_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i5_public_abstract_readonly_instance_member_property_2: String
}
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
@A4[C10(), 3.4f16, p2: true, p3: C10()]
public interface I6 <: I4 {
	// 1 成员函数。
	// 1.1 静态成员函数
	// 公开抽象静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i6_public_abstract_static_member_function_0(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i6_public_abstract_static_member_function_1(
		p0: Int64,
		p1: Bool
		): Int16
	// 公开抽象静态成员函数, 与不加 open 的等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i6_public_abstract_static_member_function_2(): Int16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static func i6_public_abstract_static_member_function_3(p0: Rune, p1: Float64): Int16

	// 1.2 实例成员函数。
	// 公开开放实例成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i6_public_open_instance_member_function_0(): Float64 { 1.2 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i6_public_open_instance_member_function_1(): Float64 { 1.2 }
	// interface 类型中定义的公开实例成员函数与不加 open 修饰符等价。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i6_public_open_instance_member_function_2(): Float64 { 1.2 }

	// 公开抽象实例成员函数。
	// 抽象内涵开放。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	func i6_public_abstract_instance_member_function_0(): Float64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open func i6_public_abstract_instance_member_function_1(): Float64

	// 操作符重载函数。
	// TODO.

	// 2 成员属性。
	// 2.1 静态成员属性。
	// 2.1.1 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i6_public_mutable_static_member_property_0: Int64 { get() { 12 } set(v) {} }
	// 抽象可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static mut prop i6_public_abstract_mutable_static_member_property_0: Int64
	// 2.1.2 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i6_public_readonly_static_member_property_0: Int64 { get() { 12 } }
	// 抽象只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	static prop i6_public_abstract_readonly_static_member_property_0: Int64
	// 2.2 实例成员属性。
	// 2.2.1 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i6_public_mutable_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i6_public_mutable_member_property_1: Int8 { get() { 13 } set(v) {} }
	// 抽象可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	mut prop i6_public_abstract_mutable_instance_member_property_0: Int8
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open mut prop i6_public_abstract_mutable_instance_member_property_1: Int8
	// 2.2.2 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i6_public_readonly_instance_member_property_0: String { get() { "hello" } }
	// 公开抽象只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	prop i6_public_abstract_readonly_instance_member_property_0: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i6_public_abstract_readonly_instance_member_property_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 3.4f16, p2: true, p3: C10()]
	open prop i6_public_abstract_readonly_instance_member_property_2: String
}


