/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import stdx.crypto.common.*

const CJ_FAIL: Int32 = -1
const CJ_NEED_READ: Int32 = -2
const CJ_NEED_WRITE: Int32 = -3
const CJ_OK: Int32 = 1

@C
struct Ssl {}

@C
struct Ctx {}

foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32
