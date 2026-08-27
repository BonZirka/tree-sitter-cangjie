/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// !!!NOTE!!!: This testcase can only be run at real device, emulator is NOT support.

// We require --link-options=--export-dynamic, so that dlsym can find functions below

// LEVEL: 3
// (OHOS and not Android) DEPENDENCE: ../exploit-wrapper.cj
// (OHOS and not Android) DEPENDENCE: ../exploit.c
// (Windows and OHOS and not Android) EXEC: %clang -c -march=armv8+pauth -fPIC %ohos_opt --sysroot=%OHOS_ROOT%/sysroot exploit.c -o exploit.o
// (MAC and OHOS and not Android) EXEC: %clang -c -march=armv8+pauth -fPIC %ohos_opt --sysroot=${OHOS_ROOT}/sysroot exploit.c -o exploit.o
// (OHOS and not Android) EXEC: %compiler %cmp_opt --link-options=--export-dynamic -ldl -o %n.%suffix %f exploit-wrapper.cj exploit.o

// In our test, runtime or ohos will rethrow SIGILL(6) as SIGSEGV(11),
// so we use 11 as return code here.
// However, runtime will print SIGILL any way, so we can scan SIGILL here

// (OHOS and not Android) RUN-EXEC-PIPE-132: %run %run_opt %n.%suffix 2>&1 | compare %f
// (OHOS and not Android) ASSERT: scan SIGILL

import std.process.Process

public func exploited(): Unit {
    try {
        // dummy code, make space for offset
        print("unreachable")
        print("unreachable")
        print("unreachable")
        print("unreachable")
        print("unreachable")
        print("unreachable")
    } catch (e: Exception) {
        print("ROP exploited!")
        Process.current.exit(1)
    }
}

public func userException(): Unit {
    // noinline in O2
    var arr = Array<Int64>(2, repeat: 0)
    print("dummy: ${arr[1]}")
    throw Exception()
}

public func victim(): Unit {

    // noinline in O2
    var arr = Array<Int64>(2, repeat: 0)
    print("dummy: ${arr[1]}")
    var conf = ExploitConfig(
        returnAddressAddon: 0x40,
        victimMangleName: "_CN7default6victimHv",
        exploitMangleName: "_CN7default9exploitedHv"
    )
    unsafe { ropAttacker(inout conf) }
    userException()
}

public func nestFunc(): Unit {
    victim()
}

main() {
    try {
        nestFunc()
    } catch (e: Exception) {
        print("Exception catched")
    }
    return 1
}
