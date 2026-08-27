/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls.common

/**
 * Failed in any tls-related cases. It may also by thrown because in cases
 * that are irrelevant to TLS itself but because of environment issues discovered in net-tls.
 * Sometimes it contains the underlying implementation errors, e.g. OpenSSL messages and
 * error codes: please consult with libopenssl documentation for more details in this case.
 */
public class TlsException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "TlsException"
    }
}
