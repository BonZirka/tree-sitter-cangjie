// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main() {
    let f2: ()->(String, Int64) = getNameAndAge
    println(f2()[0])
}

func getNameAndAge(): (name: String, age: Int64) {
    return ("ZhangSan", 12)
}
