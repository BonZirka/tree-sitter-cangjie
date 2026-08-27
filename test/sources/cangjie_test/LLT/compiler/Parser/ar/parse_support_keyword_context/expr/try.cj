// ERRCHECK: %compiler %cmp_opt %enableCompileDebug %f -o %n.%suffix

class public <: Exception{}

main() {
    try {
        throw public()
    } catch (private) { 
        return 0
    }
    finally{}
return 1
}

/* SCAN
error: expected ':' in exception type pattern, found ')'
 ==> try.cj:8:21:
  | 
8 |     } catch (private) { 
  |                     ^ expected ':' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
