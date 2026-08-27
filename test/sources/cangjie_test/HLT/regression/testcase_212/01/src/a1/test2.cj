/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package a1

public let var32 : Option<Option<Int64>> = Option<Option<Int64>>.None

public func func15(optionalParam16 ! : Float64 = 118.0) : Int64 {

    var var64 : Int64 = (-21);

    (var32 ?? try { 
        if (true) { Option<Int64>.None } else { var64 } 
    } finally {
        var64
    }) ?? try {
        var64
    } catch (e: Exception) { 
        var64
    }
}

