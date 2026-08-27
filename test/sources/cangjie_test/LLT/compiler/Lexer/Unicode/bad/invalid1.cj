// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: %n.cpp
// EXEC: %clang %n.cpp -o %n
// EXEC: %n > a.cj
// EXEC-PIPE-1: %compiler a.cj 2>&1 %cmp_opt | compare %f

// ASSERT: scan error: illegal character:\\u{00BE}
