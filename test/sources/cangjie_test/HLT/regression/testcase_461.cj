/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

public struct Aggregate7<T0> {

    static func func12<T0, T1>(param13 : T0, param14 ! : String) : Unit { 

        var loopTimeVar : Range<Int64> = (1..1:(1|1));
        for (i in loopTimeVar where (false)) {
            (match (loopTimeVar) {
                case _ => 
                    func identity<T0>(a : T0) : T0 { 
                        a
                    }
                    var var33 : Option<Unit> = Option<Unit>.Some(());
                    var False343691 : Bool = false;
                    (False343691 = identity(False343691));           
                    var33      
            } ?? func64())
        };
	for (i in loopTimeVar where (true)) {
            (match (loopTimeVar) {
                case _ => 
                    func identity<T0>(a : T0) : T0 { 
                        a
                    }
                    var var33 : Option<Unit> = Option<Unit>.Some(());
                    var False343691 : Bool = false;
                    (False343691 = identity(False343691));           
                    var33      
            } ?? func64())
        };
    }

}

public func func64() : Unit { 

}

main(): Int64 {

    Aggregate7<Int32>.func12<Bool, Float32>(true, param14 : "Any String"); 
    return 0;
}

