/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0


// ERRCHECK: %compiler %cmp_opt %f

class Coo<T> {
    public static func foo<V>(): Option<V> {
        return Option<V>.None
    }
    public static var a: Option<String> = foo<String>()
}

main(): Int64 {
    var i: Int32 = 3
    var a: Option<String> = Coo<String>.a
    var res = match (a) {
        case Some(x) => x
        case None => "No"
    }
    if (res != "No") {
        return 1
    }
    return 0
}

// ASSERT: scan-1 sema_static_variable_use_generic_parameter
