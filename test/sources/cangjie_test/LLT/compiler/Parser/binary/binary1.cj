// ERRCHECK: %compiler %cmp_opt %f -o %output

 let var536 : Int16 = Int16(-104);

 open class A {

    public open func function1806() : Bool {
        var536 < (var536 >> (var536 & 7));
        false;
    }

    public var var1838 : A = A();
}

main(): Int64 {
     return 0;
}

/* SCAN
error: recursive constructor calling detected
  ==> binary1.cj:12:30:
   | 
12 |     public var var1838 : A = A();
   |                              ^ 
   | 
note: depends on
 ==> binary1.cj:5:13:
  | 
5 |  open class A {
  |             ^ 
  | 
note: depends on
  ==> binary1.cj:12:30:
   | 
12 |     public var var1838 : A = A();
   |                              ^ 
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
