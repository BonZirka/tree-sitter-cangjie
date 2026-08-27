/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package otherPackageToImport

public class FooFinal {
    public func foo(x: PassedBar, y: PassedAnotherBar): ReturnedBar {
        println("Original `foo` of `FooFinal` was called")
        unsafe { zeroValue<ReturnedBar>() }
    }
}
