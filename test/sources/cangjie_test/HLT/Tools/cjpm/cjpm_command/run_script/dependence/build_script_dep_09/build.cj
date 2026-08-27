/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.process.*
import script_dep_test.*
import script_dep_test_1.*

func stagePreBuild(): Int64 {
    println(aa + bb)
    println("This is stagePreBuild")
    0
}

func stagePostBuild(): Int64 {
    println(aa + bb)
    println("This is stagePostBuild")
    0
}

func stagePreRun(): Int64 {
    println(aa + bb)
    println("This is stagePreRun")
    0
}

func stagePostRun(): Int64 {
    println(aa + bb)
    println("This is stagePostRun")
    0
}

func stagePreTest(): Int64 {
    println(aa + bb)
    println("This is stagePreTest")
    0
}

func stagePostTest(): Int64 {
    println(aa + bb)
    println("This is stagePostTest ")
    0
}

main(): Int64 {
    match (Process.current.arguments[0]) {
        case "pre-build" => stagePreBuild()
        case "post-build" => stagePostBuild()
        case "pre-run" => stagePreRun()
        case "post-run" => stagePostRun()
        case "pre-test" => stagePreTest()
        case "post-test" => stagePostTest()
        case _ => 0
    }
}
