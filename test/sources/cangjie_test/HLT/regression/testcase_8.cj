/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



type ran = Range<Int64

class C {
  public var item: ran = 1..2
}
let c = C()
let c1 = Option<C>.Some(c)
let ran1 : Option<ran> = c1?.item

let foo = {i: ran => i}
let f1 = Option<(ran) -> ran>.Some(foo)
let ran2 : Option<ran> = f1?(3..4) 

main(): Int64 {
  var r1 : ran = match(ran1){
    case Some(x) => x
    case _ => 0..1
  }

  var r2 : ran = match(ran2){
    case Some(x) => x
    case _ => 0..1
  }

  var str1:String = ""
  var str2:String = ""

  for (number in r1){
    str1 = "${number}"
    print("${number}") 
  }

  for (number in r2) {
    str2 = "${number}"
    print("${number}") 
  }
  if(str1 == "1" && str2 == "3"){
    return 0
  }else{
    return 1
  }
}
// ASSERT: scan parse_expected_right_delimiter


