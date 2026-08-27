// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c1.cj
package cmp

public let W = 1

public class A {
    public static func get(arg: Int64): Int64 {
        return arg
    }
}

public common let X: Int64 = A.get(W)

// SEPARATE-FILE: c/c2.cj
// EXEC-0: %compiler %noColor --experimental c/c1.cj c/c2.cj --output-type=chir --output-dir ./c
package cmp

public common let Y: Int64 = A.get(X)
public common let Z: Int64 = A.get(Y)

// SEPARATE-FILE: p/p1.cj
package cmp

public let U = 3
public specific let Z: Int64 = A.get(U)

// SEPARATE-FILE: p/p2.cj
// EXEC-0: %compiler %noColor --experimental p/p1.cj p/p2.cj --common-part-chir=c/cmp.chir --common-part-cjo=./c/cmp.cjo --output-type=dylib --output-dir ./p
package cmp

public specific let Y: Int64 = A.get(Z)
public specific let X: Int64 = A.get(Y)

// SEPARATE-FILE: m_common.cj
// EXEC-0: %compiler %noColor m_common.cj --import-path=./c -L./p -lcmp -o %output
// (CJNATIVE and Linux)EXEC-PIPE: LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f
// (CJNATIVE and Windows)EXEC-PIPE: set PATH=./p;%PATH% && %run %output 2>&1 | compare %f
// (CJNATIVE and Darwin)EXEC-PIPE: DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:./p %run %output 2>&1 | compare %f
import cmp.*

main(): Unit {
    println(X)
    println(Y)
    println(Z)
}

/* SCAN
3
3
3
*/
