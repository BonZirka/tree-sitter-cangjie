/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package p3
import std.sync.*
import std.collection.*

var count: Int64 = 0
let m = Monitor()

public func son_thread2():(Future<Unit>,Array<(Int64,String)>,Monitor){
    

    let fut = spawn {
        print("son thread: I am reading sheep 0\n")
        print("before sleep.\n")
        sleep(Duration.millisecond * 10) // sleep for 1ms.
        print("after sleep.\n")
        print("son thread: I am reading sheep 1\n")
        m.lock()
        print("locked.\n")
        count++
        m.wait()
        m.unlock()
        print("unlocked.\n") 
    }
    var returnList = [(8,"Cangjie"),(-1,"hello")]
    return (fut,returnList,m)

}

public func func_1<T1,T2,T3>(a:T1,b:T2,c:T3){
    let mydata_1 = a
    let mydata_2 = b
    let mydata_3 = c
    return mydata_3
}
