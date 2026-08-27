/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

interface AA { 
    prop aa1:Int64

}

struct B1B <: AA{
   public prop aa1:Int64 {
        get(){
            return 0
        }
    }
}

var fq1 = B1B().aa1
