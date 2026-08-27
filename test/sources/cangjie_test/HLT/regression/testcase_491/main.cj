/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 

struct Base1 {
}

struct Base2 {
  public var bb1: Base1 = Base1()
  public var bb: Int32 = 1
}

struct Son {
  public var b1: Base1 = Base1()
  public var b2: Base2 = Base2()
  public var t: Int64 = 100
}

struct AA {
    public var a : Int32 = 10
    public func test():Int32{
        var tmp: Son = Son()
        tmp.t = 30
        tmp.b2.bb = a
        return tmp.b2.bb
    }
}


main(): Int64 {
    var num = 0
    var a : AA = AA()
    if (a.test() == 10) {
        return 0
    }
    return 1
}


