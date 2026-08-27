/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC-PIPE-0: %compiler %cmp_opt -o %n.%suffix %f %cmp_utest_opt 2>&1 | compare %f
// ASSERT: scan-not unused
// ASSERT: scan-not warning
@Test
class Foo {
    @BeforeEach
    func f() {
        // function does not declare param so we check there is no warning
    }

    @AfterEach
    func g() {
    }
}
