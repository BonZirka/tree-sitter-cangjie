/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

struct Point {
    let x: Int64 = 0
    let y: Int64 = 0
    operator func +(rhs: Point): Point {
        return Point(this.x - rhs.x, this.y - rhs.y)
    }
}

main(){

}
