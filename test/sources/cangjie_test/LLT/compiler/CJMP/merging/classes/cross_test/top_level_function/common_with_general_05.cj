// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-0: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c
package cmp

public common class C {
    public common func testFunc(): Unit
    public init(){}
}

// SEPARATE-FILE: p/p.cj
// ERRCHECK: %compiler %diag_json --experimental p/p.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo -o %output
// ASSERT: scan sema_not_matched
package cmp

public specific class C {
}

public func testFunc(): Unit {
    println("2")
}

main(): Unit {
    C().testFunc()
    testFunc()
}

