// ERRCHECK:%frontendCompiler %cmp_opt %f

class A{
    static func a<T>():Unit{

    }
}
main():Unit{
    A.a<(,)>()
}

/* SCAN
error: expected type name after '(', found ','
 ==> parse_member_access_with_generic.cj:9:10:
  | 
9 |     A.a<(,)>()
  |         ~^ expected type name here
  |         |
  |         after '('
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
