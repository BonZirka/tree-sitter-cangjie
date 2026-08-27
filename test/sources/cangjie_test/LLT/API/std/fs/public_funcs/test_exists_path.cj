/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (Linux) EXEC: %touch ifile && %lnfile ifile filelink
// (Linux) EXEC: %mkdir dir1 && %lnfile dir1 dirlink
// (Linux) EXEC: %mkdir dir2 && %touch dir2/ifile2
// (Windows) EXEC: type nul > ifile && mklink filelink ifile
// (Windows) EXEC: mkdir dir1 && mklink dirlink dir1
// (Windows) EXEC: mkdir dir2 && type nul > dir2/ifile2
// EXEC: %run %run_opt %output %run_utest_opt

import std.fs.*

@Test
class Test_Fs_exists {
    @TestCase
    func test1() {
        @Expect(exists(Path("ifile")))
        @Expect(exists(Path("filelink")))
        @Expect(exists(Path("dir2")))
        @Expect(exists(Path("dir2/ifile2")))
        @Expect(!exists(Path("dir1/file2")))
    }

    @TestCase
    func testException() {
        @ExpectThrows[IllegalArgumentException](exists(Path("dir\02")))
        @ExpectThrows[IllegalArgumentException](exists(Path("dir02\0")))
        @ExpectThrows[IllegalArgumentException](exists(Path("")))
    }
}

@Test
class Test_Fs_removeIfExists {
    @TestCase
    func test1() {
        @Expect(exists(Path("ifile")))
        @Expect(exists(Path("filelink")))
        @Expect(exists(Path("dir2")))
        @Expect(exists(Path("dir2/ifile2")))
        removeIfExists(Path("ifile"))
        removeIfExists(Path("filelink"))
        @ExpectThrows[FSException](removeIfExists(Path("dir2")))
        removeIfExists(Path("dir2"), recursive: true)
        removeIfExists(Path("dir2/ifile2"))
        @Expect(!exists(Path("ifile")))
        @Expect(!exists(Path("filelink")))
        @Expect(!exists(Path("dir2")))
        @Expect(!exists(Path("dir2/ifile2")))

        @Expect(!exists(Path("dir1/file2")))
        removeIfExists(Path("dir1/file2"))
        @Expect(!exists(Path("dir1/file2")))
    }

    @TestCase
    func testException() {
        @ExpectThrows[IllegalArgumentException](removeIfExists(Path("dir\02")))
        @ExpectThrows[IllegalArgumentException](removeIfExists(Path("dir2\0")))
        @ExpectThrows[IllegalArgumentException](removeIfExists(Path("")))
    }
}
