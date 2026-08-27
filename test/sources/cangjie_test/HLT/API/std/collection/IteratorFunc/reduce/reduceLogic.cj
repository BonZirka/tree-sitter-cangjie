/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
/*
      Use the specified initial value to traverse the sequence from left to right,
  modify the initial value based on the logic in the mapping function, and obtain
  the initial value of R after the sequence is traversed.
  params:
  initial:set Initial Value,the input parameter of the reduce function.
  operation:the input parameter of the reduce function.Generates a lamda expression.
  itT1：Input parameter of the lambda expression,Returns a value of type R.
  expectResult：Expected value of type R.
  actualResult: Actual value of type R
 */

public func testIterableReduce<T>(operation: (T, T) -> T, itT1: Iterable<T>, expectResult: T): Int64 where T <: Equatable<T> & ToString {
    var reduceFunc = reduce<T>(operation)
    var actualResult = reduceFunc(itT1)
    if (!(actualResult is Option<T>)) {
        return 1
    }
    if (actualResult != Some(expectResult)) {
        return 2
    }
    return 0
}
