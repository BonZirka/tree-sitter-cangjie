// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

enum TimeUnit {
    | `Year`(UInt64)
    | Month(UInt64)
}
enum Command {
    | SetTimeUnit(TimeUnit)
    | GetTimeUnit
    | Quit
}
main() {
    let command = SetTimeUnit(`Year`(2023))
    match (command) {
        case SetTimeUnit(Year(year)) => println("Set year ${year}")
        case SetTimeUnit(Month(month)) => println("Set month ${month}")
        case _ => println(println("Undefine"))
    }
}

/* SCAN
Set year 2023
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
