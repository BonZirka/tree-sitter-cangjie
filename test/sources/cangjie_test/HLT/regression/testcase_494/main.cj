/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
class A <: Exception{}

class B <: Exception{}

class C{
    public static var a : Int64 = if (true) {throw A();1} else {2} // throw before main
    public static var b : Int64 = 1
}

main() {
    try{
        C.b;
        ()
    } catch (a:Error) {
        a.printStackTrace()
        print("success")
    }
    return 0
}


