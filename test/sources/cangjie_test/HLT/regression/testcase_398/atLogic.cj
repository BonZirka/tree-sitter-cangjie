/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
public func testIterableAt<T>(itT1: Iterable<T>,n:Int64,atResultExpect: Option<T>):Int64  where  T <: Comparable<T> {
   var atFunc=at<T>(n)
   var atResultActual=atFunc(itT1)
   if(atResultActual!=atResultExpect){
       return 1
   }
   return 0
}

