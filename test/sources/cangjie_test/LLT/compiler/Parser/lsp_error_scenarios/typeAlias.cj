// EXEC:%frontendCompiler %cmp_opt %dump-parse %f 2>&1 | compare %f




class Data1 {
    public static var tmp : Int32 = 234
    public var num: Int32 = 100;
    public init(a:Int32) {
        num = a
    }
    public func getA() : Int32 {
        return 1
    }
    public func getB(a:Int32,b:Int32) : Int32 {
        return 2
    }
}

type dt = Data1.

/* SCAN-IN
error: expected a type name after '.' in qualified name, found '<EOF>'
  ==> typeAlias.cj:20:17:
   | 
20 | type dt = Data1.
   |                ~^ expected a type name here
   |                |
   |                after '.' in qualified name
   | 
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
