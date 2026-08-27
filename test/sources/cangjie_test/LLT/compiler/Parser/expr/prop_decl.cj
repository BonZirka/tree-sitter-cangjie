// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

class Foo {}

extend Foo {
    /**
    * this extended function
    */
    public func fExtend() {}
    static prop var errorPrpo: Int64 {
    
        get() {
            return errorPrpo
        }
        set(v) {
            errorPrpo = v + 0.1
        }
    }
    static prop let staticPrpo: Int64 {
        get() {
            return 0
        }
        set(v) {
            staticPrpo = v
        }
    }
}

/* SCAN
error: expected a property name after keyword 'prop' in property definition, found keyword 'var'
  ==> prop_decl.cj:10:17:
   | 
10 |     static prop var errorPrpo: Int64 {
   |            ~~~~ ^^^ expected a property name here
   |            |
   |            after keyword 'prop' in property definition
   | 
help: you could escape keyword as a property name using '`':
   | 
10 |     static prop `var` errorPrpo: Int64 {
   |                 ~~~~~ 
   | 

error: expected declaration, found '{'
  ==> prop_decl.cj:10:38:
   | 
10 |     static prop var errorPrpo: Int64 {
   |                                      ^ expected declaration here
   | 

error: expected a property name after keyword 'prop' in property definition, found keyword 'let'
  ==> prop_decl.cj:19:17:
   | 
19 |     static prop let staticPrpo: Int64 {
   |            ~~~~ ^^^ expected a property name here
   |            |
   |            after keyword 'prop' in property definition
   | 
help: you could escape keyword as a property name using '`':
   | 
19 |     static prop `let` staticPrpo: Int64 {
   |                 ~~~~~ 
   | 

error: expected declaration, found '{'
  ==> prop_decl.cj:19:39:
   | 
19 |     static prop let staticPrpo: Int64 {
   |                                       ^ expected declaration here
   | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
