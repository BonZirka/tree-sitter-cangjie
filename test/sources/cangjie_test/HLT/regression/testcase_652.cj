/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

func func32(param33 : UInt16) : Unit { // block id: 34
}


public func func32(param27 : String) : Bool { // block id: 28
    func32(match (param27) {
            case caseVar271 : Range<Int16> =>
                UInt16(69);
            case caseVar279 =>
                UInt16(69);
            case _ =>
                UInt16(111);
        })
    true
}

main(): Int64 {
    return 0;
}
