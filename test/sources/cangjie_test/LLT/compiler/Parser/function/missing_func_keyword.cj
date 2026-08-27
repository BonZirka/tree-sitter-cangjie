// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

public abstract class A {
    // Levenshtain distance is 1, so it treated as primary constructor
    public abstract f(): Int
}

/* SCAN
TODO: `func` keyword missed
SEE: SeeingPrimaryIdentifer in ParseUtils.cpp
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

