/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 3.2.1.10.2.3
  @Scene: delete
  @Visibility: public|non public
  @Object: struct instance func
  @Behavior: delete @Deprecated
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

// test struct: delete @Deprecated
package test_stable_abi


public struct Rectangle {
    static let width = 10

    public func getWidth(): Int64{
        return width
    }

    func geta1() {
        return 0
    }

    public func geta2() {
        return 1
    }

    func geta3() {
        return 2
    }

    public func geta4() {
        return 3
    }

    public func geta5() {
        return 4
    }

    @Frozen
    public func get5() {
        let x = geta1()
        return x
    }

    @Frozen
    public func get6() {
        let x = geta3()
        return x
    }
}

public func assert<T>(expected:T, actual:T) : Unit where T <: Equatable<T> & ToString{
    if(expected == actual){
    }else{
        throw Exception("${expected} != ${actual}")
    }
}

public func check(){
    assert(Rectangle().geta1(), 0)
    assert(Rectangle().geta3(), 2)
    assert(Rectangle().geta4(), 3)
    assert(Rectangle().geta5(), 4)
    return 0
}

