/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum TimeUnit {
    | Year
    | Month
}

main() {
    sleep(Duration.millisecond*3000)
    let x = Year
    let s = match (x) {
        case Year => "Matched"
        case TimeUnit.Month => "false"
    }
    println(s)
}
