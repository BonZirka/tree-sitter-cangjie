// EXEC: %compiler %cmp_opt %f -o %output

internal import std.ast.*;

let a = 1;
let b = 2;
let c = 3;
let d = 4;
let e = 5;
let f = 6;
let g = 6;
let h = 6;

type Point2D = (Float64, Float64);
type i32 = Int32;

struct S<T1, T2>{}

func foo2(a : Bool, b : Bool) {};
func foo3(a : Bool, b : Bool, c : Bool) {};
func foo4(a : Bool, b : Bool, c : Bool, d : Bool) {};
func ioo2(a : Int64, b : Int64) {};
func ioo3(a : Int64, b : Int64, c : Int64) {};

func goo2<T1, T2>(a : Int64){0}
func goo3<T1, T2, T3>(a : Int64){0}

main()
{
    foo3((a < b), (c > 0), false)
    foo3(a < b, c > 0, false);
    foo3(true, (a < b), (c > d))
    foo3(true, a < b, c > d);
    foo2((a < b), (c >= d))
    foo2(a < b, c >= d);
    ioo2((goo2<Point2D, i32>(a)), (b))
    ioo2(goo2 < Point2D, i32 > (a), b);
    foo4((a<b), (c<d), (e>f), (g>h))
    foo4(a<b, c<d, e>f, g>h);
    ioo3((a), (goo3<Point2D, S<Point2D, i32>, i32>(b)), (c))
    ioo3(a, goo3<Point2D, S<Point2D, i32>, i32>(b), c);
    foo2(a < b, (c)> d)
    foo2((a < b), ((c)> d));
    ioo2((goo2<FuncDecl, (?Point2D)>(d)), e);
    ioo2(goo2<FuncDecl, (?Point2D)>(d), e);
    0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
