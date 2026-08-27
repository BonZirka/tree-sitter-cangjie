// ERRCHECK: %compiler %cmp_opt %n.cj -o %output
// ASSERT: regex-not core dump
// ASSERT: regex expected a generic type name after '<' in generic, found ':'

func Add<  : T, b: T): T {
              var res = a
              return res
T>(a     }
       Add

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
