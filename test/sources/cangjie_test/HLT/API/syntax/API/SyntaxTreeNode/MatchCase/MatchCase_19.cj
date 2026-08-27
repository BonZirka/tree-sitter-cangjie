/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    match(xxx) {
        case Date.Year(y) => ()
        case Date.Hour(y, m, d, h) => ()
        case Date.Month(x, _) => ()
        case pkgA.Date.Year(y) | Month(y, m) => ()
        case _ => ()
    }
}
