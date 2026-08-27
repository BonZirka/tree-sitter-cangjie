// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output %run_args

main(): Int64 {
    var j : Int32 = 0

    match (j) {case _ => 0}

    match (j) {case _ => 0;}

    match (j) {case _ => 0
    }

    match (j) {case _ => 0
     1   }

    match (j) {case _ => 0
             case 1 => 1}

    match (j) {case _ => 0
             case 1 => 1;
            }

    match (j) {case _ => 0;
             case 1 => 1;}

    match (j) {case _ => 0; case 1 => 1

            }

    match (j) {case _ => 0 case 1 => 1}

    match (j) {case _ => 0
             case 1 => 1
             }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
