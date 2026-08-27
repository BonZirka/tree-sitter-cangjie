// ERRCHECK: %compiler %noColor %f -o %output

const a
const b: Int64
const (c, d)

func f(): Unit {
    const e
    const f: Int64
    const (g, h)
}

main() {}

/* SCAN
error: const variable declaration must be initialized
 ==> const_variable7.cj:3:8:
  | 
3 | const a
  | ~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
 ==> const_variable7.cj:4:15:
  | 
4 | const b: Int64
  | ~~~~~~~~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
 ==> const_variable7.cj:5:13:
  | 
5 | const (c, d)
  | ~~~~~~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
 ==> const_variable7.cj:8:12:
  | 
8 |     const e
  |     ~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
 ==> const_variable7.cj:9:19:
  | 
9 |     const f: Int64
  |     ~~~~~~~~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
  ==> const_variable7.cj:10:17:
   | 
10 |     const (g, h)
   |     ~~~~~~~~~~~~^ expected a initializer here
   | 

6 errors generated, 6 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
