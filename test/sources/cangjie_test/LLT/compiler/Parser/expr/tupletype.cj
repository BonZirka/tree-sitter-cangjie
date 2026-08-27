// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %diag_json %f -o %output

main() {
   // a tuple is of at least two dimensions
   var x: (Int64, ) = (1, ) // err
   var y: (Int64, Int64, ) = (1, 2) // ok
   println(y)
}

// ASSERT: scan-1 parse_expected_expression
// ASSERT: scan "Errors": 1,
