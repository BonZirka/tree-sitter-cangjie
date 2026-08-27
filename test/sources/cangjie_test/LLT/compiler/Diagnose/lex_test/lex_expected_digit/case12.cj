// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: case12.expect.out
// EXEC-1: %compiler %noColor --error-count-limit=30 %f 2>%f.out 1>%redirectNull
// EXEC: %diff case12.expect.out %f.out

var a = '\u{}'
var b = '\u{
}'

var i = '\u{我}'