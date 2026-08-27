/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 

class C{
        public var a = 1
}

main(){
    var a:C = C()
    var b:C = C()
    var c:List<C> = [a,b]
    print("${c}.\n")
    return 0
}
// ASSERT: scan sema_undeclared_type_name


