// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-0: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c
package cmp

common interface IA {
    common func foo():Unit
}

common extend Int64 <: IA {
    common public func foo():Unit {
        println("common::Int64::foo")
    }
}

common public func int64Foo():Unit {
    var x:Int64 = 100
    x.foo()
}


// SEPARATE-FILE: p/p.cj
// EXEC-0: %compiler %noColor --experimental p/p.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo --output-type=dylib --output-dir ./p
package cmp

specific interface IA {
}

specific extend Int64 <: IA {
    specific public func foo():Unit {
        println("specific::Int64::foo")
    }
}


// SEPARATE-FILE: m_common.cj
// EXEC-0: %compiler %noColor m_common.cj --import-path=./p -L./p -lcmp -o %output
// (CJNATIVE and Linux)EXEC-PIPE-0: LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f
// (CJNATIVE and Windows)EXEC-PIPE-0: set PATH=./p;%PATH% && %run %output 2>&1 | compare %f
// (CJNATIVE and Darwin)EXEC-PIPE-0: DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f
// ASSERT: scan specific::Int64::foo
import cmp.*

main() {
    int64Foo()
    return 0
}
