/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



interface I<T>{
    abstract class J<T>{} 
}

main(){
var a : I<Int32>.J<Int32>
return 0
}
// ASSERT: scan parse_unexpected_declaration_in_scope
