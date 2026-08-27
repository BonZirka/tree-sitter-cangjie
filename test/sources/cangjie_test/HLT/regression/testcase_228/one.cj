/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class JoinSubIterator <: Iterator<ToString> {
    private var current = 0

    JoinSubIterator(private let sub: ToString, private let _count: Int64) {}

    public func next(): Option<ToString> {
        if (current < _count) {
            current++
            sub
        } else {
            None<ToString>
        }
    }
}
main(){
  let itr = JoinSubIterator(1, 3)
  var i = 0
  var str = ""
  for(v in itr){
    str = str + "${v} ${v is Option<ToString>} ${v is Int64}"
    i++
  }
  print(str)
  if (str != "1 false true1 false true1 false true"){
    return 1
  }
  return 0
}
