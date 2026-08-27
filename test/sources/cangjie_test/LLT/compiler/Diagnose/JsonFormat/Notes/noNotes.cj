// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

var a : 1 = 1

main () { 0 }
// ASSERT: scan parse_expected_type
