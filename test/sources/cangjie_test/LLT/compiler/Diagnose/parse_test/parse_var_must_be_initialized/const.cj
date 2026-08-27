// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %noColor %f 2>&1 | compare %f

const a : Int32
const b
const (c, d) : (Int32, Int32)
const (e, f)

main () {
}

/* SCAN
error: const variable declaration must be initialized
 ==> const.cj:9:16:
  | 
9 | const a : Int32
  | ~~~~~~~~~~~~~~~^ expected a initializer here
  | 

error: const variable declaration must be initialized
  ==> const.cj:10:8:
   | 
10 | const b
   | ~~~~~~~^ expected a initializer here
   | 

error: const variable declaration must be initialized
  ==> const.cj:11:30:
   | 
11 | const (c, d) : (Int32, Int32)
   | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^ expected a initializer here
   | 

error: const variable declaration must be initialized
  ==> const.cj:12:13:
   | 
12 | const (e, f)
   | ~~~~~~~~~~~~^ expected a initializer here
   | 

4 errors generated, 4 errors printed.
*/
