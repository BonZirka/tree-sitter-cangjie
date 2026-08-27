/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package myType.p0
// 注解。

// 空的注解。
@Annotation
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
public class A0 {
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
    public const init() {}
}

// 标准普通注解。
@Annotation
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
public class A1 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_0: Int64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_2: Float16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_3: Rune
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_4: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_5: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a1_public_readonly_instance_member_variable_6: Bool
	
	// 静态成员变量。
	// 公开可变静态成员函数。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a1_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a1_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init() {
		this.a1_public_readonly_instance_member_variable_0 = 12
		this.a1_public_readonly_instance_member_variable_1 = "kiki"
		this.a1_public_readonly_instance_member_variable_2 = 1.2
		this.a1_public_readonly_instance_member_variable_3 = 'a'
		this.a1_public_readonly_instance_member_variable_4 = C10()
		this.a1_public_readonly_instance_member_variable_5 = C10()
		this.a1_public_readonly_instance_member_variable_6 = true
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: Int64
	) {
		this.a1_public_readonly_instance_member_variable_0 = p0
		this.a1_public_readonly_instance_member_variable_1 = "do you love me"
		this.a1_public_readonly_instance_member_variable_2 = 3.14
		this.a1_public_readonly_instance_member_variable_3 = 'b'
		this.a1_public_readonly_instance_member_variable_4 = C10()
		this.a1_public_readonly_instance_member_variable_5 = C10()
		this.a1_public_readonly_instance_member_variable_6 = false
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: Bool,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p1: Rune
	) {
		this.a1_public_readonly_instance_member_variable_0 = 12
		this.a1_public_readonly_instance_member_variable_1 = "kiki"
		this.a1_public_readonly_instance_member_variable_2 = 1.2
		this.a1_public_readonly_instance_member_variable_3 = p1
		this.a1_public_readonly_instance_member_variable_4 = C10()
		this.a1_public_readonly_instance_member_variable_5 = C10()
		this.a1_public_readonly_instance_member_variable_6 = p0
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: String,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p1!: Float16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p2!: C10,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p3!: C10
	) {
		this.a1_public_readonly_instance_member_variable_0 = 12
		this.a1_public_readonly_instance_member_variable_1 = p0
		this.a1_public_readonly_instance_member_variable_2 = p1
		this.a1_public_readonly_instance_member_variable_3 = 'a'
		this.a1_public_readonly_instance_member_variable_4 = p2
		this.a1_public_readonly_instance_member_variable_5 = p3
		this.a1_public_readonly_instance_member_variable_6 = false
	}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a1_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a1_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a1_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a1_public_instance_member_function_1(): Int16 {
		throw Exception("exception from instance member function")
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a1_public_instance_member_function_2(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: UInt32,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p1: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p2: Float32
	): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_0(
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: UInt16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p1: Rune,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p2: Float16,
		@A0
		@A1[12]
		@A2[true, 'a']
		@A3[false, 'b']
		@A4[1.2, 'q', p2: "hello", p3: 14]
		@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p3: C1
	): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune,
		p2!: Float16
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_1(
		p0: String,
		p1: UInt32,
		p2: C1
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_1(
		p0: String,
		p1: UInt32
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_1(
		p0: String
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a1_public_static_member_function_2(
		p0: String
	): Float64 {
		throw Exception("exception from instance member function")
	}
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a1_static_member_function_0(
		p0: Unit,
		p1: C1
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a1_static_member_function_1(
		p0: Unit
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a1_static_member_function_1(): Unit {}

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut prop a1_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open mut prop a1_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public prop a1_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open prop a1_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut static prop a1_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static prop a1_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 继承自抽象类的注解类。
@Annotation
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
public class A2 <: C11 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_0: Int64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_2: Float16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_3: Rune
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_4: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_5: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a2_public_readonly_instance_member_variable_6: Bool
	
	// 静态成员变量。
	// 公开可变静态成员函数。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a2_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a2_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init() {
		this.a2_public_readonly_instance_member_variable_0 = 12
		this.a2_public_readonly_instance_member_variable_1 = "kiki"
		this.a2_public_readonly_instance_member_variable_2 = 1.2
		this.a2_public_readonly_instance_member_variable_3 = 'a'
		this.a2_public_readonly_instance_member_variable_4 = C10()
		this.a2_public_readonly_instance_member_variable_5 = C10()
		this.a2_public_readonly_instance_member_variable_6 = true
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		p0: Int64
	) {
		this.a2_public_readonly_instance_member_variable_0 = p0
		this.a2_public_readonly_instance_member_variable_1 = "do you love me"
		this.a2_public_readonly_instance_member_variable_2 = 3.14
		this.a2_public_readonly_instance_member_variable_3 = 'b'
		this.a2_public_readonly_instance_member_variable_4 = C10()
		this.a2_public_readonly_instance_member_variable_5 = C10()
		this.a2_public_readonly_instance_member_variable_6 = false
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		p0: Bool,
		p1: Rune) {
		this.a2_public_readonly_instance_member_variable_0 = 12
		this.a2_public_readonly_instance_member_variable_1 = "kiki"
		this.a2_public_readonly_instance_member_variable_2 = 1.2
		this.a2_public_readonly_instance_member_variable_3 = p1
		this.a2_public_readonly_instance_member_variable_4 = C10()
		this.a2_public_readonly_instance_member_variable_5 = C10()
		this.a2_public_readonly_instance_member_variable_6 = p0
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		p0: String,
		p1!: Float16,
		p2!: C10,
		p3!: C10
	) {
		this.a2_public_readonly_instance_member_variable_0 = 12
		this.a2_public_readonly_instance_member_variable_1 = p0
		this.a2_public_readonly_instance_member_variable_2 = p1
		this.a2_public_readonly_instance_member_variable_3 = 'a'
		this.a2_public_readonly_instance_member_variable_4 = p2
		this.a2_public_readonly_instance_member_variable_5 = p3
		this.a2_public_readonly_instance_member_variable_6 = false
	}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a2_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a2_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a2_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a2_public_instance_member_function_1(): Int16 { throw Exception("exception from instance member function") }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a2_public_instance_member_function_2(
		p0: UInt32,
		p1: Rune,
		p2: Float32
	): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_0(
		p0: UInt16,
		p1: Rune,
		p2: Float16,
		p3: C1
	): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune,
		p2!: Float16
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_1(
		p0: String,
		p1: UInt32,
		p2: C1
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_1(
		p0: String,
		p1: UInt32
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_1(
		p0: String
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a2_public_static_member_function_2(
		p0: String
	): Float64 {
		throw Exception("exception from instance member function")
	}
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a2_static_member_function_0(
		p0: Unit,
		p1: C1
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a2_static_member_function_1(
		p0: Unit
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a2_static_member_function_1(): Unit {}

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut prop a2_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open mut prop a2_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public prop a2_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open prop a2_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut static prop a2_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static prop a2_public_readonly_static_member_property_0: String { get() { "hello" } }

	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func c11_public_abstract_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func c11_public_abstract_instance_member_function_1(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func c11_public_abstract_instance_member_function_2(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut prop c11_public_abstract_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public prop c11_public_abstract_readonly_instance_member_property_0: String { get() { "hello" } }
}

// 继承自开放类的注解类。
@Annotation
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
public class A3 <: C12 {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_0: Int64
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_1: String
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_2: Float16
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_3: Rune
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_4: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_5: C10
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a3_public_readonly_instance_member_variable_6: Bool
	
	// 静态成员变量。
	// 公开可变静态成员函数。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a3_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a3_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init() {
		this.a3_public_readonly_instance_member_variable_0 = 12
		this.a3_public_readonly_instance_member_variable_1 = "kiki"
		this.a3_public_readonly_instance_member_variable_2 = 1.2
		this.a3_public_readonly_instance_member_variable_3 = 'a'
		this.a3_public_readonly_instance_member_variable_4 = C10()
		this.a3_public_readonly_instance_member_variable_5 = C10()
		this.a3_public_readonly_instance_member_variable_6 = true
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
		p0: Int64
	) {
		this.a3_public_readonly_instance_member_variable_0 = p0
		this.a3_public_readonly_instance_member_variable_1 = "do you love me"
		this.a3_public_readonly_instance_member_variable_2 = 3.14
		this.a3_public_readonly_instance_member_variable_3 = 'b'
		this.a3_public_readonly_instance_member_variable_4 = C10()
		this.a3_public_readonly_instance_member_variable_5 = C10()
		this.a3_public_readonly_instance_member_variable_6 = false
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(p0: Bool, p1: Rune) {
		this.a3_public_readonly_instance_member_variable_0 = 12
		this.a3_public_readonly_instance_member_variable_1 = "kiki"
		this.a3_public_readonly_instance_member_variable_2 = 1.2
		this.a3_public_readonly_instance_member_variable_3 = p1
		this.a3_public_readonly_instance_member_variable_4 = C10()
		this.a3_public_readonly_instance_member_variable_5 = C10()
		this.a3_public_readonly_instance_member_variable_6 = p0
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(p0: String, p1!: Float16, p2!: C10, p3!: C10) {
		this.a3_public_readonly_instance_member_variable_0 = 12
		this.a3_public_readonly_instance_member_variable_1 = p0
		this.a3_public_readonly_instance_member_variable_2 = p1
		this.a3_public_readonly_instance_member_variable_3 = 'a'
		this.a3_public_readonly_instance_member_variable_4 = p2
		this.a3_public_readonly_instance_member_variable_5 = p3
		this.a3_public_readonly_instance_member_variable_6 = false
	}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a3_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a3_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a3_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a3_public_instance_member_function_1(): Int16 { throw Exception("exception from instance member function") }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a3_public_instance_member_function_2(p0: UInt32, p1: Rune, p2: Float32): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_0(p0: UInt16, p1: Rune, p2: Float16, p3: C1): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_0(p0: UInt16, p1!: Rune, p2!: Float16): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_0(p0: UInt16, p1!: Rune): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_1(p0: String, p1: UInt32, p2: C1): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_1(p0: String, p1: UInt32): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_1(p0: String): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a3_public_static_member_function_2(p0: String): Float64 { throw Exception("exception from instance member function") }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a3_static_member_function_0(p0: Unit, p1: C1): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a3_static_member_function_1(p0: Unit): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a3_static_member_function_1(): Unit {}

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut prop a3_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open mut prop a3_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public prop a3_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open prop a3_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut static prop a3_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static prop a3_public_readonly_static_member_property_0: String { get() { "hello" } }
}

// 拥有泛型的注解类。
@Annotation
@A0
@A1[12]
@A2[true, 'a']
@A3[false, 'b']
@A4[1.2, 'q', p2: "hello", p3: 14]
public class A4<G0, G1, G2, G3> {
	// 成员变量。
	// 实例成员变量。
	// 公开可变实例成员变量。
	// 公开只读实例成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a4_public_readonly_instance_member_variable_0: G0
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a4_public_readonly_instance_member_variable_1: G1
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a4_public_readonly_instance_member_variable_2: G2
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public let a4_public_readonly_instance_member_variable_3: G3
	
	// 静态成员变量。
	// 公开可变静态成员函数。
	// 公开只读静态成员变量。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a4_public_readonly_static_member_variable_0: String = "do you love me"
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static let a4_public_readonly_static_member_variable_1: Int64 = 13

	// 构造器
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public const init(
		p0: G0,
		p1: G1,
		p2!: G2,
		p3!: G3
	) {
		this.a4_public_readonly_instance_member_variable_0 = p0
		this.a4_public_readonly_instance_member_variable_1 = p1
		this.a4_public_readonly_instance_member_variable_2 = p2
		this.a4_public_readonly_instance_member_variable_3 = p3
	}

	// 成员函数。
	// 实例成员函数。
	// 公开开放实例成员函数，因为 C7 不是开放类，所以这些函数并不是真的开放，编译会报警告但不会报错。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a4_public_open_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open func a4_public_open_instance_member_function_1(): Int16 { 12 }

	// 公开实例成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a4_public_instance_member_function_0(): Int16 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a4_public_instance_member_function_1(): Int16 {
		throw Exception("exception from instance member function")
	}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public func a4_public_instance_member_function_2(
		p0: UInt32,
		p1: Rune,
		p2: Float32
	): Int16 { 12 }

	// 公开静态成员函数
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_0(
		p0: UInt16,
		p1: Rune,
		p2: Float16,
		p3: C1
	): UInt32 { 12 }
	// 带有命名形参的成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune,
		p2!: Float16
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_0(
		p0: UInt16,
		p1!: Rune
	): UInt32 { 12 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_1(
		p0: String,
		p1: UInt32,
		p2: C1
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_1(
		p0: String,
		p1: UInt32
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_1(
		p0: String
	): Float64 { 12.9 }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static func a4_public_static_member_function_2(
		p0: String
	): Float64 { throw Exception("exception from instance member function") }
	// 静态成员函数不能是开放的。

	// 静态成员函数。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a4_static_member_function_0(
		p0: Unit,
		p1: C1
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a4_static_member_function_1(
		p0: Unit
	): Unit {}
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	static func a4_static_member_function_1(): Unit {}

	// 成员属性。
	// 非抽象类中不允许定义抽象成员属性。
	// 实例成员属性。
	// 可变实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut prop a4_public_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open mut prop a4_public_open_mutable_instance_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读实例成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public prop a4_public_readonly_instance_member_property_0: String { get() { "hello" } }
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public open prop a4_public_open_readonly_instance_member_property_0: String { get() { "hello" } }

	// 静态成员属性。
	// 可变静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public mut static prop a4_public_mutable_static_member_property_0: Int8 { get() { 12 } set(v) {} }
	// 只读静态成员属性。
	@A0
	@A1[12]
	@A2[true, 'a']
	@A3[false, 'b']
	@A4[1.2, 'q', p2: "hello", p3: 14]
	@A4[C10(), 2.3f32, p2: true, p3: 2.4]
	public static prop a4_public_readonly_static_member_property_0: String { get() { "hello" } }
}


