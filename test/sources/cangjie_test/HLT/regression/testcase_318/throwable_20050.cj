/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class A <: Exception{}
class B <: Exception{}


func test(){
    var x = 0
    var f1 = 0
    var f2 = 0
    try{
        try{
            throw B()
        } catch (e:B) {
            throw A()
        } finally {
            f1 = 1
        }
    } catch (e:A) {
        x = 2
    } finally {
        f2 = 1
    }
    if (f1 == 1 && f2 == 1){
        return x
    } else {
        return -1
  9  }
}

main() {
    test() - 2
}
