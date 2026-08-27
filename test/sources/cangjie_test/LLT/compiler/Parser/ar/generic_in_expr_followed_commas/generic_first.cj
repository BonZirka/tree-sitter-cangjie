// EXEC: %compiler %cmp_opt %f 2>&1 | compare %f
// ASSERT: scan error

let a = 1;
let b = 2;
let c = 3;
let d = 4;
let e = 5;
let f = 6;
let g = 6;
let h = 6;

main()
{
    (a < b, c > (d));
    (a<b, c<d, e>>f, g>h);
    (a< b, c >>= d, e);
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
