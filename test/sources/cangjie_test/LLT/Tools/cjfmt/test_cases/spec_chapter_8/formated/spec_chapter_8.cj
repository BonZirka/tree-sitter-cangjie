// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// 8.1 扩展语法
extend String {
    func printSize() {
        print(this.size)
    }
}

// 8.1.1 直接扩展
class Foo {}

extend Foo {
    func f() {}
}

main() {
    let a = Foo()
    a.f() // call extension function
}

// 8.1.2 接口扩展
// 接口扩展可以用来为现有的类型添加新功能并实现接口，增强抽象灵活性。使用接口扩展时必须要声明被实现的接口。
interface I {
    func f(): Unit
}

class Foo {}

extend Foo <: I {
    public func f() {}
}

// 对一个类型使用接口扩展功能实现接口 I，其等价于在类型声明时实现接口 I，但使用范围会受到扩展
// 导入导出的限制，详情见扩展的导入导出。
func g(i: I) {
    i.f()
}

main() {
    let a = Foo()
    g(a)
}

// 可以在同一个扩展内同时实现多个接口，多个接口之间使用 & 分开，接口的顺序没有先后关系。
interface I1 {
    func f1(): Unit
}

interface I2 {
    func f2(): Unit
}

interface I3 {
    func f3(): Unit
}

class Foo {}

extend Foo <: I1 & I2 & I3 {
    public func f1() {}
    public func f2() {}
    public func f3() {}
}

// 如果被扩展类型已经实现过某个接口，则不能通过扩展重复实现该接口，包含使用扩展实现过的接口。
interface I {
    func f(): Unit
}

class Foo <: I {
    func f(): Unit {}
}

extend Foo <: I {} // error, can not repeat the implementation of the interface

class Bar {}

extend Bar <: I {
    func f(): Unit {}
}

extend Bar <: I {} // error, already implemented through the extension can not repeat the implementation

// 如果被扩展类型已经直接实现某个非泛型接口，则不能使用扩展重新实现该接口；如果被扩展类型已经
// 直接实现某个泛型接口，则不能使用相同的类型参数扩展重新实现该接口。
interface I1 {}

class Foo <: I1 {}

extend Foo <: I1 {} // error

interface I2<T> {}

class Goo<T> <: I2<Int32> {}

extend<T> Goo<T> <: I2<Int32> {} // error

extend<T> Goo<T> <: I2<T> {} // ok

// 如果被扩展的类型已经包含接口要求的函数，则接口扩展不能再重新实现这些函数，也不会再使用接口中的默认实现。
class Foo {
    public func f() {}
}

interface I {
    func f(): Unit
}

extend Foo <: I {} // ok

extend Foo {
    public func g(): Unit {
        print("In extend!")
    }
}

interface I2 {
    func g(): Unit {
        print("In interface!")
    }
}

extend Foo <: I2 {} // ok, default implementation of g in I2 is no longer used

/*
    禁止定义孤儿扩展，孤儿扩展指的是接口扩展既不与接口（包含接口继承链上的所有接口）声明在同一个包中，也不与被扩展类型声明在同一个包中。
    即接口扩展只允许以下两种情况：
    1. 接口扩展与类型声明处在同一个包。
    2. 接口扩展实现的接口，和接口的继承链上所有未被被扩展类型实现的接口，都必须在同一个包中。其它情况的接口扩展都是不允许定义的。
 */
// package pkg1
public class Foo {}

public class Goo {}

// package pkg2
public interface Bar {}

extend Goo <: Bar {}

// package pkg3
extend Foo <: Bar {} // error

interface Sub <: Bar {}

extend Foo <: Sub {} // error

extend Goo <: Sub {} // ok, 'Goo' has implemented the interface 'Bar' on the inheritance chain in pkg2.

// 8.2 扩展的成员
// 8.2.1 函数
interface I {}

extend Int64 {
    func f<T>(a: T, b!: Int64 = 0) where T <: I {}
    func f(a: String, b: String) {}
}

// 8.2.1.1 修饰符
// 扩展内的函数的访问性修饰符默认为 internal。
// file1 in package p1
public open class Foo {}

extend Foo {
    private func f1() {} // ok
    public func f2() {} // ok
    protected func f3() {} // ok
    func f4() {} // visible in the package
}

