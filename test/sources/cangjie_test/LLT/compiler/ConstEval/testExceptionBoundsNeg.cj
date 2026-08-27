// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %compile_exe_opt %n.cj %cmp_opt -o %output 2>&1 | compare %f
// ASSERT: scan error: an exception was thrown while evaluating constant
// ASSERT: scan IndexOutOfBoundsException
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace

// Tests constant evaluation when an exception is thrown.

const func index(m: Int64) : Int64 {
  let arr: VArray<Int64, $3> = [1, 2, 3]
  arr[m]
}

const meaningful_value = index(-1)

main() {}