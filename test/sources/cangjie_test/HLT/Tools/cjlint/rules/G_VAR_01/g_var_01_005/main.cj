/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE: %lint -f ./ 2>&1 | compare %f
// ASSERT: scan G.VAR.01: Prefer immutable variables when the value of the variable 'a' does not change.
func temp<T>(){
    var a = 1
    func temp1(){
    }
    temp1()
    return 1
}

main(){

}
