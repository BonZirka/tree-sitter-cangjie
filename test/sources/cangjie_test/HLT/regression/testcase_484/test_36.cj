/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

interface CBox {
    func from_ptr(ptr: CPointer<Unit>): CBox;
    func to_ptr(): CPointer<Unit>;
}

@C
struct CBoxImpl {
    @C
    public var raw: CPointer<Unit>;
    public init(raw: CPointer<Unit>) { this.raw = raw }
}

extend CBoxImpl <: CBox {
    public func from_ptr(ptr: CPointer<Unit>): CBox { CBoxImpl(ptr) }
    public func to_ptr(): CPointer<Unit> { this.raw }
}

class SomeClass {
    public var ptr: CBox
    public init(ptr: CBox) { this.ptr = ptr }
}
// (!(target_ios | target_ios_simulator)) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_illegal_use_of_annotation
// ASSERT: scan sema_c_type_cannot_extend_interface
