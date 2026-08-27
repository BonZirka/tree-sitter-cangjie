/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// (not (JS or VM) and not iOS) ERRCHECK: %compiler %cmp_opt %f -o %output
// (JS or VM) EXEC-0: %compiler %cmp_opt %f -o %output
// ASSERT: regex-not Cangjie::CodeGen::CodeGenerator::AttachFuncInfo
// ASSERT: regex-not core dumped



foreign func printf(fmt: CString, ...): Int32
foreign func testfunc(): CPointer<CString>

unsafe main():Int64 {
    var ptr: CPointer<CString> = testfunc() 

    printf(ptr.read(0))
    printf;(ptr.read(1))

    return 0
}
