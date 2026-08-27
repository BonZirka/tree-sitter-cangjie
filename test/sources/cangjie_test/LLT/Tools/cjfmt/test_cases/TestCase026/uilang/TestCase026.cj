// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

/*
  注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释注释
 */
func demo() {}

main() {
    let code = "" + "a,b#\n" // 1)
    + "\"\n\",\" \",#\n" // 2)
    + "#,\"\"\n" // 3)
    + "# Final comment\n" // 4)
    println("code")
}