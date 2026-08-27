/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output
// RUN-EXEC: %run_stdx %output %run_args

import stdx.encoding.url.*

var form1 = Form("1=a")

main(): Int64 {
    form1.add("1", "你")
    if (case01("1") != "a") {
        return 1
    }
    return 0
}

func case01(x: String) {
    var a = form1.get(x)
    return match (a) {
        case Some(y) => y
        case None => "No"
    }
}
