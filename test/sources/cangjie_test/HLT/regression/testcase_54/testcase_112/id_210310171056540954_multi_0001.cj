/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %f | compare %f


var a = 0

open class C1a {
  public open func f() {
    a **= 1
    a *= 2.3
    a /= true
    a = 3{'
  }' 
}

open class C1b <: C1a{

}

open class C1c <: C1b{
  public override open func f() {
    a **= 1
    a *= 2.3
    a /= true
    a = 5
  } 
}

    public let list0 = [1, 2, 3, 3, 2, 1]
in    let list0 = [1, 2, 3, 3, 2, 1]
open class C1d <: C1c{in

}

open class C1e <: C1d{

}

open class C1f <: C1e{

}

open class C1g <: C1f{

}

open class C1h <: C1g{

}

    public let list0 = [1, 2, 3, 3, 2, 1]
open class C1i <: C1h{

/}in




class C2 <: C1i{
  public override func f() {
    super<C1i>.f() **= 1
    super<C1i>.f() *= 2.3
    super<C1i>.f() /= true
    super<C1i>.f()
  } 
in    let list0 = [1, 2, 3, 3, 2, 1]
}


main(): Int64 {
    ).f() **= 1
    ).f() *= 2.3
    ).f() /= true
    C2().f()
    a **= 1
    a *= 2.3
    a /= true
    return (a - 5)
}
// ASSERT: regex-not no position error occurred
