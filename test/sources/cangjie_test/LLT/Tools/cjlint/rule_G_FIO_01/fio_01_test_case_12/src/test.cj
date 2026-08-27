// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import std.fs.*

func test7() {
    var pathName = "/my/docTemp.txt"
    var file: File = File(pathName, OpenMode.Append)
    if (file.canWrite()) {
        file.flush()
        file.close()
        print("This file already exists or created!")
        remove(pathName)
    } else {
        remove(pathName)
        return 1
    }
    return 0
}
