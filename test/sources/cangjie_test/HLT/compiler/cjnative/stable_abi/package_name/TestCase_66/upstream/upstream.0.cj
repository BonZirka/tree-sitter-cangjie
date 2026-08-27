/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package abc.edf

import std.reflect.*

public interface UpStreamParent<T0> <: NewParent<Float64> {
    func UpStreamParent_NonMutInstanceMemberFunction(): Unit {
        println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_NonMutInstanceMemberFunction")
    }

    mut func UpStreamParent_MutInstanceMemberFunction(): Unit {
        println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_MutInstanceMemberFunction")
    }

    static func UpStreamParent_staticMemberFunction(): Unit {
        println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_staticMemberFunction")
    }

    prop UpStreamParent_NonMutInstanceMemberProperty: Int64 {
        get() {
            println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_NonMutInstanceMemberProperty")
            114514i64
        }
    }

    mut prop UpStreamParent_MutInstanceMemberProperty: Int64 {
        get() {
            println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_MutInstanceMemberProperty")
            114514i64
        }
        set(v) {
            println("UpStreamParent<${TypeInfo.of<T0>()}>.UpStreamParent_MutInstanceMemberProperty")
        }
    }

    static prop UpStreamParent_NonMutStaticMemberProperty: Int64 {
        get() {
            println("UpStreamParent<?>.UpStreamParent_NonMutStaticMemberProperty")
            114514i64
        }
    }

    static mut prop UpStreamParent_MutStaticMemberProperty: Int64 {
        get() {
            println("UpStreamParent<?>.UpStreamParent_MutStaticMemberProperty")
            114514i64
        }
        set(v) {
            println("UpStreamParent<?>.UpStreamParent_MutStaticMemberProperty")
        }
    }
}

public interface UpStreamChild<T0> <: UpStreamParent<Float64> {}

public interface NewParent<T0> {
    public mut func NewParent_MutInstanceMemberFunction(): Unit {
        println("NewParent<${TypeInfo.of<T0>()}>.NewParent_MutInstanceMemberFunction")
    }

    public func NewParent_NonMutInstanceMemberFunction(): Unit {
        println("NewParent<${TypeInfo.of<T0>()}>.NewParent_NonMutInstanceMemberFunction")
    }

    public static func NewParent_StaticMemberFunction(): Unit {
        println("NewParent<${TypeInfo.of<T0>()}>.NewParent_StaticMemberFunction")
    }

    public mut prop NewParent_MutInstanceMemberProperty: Int64 {
        get() {
            println("NewParent<${TypeInfo.of<T0>()}>.NewParent_MutInstanceMemberProperty")
            114514i64
        }
        set(v) {
            println("NewParent<${TypeInfo.of<T0>()}>.NewParent_MutInstanceMemberProperty")
        }
    }

    public prop NewParent_NonMutInstanceMemberProperty: Int64 {
        get() {
            println("NewParent<${TypeInfo.of<T0>()}>.NewParent_NonMutInstanceMemberProperty")
            114514i64
        }
    }

    public static prop NewParent_NonMutStaticMemberProperty: Int64 {
        get() {
            println("NewParent<?>.NewParent_NonMutStaticMemberProperty")
            114514i64
        }
    }

    public static mut prop NewParent_MutStaticMemberProperty: Int64 {
        get() {
            println("NewParent<?>.NewParent_MutStaticMemberProperty")
            114514i64
        }
        set(v) {
            println("NewParent<?>.NewParent_MutStaticMemberProperty")
        }
    }
}

public func checkParent<F0>(i: UpStreamParent<F0>): Unit {
    var instance = i
    instance.UpStreamParent_NonMutInstanceMemberFunction()
    instance.UpStreamParent_MutInstanceMemberFunction()
    instance.UpStreamParent_NonMutInstanceMemberProperty
    instance.UpStreamParent_MutInstanceMemberProperty
    instance.UpStreamParent_MutInstanceMemberProperty = 1i64
    UpStreamParent<F0>.UpStreamParent_staticMemberFunction()
    UpStreamParent<F0>.UpStreamParent_NonMutStaticMemberProperty
    UpStreamParent<F0>.UpStreamParent_MutStaticMemberProperty
    UpStreamParent<F0>.UpStreamParent_MutStaticMemberProperty = 1i64
    instance.NewParent_MutInstanceMemberFunction()
    instance.NewParent_NonMutInstanceMemberFunction()
    UpStreamParent<F0>.NewParent_StaticMemberFunction()
    instance.NewParent_MutInstanceMemberProperty
    instance.NewParent_MutInstanceMemberProperty = 1i64
    instance.NewParent_NonMutInstanceMemberProperty
    UpStreamParent<F0>.NewParent_NonMutStaticMemberProperty
    UpStreamParent<F0>.NewParent_MutStaticMemberProperty
    UpStreamParent<F0>.NewParent_MutStaticMemberProperty = 1i64
}

public func checkChild<F0>(i: UpStreamChild<F0>): Unit {
    var instance = i
    instance.UpStreamParent_NonMutInstanceMemberFunction()
    instance.UpStreamParent_MutInstanceMemberFunction()
    UpStreamChild<F0>.UpStreamParent_staticMemberFunction()
    instance.UpStreamParent_NonMutInstanceMemberProperty
    instance.UpStreamParent_MutInstanceMemberProperty
    instance.UpStreamParent_MutInstanceMemberProperty = 1i64
    UpStreamChild<F0>.UpStreamParent_NonMutStaticMemberProperty
    UpStreamChild<F0>.UpStreamParent_MutStaticMemberProperty
    UpStreamChild<F0>.UpStreamParent_MutStaticMemberProperty = 1i64
}

public func checkStatic<P, T0>(): Unit where P <: UpStreamParent<T0> {
    P.UpStreamParent_staticMemberFunction()
    P.UpStreamParent_NonMutStaticMemberProperty
    P.UpStreamParent_MutStaticMemberProperty
    P.UpStreamParent_MutStaticMemberProperty = 1i64
    P.NewParent_StaticMemberFunction()
    P.NewParent_NonMutStaticMemberProperty
    P.NewParent_MutStaticMemberProperty
    P.NewParent_MutStaticMemberProperty = 1i64
}
