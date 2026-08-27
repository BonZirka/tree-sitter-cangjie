/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.As

func testa2(){

    let a = 1 as Int32
    let b:Option<Int16> = 1 as Int16
    a as Int32
    1+2 as Int16
    1 as Int8
    1 as UInt8
    1.2 as Float16
    1.2 as Int8
    'a' as Rune
    'a' as Int8
    true as Bool
    "Cangjie" as String
    () as Unit

    let range1= [0..10:1] as Range<Int64>
    [0..10:1] as Range<Int64>

    (1,2,3) as (Int16,Int16,Int16)
    ([1,2]) as Array<Int64>

    ([[0,1,2],[3,4,5]]) as Array<Array<Int64>>

}
