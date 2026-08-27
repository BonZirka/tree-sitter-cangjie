// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE) DEPENDENCE: %n.old.cj %n.new.cj
// (CJNATIVE) EXEC: %compiler %incrementalCompile %cmp_opt %n.old.cj -o %output
// (CJNATIVE) EXEC: %run %run_opt %output %run_args
// (CJNATIVE) EXEC: %rmfile %output
// (CJNATIVE) EXEC: %rmfile %n.old.cj
// (CJNATIVE) EXEC: %move %n.new.cj %n.old.cj
// (CJNATIVE) EXEC: %compiler %incrementalCompile %cmp_opt %n.old.cj -o %output