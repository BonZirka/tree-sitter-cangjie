/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    @M1 @M2(foo())
    @M1[a: T, b: U](a = b)
    @M1(if (a) {b} else {c})
    @pkg1.pkg2.M1[aaaaaa](
        a ** b
    )
}

