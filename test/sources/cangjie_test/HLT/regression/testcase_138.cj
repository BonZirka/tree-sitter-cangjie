/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


main()(right:Rune):Int32 {
        if (right == 'a') {
            return 55
        }else{
            return 66
           return 2
    }
    return 0
}

extend Int32 {
    public operator func >(right:Rune):Int32 {
        if (right == 'a') {
            return 55
        }else{
            return 66
        }
    }
}
// ASSERT: scan parse_expected_left_brace


