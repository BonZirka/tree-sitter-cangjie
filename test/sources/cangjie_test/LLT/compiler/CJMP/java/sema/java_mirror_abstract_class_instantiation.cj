// (CJNATIVE and not Windows) EXEC-PIPE-1: %compiler %cmp_opt %f -o %output %compile_shared_lib_opt %import_java_interop 2>& 1 | compare %f


import java.lang.*

@JavaMirror
abstract class A {
    public abstract func foo(): Unit
}

@JavaImpl
class Impl {
    init() {
        let x = A()
    }
}

/* SCAN-IN
error: abstract class 'A' can not be instantiated
  ==> java_mirror_abstract_class_instantiation.cj:14:17:
   | 
14 |         let x = A()
   |                 ^ 
   | 
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

