/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC-3: %run %run_opt %output %run_args

class A <: Exception {
    public override prop message:String{ get(){return "a"}}
    public override func toString():String{ return "b"}
}


class B{
    public func test(){
        throw A()
    }
}

main() {
    var a = A()
    var res = 3
    try{
        B().test()
    }
    catch (e:A){
        print(e.message)
        print(e.toString())
        e.printStackTrace()
      0;return res}
    res = 4
    return res
}
