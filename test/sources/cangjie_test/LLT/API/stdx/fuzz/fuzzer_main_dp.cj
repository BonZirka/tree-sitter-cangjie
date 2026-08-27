/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// (CJNATIVE and Linux) EXEC: %compiler %import-stdx-fuzz %cmp_opt -o %n.%suffix %f --sanitizer-coverage-inline-8bit-counters --link-options="--whole-archive $(find $CANGJIE_HOME -name libclang_rt.fuzzer_no_main.a) -no-whole-archive -lstdc++ -lpthread -lgcc_s"
// (CJNATIVE and Darwin) EXEC: %compiler %import-stdx-fuzz %cmp_opt -o %n.%suffix %f --sanitizer-coverage-inline-8bit-counters $(find $CANGJIE_HOME -name libclang_rt.fuzzer_no_main.a) -lc++
// (CJNATIVE and Unix) EXEC-PIPE: %set_stdx_path %run %set_stdx_path %run_opt %n.%suffix -max_len=1 2>&1 | compare %f
// ASSERT:scan ExhaustedException: Remaining data is not enough, please increase -max_len=N
// (CJNATIVE and Unix) EXEC-77: %set_stdx_path %run %set_stdx_path %run_opt %n.%suffix -max_len=1024
// (CJNATIVE and Unix) EXEC-77: %set_stdx_path %run %set_stdx_path %run_opt %n.%suffix
import stdx.fuzz.*

main() {
    Fuzzer(ttt).startFuzz()
    return 0
}

public func ttt(dp: FuzzDataProvider): Int32 {
    if (dp.consumeBool() && dp.consumeBool()) {
        throw Exception("TRAP!")
    }
    return 0
}
