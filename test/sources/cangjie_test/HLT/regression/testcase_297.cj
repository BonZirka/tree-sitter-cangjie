/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler  %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

let var_1683195130349_322 : Class_1683195130349_318 = Class_1683195130349_318()

public open class Class_1683195130349_31<T0> {
    public init() { }
}

extend<T0> Class_1683195130349_31<T0> {
    public func func_1683195130349_325()  : Unit{ }
}

public open class Class_1683195130349_318 <: Class_1683195130349_31<UInt8>  {
    init() {}
}

func func_1683195130349_314<T0, T1>(param_1683195130349_315 : UInt8) : Unit {
    var_1683195130349_322.func_1683195130349_325()
}

main(){}
