/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output



@OverflowSaturating
func test(a:Int8,b:Int8){
    return a+b
}

main(){
    return 0
}

@OverflowSaturating
// ASSERT: scan parse_unexpected_anno_on
// ASSERT: scan parse_expected_decl
