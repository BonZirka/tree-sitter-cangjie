/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// LEVEL: 0
// DEPENDENCE: mp ../reference
// EXEC: %compiler -j1 --coverage %cmp_opt mp/test_com.cj %compile_chir_opt -o ./
// EXEC: %compiler -j1 --coverage %cmp_opt mp/test_plat.cj %compile_dylib_opt_cjmp -o ./
// EXEC: %compiler -j1 --coverage %cmp_opt %f %link_cjmp -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// EXEC: /home/duanwenxue/program/gitcode-cangjie/cangjie_tools/cjcov/dist/cjcov  --root=./ --html-details --output=html_output --json
// EXEC: %diff html_output/coverage.json reference/coverage.json >/dev/null 2>&1

import mp.*

main(): Int64 {
    var x1 = A(0).a
    0
}
