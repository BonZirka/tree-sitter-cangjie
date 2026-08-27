// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (not Windows) EXEC: LIBRARY_PATH= %compiler %f -o %output
// (Windows) EXEC: set LIBRARY_PATH=&& %compiler %f -o %output
// EXEC: %run %run_opt %output %run_args
// ASSERT: scan Hello world.

main() {
    println("Hello world.")
}
