/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.fs.*
internal import std.posix.*

func isInSecureDir(path: Path): Bool {
    return true
}

func WriteToSecureFile(path: Path) {

}
class A{}
extend A {
    func dumpSecureFile(path: String, condition: Bool): Unit
    {
        let dir = Path(path)
        var dir2 = canonicalize(dir)
        if (isInSecureDir(dir2)) {
            WriteToSecureFile(dir2)
        }
    }
}

main() {
    let result:String = getcwd()
    var a = A()
    a.dumpSecureFile(result, true)
}

