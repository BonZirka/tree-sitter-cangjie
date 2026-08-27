/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// line comment1
extend<T> A<T> /* block comment1 */ where T <: I1 {
    public func foo() {}
    // line comment2
    public mut prop _prop: Int64 {
        /* block comment2 */
        get( /** document comment1 */ ) { 0  /** document comment2 */}

        set(/* block comment3 */ v) {
            // line comment3
        }
    }
} // line comment4