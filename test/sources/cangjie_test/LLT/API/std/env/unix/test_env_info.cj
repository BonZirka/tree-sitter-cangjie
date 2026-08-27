/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// (Unix)EXEC: %compiler %cmp_opt %f --test -o %output
// (Unix)EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT:regex-begin .*PASSED.*: 4,.*SKIPPED.*: 0,.*ERROR.*: 0
// ASSERT:regex-next .*FAILED.*: 0

import std.math.*
import std.collection.*
import std.posix.*
import std.env.*
import std.unittest.*
import std.unittest.testmacro.*

let argCount = 0
let currentPid: Int64 = Int64(getpid())

func checkMapEqual(envFromOs: Array<(String, String)>, envFromCurProcess: Array<(String, String)>): Bool {
    if (envFromOs.size == envFromCurProcess.size) {
        for (i in 0..envFromOs.size) {
            if (envFromOs[i][0] != envFromCurProcess[i][0] || envFromOs[i][1] != envFromCurProcess[i][1]) {
                return false
            }
        }
        return true
    }
    return false
}

@Test
public class Test_env_info {
    @TestCase
    func case_test_info_1(): Unit {
        @Expect(getProcessId() > 0, true)
        @Expect(getProcessId() < Int64(Int32.Max), true)
        @Expect(getProcessId(), currentPid)
        @Expect(getCommand().size > 0, true)
        @Expect(getCommandLine().size > 0, true)
        @Expect(getHomeDirectory().toString().size > 0, true)
        @Expect(getTempDirectory().toString().size > 0, true)
    }

    @TestCase
    func case_test_info_2(): Unit {
        @Expect(getProcessId() > 0, true)
        @Expect(getProcessId() < Int64(Int32.Max), true)
        @Expect(getProcessId(), getProcessId())
        @Expect(getCommand(), getCommand())
        @Expect(getCommandLine(), getCommandLine())
        @Expect(getWorkingDirectory().toString(), getWorkingDirectory().toString())
        @Expect(getHomeDirectory().toString(), getHomeDirectory().toString())
        @Expect(getTempDirectory().toString(), getTempDirectory().toString())
        @Expect(checkMapEqual(getVariables(), getVariables()), true)
    }

    @TestCase
    func case_test_info_3(): Unit {
        setVariable("currentProcess", "test")
        @Expect(getProcessId() > 0, true)
        @Expect(getProcessId() < Int64(Int32.Max), true)
        @Expect(getProcessId(), currentPid)
        @Expect(getCommand().size > 0, true)
        @Expect(getCommandLine().size > 0, true)
        @Expect(getVariable("currentProcess"), Some("test"))
        removeVariable("currentProcess")
        @Expect(getVariable("currentProcess"), None)
    }

    @TestCase
    func case_test_info_4(): Unit {
        try {
            getVariable("\0")
            @Expect(false)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The path cannot contain null character!")
        }
    }
}
