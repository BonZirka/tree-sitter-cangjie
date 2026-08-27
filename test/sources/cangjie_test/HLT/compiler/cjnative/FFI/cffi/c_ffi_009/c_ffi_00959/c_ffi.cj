/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL:2
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

@C
struct Test1<T> {
    var a: T

    init(a: T) {
        this.a = a
    }
}

struct Test2<T> {
    var a: Test1<T>

    init(a: T) {
        this.a = Test1<T>(a)
    }
}

class Test3<T> {
    var mem1: Test1<T>
    var mem2: T
    static var mem3: Test2<T> = Test2<T>(mem2)

    init(mem1: Test2<T>, mem2: T) {
        this.mem1 = mem1
        this.mem2 = mem2
    }
}

main() {
    var a1 = Test1<Int64>(0)
    var a2 = Test2<String>("")
    var a3 = Test3<Float32>(1.1)
}
// ASSERT: scan sema_cffi_cannot_have_type_param
// ASSERT: scan sema_illegal_member_of_cstruct
// ASSERT: scan sema_static_variable_cannot_access_non_static_member
// ASSERT: scan sema_used_before_initialization
// ASSERT: scan sema_mismatched_types
// ASSERT: scan sema_wrong_number_of_arguments
