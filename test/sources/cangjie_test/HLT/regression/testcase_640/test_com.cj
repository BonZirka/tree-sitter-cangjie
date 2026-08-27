/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: com
// EXEC: %compiler %cmp_opt com/*.cj %compile_lib_opt -o com.%middle
// EXEC: %compiler %cmp_opt -L./ test_com.cj com.%middle -o %output
// RUN-EXEC: %run %run_opt %output

import com.*

//// EXEC: %compiler %cmp_opt %compile_lib_opt com/*.cj -o com.%middle
//// EXEC: %compiler %cmp_opt com.%middle %f -o ./%n
//// EXEC: %compiler %compile_dylib_opt com/*.cj -o libcom.%test_suffix
//// EXEC: %compiler -lcom -L./ test_com.cj -o ./%output
// %compiler %compile_dylib_opt com/*.cj -o libcom.%test_suffix
// %compiler -lcom -L./ test_com.cj

main(){
    hi()
    return 0
}
