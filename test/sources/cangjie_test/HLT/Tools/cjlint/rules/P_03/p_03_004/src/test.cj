/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package example

open class SecretFile {
    var path: String
    var stream: String ="def"
    public init(path: String) {
        this.path = path;
    }
    public open func getPath() {
        return path
    }
    public open func getStream() {
        return stream
    }
}

class UntrustedFile <: SecretFile {
    private var count: Int32 = 0
    public init(path: String) {
        super(path)
    }
    public override func getPath(): String {
        return if (count == 0) {
            count++
            "/tmp/pub"
        } else {
            "/etc/passwd"
        }
    }
}
class A{
    public func securityCheck(path:String) {
    }
}
extend A {
    public func getFileAsStream(file: SecretFile): String {
        var copy = SecretFile(file.getPath())
        try {
            this.securityCheck(copy.getPath())
            return copy.getStream()
        } catch (e: NegativeArraySizeException) {
            return copy.getStream()
        }
    }
}

