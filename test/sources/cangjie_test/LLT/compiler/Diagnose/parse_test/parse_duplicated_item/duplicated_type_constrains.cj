// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

public struct range<T> where T <: Countable<T> , T <: Comparable<T> , T <: Equatable<T> 
{}

/* SCAN
error: duplicated type name 'T' in generic constrain
  ==> duplicated_type_constrains.cj:10:50:
   | 
10 | public struct range<T> where T <: Countable<T> , T <: Comparable<T> , T <: Equatable<T> 
   |                              ~                   ^ duplicated type name
   |                              |
   |                              previous one is here
   | 

error: duplicated type name 'T' in generic constrain
  ==> duplicated_type_constrains.cj:10:71:
   | 
10 | public struct range<T> where T <: Countable<T> , T <: Comparable<T> , T <: Equatable<T> 
   |                              ~                                        ^ duplicated type name
   |                              |
   |                              previous one is here
   | 

2 errors generated, 2 errors printed.
*/
