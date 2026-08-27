/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.typeHierarchy

interface AD1{}
interface AD2{}

class AD3 <: AD1 & AD2{}
interface AD4 <: AD2{}
extend Int64 <: AD4 & AD2{}
