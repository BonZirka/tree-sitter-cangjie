/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.effect

public class DoubleResumeException <: Exception {
    public init() {
        super("Resumption resumed multiple times")
    }
    protected override func getClassName(): String {
        "DoubleResumeException"
    }
}

public class UnhandledCommandException <: Exception {
    public init() {
        super("Unhandled command")
    }
    protected override func getClassName(): String {
        "UnhandledCommand"
    }
}

public abstract class Command<Res> {
    public open func defaultImpl(): Res {
        throw UnhandledCommandException()
    }
}
