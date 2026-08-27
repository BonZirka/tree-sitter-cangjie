/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file implements the report method of fuzz.
 */

package stdx.fuzz

interface IReportable {
    func report(): Unit
}

extend Exception <: IReportable {
    public func report(): Unit {
        this.printStackTrace()
    }
}

extend Error <: IReportable {
    public func report(): Unit {
        this.printStackTrace()
    }
}

func report(e: IReportable, data: Array<UInt8>) {
    println("[WARNING]: Detect uncatched exception, maybe caused by bugs, exit now")

    e.report()
    println("[INFO]: data is: ${data}")

    // Currently use the file dump function provided by libfuzzer.
    println("[INFO]: crash file will stored with libfuzzer")
}
