/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

interface I1<T> {}
interface I2<T> {}

class C1<T> <: I1<T> & I1<T> {} 
class C2<T> <: I1<T> {}
extend<T> C2<T> <: I1<T> {}    

interface II1<T> <: I1<T> & I1<T> {}    
interface II2<T> <: I1<T> {}
extend<T> II2<T> <: I1<T> {}       

struct R1<T> <: I1<T> & I1<T> {}
struct R2<T> <: I1<T> {}
extend<T> R2<T> <: I1<T> {}    

enum E1<T> <: I1<T> & I1<T> { A | B }  
enum E2<T> <: I1<T> { C | D }
extend<T> E2<T> <: I1<T> {}
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_inherit_duplicate_interface
// ASSERT: scan sema_extend_duplicate_interface
// ASSERT: scan sema_illegal_extended_type
