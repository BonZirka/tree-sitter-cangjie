/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

interface I0 <: I2{
interface I0 <: I2{

  interface I1 <: I2.I3{}
}

interface I2 <: I0.I1{
  interface I3 <: I0{}
}

  interface I1 <: I2.I3{}
}

interface I2 <: I0.I1{
  interface I3 <: I0{}
}
// ASSERT: scan parse_unexpected_declaration_in_scope
