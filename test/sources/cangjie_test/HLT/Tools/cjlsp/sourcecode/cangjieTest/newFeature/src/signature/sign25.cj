/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.signature

enum EE{
    |xx(Int64)|yy(Int64,Float64)
}

var m1 = EE.xx(8)
var m2 = EE.yy(33,222.0)
var m3 = xx(4)
