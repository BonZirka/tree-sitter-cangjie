// EXEC: %frontendCompiler %cmp_opt %typecheck %f 2>&1 | compare %f


main () {
    var ra: String = "\u{"  
    var rb: String = "\u{}" 
    var rc: String = "\u{123" 
    var rd: String = "\u{123456789}" // regex escape unicode must be 1 to 8 hexadecimal digits in braces
    var re: String = "\u"  
    var rf: String = "\u123"  
    var rg: String = "\u}"  

    var ca: Rune = '\u{'  
    var cb: Rune = '\u{}' 
    var cc: Rune = '\u{123' 
    var cd: Rune = '\u{123456789}' 
    return 0
}

/* SCAN
error: expected hexadecimal digit, found '"'
 ==> string_unicode1.cj:5:26:
  | 
5 |     var ra: String = "\u{"  
  |                          ^ expected hexadecimal digit
  | 

error: expected hexadecimal digit, found '}'
 ==> string_unicode1.cj:6:26:
  | 
6 |     var rb: String = "\u{}" 
  |                          ^ expected hexadecimal digit
  | 

error: expected '}' or hexadecimal digit in unicode escape, found '"'
 ==> string_unicode1.cj:7:29:
  | 
7 |     var rc: String = "\u{123" 
  |                       ~~    ^ expected '}' or hexadecimal digit
  |                       |
  |                       because it is in this Unicode escape
  | 
  # note: unicode escape may only contain hexadecimal digits

error: expected '}', found '9'
 ==> string_unicode1.cj:8:34:
  | 
8 |     var rd: String = "\u{123456789}" // regex escape unicode must be 1 to 8 hexadecimal digits in braces
  |                         ~        ^ expected '}'
  |                         |
  |                         to match this opening '{'
  | 
  # note: unicode escape may contain 8 hexadecimal digits at most

error: expected '{' in unicode escape, found '"'
 ==> string_unicode1.cj:9:25:
  | 
9 |     var re: String = "\u"  
  |                       ~~^ expected '{'
  |                       |
  |                       because it is in this Unicode escape
  | 

error: expected '{' in unicode escape, found '1'
  ==> string_unicode1.cj:10:25:
   | 
10 |     var rf: String = "\u123"  
   |                       ~~^ expected '{'
   |                       |
   |                       because it is in this Unicode escape
   | 

error: expected '{' in unicode escape, found '}'
  ==> string_unicode1.cj:11:25:
   | 
11 |     var rg: String = "\u}"  
   |                       ~~^ expected '{'
   |                       |
   |                       because it is in this Unicode escape
   | 

error: expected hexadecimal digit, found '''
  ==> string_unicode1.cj:13:24:
   | 
13 |     var ca: Rune = '\u{'  
   |                        ^ expected hexadecimal digit
   | 

error: expected hexadecimal digit, found '}'
  ==> string_unicode1.cj:14:24:
   | 
14 |     var cb: Rune = '\u{}' 
   |                        ^ expected hexadecimal digit
   | 

error: expected '}' or hexadecimal digit in unicode escape, found '''
  ==> string_unicode1.cj:15:27:
   | 
15 |     var cc: Rune = '\u{123' 
   |                     ~~    ^ expected '}' or hexadecimal digit
   |                     |
   |                     because it is in this Unicode escape
   | 
   # note: unicode escape may only contain hexadecimal digits

error: expected '}', found '9'
  ==> string_unicode1.cj:16:32:
   | 
16 |     var cd: Rune = '\u{123456789}' 
   |                       ~        ^ expected '}'
   |                       |
   |                       to match this opening '{'
   | 
   # note: unicode escape may contain 8 hexadecimal digits at most

11 errors generated, 11 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
