/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// RUN-EXEC-PIPE-1: %compiler %cmp_opt %f -o %output %cmp_utest_opt 2>&1 | compare %f

// NOTE: if this is fixed in compiler we should add diagnostics so macros cannot be put on finalizers
@Test
class Foo {
    // finalizer is a special member function as spec states, it can be applied by a macro or annotation
    @Configure
    ~init() {}
}

/* SCAN-IN
error: expect a plain macro 'Configure', but find an attributed one
 */
