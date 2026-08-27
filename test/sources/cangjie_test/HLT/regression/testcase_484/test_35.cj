/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

@C
struct CBox {
    @C
    public var raw: CPointer<Unit>
}

class SomeClass {
    public var ptr: CBox
    public init(ptr: CBox) {
        this.ptr = ptr
    }
}

// (!(target_ios | target_ios_simulator)) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_illegal_use_of_annotation
// ASSERT: scan sema_class_uninitialized_field