main() {
    let a = Foo()
    a.f1() // error, can not access private function
    a.f2() // ok
    a.f3() // ok
    a.f4() // ok
}

// file2 in package p2
class Bar <: Foo {
    func f() {
        f1() // error, can not access private function
        f2() // ok
        f3() // ok
        f4() // error, can not access default function
    }
}

// 扩展内的函数支持使用 static 修饰。
class Foo {}

extend Foo {
    static func f() {}
}

// 对 struct 类型的扩展可以定义 mut 函数。
struct Foo {
    var i = 0
}

extend Foo {
    mut func f() { // ok
        i += 1
    }
}

// 扩展内的函数声明不支持使用 open、override、redef 修饰。
class Foo {
    public open func f() {}
    static func h() {}
}

// 8.2.2 属性
// 扩展可以对被扩展类型添加属性。这些属性都不能是抽象属性。
// 例如：
extend Int64 {
    mut prop i: Int64 {
        get() {
            0
        }
        set(value) {}
    }
}

// 8.2.2.1 修饰符
// 扩展内的属性的访问性修饰符默认为 internal。
// file1 in package p1
public open class Foo {}

extend Foo {
    private prop v1: Int64 { // ok
        get() {
            0
        }
    }

    public prop v2: Int64 { // ok
        get() {
            0
        }
    }

    protected prop v3: Int64 { // ok
        get() {
            0
        }
    }

    prop v4: Int64 { // visible in the package
        get() {
            0
        }
    }
}

main() {
    let a = Foo()
    a.v1 // error, can not access private property
    a.v2 // ok
    a.v3 // ok
    a.v4 // ok
}

// file2 in package p2
class Bar <: Foo {
    func f() {
        v1 // error, can not access private function
        v2 // ok
        v3 // ok
        v4 // error, can not access default function
    }
}

// 扩展内的属性支持使用 static 修饰。
class Foo {}

extend Foo {
    static prop i: Int64 {
        get() {
            0
        }
    }
}

// 扩展内的属性声明不支持使用 open、override、redef 修饰。
class Foo {
    open prop v1: Int64 {
        get() {
            0
        }
    }

    static prop v2: Int64 {
        get() {
            0
        }
    }
}

// 8.3 泛型扩展
extend Array<String> {} // ok

extend Array<Int> {} // ok

// 在扩展中，泛型类型的类型实参必须符合泛型类型声明处的约束要求，否则会编译报错。
class Foo<T> where T <: ToString {}

extend Foo<Int64> {} // ok

class Bar {}

extend Foo<Bar> {} // error

extend<T> Array<T> {} // ok

extend<T> Array<T> {} // ok

extend<T> Array<Option<T>> {} // ok

extend<T> Array<Int64> {} // error

extend<T> Int64 <: Equatable<T> {} // error

class Foo<T> where T <: ToString {}

extend<T> Foo<T> {} // T <: ToString

class Foo<T> {
    var item: T

    init(it: T) {
        item = it
    }
}

interface Eq<T> {
    func equals(other: T): Bool
}

extend<T> Foo<T> <: Eq<Foo<T>> where T <: Eq<T> {
    public func equals(other: Foo<T>) {
        item.equals(other.item)
    }
}

class A {}

class B <: Eq<B> {
    public func equals(other: B) {
        true
    }
}

main() {
    let a = Foo(A())
    a.equals(a) // error, A has not implement Eq
    let b = Foo(B())
    b.equals(b) // ok, B has implement Eq
}

// 泛型类型不能重复实现同一接口。对于同一个泛型类型，无论它是否完全实例化，都不能重复实现同一接口。如果重复实现会在编译时报错。
interface I {}

extend Array<String> <: I {} // error, can not repeatedly implement the same interface

extend<T> Array<T> <: I {} // error, can not repeatedly implement the same interface

interface Bar<T> {}

extend Array<String> <: Bar<String> {} // error, can not repeatedly implement the same interface

extend<T> Array<T> <: Bar<T> {} // error, can not repeatedly implement the same interface

// 对于同一个泛型类型，无论它是否完全实例化，都不能声明相同类型或相同签名的成员。如果重复声明会在编译时报错。
// case 1
extend Array<String> {
    func f() {} // error, cannot be repeatedly defined
}

extend<T> Array<T> {
    func f() {} // error, cannot be repeatedly defined
}

// case 2
extend Array<String> {
    func g(a: String) {} // error, cannot be repeatedly defined
}

