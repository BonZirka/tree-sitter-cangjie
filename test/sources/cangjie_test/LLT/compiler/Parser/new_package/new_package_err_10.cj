// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// LEVEL 0
// ERRCHECK:%frontendCompiler %typecheck %diag_json %f

internal macro package a::b

main() {}
// ASSERT: scan package_root_package_should_be_public
