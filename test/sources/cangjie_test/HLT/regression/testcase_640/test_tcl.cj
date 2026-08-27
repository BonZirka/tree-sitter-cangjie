/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: tcl
// EXEC: %compiler %cmp_opt %compile_lib_opt tcl/*.cj -o tcl.%middle
// EXEC: %compiler %cmp_opt tcl.%middle %f -o %output
// RUN-EXEC: %run %run_opt %output
//// RUN-EXEC: %run %run_opt %output %run_args

import tcl.*

// cjc %compile_dylib_opt com/*.cj -o libcom.so
// cjc -lcom -L./ test_com.cj

main(){
    hi()
    return 0
}