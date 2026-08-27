// DEPENDENCE: dependency.cj
// (DEBUG_OPTION)EXEC: %compiler dependency.cj %compile_lib_opt -o dependency.%middle
// (DEBUG_OPTION)EXEC: %frontendCompiler dependency.%middle %dump-parse %cmp_opt %n.cj -o %n.%suffix 
// ASSERT: regex-not error
internal import A.C

.

B

type Q =
(I
.
B ,
Unit)

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
