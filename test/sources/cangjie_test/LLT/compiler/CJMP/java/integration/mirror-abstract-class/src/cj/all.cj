// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package com.java.lib

import java.lang.*;

@JavaMirror
abstract class AbstractMirror {
    init()
    public static func staticFunc(): Unit
    protected open abstract func abstractFunc(): Unit
    public open func instanceFunc(): Unit
}

@JavaMirror
open class ImplAbstractMirror <: AbstractMirror {
    init()
    public func abstractFunc(): Unit
    public func id(x: AbstractMirror): AbstractMirror
    public func idImpl(x: ImplAbstractMirror): AbstractMirror
}

@JavaImpl
class Impl <: JObject {
    init() {
        print("In CJ Impl: start\n", flush: true)
        let i = ImplAbstractMirror()
        let res: AbstractMirror = i.id(i)
        res.abstractFunc()
        (res as ImplAbstractMirror)?.abstractFunc()
        ImplAbstractMirror.staticFunc()

        match (res) {
            case AbstractMirror => print("id match: ok\n", flush: true)
            case ImplAbstractMirror => print("id match: failed\n", flush: true)
            case _ => print("id match: unexpected case\n", flush: true)
        }

        match (res) {
            case ImplAbstractMirror => print("id match: ok\n", flush: true)
            case AbstractMirror => print("id match: failed\n", flush: true)
            case _ => print("id match: unexpected match\n", flush: true)
        }

        res.abstractFunc()
        print("cast to ImplAbstractMirror: ", flush: true)
        (res as ImplAbstractMirror)?.abstractFunc()

        let res2 = i.idImpl(i)
    }
}