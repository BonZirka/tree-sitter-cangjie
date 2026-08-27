/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.pkg1


public interface I1{
    func size1_1(): Unit
}


public interface I2{
    func size1_1(): Unit {}
}


public interface I3{
    open prop  ii_1:Int64
}

public interface I4{
    static func name():Unit
}
public interface I6<T>{
    static func name_1<T>():Unit
}

public interface I7{
    static mut prop  ii_1:Int64{
        get(){1}
        set(v){}
    }

}


public interface I8<T>{
    static func name2<T>():Unit
}


public interface I9{
    func size1_2():Unit
}

public interface I10{
    func size1_1():Unit {}
}

public interface I11{
    open prop  ii12:Int64{
        get(){1}
    }
}

public interface I12<T>{
    open prop ii:Int64
}

public interface I12_1{
    open prop  ii2:Int64{
        get(){1}
    }
}

public interface I13{
    func size1_1(): Unit
}

public interface I14{
    func size1_1(): Unit
}

public interface I15{
    func size1_1(): Unit
}

public interface I16{
    static func name():Unit
    func size1(): Unit
}

public open class CA1{}
extend CA1 <: I16{
    public static func name():Unit{}
    public func size1(): Unit{}
}

public interface I20{
    func size1_2(a:Int64,b!:Float16):Unit
}
