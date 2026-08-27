/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// (not VM and not iOS) ERRCHECK: %compiler %cmp_opt %f -o %output
// (not VM and not iOS) ASSERT: regex-not Cangjie::CodeGen::CodeGenerator::GenerateAllInitFunctions



interface I {
    func foo(): CString {
        return unsafe { LibC.mallocCString("CANG") }
    }
}

foreign {
    func testfunc(): CPointer<CString>
}

extend<T> CPointer<T> <: I {
    public func goo(): CString {
        return unsafe { LibC.mallocCString("CANG") }
    }
}

unsafe main():Int64 {
    var count = 0

    var p1: CPointer<CString> = testfunc()

    if ( (p1.read(0).equals(LibC.mallocCString("cang"))) && (p1.read(1).equals(LibC.mallocCString("jie"))) ) {
        count += 1
    }

    if (p1.foo().equals(LibC.mallocCString("CANG"))) {
        count += 1
    }

    if (count == 2) {
        return 0
    } else {
        return 1
    }
}


