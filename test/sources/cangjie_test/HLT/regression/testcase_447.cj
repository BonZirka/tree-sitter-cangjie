/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


var cStr: CString = unsafe { LibC.mallocCString("init") }
@C
struct teststruct {
    public var canonname: CString = cStr
    public var next: CPointer<teststruct> = CPointer.teststruct>()
    public init(canonname!: CString = cStr, next!: CPointer<teststruct> = CPointer<teststruct>()) {
        this.canonname = canonname
        this.next = next
        unsafe { LibC.free(cStr) }
    }

}

foreign {
    func testfunc(str: CString, ppst: CPointer<CPointer<teststruct>>): CPointer<CPointer<teststruct>>
    func GetDoublePtr(): CPointer<CPointer<teststruct>>
    func MallocWithZero(size: UIntNative): CPointer<Unit>
    func free(cp: CPointer<Unit>): Unit
}

unsafe main():Int64 {
    var cStr1 = unsafe { LibC.mallocCString("abc") }
    var cStr2 = unsafe { LibC.mallocCString("efg") }
    var struct1 = teststruct(canonname: cStr1)

    LibC.free(cStr1)

    var p1 = MallocWithZero(16)
    var pst1 = CPointer<teststruct>(p1)
    pst1.write(struct1)

    var ppst1 = GetDoublePtr()
    ppst1.write(pst1)

    var ppst2 = testfunc(cStr2, ppst1)

    if ( ppst2.read().read().canonname.equals(cStr2)) {
        free(CPointer<Unit>(pst1))
        free(CPointer<Unit>(ppst2))
        LibC.free(cStr2)
        return 0
    } else {
        return 1
    }
}
// ASSERT: scan sema_undeclared_identifier


