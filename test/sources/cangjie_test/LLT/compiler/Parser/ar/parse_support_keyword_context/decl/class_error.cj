


// EXEC: %compiler %cmp_opt %compile_lib_opt %f 2>&1 | compare %f


 open class public {
    public private var abstract : Int64 = 0
    public var redef : Int64 = 0
    static func open(): Int64 {
        return 1
    }
    public private public() {}
}

main() {
    return 0
}

/* SCAN-IN
error: 'private' and 'public' modifiers conflict on variable declaration
 ==> class_error.cj:8:12:
  | 
8 |     public private var abstract : Int64 = 0
  |     ~~~~~~ ^^^^^^^ ~~~ on variable declaration
  |     |      |
  |     |      unexpected modifier
  |     |
  |     because it is conflicted with this
  | 

error: 'private' and 'public' modifiers conflict on constructor
  ==> class_error.cj:13:12:
   | 
13 |     public private public() {}
   |     ~~~~~~ ^^^^^^^ ~~~~~~ on constructor
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
