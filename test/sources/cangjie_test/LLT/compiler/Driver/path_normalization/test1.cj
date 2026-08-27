// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: pkg
// EXEC-PIPE-1: %compiler %cmp_opt .//pkg//////pkg.cj 2>&1 | compare %f
// (not Windows) ASSERT: scan ./pkg/pkg.cj:8:7
// (Windows) ASSERT: scan .\pkg\pkg.cj:8:7
