func foo(){
    return 1
}

public interface I<T> {
    func f(): Int64 {
        return foo()
    }
}

public class C<T> <: I<Int64> {}

main() {
    return C<Int64>().f()
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
