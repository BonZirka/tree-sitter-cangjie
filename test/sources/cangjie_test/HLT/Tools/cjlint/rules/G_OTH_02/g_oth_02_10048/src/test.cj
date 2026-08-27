/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

func test(){
    try{
        var passwd = "Example@123"
    } catch (_:Exception){
        var passwd = "Example@123"
    } finally{
        var passwd = "Example@123"
    }
}

main(){}
