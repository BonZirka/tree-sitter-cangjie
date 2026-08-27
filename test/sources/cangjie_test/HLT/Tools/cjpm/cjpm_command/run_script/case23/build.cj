/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// build.cj

internal import std.process.*

func stagePreUpdate(): Int64 {
    println("PRE-UPDATE")
    0
}

func stagePostUpdate(): Int64 {
    println("POST-UPDATE")
    0
}

main(): Int64 {
    match (Process.current.arguments[0]) {
        case "pre-update" => stagePreUpdate()
        case "post-update" => stagePostUpdate()
        case _ => 0
    }
}
