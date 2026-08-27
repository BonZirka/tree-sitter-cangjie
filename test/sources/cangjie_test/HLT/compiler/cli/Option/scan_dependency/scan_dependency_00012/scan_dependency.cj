/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: pkgA
// EXEC-PIPE: %compiler -p pkgA %compile_lib_opt
// EXEC-PIPE: %compiler --scan-dependency pkgA.cjo 2>&1 | compare %f
// ASSERT: scan {"package":"pkgA","isMacro":false,"accessLevel":"public","dependencies":[],"std-dependencies":[{"std.core":[]}],"features":[],"product":true}

