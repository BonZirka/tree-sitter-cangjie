/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

type KeylogCallbackFunction = (TlsSocket, String) -> Unit

@C
func keylogCallback(ssl: CPointer<Ssl>, data: CString): Unit {
    if (let Some(bridge) <- Bridge.findByStream(ssl)) {
        if (let Some(callback) <- bridge.keylogCalback) {
            callback(bridge.socket, data.toString())
        }
    }
}
