/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum TimeUnit {
    | Year(Int64)
    | Month(Int64, Int64)
    | Day(Int64, Int64, Int64)
}
class A{
    static func Year(a: Int64) {return a}
}


main() {
    return 0
}

