/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan id: 0, name: 
// ASSERT: scan id: 1000, name: abs

import std.objectpool.*
import std.sync.*

class City {
    var id: Int64 = 0
    var name: String = ""
}

func resetCity(c: City): City {
    let city = c
    city.id = 1000
    city.name = ""
    return city
}

main() {
    let cityPool = ObjectPool({=> City()})
    let cityA = cityPool.get()
    cityA.id = 1000
    cityA.name = "abs"
    cityPool.put(cityA)
    let cityB = cityPool.get()
    println("id: ${cityB.id}, name: ${cityB.name}")
    cityB.id = 2000
    cityB.name = "max"
    cityPool.put(cityB)

    let fut1 = spawn {
        let city1 = cityPool.get()
        println("id: ${city1.id}, name: ${city1.name}")
    }

    let fut2 = spawn {
        let city2 = cityPool.get()
        println("id: ${city2.id}, name: ${city2.name}")
    }

    let fut3 = spawn {
        let city3 = cityPool.get()
        println("id: ${city3.id}, name: ${city3.name}")
    }

    sleep(Duration.second * 3)
    return 0
}
