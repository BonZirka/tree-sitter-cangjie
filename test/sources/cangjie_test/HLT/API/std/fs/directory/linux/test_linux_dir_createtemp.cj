/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// (not Windows or OHOS) EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (not Windows or OHOS) RUN-EXEC: export USER=`whoami` && %run %run_opt %output %run_utest_opt %run_args

/*
 * Test description: Test the Directory.createTemp
 * Test API: public static func createTemp(directoryPath: String): Directory
 *           public static func createTemp(directoryPath: Path): Directory
 */

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.process.*

var user = Option<String>.None

@Test
class Test_Dir_CreateTemp {
    public override func beforeAll(): Unit {
        user = Process.current.getEnv("USER")
    }

    @TestCase
    func test_createtemp_illegal(): Unit {
        var sum = 0
        var illegal_path_string = ["./\0", "/a\0"]
        try {
            Directory.createTemp("")
        } catch (e: IllegalArgumentException) {
            sum += 1
        }
        try {
            Directory.createTemp(Path(""))
        } catch (e: IllegalArgumentException) {
            sum += 1
        }
        for (str in illegal_path_string) {
            try {
                Directory.createTemp(str)
            } catch (e: IllegalArgumentException) {
                sum += 1
            }
            try {
                Directory.createTemp(Path(str))
            } catch (e: IllegalArgumentException) {
                sum += 1
            }
        }
        @Expect(sum, 6)
    }

    @TestCase
    func test_no_parent_dir(): Unit {
        var sum = 0
        @Expect(exists("dir001"), false)
        try {
            Directory.createTemp("dir001")
        } catch (e: FSException) {
            @Expect(e.message, "Failed to canonical: the input path `dir001` may not exist or permission denied!")
            sum += 1
        }
        @Expect(sum, 1)
    }

    @TestCase
    func test_no_permission(): Unit {
        var sum = 0
        Directory.create("dir001")
        @Assert(exists("dir001"), true)
        var dirinfo = FileInfo("dir001")
        dirinfo.setExecutable(false)
        try {
            Directory.createTemp("dir001")
        } catch (e: FSException) {
            @Expect(e.message, "Failed to create the temporary directory `dir001`!")
            sum += 1
        }
        match (user) {
            case Some("root") => @Expect(sum, 0)
            case _ => @Expect(sum, 1)
        }
        dirinfo.setExecutable(true)
        remove("dir001", recursive: true)
    }

    @TestCase
    func test_createtemp(): Unit {
        Directory.create("dir002")
        @Assert(exists("dir002"), true)
        @Expect(Directory.isEmpty("dir002"), true)
        var cretemp = Directory.createTemp("dir002")
        @Assert(exists(cretemp), true)
        @Expect(Directory.isEmpty("dir002"), false)
        remove("dir002", recursive: true)
    }
}
