/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {
    quote((x))
    quote(quote(x))
    quote($(quote(x)))
    quote($(quote($t)))
    quote($x + 2)
    quote(1 + ($x + 1) * 2)
    quote(@PlusOne(x))
    quote(@PlusOne($x))
    quote(1 + @PlusOne(x) * 2)
}
