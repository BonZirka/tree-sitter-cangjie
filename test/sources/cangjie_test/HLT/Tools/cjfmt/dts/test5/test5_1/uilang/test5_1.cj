/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Deprecated    public interface Swiming {
    func swim(): Unit
}

@Deprecated  protected class Fish <: Swiming {
    public func swim(): Unit {
        println("Fish Swiming")
    }
}

@Deprecated  protected struct Submarine <: Swiming {
    public func swim(): Unit {
        println("Submarine Swiming")
    }
}

@Deprecated  protected func swim(item: Swiming): Unit {
    item.swim()
}
class I {
@Deprecated public open func test(x: Int64 // Deprecated
){
    var a = 1
        a}}
main() {}