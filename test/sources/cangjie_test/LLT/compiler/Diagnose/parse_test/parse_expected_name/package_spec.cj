// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

package

/* SCAN
error: expected a package name after keyword 'package', found '<EOF>'
  ==> package_spec.cj:10:8:
   | 
10 | package
   | ~~~~~~~^ expected a package name here
   | |
   | after keyword 'package'
   | 

1 error generated, 1 error printed.
*/
