// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %error_count_limit_all %n.cj 2>&1 | compare %f

class A {
    public static init(){}
    protected static init(){}
    private static init(){}
    static public init(){}
    static protected init(){}
    static private init(){}
}
struct S0 {
    public static init(){}
    private static init(){}
    static public init(){}
    static private init(){}
}

/* SCAN
error: 'static' and 'public' modifiers conflict on function declaration
  ==> case49.cj:11:12:
   | 
11 |     public static init(){}
   |     ~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'static' and 'protected' modifiers conflict on function declaration
  ==> case49.cj:12:15:
   | 
12 |     protected static init(){}
   |     ~~~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |         |
   |     |         unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'static' and 'private' modifiers conflict on function declaration
  ==> case49.cj:13:13:
   | 
13 |     private static init(){}
   |     ~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |       |
   |     |       unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'public' and 'static' modifiers conflict on function declaration
  ==> case49.cj:14:12:
   | 
14 |     static public init(){}
   |     ~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'protected' and 'static' modifiers conflict on function declaration
  ==> case49.cj:15:12:
   | 
15 |     static protected init(){}
   |     ~~~~~~ ^^^^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'private' and 'static' modifiers conflict on function declaration
  ==> case49.cj:16:12:
   | 
16 |     static private init(){}
   |     ~~~~~~ ^^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'static' and 'public' modifiers conflict on function declaration
  ==> case49.cj:19:12:
   | 
19 |     public static init(){}
   |     ~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'static' and 'private' modifiers conflict on function declaration
  ==> case49.cj:20:13:
   | 
20 |     private static init(){}
   |     ~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |       |
   |     |       unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'public' and 'static' modifiers conflict on function declaration
  ==> case49.cj:21:12:
   | 
21 |     static public init(){}
   |     ~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'private' and 'static' modifiers conflict on function declaration
  ==> case49.cj:22:12:
   | 
22 |     static private init(){}
   |     ~~~~~~ ^^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

10 errors generated, 10 errors printed.
*/
