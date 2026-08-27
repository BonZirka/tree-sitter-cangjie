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

main() {
    var score: Int64 = 0
    var res: String = match (score) { ; case 0 => "pass" ; case _ => "failed" ; }
    var res1: String = match (score) { case 0 => "pass" ; case _ => "failed" ; }
    var res2: String = match (score) {
    case 0 => "pass" ; case _ => "failed" ; }
}
