/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %overflow_wrapping %cmp_opt %f -o %output

class a<b> {
    static var c = 5
}
main() {
    try {
        a.c >>= 0
    } catch (d: NoneValueException) {}
}
// ASSERT: scan sema_generic_type_without_type_argument


