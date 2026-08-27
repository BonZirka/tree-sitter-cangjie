/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %cmp_opt  %f -o %output
// RUN-EXEC: %run_stdx %output %run_args

import stdx.encoding.base64.*

func matchResult<T>(x: Option<T>, default: T): T {
    var result = match (x) {
        case Some(x) => x
        case None => default
    }
    return result
}

func getLongString(): String {
    var base64String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    var str: String = ""
    var loop = 0
    while (loop < 10) {
        str = str + base64String
        loop = loop + 1
    }
    str
}

main(): Int64 {
    var str = getLongString()
    var opt = fromBase64String(str)
    var res = matchResult<Array<UInt8>>(opt, Array<UInt8>())
    if (res.size == 480 && res[res.size - 1] == 191) {
        return 0
    }
    return 1
}
