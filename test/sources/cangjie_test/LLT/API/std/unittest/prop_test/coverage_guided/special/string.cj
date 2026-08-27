/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt --sanitizer-coverage-trace-pc-guard --sanitizer-coverage-trace-compares 
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt --no-color --coverage-guided | compare %f
// ASSERT: scan Assert Failed

@Test[s in random() 
]
@Configure[generationSteps: 1000000, randomSeed: 1]
func triggerGCov(s: String) {
    if (s.size < 3) {
        return
    }

    if (s[0] == 67) { //'C'
        if (s[1] == 71) { //'G'
            if (s[2] == 70) { //'F'
                @Fail("CGF generated")
            }
        }
    }
}
