// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f

package a::::b
/* SCAN
error: expected a package name after '::' in qualified name, found '::'
  ==> package_spec_org.cj:10:12:
   | 
10 | package a::::b
   |          ~~^^ expected a package name here
   |          |
   |          after '::' in qualified name
   | 

1 error generated, 1 error printed.
*/
