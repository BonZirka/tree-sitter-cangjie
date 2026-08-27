// EXEC: %compiler %cmp_opt %n.cj -o %output
// ASSERT: regex-not core dump

func foo() {
  var bool = true;
  match(bool) {
    case true => return
    case false => return () 
  }
  print("hello")
}

main() {
  foo()
  return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
