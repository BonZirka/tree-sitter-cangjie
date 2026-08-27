/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.sync.*
import std.collection.ArrayList

var count: Int64 = 0

main(): Int64 {
    sleep(Duration.millisecond*3000)

    var thread_list = ArrayList<Future<Unit>>()
    var maxCoroutineNumber = 50

    for (i in 0..(maxCoroutineNumber-1)) {
        let fut = spawn {
            while (true) {
                var a = E1<String>.AB("abc").test()
                sleep(Duration.second)
            }
        }
        thread_list.add(fut)
    }
    while (true) {
        sleep(1000 * Duration.millisecond)
        count++
    }
    print("${thread_list.size}\n")
    return 0
}

enum E1<T>{
    AB(T)
    func test(){
        var a = 1
    }
}
