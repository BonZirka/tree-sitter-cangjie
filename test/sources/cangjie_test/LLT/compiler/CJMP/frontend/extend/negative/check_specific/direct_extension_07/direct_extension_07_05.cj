// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-0: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c
package cmp

common func foo<T>(x:T):Unit
common func foo<M, N>(m:M, n:N):Unit where M <: ToString


// SEPARATE-FILE: p/p.cj
// EXEC-PIPE-0: %compiler %noColor --experimental p/p.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo --output-type=dylib --output-dir ./p 2>&1
package cmp

specific func foo<T>(x:T):Unit {}
specific func foo<M, N>(m:M, n:N):Unit {}

