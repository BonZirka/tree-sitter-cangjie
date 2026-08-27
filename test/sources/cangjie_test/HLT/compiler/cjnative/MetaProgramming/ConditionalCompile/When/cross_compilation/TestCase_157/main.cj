/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Level: 1
// Description:
// EXEC: %compiler %cmp_opt main.cj -o %output
// (target_aarch64 & target_mac) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_x86_64 & target_mac) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_aarch64 & target_ios) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_x86_64 & target_ios_simulator) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_aarch64 & target_ios_simulator) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_x86_64 & target_win) RUN-EXEC: %run %run_opt %output %run_args
// (target_aarch64 & target_linux) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_x86_64 & target_linux) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_aarch64 & target_ohos) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_aarch64 & target_android) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_aarch32 & target_android) RUN-EXEC-3: %run %run_opt %output %run_args
// (target_x86_64 & target_android) RUN-EXEC-3: %run %run_opt %output %run_args

public open class P {
    public open func foo(): Int64 {
        3i64
    }
}

public class S <: P {
    @When[os == "Windows" && arch == "x86_64" && env != "ohos"]
    public func foo(): Int64 {
        0i64
    }
}

main(): Int64 {
    S().foo()
}
