/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

let a : Range<UInt32> = 129..0
var b = Int16(1)
var ab :  (Float32,Unit,String,UInt8,Int64)  = (74.0, (), "", 9, 4)
let ae : Int16 = 7
func be(bf : Range<Int32>) {
    func bg(bh ! :  (Float32,Unit,String,UInt8,Int64)  = (126.0, (), "", 4, 9), bi ! :  (Float32,Unit,String,UInt8,Int64) , bj ! : Int16, bk ! : Range<UInt32>)
        {
        match (2 % UInt16(0)  ) {
            case c =>
                0
        }
    }
    try {} finally {
        bg(bi : ab, bj : ae, bk : a)}
}
func bl() {
    let bm = be
    56..48|>bm
    }
func bn(bo ! : Unit, bp ! : Int16) {
    bl()
}
main(){
    bn(bo : (), bp : b)
}
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_divisor_is_zero


