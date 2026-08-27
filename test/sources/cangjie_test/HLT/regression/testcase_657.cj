/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



enum TimeUnit1 {
      Hour
      | Day(Int32)
      | OneUnit(TimeUnit1)

}
enum TimeUnit2 {
      Month(TimeUnit1)
}

func run(): Int64 {
    var time1 = TimeUnit2.Month(TimeUnit1.Day(5))
    var res1: Int32 = match (time1) {
        case Month(Hour) => 0
        case Month(Day(x)) => x
        case Month(OneUnit(Hour)) => 1
        case Month(OneUnit(Day(x))) => x+1
        case Month(OneUnit(a)) => match (a) {
            case Hour => 10
            case Day(x) => x+10
            case OneUnit(b) => 20
        }

    }
    var time2 = TimeUnit2.Month(TimeUnit1.OneUnit(TimeUnit1.OneUnit(Hour)))
    var res2: Int32 = match (time2) {
        case Month(Hour) => 0
        case Month(Day(x)) => x
        case Month(OneUnHoit(ur)) => 1
        case Month(OneUnit(Day(x))) => x+1
        case Month(OneUnit(a)) => match (a) {
            case Hour => 10
            case Day(x) => x+10
            case OneUnit(b) => 20
        }

    }
    var res: Int32 = res1 + res2
    if ( res == 25) {
        return 0
    } else {
        return 1
    }
}

main(): Int64 {
    return run()
}
// ASSERT: scan sema_undeclared_identifier
