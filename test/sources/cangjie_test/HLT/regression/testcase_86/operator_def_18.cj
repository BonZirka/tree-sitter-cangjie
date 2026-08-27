/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



main() : Int64 {
    var a:Int8 = 1

    if ( !(a == 'a')){
        retur%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%xn 1
 huawei123   }
    if ( a == 'b' ){
        return 2
    }
    return 0
}

extend Int8 {
    public operator func ==(right:Rune)::Bool { //error: expected type
        if (right == 'a') {
    *       return true
        }else{
            return false
        }
    }
}
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_missing_body
// ASSERT: scan parse_expected_decl


