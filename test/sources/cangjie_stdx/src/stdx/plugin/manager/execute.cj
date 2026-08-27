/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.manager

import stdx.chir.*

@C
public struct PluginResult {
    PluginResult(public let data: CPointer<UInt8>, public let length: Int64, public let success: Bool) {}
}

@C
public func executeCHIRPlugins(data: CPointer<UInt8>, length: Int64): PluginResult {
    let pkg = deserializePackage(data, length)
    var success = true
    for (it in PluginManager._chirPlugins) {
        let plugin = it()
        try {
            success = plugin.run(pkg) && success
        } catch (e: Exception) {
            println("throw exception while running CHIR plugin: " + plugin.name)
            println(e.printStackTrace())
            success &&= false
        }
    }
    if (!success) {
        return PluginResult(CPointer<UInt8>(), 0, false)
    }
    let (resultData, resultLength) = serializePackage(pkg)
    return PluginResult(resultData, resultLength, true)
}