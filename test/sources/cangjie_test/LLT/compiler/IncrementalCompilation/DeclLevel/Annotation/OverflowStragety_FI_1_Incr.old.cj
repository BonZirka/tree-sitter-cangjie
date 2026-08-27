package inc

@OverflowSaturating
public func foo(a:UInt8):UInt8{
    return a * 2
}

@OverflowSaturating
public func bar():UInt8{
    foo(0xfeu8)
}

main():UInt8{
    if(255u8 == bar()){
        return 0
    }
    return 1
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
