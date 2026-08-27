/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import std.collection.*
import std.runtime.*

var globalNumber: Int64 = 0

main(): Int64 {
    var rightCount = 0
    let buf = ArrayList<Future<Int64>>(10)
    var threadCount: Int64 = 10
    var index = 0
    while (index < threadCount) {
      let val:Future<Int64> = spawn {
        globalNumber+=10
        return globalNumber
      }
      buf.add(val)
      index++
    }

    GC()

    index = 0
    while (index < threadCount) {
      try {
        let res: Int64 = buf.get(index).getOrThrow().get()
        rightCount++
      } catch(_) {
        print("error\n")
      }
      index++
    }
    if (rightCount == threadCount) {
      print((threadCount).toString() + "\n")
    }
    return 0
}



