func foo(){
    return 1
}

public enum E<T> {
    R | G | B

    public func f(): Int64 {
        return foo()
    }
}

main() {
    return E<Int64>.R.f()
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
