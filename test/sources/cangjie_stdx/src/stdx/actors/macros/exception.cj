/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines the exception thrown by using the actor macros.
 *
 */

macro package stdx.actors.macros

class MacroException <: Exception {
    public init(message: String) {
        super("macro failed to expand.\n" + message)
    }

    protected override func getClassName(): String {
        return "Actor framework"
    }
}
