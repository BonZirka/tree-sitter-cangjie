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

public let var_1685877180523_552 : UInt16 = UInt16(95)
public let var_1685877180523_1085 : UInt32 = UInt32(204)

main() : Int64{
    let var_1685877180523_1331 : UInt32 = UInt32(82);
    [var_1685877180523_1085 < var_1685877180523_1331, var_1685877180523_552 >= UInt16(17)][0];
    0
}
