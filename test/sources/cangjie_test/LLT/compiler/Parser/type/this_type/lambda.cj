// EXEC-PIPE-1: %frontendCompiler %front_cmp_opt %f 2>&1 | compare %f

class A {
	func foo1(): () -> This {
		return { => this }
	}
}

main():Unit{

}

/* SCAN
error: 'This' type is not allowed
 ==> lambda.cj:4:21:
  | 
4 |     func foo1(): () -> This {
  |                        ^^^^ 
  | 
  # note: 'This' type can only be used as the return type of an instance member function in class

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
