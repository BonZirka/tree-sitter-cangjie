/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0 EXCLUDE DTS2025070902735
// DEPENDENCE: A/A.cj B/B.cj B/B1.cj
// EXEC: %compiler %cmp_opt %compile_lib_opt A.cj -o A.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt B.cj B1.cj -o B.%middle
// EXEC: %compiler %cmp_opt %f B.%middle A.%middle -g -o %output
// RUN-EXEC: %run %run_opt %output %run_args

package C
import A.*
import B.*
main () {
    var x :I2<Int64,Any> = Empty<Int64,Any>.instance
    
    
    0
}
