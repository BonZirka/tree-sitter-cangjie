/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.fs.{File, OpenMode, remove}

class A {
    func test<T>() {
        var a = { =>
            var pathName = "/mytmp/doc.txt"
            var file: File = File(pathName, OpenMode.Append)
            if (file.canWrite()) {
                file.flush()
                file.close()
                remove(pathName)
            } else {
                return 1
            }
            return 0
        }
        a()
    }
}

main(){
    A().test<Int64>()
    return 0
}


