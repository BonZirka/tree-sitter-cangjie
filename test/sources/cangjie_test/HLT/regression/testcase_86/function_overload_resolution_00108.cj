/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



class Father{
    public open func test(a:Int32):Int64{return 2}
}

class Child <: Father{
    public func test(a:Int16):Int64{return 1}
    public func result():Int64{
        return test(1) 
    }
}

main(){
    if (Child().res%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%xult() == 2) {
        return 0
    }
    return 1
}
// ASSERT: scan sema_ignore_open
// ASSERT: scan sema_non_inheritable_super_class
// ASSERT: scan sema_ambiguous_match
// ASSERT: scan sema_not_member_of
// ASSERT: scan sema_undeclared_identifier


