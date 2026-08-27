/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// (not Windows) EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (not Windows) RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 
import std.unittest.*
import std.unittest.testmacro.*
import std.posix.*

@Test
class Test_openat {
    @TestCase
    func test_openat_01(): Unit {
        var flag: Bool
        var cre = creat("file.txt", S_IRWXU)
        @Assert(cre != -1, true)
        let fd = `open`("./", O_RDONLY)
        @Assert(fd != -1, true)
        let res = openat(fd, "file.txt", O_RDWR)
        @Assert(res != -1, true)
        close(fd)
        if (res > 1) {
            flag = true
        } else {
            flag = false
        }
        remove("file.txt")
        @Assert(flag, true)
    }

    @TestCase
    func test_openat_02(): Unit {
        var cre = creat("file.txt", S_IRWXU)
        @Assert(cre != -1, true)
        let fd = `open`("./", O_RDONLY)
        @Assert(fd != -1, true)
        let res = openat(fd, "/", O_RDWR)
        @Assert(res != -1, false)
        close(fd)
        remove("file.txt")
        @Assert(res, -1)
    }

    @TestCase
    func test_openat_03(): Unit {
        let res = openat(
            0,
            "/file.txt",
            O_RDWR
        )
        @Assert(res, -1)
    }

    @TestCase
    func test_openat_04(): Unit {
        var count = 0
        try {
            let fd = `open`(
                "\0",
                O_RDONLY
            )
            let res = openat(fd, "/", O_RDWR)
        } catch (e: IllegalArgumentException) {
            count += 1
        }
        @Assert(count, 1)
    }
}
