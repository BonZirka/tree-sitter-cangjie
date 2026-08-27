// EXEC: %compiler %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

@Annotation
public class APILevel {
    public const APILevel(public let value!: Int = 3) {}
}

@!APILevel
public class Some {
    @!APILevel let a = 1
    @!APILevel func foo() {}
    @!APILevel init() {}
}

@!APILevel
enum S {
    @!APILevel R 
    | @!APILevel SS(Int)
}

@!APILevel
extend Some {
    @!APILevel
    func bar() {}
}

main() {
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
