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

interface I3<T1,T2> {
    func foo3(a: T1): Int64 
    func foo1(a: T1): Int64 
    {
        return 1
    }
}



struct R1<T> <: I3<T,T> {
    // 成员变量
    public var width: T
    public var length: T

    public init (width: T, length: T) {
        this.width = width
        this.length = length
    }
    public func foo3(a: T): Int64 {
        return 9
    }
    public func foo1(a: T): Int64 {
        return 1
    }

}

main(){
	var r1:R1<Int64> = R1(10,10)
	r1.foo1(2)
	r1.foo3(10)
	return 0
}


