// DEPENDENCE: %n.old.cj %n.new.cj
// EXEC: %mkdir a b
// (not Windows) EXEC: echo "package a.A" >> a/%f
// (Windows) EXEC: echo package a.A >> a/%f
// EXEC: %cat %f >> a/%f
// EXEC: %compiler %cmp_opt -p a %compile_lib_opt -o a/A.%lib_extension
// (not Windows) EXEC: echo "package b.A" >> b/%f
// (Windows) EXEC: echo package b.A >> b/%f
// (not Windows) EXEC: echo "public func foo(): Int64 { 3 }" >> b/%f
// (Windows) EXEC: echo public func foo(): Int64 { 3 } >> b/%f
// EXEC: %compiler %cmp_opt -p b %compile_lib_opt -o b/A.%lib_extension
// EXEC: %compiler %incrementalCompile %cmp_opt a/A.%lib_extension b/A.%lib_extension %n.old.cj -o %output
// EXEC: %run %run_opt %output %run_args

// EXEC: %rmfile %n.old.cj
// EXEC: %move %n.new.cj %n.old.cj
// EXEC-PIPE-0: %compiler %incrementalCompile %cmp_opt a/A.%lib_extension b/A.%lib_extension %n.old.cj -o %output 2>&1 && cat .cached/*.log | compare %f
// ASSERT: scan rollback
// ASSERT: scan-not incremental compilation triggered
// ASSERT: scan-not no change
// EXEC-3: %run %run_opt %output %run_args
public func foo(): Int64 { 0 }


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