extend<T> Array<T> {
    func g(a: T) {} // error, cannot be repeatedly defined
}

// case 3
extend<T> Array<T> where T <: Int {
    func g(a: T) {} // error, cannot be repeatedly defined
}

extend<V> Array<V> where V <: String {
    func g(a: V) {} // error, cannot be repeatedly defined
}

// case 4
extend Array<Int> {
    func g(a: Int) {} // ok
}

extend Array<String> {
    func g(a: String) {} //ok
}

// 8.4 扩展的访问和遮盖
class A {
    var v = 0
}

extend A {
    func f() {
        print(this.v) // ok
        print(v) // ok
    }
}

// 扩展不能访问被扩展类型的 private 成员，其它修饰符修饰的成员遵循可见性原则。
class A {
    private var v1 = 0
    protected var v2 = 0
}

extend A {
    func f() {
        print(v1) // error
        print(v2) // ok
    }
}

// 扩展不允许遮盖被扩展类型的任何成员。
class A {
    func f() {}
}

extend A {
    func f() {} // error
}

// 扩展也不允许遮盖被扩展类型的其它扩展中已增加的任何成员。
class A {}

extend A {
    func f() {}
}

extend A {
    func f() {} // error
}

// 在同一个 package 内对同一类型可以扩展任意多次。
// 在扩展中可以直接使用（不加任何前缀修饰）其它对同一类型的扩展中的非 private 修饰的成员。
class Foo {}

extend Foo { // OK
    private func f() {}

    func g() {}
}

extend Foo { // OK
    func h() {
        g() // OK
        f() // Error
    }
}

// 示例：假设对同一个类型 E<X> 的两个扩展分别为扩展 1 和扩展 2 ，X 的约束在扩展 1 中比扩展 2 中更
// 严格，那扩展 1 中可直接使用扩展 2 中的成员，扩展 2 中不可直接使用扩展 1 的成员。
// B <: A
class E<X> {}

interface I1 {
    func f1(): Unit
}

interface I2 {
    func f2(): Unit
}

extend<X> E<X> <: I1 where X <: B { // extension 1
    public func f1(): Unit {
        f2() // OK
    }
}

extend<X> E<X> <: I2 where X <: A { // extension 2
    public func f2(): Unit {
        f1() // Error
    }
}

// 8.5 扩展的继承
// 如果被扩展的类型是 class，那么扩展的成员会被子类继承。
open class A {}

extend A {
    func f() {}
}

class B <: A {
    func g() {
        f() // ok
    }
}

main() {
    let x = B()
    x.f() // ok
}

// 需要注意的是，如果在父类中扩展了成员，由于继承规则限制，子类中就无法再定义同名成员，同时也无法覆盖或重新实现（允许函数重载）。
open class A {}

extend A {
    func f() {}
    func g() {}
}

class B <: A {
    func f() {} // error
    override func g() {} // error
}

// 如果在同包内对同一个类型分别扩展实现父接口和子接口，那么编译器会先检查实现父接口的扩展，然后再检查实现子接口的扩展。
class Foo {}

interface I1 {
    func f() {}
}

interface I2 <: I1 {
    func g() {}
}

extend Foo <: I1 {} // first check

extend Foo <: I2 {} // second check

// The extension will not be exported because I1 is not visible outside the file.
extend<T> Foo<T> <: I1 {}

// The extension is exported. Only the package that imports both Foo and I2 can access the members of I2 in the extension.
extend<T> Foo<T> <: I2 {}

// The extension is exported, and only packages that import both Foo and I3 can access the members of I3 in the extension.
extend<T> Foo<T> <: I3 {}

// The extension is exported. Only the package that imports both Foo and (I2/I3) can access the members of the corresponding (I2/I3) in the extension.
extend<T> Foo<T> <: I1 & I2 & I3 {}

// The extension will not be exported. The I1 with the lowest access level determines the export.
extend<T> Foo<T> <: I4 where T <: I1 & I2 & I3 {}

// The extension is exported. Only the package that imports Foo, I2, I3, and I4 can access the extension.
extend<T> Foo<T> <: I4 where T <: I2 & I3 {}

// The extension will be exported and only packages that import both Foo and I2, (I3 or I4) will be able to access it.
extend<T> Foo<T> <: I4 & I3 where T <: I2 {}
