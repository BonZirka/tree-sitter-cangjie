struct S
{
    @OverflowThrowing // Annotation
    static 
    public // Modifier
    func get  // Identifier
    <T> // Generic Param
    (a  // Param name
    !  // is named
    :Int64  // param type
    = 1  // initializer
    ) 
    // RetType
    where T <: ToString // Generic Constraint
    {
        3   // a) body change with type, b) body change without type
    }
}

main(): Int64 { 0 }

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
