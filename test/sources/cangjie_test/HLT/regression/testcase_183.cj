/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler  %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

main (){
    let mt: IsTest = MyTest()
    if(testAny(mt)){
        return 0
    }
    return 1
}

public interface IsTest { }

public class MyTest <: IsTest {
    public var num: Int64 = 0
}

public func testAny(mt: Any): Bool {
    let flag: Bool = mt is MyTest
    
    if(flag){
        return match(mt as MyTest) {
            case Some(v) => true
            case None => false
        }
    }else{
        return false
    }
}

