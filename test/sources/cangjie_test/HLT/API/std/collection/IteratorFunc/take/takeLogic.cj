/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
/*
   if count<0,will throw a exception
 */
public func testIterableExceptionTake<T>(itT1: Iterable<T>, count: Int64, itLength: Int64): Int64 where T <: Equatable<T> {
    var limitFunc = take<T>(count)
    try {
        var itT1Result: Iterator<T> = limitFunc(itT1)
    } catch (e: IllegalArgumentException) {
        return 0
    }
    return 1
}
/*
   itLength>=count>0,Obtains subsequences by index.
   count>itLength,Obtains all sequences
 */
public func testIterableTake<T>(itT1: Iterable<T>, count: Int64, itLength: Int64): Int64 where T <: Equatable<T> {
    var limitFunc = take<T>(count)
    var itT1Result = limitFunc(itT1)
    var arrActual = ArrayList<T>()
    var arrExpectOrigin = ArrayList<T>()
    for (i in itT1Result) {
        arrActual.add(i)
    }
    for (i in itT1) {
        arrExpectOrigin.add(i)
    }
    var indexFinal = count
    if (count > itLength) {
        indexFinal = itLength
    }
    if (itLength == 0) {
        return arrActual.size
    }
    var arrExpect = arrExpectOrigin[0..indexFinal]
    if (arrActual != arrExpect) {
        return 1
    }
    return 0
}
