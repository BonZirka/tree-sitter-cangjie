/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package asan

import std.runtime.*
import std.process.*

public func asanGC(): Unit  {
    let map = Process.current.arguments
    if (map.contains("--asan")) {
        sleep(Duration.second * 2)
        GC()
        sleep(Duration.second * 2)
    }
}
