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

func foo(a : Bool, b : Bool, c : Bool) {};
func f1<T>(a : Int64){0}
func f2<T1, T2>(a : Int64){0}
func f3<T1, T2, T3>(a : Int64){0}

class E {
    let x = 5;
};
let m = E();

main()
{
    ((a < b), (c >= d)); // tuple expr, type is (Bool, Bool)
    (a < b, c >= d);
    ((a < b), (c > !d)); // tuple expr, type is (Bool, Bool)
    (a < m.x, c > !d);
    ((a < b), (c > d)); // tuple expr, type is (Bool, Bool)
    (a < b, c >
    (d));
    ((f2<Point2D, i32>(a)), (b)); // tuple expr, type is (Int64, Int64)
    (f2 < Point2D, i32 > (a), b);
    (a, (f2 < Point2D, i32 >), c); // tuple expr, type is (Int64, (Int64) -> Int64, Int64)
    (a, f2 < Point2D, i32 >, c);
    (a, b, (f2 < Point2D, i32 >)); // tuple expr, type is (Int64, Int64, (Int64) -> Int64)
    (a, b, f2 < Point2D, i32 >);
    ((a<b), (c<d), (e>f), (g>h)); // tuple expr, type is (Bool, Bool, Bool, Bool)
    (a<b, c<d, e>f, g>h);
    (a<b, f1<i32>, e>f); // tuple expr, type is (Bool, (Int64) -> Int64, Bool)
    (a<b, f1<i32>, e>f)
    ((a<b), (c<d), (e>=f), (g>h)); // tuple expr, type is (Bool, Bool, Bool, Bool)
    (a<b, c<d, e>=f, g>h);
    (a, (f2<Point2D, i32>(b)), (c)); // tuple expr, type is (Int64, Int64, Int64)
    (a, f2<Point2D, i32>(b), c);
    (a, (f3<Point2D, S<Point2D, i32>, i32>), (c)); // tuple expr, type is (Int64, Int64, Int64)
    (a, f3<Point2D, S<Point2D, i32>, i32>(b), c);
    ((a < b), (c , d), (e > f)); // tuple expr, type is (Bool, (Int64, Int64), Bool)
    (a < b, (c , d), e > f);
    (a<b, (c, d,), f>g); // tuple expr, type is (Bool, (Int64, Int64), Bool)
    (a<b, (c, d,), f>g)
    ((f3<i32, (i32 , i32), i32>(f)), (g), (h)); // tuple expr, type is (Int64, Int64, Int64)
    (f3<i32, (i32 , i32), i32>(f), g, h);
    ((a < b), ((c)> d)); // tuple expr, type is (Bool, Bool)
    (a < b, (c)> d);
    ((f2<i32, (Point2D)>(d)), (e), (f)); // tuple expr, type is (Int64, Int64, Int64)
    (f2<FuncDecl, (?Point2D)>(d), e, f);
    0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
