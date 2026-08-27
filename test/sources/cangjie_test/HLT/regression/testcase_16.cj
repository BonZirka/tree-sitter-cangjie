/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

public interface Interface15 {
    func func447(): Unit {}
}
public interface Interface19 <: Interface15 {

}
public interface Interface18 <: Interface15 & Interface19 {
    func func447(): Unit {}
}

public open class Class69 <: Interface18 {
}

public open class Class1697 <: Class69 & Interface15{
    public func func447(): Unit{}
}

main(): Int64 {
    return 0;
}

extend Class69 {

}

extend Class1697 {

}
