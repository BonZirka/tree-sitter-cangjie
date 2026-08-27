/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.fuzz

const oomInformation = ###"OutOfMemoryError throws during fuzz.
It happens everywhere in the program, no stacktrace for OutOfMemoryError"###

// When OOMError throws, fuzzer will exit. No need to free CString.
// If it doesn't throw, we don't have the right time to free CString.
let oomString: CString = unsafe { LibC.mallocCString(oomInformation) }
