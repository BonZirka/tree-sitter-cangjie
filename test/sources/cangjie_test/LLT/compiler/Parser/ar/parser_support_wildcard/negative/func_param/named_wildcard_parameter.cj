// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

func f(_!:Int64):Unit{

}

main():Unit{
    f(1)
}

/* SCAN
error: expected ':', found !
 ==> named_wildcard_parameter.cj:3:9:
  | 
3 | func f(_!:Int64):Unit{
  |         ^ expected ':' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
