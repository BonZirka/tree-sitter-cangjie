// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args

var _ = { => let x = { => 2 } }

main() {}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
