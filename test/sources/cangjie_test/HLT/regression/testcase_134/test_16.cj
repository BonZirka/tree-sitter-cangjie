/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE: mkdir c && cd c && mkdir b && cd ..
// EXEC-PIPE: %compiler %cmp_opt %n.cj -o b/target_name --output-dir=c
// EXEC-PIPE: cd c/b && %ls | compare %f
// ASSERT: scan target_name

main(){
        return 0
}
