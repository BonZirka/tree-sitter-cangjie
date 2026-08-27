// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

main(): Unit {
    // signed overflow
    let _: Int8 = 128i8
    let _: Int16 = 32768i16
    let _: Int32 = 2147483648i32
    let _: Int64 = 9223372036854775808i64

    // signed underflow
    let _: Int8 = -129i8
    let _: Int16 = -32769i16
    let _: Int32 = -2147483649i32
    let _: Int64 = -9223372036854775809i64

    // unsigned overflow
    let _: UInt8 = 256u8
    let _: UInt16 = 65536u16
    let _: UInt32 = 4294967296u32
    let _: UInt64 = 18446744073709551616u64

    // unsigned underflow
    let _: UInt8 = -1u8
    let _: UInt16 = -1u16
    let _: UInt32 = -1u32
    let _: UInt64 = -1u64
}

/* SCAN
error: the number '128i8' exceeds the value range of type 'Int8'
 ==> int_literal_corner_cases.cj:5:19:
  | 
5 |     let _: Int8 = 128i8
  |                   ^^^^^ 
  | 

error: the number '32768i16' exceeds the value range of type 'Int16'
 ==> int_literal_corner_cases.cj:6:20:
  | 
6 |     let _: Int16 = 32768i16
  |                    ^^^^^^^^ 
  | 

error: the number '2147483648i32' exceeds the value range of type 'Int32'
 ==> int_literal_corner_cases.cj:7:20:
  | 
7 |     let _: Int32 = 2147483648i32
  |                    ^^^^^^^^^^^^^ 
  | 

error: the number '9223372036854775808i64' exceeds the value range of type 'Int64'
 ==> int_literal_corner_cases.cj:8:20:
  | 
8 |     let _: Int64 = 9223372036854775808i64
  |                    ^^^^^^^^^^^^^^^^^^^^^^ 
  | 

error: the number '-129i8' exceeds the value range of type 'Int8'
  ==> int_literal_corner_cases.cj:11:19:
   | 
11 |     let _: Int8 = -129i8
   |                   ^^^^^^ 
   | 

error: the number '-32769i16' exceeds the value range of type 'Int16'
  ==> int_literal_corner_cases.cj:12:20:
   | 
12 |     let _: Int16 = -32769i16
   |                    ^^^^^^^^^ 
   | 

error: the number '-2147483649i32' exceeds the value range of type 'Int32'
  ==> int_literal_corner_cases.cj:13:20:
   | 
13 |     let _: Int32 = -2147483649i32
   |                    ^^^^^^^^^^^^^^ 
   | 

error: the number '-9223372036854775809i64' exceeds the value range of type 'Int64'
  ==> int_literal_corner_cases.cj:14:20:
   | 
14 |     let _: Int64 = -9223372036854775809i64
   |                    ^^^^^^^^^^^^^^^^^^^^^^^ 
   | 

error: the number '256u8' exceeds the value range of type 'UInt8'
  ==> int_literal_corner_cases.cj:17:20:
   | 
17 |     let _: UInt8 = 256u8
   |                    ^^^^^ 
   | 

error: the number '65536u16' exceeds the value range of type 'UInt16'
  ==> int_literal_corner_cases.cj:18:21:
   | 
18 |     let _: UInt16 = 65536u16
   |                     ^^^^^^^^ 
   | 

error: the number '4294967296u32' exceeds the value range of type 'UInt32'
  ==> int_literal_corner_cases.cj:19:21:
   | 
19 |     let _: UInt32 = 4294967296u32
   |                     ^^^^^^^^^^^^^ 
   | 

error: the number '18446744073709551616u64' exceeds the value range of type 'UInt64'
  ==> int_literal_corner_cases.cj:20:21:
   | 
20 |     let _: UInt64 = 18446744073709551616u64
   |                     ^^^^^^^^^^^^^^^^^^^^^^^ 
   | 

error: the number '-1u8' exceeds the value range of type 'UInt8'
  ==> int_literal_corner_cases.cj:23:20:
   | 
23 |     let _: UInt8 = -1u8
   |                    ^^^^ 
   | 

error: the number '-1u16' exceeds the value range of type 'UInt16'
  ==> int_literal_corner_cases.cj:24:21:
   | 
24 |     let _: UInt16 = -1u16
   |                     ^^^^^ 
   | 

error: the number '-1u32' exceeds the value range of type 'UInt32'
  ==> int_literal_corner_cases.cj:25:21:
   | 
25 |     let _: UInt32 = -1u32
   |                     ^^^^^ 
   | 

error: the number '-1u64' exceeds the value range of type 'UInt64'
  ==> int_literal_corner_cases.cj:26:21:
   | 
26 |     let _: UInt64 = -1u64
   |                     ^^^^^ 
   | 

16 errors generated, 16 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
