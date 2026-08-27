/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.manager

import stdx.chir.*

sealed abstract class PluginBase {
    internal let _name: String

    internal init(name: String) {
        this._name = name
    }

    public prop name: String {
        get() {
            return _name
        }
    }
}

public abstract class CHIRPluginBase <: PluginBase {
    public init(name: String) {
        super(name)
    }

    public open func run(pkg: Package): Bool
}