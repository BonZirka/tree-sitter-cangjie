// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package cmp

public specific func foo(): Unit {
	println(1111111111)
}

public specific class A {
    specific var a:Int64
    public specific A(specific public var x: Int64) {
		this.a = x
	}
	public func foo() {
		println(this.a)
	}
	public specific func foo1():Unit{
		println("111111111")
	}
}

public specific struct B {
    specific var a:Int64
    public specific B(specific public var x: Int64) {
		this.a = x
	}
	public func foo() {
		println(this.a)
	}
	public specific func foo1():Unit{
		println("111111111")
	}
}

specific enum C {
    | cs
    specific func foo(): Unit { println("specific") }
    func foo1(): Unit { println("111111111") }
}