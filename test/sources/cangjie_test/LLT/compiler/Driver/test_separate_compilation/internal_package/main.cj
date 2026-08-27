// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: ./pkg
// DEPENDENCE: ./pkg/sub_pkg
// DEPENDENCE: ./pkg_test
// EXEC: %mkdir build
// EXEC: %compiler %cmp_opt %pkg_opt -Woff=all pkg --mock=off %compile_lib_opt --output build/p1.%middle
// EXEC: %compiler %cmp_opt %pkg_opt -Woff=all pkg/sub_pkg --mock=off %compile_lib_opt --output build/p2.%middle
// EXEC: %compiler build/p1.%middle build/p2.%middle %cmp_opt -Woff=all -p pkg_test --test-only --import-path=build --mock=off -o %output
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args
