/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


interface FuncImp {
    mut func setValue(value: Int32): Unit
    func getValue(): Int32
}

struct A <: FuncImp{
    var value: Int32 = 0
    public mut func setValue(value: Int32): Unit{
        this.value = value
    }
    public func getVaule(): Int32{
        return this.value
    }
}

func setValueImpl<T>(variable:T,value: Int32): Unit where T <: A{
    variable.setValue(value)
}

func setValue(variable:FuncImp,value: Int32): Unit{
    variable.setValue(value)
}

func test(){
    let a = A()
    println("a init value: ${a.getValue()}")
    setValue(a,1)
    println("a value: ${a.getValue()}")
    setValueImpl(a,2)
    println("a value: ${a.getValue()}")
}

main(): Unit{
    test()
}
// ASSERT: scan sema_need_member_implementation
// ASSERT: scan sema_immutable_access_mutable_func


