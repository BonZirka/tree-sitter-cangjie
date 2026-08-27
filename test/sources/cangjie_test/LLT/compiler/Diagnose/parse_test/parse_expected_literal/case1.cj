// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo()
{
    var a = match(b) {
        case - => 1
        case _ => 2
    }
}

/* SCAN
error: expected literal after '-', found '=>'
  ==> case1.cj:13:16:
   | 
13 |         case - => 1
   |              ~ ^^ expected literal here
   |              |
   |              after this
   | 

1 error generated, 1 error printed.
*/
