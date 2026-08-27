/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import stdx.log.*
import stdx.net.http.*
import std.regex.*

func foo(){
  var rep = HttpResponseBuilder().build()
  var s1: Protocol = rep.version
  if (s1 is Protocol){
    var b = Regex(s1.toString())
  }
  0.0
}

main(): Int64 {
  foo()
  0
}

