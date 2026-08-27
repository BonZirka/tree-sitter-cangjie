/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum E1{
    AB(Rune) | CD (Rune)
}

main() {
    sleep(Duration.millisecond*3000)
    let tv = (E1.AB(r'1'), E1.CD(r'2'))
    let s = match (tv) {
        case (E1.AB(r'1'), E1.CD(r'2')) => "matched"
        case (_, _) => "someone"
    }
    println(s)
}
