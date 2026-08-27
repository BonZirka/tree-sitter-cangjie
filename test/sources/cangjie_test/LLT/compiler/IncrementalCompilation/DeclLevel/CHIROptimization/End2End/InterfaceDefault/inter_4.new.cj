func foo():Int64 {
    1
}

public interface I{
    func f():Int64 {
        return foo()
    }
}

public enum E <: I{
    R | G | B
}

main() {
    return E.R.f()
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
