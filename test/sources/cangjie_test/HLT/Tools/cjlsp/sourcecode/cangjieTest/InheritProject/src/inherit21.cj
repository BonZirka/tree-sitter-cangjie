/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default
import default.pkg1.* 
import default.pkg2.* 

interface K5 <: I3 & I5{
    static func name():Unit
    open prop ii_1:Int64{
        get(){1}
    }
}
