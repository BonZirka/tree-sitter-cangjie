// EXEC: %compiler %cmp_opt %f -o %output

const a = 1;
const b = 2;
const c = 3;
const d = 4;

type i32 = Int32;

const func f2<T1, T2>(a : Int64){0}

@Annotation
public class A {
    public const init(arg1: Bool, arg2: Bool) {}
}
@Annotation
public class B {
    public const init(arg1: Int64, arg2: Int64) {}
}

@A[a < b, c >= d]
@B[f2<i32, i32>(d), 0]
public class C {}

main() {}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
