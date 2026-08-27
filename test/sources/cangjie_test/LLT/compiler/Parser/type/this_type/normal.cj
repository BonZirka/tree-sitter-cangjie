// EXEC-0: %frontendCompiler %front_cmp_opt %f 

class A {
	func foo1(): This { // OK
		return this
	}
}

main():Unit{

}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
