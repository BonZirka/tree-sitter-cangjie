/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output

class A<T> {}

extend<T> A<T> {
    public func isClosed():Bool {
        print("A!");
        true
    }
    public func close():Unit {}
}

main() {
    try (x: A<Int64> = A<Int64>()) {
    } finally {}
    print("success!\n")
    return 0
}
// ASSERT: scan sema_mismatched_types
