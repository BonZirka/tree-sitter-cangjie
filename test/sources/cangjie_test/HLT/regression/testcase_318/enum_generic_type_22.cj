/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

enum TimeUnit<T> { Day(T) }

struct test {
    public test(let time : TimeUnit<Int64>) {}
}

func run(): Int64 {
    let data = test(TimeUnit.Day(14))
    let time = data.time
    
    var res = match (time) {
        case Day(x) => x + 2
    }  

    if (res == 16) {
        return 0
   2} else {
        return 1
    }
}

main(): Int64 {
    return run()
}