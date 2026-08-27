/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package UNNAMED

import java.lang.*

@JavaMirror["com.JavaClass"]
public open class JavaClass {
    public mut prop aBoolean: JArray<Bool>

    public mut prop aInt: JArray<Int32>

    public mut static prop arrayInt: JArray<Int32>

    public init(aInt: JArray<Int32>) 

    public open func getAInt(): JArray<Int32>

    public open func setAInt(aInt: JArray<Int32>): Unit

    public static func getArrayInt(): JArray<Int32>

    public static func setArrayInt(aInt: JArray<Int32>): Unit

    public init() 
}


