/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    match(xxx) {
        case opt: Point where (opt.x < 0 && opt.y > 2.0) || opt.x < -10 => println("case opt: Point => ()")
    }
}
