/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.manager

import std.collection.*

public class PluginManager {
    internal static var _chirPlugins = ArrayList<()->CHIRPluginBase>()

    public static func registerCHIRPlugin(f: () -> CHIRPluginBase): Unit {
        _chirPlugins.add(f)
    }
}