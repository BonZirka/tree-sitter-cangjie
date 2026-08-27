// ERRCHECK: %compiler %f %cmp_opt

@!C struct Foo {}

@!OverflowWrapping func foo() {

}

@!When[backend == "cjnative"]
class C {

}

@!Annotation[target: []]
public class APILevel {
    public const init() {}
}

@!CallingConv[CDECL] @C foreign func bar(): Int

/* SCAN
error: expected declaration, found '@!'
 ==> bad_atexcl_builtin_annotation.cj:3:1:
  | 
3 | @!C struct Foo {}
  | ^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '@!'
 ==> bad_atexcl_builtin_annotation.cj:5:1:
  | 
5 | @!OverflowWrapping func foo() {
  | ^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected ';' or '<NL>', found keyword 'func'
 ==> bad_atexcl_builtin_annotation.cj:5:20:
  | 
5 | @!OverflowWrapping func foo() {
  |                    ^^^^ expected ';' or '<NL>' here
  | 

error: expected declaration, found '@!'
 ==> bad_atexcl_builtin_annotation.cj:9:1:
  | 
9 | @!When[backend == "cjnative"]
  | ^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '@!'
  ==> bad_atexcl_builtin_annotation.cj:14:1:
   | 
14 | @!Annotation[target: []]
   | ^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '@!'
  ==> bad_atexcl_builtin_annotation.cj:19:1:
   | 
19 | @!CallingConv[CDECL] @C foreign func bar(): Int
   | ^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

error: expected ';' or '<NL>', found '@'
  ==> bad_atexcl_builtin_annotation.cj:19:22:
   | 
19 | @!CallingConv[CDECL] @C foreign func bar(): Int
   |                      ^ expected ';' or '<NL>' here
   | 

7 errors generated, 7 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
