/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


public struct Struct_1667372034121_7 {
    unsafe public Struct_1667372034121_7() { // block id: 26
        func_1667372034121_28(namedParam_1667372034121_30 : ({ lambdaParameter_1667372034121_314 : Int64 => func_1667372034121_51() }(1)));
    }
}

public func func_1667372034121_28(namedParam_1667372034121_30 ! : UInt8) : Unit { // block id: 31

}

unsafe public func func_1667372034121_51() : UInt8 { // block id: 53
    UInt8(1);
}

main(): Int64 {
    return 0;
}
// ASSERT: scan parse_illegal_modifier_in_scope


