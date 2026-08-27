package cjworld

import objc.lang.*

@ObjCMirror
open class M {
    @ForeignName["init"]
    public init()

    @ForeignName["printPointOC:"]
    public func printPointOC(point: ObjCPointer<Point2D>): ObjCPointer<Point2D>
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

