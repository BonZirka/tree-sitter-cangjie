/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    match(xxx) {
        case Year(y) => ()
        case Hour(y, m, d, h) where y > 0.0f32 && m > 0.0f32 && d > 0.0f32 && h > 0.0f32 => ()
        case Month(x, _) => ()
        case Year(y) | Month(y, m) => ()
        case _ => ()
    }
}
