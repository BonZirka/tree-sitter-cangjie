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

class E {
    let x = 5;
    func g<T1, T2>(a : Int64){0}
};

let m = E();
main()
{
    [(-a < b), (c > d)]
    [-a < b, c > d];
    [(-goo2<i32, Point2D>(d)), e, f, g, h]
    [-goo2<i32, Point2D>(d), e, f, g, h]
    [(m.x < b), (c > d)];
    [m.x < b, c > d];
    [(m.g<i32, Point2D>(d)), e, f, g, h];
    [m.g<i32, Point2D>(d), e, f, g, h];
    [(a<b), (c<d), (e>f), (g>h)];
    [a<b, c<d, e>f, g>h];
    [(goo2<i32, S<Point2D, ?Point2D>>(f)), g, h];
    [goo2<i32, S<Point2D, ?Point2D>>(f), g, h];
    0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
