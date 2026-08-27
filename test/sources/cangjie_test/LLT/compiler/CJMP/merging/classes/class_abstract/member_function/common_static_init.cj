// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-0: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c
package cmp

 public common class A {
    public static let degree: Int64
    static init() {
        degree = 180
    }
    public init(){}
}

// SEPARATE-FILE: p/p.cj
// EXEC-0: %compiler %noColor --experimental p/p.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo --output-type=dylib --output-dir ./p
package cmp

public specific class A {

}

// SEPARATE-FILE: m_common.cj
// EXEC-0: %compiler %noColor -j8 m_common.cj --import-path=./p -L./p -lcmp -o %output
import cmp.*

main(): Unit {
   
    println(A.degree)

}
// (CJNATIVE and Linux)EXEC-PIPE: LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f
// (CJNATIVE and Windows)EXEC-PIPE: set PATH=./p;%PATH% && %run %output 2>&1 | compare %f
// (CJNATIVE and Darwin)EXEC-PIPE: DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f


/* SCAN
180
*/
