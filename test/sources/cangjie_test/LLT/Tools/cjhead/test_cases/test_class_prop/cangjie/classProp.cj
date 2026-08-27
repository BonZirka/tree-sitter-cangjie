// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package test.classProp

/**
 * Foo
 */
@!APILevel[
    20,
    stagemodelonly: true,
    syscap: "SystemCapability.Applications.CalendarData"
]
public class Foo {
    /**
     * Foo::a
     */
    @!APILevel[
        20,
        stagemodelonly: true,
        syscap: "SystemCapability.Applications.CalendarData"
    ]
    public var a = 0

    /**
     * Foo::b
     */
    public mut prop b: Int64 {
        get() {
            println("get")
            a
        }
        // setter
        set(value) {
            println("set")
            a = value
        }
    }

    /**
     * Foo::c
     */
    public var c = 0
}
