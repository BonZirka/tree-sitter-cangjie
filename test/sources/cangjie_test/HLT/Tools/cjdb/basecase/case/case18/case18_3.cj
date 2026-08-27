/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.sync.*
import std.time.*

main(): Int64 {
    sleep(Duration.millisecond*3000)
      let fut1: Future<Int64> = spawn { =>
        println("当前fut1线程ID为：${Thread.currentThread.id},name为：${Thread.currentThread.name}")
        var f14=1.11
        var intt=Int8(f14)
        var pi = (3.14, "hello")
        var vChar:Rune ='C'
        var vFloat32:Float32 = 13.13
        var vInt16:Int16 = -16
        var vUInt16:UInt16 = 16
        var vrange = 1..10:1
        var sbf:Bool = false
        var sbt:Bool = true
        var sba = 'a'
        var sbarr = "abc"
        let runevar01:Rune='a'
        println("New thread before sleeping")
        sleep(1*Duration.Min)
        println("New thread after sleeping")
        return 0
    }
    let fut2: Future<Int64> = spawn { =>
        println("当前fut2线程ID为：${Thread.currentThread.id},name为：${Thread.currentThread.name}")
        var var1: Int8 = -128
        var var2: Int8 = 127
        var var3: Int64 = 1
        var var4: Int16 = 1
        var var5: Int32 = 1
        var var6: Int64 = 1
        var var7: UInt8 = 1
        var var8: UInt16 = 1
        var var9: UInt32 = 1
        var var10: UInt64 = 1
        println("New thread before sleeping")
        sleep(1*Duration.Min)
        println("New thread after sleeping")
        return 0
    }

    println("Main thread")

    fut1.get()
    fut1.get()
    return 0
}
