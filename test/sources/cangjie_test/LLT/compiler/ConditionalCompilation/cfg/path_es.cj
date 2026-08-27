// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: ./pa=h
// DEPENDENCE: ./p==h
// DEPENDENCE: ./p=a=t=h
// (not Windows)EXEC:%compiler %cmp_opt %n.cj %conditional_compilation_config_opt="./pa\\=h"
// (not Windows)EXEC:%compiler %cmp_opt %n.cj %conditional_compilation_config_opt="./p\\=\\=h"
// (not Windows)EXEC:%compiler %cmp_opt %n.cj %conditional_compilation_config_opt="./p\\=a\\=t\\=h"

@When[k=="v"]
var a = 0

main() {
    return a
}
