// (DEBUG_OPTION)EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

foreign {
    abstract class B{}
    open class C{}
}

main():Unit{
}

/* SCAN
error: unexpected class declaration
 ==> block_modifier.cj:3:1:
  | 
3 | foreign {
  | ^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
