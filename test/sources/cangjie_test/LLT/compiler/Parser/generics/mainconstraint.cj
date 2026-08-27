// EXEC-PIPE-1: %compiler %f %cmp_opt 2>&1 | compare %f

main(): Unit where T<: Comparable<T> {}

// ASSERT: scan unexpected 'where' in non-generic declaration
// ASSERT: scan error: body of main function is missing

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
