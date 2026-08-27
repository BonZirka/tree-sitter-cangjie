/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt  %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

type hF =  (String) -> String

func Aprint (f:hF, name: String) {
    let r = f(name)
    print("${r}\n")
}

main() {
    let Dff:hF = {name:String => "你好: ${name}"}
    Aprint(Dff, "仓颉")
    return 0
}
