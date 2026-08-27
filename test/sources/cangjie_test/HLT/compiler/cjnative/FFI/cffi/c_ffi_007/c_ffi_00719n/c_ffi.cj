/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL:2
// DEPENDENCE: %n.c cfg.json
// (not Windows) EXEC: %sed %sed_opt "s!cangjieCFFI_path!%cstring_cjo!g" cfg.json
// (not Windows) EXEC: %clang %clang_opt %n.c -o %cffi_output
// (not Windows) EXEC-PIPE-1: %compiler %cmp_opt %ffic_opt -o %output 2>&1 | compare %f

foreign func testfunc(): CPointer<Int8>

main(): Int64 {
    var ptr: CPointer<Int8> = testfunc()
    if (!ptr.isNotNull()) {
        return 1
    }

    if (ptr.isNull()) {
        return 2
    }

    var ptrtmp: CPointer<Int8> = ptr + 1
    print("before: ")
    print((ptrtmp - 1).read().toString())
    print(ptrtmp.read().toString())
    print((ptrtmp + 1).read().toString())

    if ((ptrtmp - 1).read() == -128 && ptrtmp.read() == 0 && (ptrtmp + 1).read() == 127) {
        (ptrtmp - 1).write(-1)
        ptr.write(1, 0)
        (ptrtmp + 1).write(1)
    } else {
        return 3
    }

    print("\n")
    print("after: ")
    print(ptr.read(0).toString())
    print(ptr.read(1).toString())
    print(ptr.read(2).toString())
    return 0
}
// (not Windows) ASSERT: scan sema_unsafe_function_invoke_failed
