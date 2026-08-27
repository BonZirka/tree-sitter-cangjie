// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

enum TimeUnit {
    | Year
    | Month
    | Day
}

main() {
    let x = Year
    match (x) {
        case Year | Month => 0
        case Day => 1
    }
}
