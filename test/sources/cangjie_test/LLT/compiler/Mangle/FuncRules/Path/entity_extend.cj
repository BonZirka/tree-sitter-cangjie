// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (CJNATIVE) EXEC: %compiler %cmp_opt %f --save-temps . --apc=1 -Woff unused --output-type=staticlib
// (CJNATIVE) EXEC: %llvmDissembler %n.bc -o %n.ll
// (CJNATIVE) EXEC: %cat %n.ll 2>&1 | compare %f
// (CJNATIVE) ASSERT: scan define void @_CN13entity_extendXCNY_1AE3fooHv
package entity_extend

class A {}

extend A {
    // 此处的 foo 函数 mangle 名为：_CN13entity_extendXCNY_1AE3fooHv
    func foo() {}
}

main() {
    A().foo()
    0
}
