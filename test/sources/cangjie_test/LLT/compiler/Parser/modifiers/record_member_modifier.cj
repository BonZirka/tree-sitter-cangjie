// EXEC: %frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

struct S {
    public var a : Int64 = 1 // ok
    private var b : Int64 = 2 // ok
    public static var c : Int64 = 3 // ok
    public static var d : Int64 = 4 // ok
    public private var e : Int64 = 5 

    public func f() {} // ok
    private func g() {} // ok
    public static func h() {} // ok
    private static func i() {} // ok
    public private static func j() {} 

    public operator func +(hi:S, h : Int64) {} // ok
    private operator func -(hi:S, h : Int64) {} // ok

    public static operator func [](hi:S, h:Int64) {} 
    public static operator func ==(hi:S, h : Int64) {} 
    private static operator func !=(hi:S, h : Int64) {} 

    public static init() {}
    private init(k : Int64) {} // ok
    public init(l : Int64, m : Int64) {} // ok

    protected var  n: Int64 = 1
    public open var o: Int64 = 2
    public override var p:Int64 = 3
}

/* SCAN
error: 'private' and 'public' modifiers conflict on variable declaration
 ==> record_member_modifier.cj:8:12:
  | 
8 |     public private var e : Int64 = 5 
  |     ~~~~~~ ^^^^^^^ ~~~ on variable declaration
  |     |      |
  |     |      unexpected modifier
  |     |
  |     because it is conflicted with this
  | 

error: 'private' and 'public' modifiers conflict on function declaration
  ==> record_member_modifier.cj:14:12:
   | 
14 |     public private static func j() {} 
   |     ~~~~~~ ^^^^^^^        ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: 'operator' and 'static' modifiers conflict on function declaration
  ==> record_member_modifier.cj:19:19:
   | 
19 |     public static operator func [](hi:S, h:Int64) {} 
   |            ~~~~~~ ^^^^^^^^ ~~~~ on function declaration
   |            |      |
   |            |      unexpected modifier
   |            |
   |            because it is conflicted with this
   | 

error: 'operator' and 'static' modifiers conflict on function declaration
  ==> record_member_modifier.cj:20:19:
   | 
20 |     public static operator func ==(hi:S, h : Int64) {} 
   |            ~~~~~~ ^^^^^^^^ ~~~~ on function declaration
   |            |      |
   |            |      unexpected modifier
   |            |
   |            because it is conflicted with this
   | 

error: 'operator' and 'static' modifiers conflict on function declaration
  ==> record_member_modifier.cj:21:20:
   | 
21 |     private static operator func !=(hi:S, h : Int64) {} 
   |             ~~~~~~ ^^^^^^^^ ~~~~ on function declaration
   |             |      |
   |             |      unexpected modifier
   |             |
   |             because it is conflicted with this
   | 

error: 'static' and 'public' modifiers conflict on function declaration
  ==> record_member_modifier.cj:23:12:
   | 
23 |     public static init() {}
   |     ~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: unexpected modifier 'open' on variable declaration in struct body
  ==> record_member_modifier.cj:28:12:
   | 
3  | struct S {
   | ~~~~~~ in struct
4  |     public var a : Int64 = 1 // ok
   | ...
28 |     public open var o: Int64 = 2
   |            ^^^^ ~~~ on variable declaration
   |            |
   |            unexpected modifier
   | 

error: unexpected modifier 'override' on variable declaration in struct body
  ==> record_member_modifier.cj:29:12:
   | 
3  | struct S {
   | ~~~~~~ in struct
4  |     public var a : Int64 = 1 // ok
   | ...
29 |     public override var p:Int64 = 3
   |            ^^^^^^^^ ~~~ on variable declaration
   |            |
   |            unexpected modifier
   | 

8 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
