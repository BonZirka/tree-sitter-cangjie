/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// (OHOS and not Android) LEVEL: 3
// (OHOS and not Android) EXEC: %compiler %cmp_opt -lcangjie-demangle %f -o %output
// (OHOS and not Android) RUN-EXEC: %run %run_opt %output %run_args

foreign func CJ_MRT_Demangle(str: CString): CString

main(): Int64 {
    var demangleResult = unsafe { LibC.mallocCString(" ") }

    unsafe {
        var returnValue = 1
        var input = LibC.mallocCString(" ")
        var result = CJ_MRT_Demangle(input)
        if (result.equals(demangleResult)) {
            returnValue = 0
        }
        LibC.free(input)
        LibC.free(result)
        LibC.free(demangleResult)
        return returnValue
    }
}
