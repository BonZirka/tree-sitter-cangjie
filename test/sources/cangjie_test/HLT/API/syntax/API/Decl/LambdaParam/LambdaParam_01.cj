/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main(){
    { => 42 }
    { x => x + 1 }
    { x: Int64 => x + 1 }
    { a: Int64, b: Int64 => a + b }
    { x: Int64 =>
        let result = x * 2
        return result
    }
}
