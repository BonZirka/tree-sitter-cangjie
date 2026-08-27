/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



main() : Int64 {
    if( Range<Int64>.ns != 3) {
        return 3
    }
    if( Range<rnt64>.ms != 4) {
        return 4
    }
    return 0
}

extend<T> Range<T> where T <: Countable<T> & Comparable<T> & Equatable<T> {
    public static prop ms: Int64 {
        get() {
            return 4
        }
    }
    public static prop ns: Int64 {
        get() {
            return 3
        }
    }
}
// ASSERT: scan sema_undeclared_type_name
