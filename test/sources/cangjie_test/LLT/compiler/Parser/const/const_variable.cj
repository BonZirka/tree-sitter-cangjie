// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %f -o %output

public const a: Int64 = 0 // ok
public const b: Int64 // err
public const (c, d) = (1, 2)
public const e = 0 // ok, the type of d is Int64
public const _ = 1
const public (f, g) = (1, 2) // ok, public is contextual keyword, here will be parsed as enumPattern variable

main() { }

/* SCAN
error: const variable declaration must be initialized
  ==> const_variable.cj:11:22:
   | 
11 | public const b: Int64 // err
   |        ~~~~~~~~~~~~~~^ expected a initializer here
   | 

1 error generated, 1 error printed.
*/
