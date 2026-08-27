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

interface PrintSizeable {
    func printSize(): Int64
}

extend<T> Array<T> <: PrintSizeable {
    public func printSize(): Int64 {
        println("The size is ${this.size}")
        return this.size
    }
}

main():Int64 {
    let a: PrintSizeable = Array<Int64>()
    if( a.printSize() == 1 ){
        return 1
    }
    a.printSize() // 0
}
