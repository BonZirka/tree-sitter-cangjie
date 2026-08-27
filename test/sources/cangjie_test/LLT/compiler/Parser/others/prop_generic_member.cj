// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj -o %n.%suffix


class A{
    public mut prop a : Int64{
        get<T>(){1}
        set<T>(i){}
    }
}

main() {
    A()
    0
}


/* SCAN
error: 'setter' cannot be generic
 ==> prop_generic_member.cj:7:12:
  | 
7 |         get<T>(){1}
  |         ~~~^^^ unexpected generic here
  |         |
  |         in 'setter'
  | 

error: 'getter' cannot be generic
 ==> prop_generic_member.cj:8:12:
  | 
8 |         set<T>(i){}
  |         ~~~^^^ unexpected generic here
  |         |
  |         in 'getter'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
