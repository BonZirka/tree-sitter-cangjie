/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 3.2.1.3.2
  @Scene: modify
  @Visibility: non public
  @Object: struct
  @Behavior: modifier: non public -> public
  @Expect: api compatible & abi compatible
*/
// LEVEL: 1
// DEPENDENCE: main.cj, template.cj
// EXEC: %compiler %cmp_opt %compile_dylib_opt template.cj -o libstable_abi.%dylib_suffix
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// EXEC: %rm libstable_abi.%dylib_suffix
// EXEC: %mv test_stable_abi.cjo old.cjo
// EXEC: %compiler %cmp_opt %compile_dylib_opt %f -o libstable_abi.%dylib_suffix

// TEST CJCPL
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare template.cj
// TEST ABI Compatibility
// RUN-EXEC: %run %run_opt %output %run_args
// TEST API Compatibility
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args

// test struct: add access modifier: Invisible to Visible
package test_stable_abi

public struct S1 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

public struct S2 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}


private struct S4 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

internal struct S5 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

struct S6 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

protected struct S7 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

public struct S8 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}

struct S9 {
    let x: Int64 = 0

    public func getX(): Int64 {
        return x
    }
}


public func f(){
    var a = S2().getX() + S4().getX() + S5().getX() + S7().getX() + S6().getX() + S9().getX()
    return a
}