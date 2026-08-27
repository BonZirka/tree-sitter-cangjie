/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 1
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// (not O2)RUN-EXEC-PIPE: %run %run_opt %n.%suffix %run_args 2>&1 | compare %f
// ASSERT: scan handle error: OutOfMemoryError
// ASSERT: scan handler finished
// ASSERT: scan quit normally


import std.unittest.*
import std.unittest.testmacro.*


main() {

  func handler_01(err: Error): Unit { // easy handler。will all print log
    println("handle error: ${err}")  
    println("handler finished")
  }

  Thread.handleUncaughtErrorBy(handler_01)

  spawn {
    consumeMemory()
  }

  sleep(Duration.second * 10)
  println("quit normally")

  return 0
}


public func consumeMemory() {
  let array = Array(1024*1024*1024*1024, repeat: 10)
  for (i in 0..array.size) {
    array[i] = i
  }
}

