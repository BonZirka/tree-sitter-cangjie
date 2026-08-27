/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

// sort(v)
// 	Vector<T> <: Vector<T0>
// 	unify(T, T0)
// 		T <: T0    T0 <: Real<T0> & Comparable<T0>
// 		unify(T, Real<T0>)
// 			unify(Real<T> & Comparable<T>, Real<T0>)
// 				unify(Real<T>, Real<T0>)
// 					unify(T, T0) -- return true
// 					unify(T0, T) -- see below
// 				or
// 				unify(Comparable<T>, Real<T0>) -- error. use the above choice
// 		and
// 		unify(T, Comparable<T0>)
// 			-- similar to the above return true
// 
// 	unify(T0, T)
// 	-- now T <: T0 is in the constraint set
// 		unify(T, T) -- return true
// 
// unification succeeds
// the constraint set is T <: T0 <: T
// 
// solving T <: T0 <: T
// 	T0 = T is the answer

interface Number<T> {}
interface Real<T> <: Number<T> {}
class Vector<T> where T <: Real<T> {}
func sort<T>(v: Vector<T>) where T <: Real<T> & Comparable<T> {}
func f<T>(v: Vector<T>) where T <: Real<T> & Comparable<T> {
    sort(v)
}
main() {}
