/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


main():Int64 {
    var MyChild = Child()
    if ( MyChild.a != 2 ) {
        return 1
    }
    if ( Son.a != 3 ) {
        return 1
    }
    return 0
}

open class Father {
    static private var a  = 1
}

class Child <: Father {
    public var a  = 2
}

class Son <: Father {
    public static var a  = H
}
// ASSERT: scan sema_undeclared_identifier


