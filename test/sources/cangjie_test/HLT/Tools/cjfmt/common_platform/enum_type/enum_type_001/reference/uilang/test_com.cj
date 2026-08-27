/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package mp

common public enum E1 {
    AB
}

common public enum E2<T> {
    AB | AB(T)
}

common protected enum E3<T, R> {
    AB | AB(T, R) | ...
}
