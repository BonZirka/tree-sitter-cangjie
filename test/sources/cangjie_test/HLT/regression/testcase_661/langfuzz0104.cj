/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


 let var536:Int16 = Int16(-104)
 open class Class1390 <: Class14{
    public open func function1906():Bool{
       var536 < (var536>>(var536 & 7))
    }
    public var var1838:Class32=Class32()
}
main():Int64 {
    return 0
}
// ASSERT: scan sema_undeclared_type_name
// ASSERT: scan sema_undeclared_identifier
