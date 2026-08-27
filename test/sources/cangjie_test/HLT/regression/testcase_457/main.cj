/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import std.collection.{Map, HashMap}

main() {
    let map: HashMap<String, Int64> = HashMap()
    let arr1: Array<(String,Int64)> = map.toArray()

    let coll: Collection<(String,Int64)> = map
    let arr2: Array<(String,Int64)> = coll.toArray()
}


