/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.time.DateTime
import stdx.crypto.common.*

public struct X509CertificateInfo {
    public var serialNumber: SerialNumber
    public var notBefore: DateTime
    public var notAfter: DateTime
    public var subject: ?X509Name
    public var dnsNames: Array<String>
    public var emailAddresses: Array<String>
    public var IPAddresses: Array<IP>
    public var keyUsage: ?KeyUsage
    public var extKeyUsage: ?ExtKeyUsage

    public init(
        serialNumber!: ?SerialNumber = None,
        notBefore!: ?DateTime = None,
        notAfter!: ?DateTime = None,
        subject!: ?X509Name = None,
        dnsNames!: Array<String> = Array<String>(),
        emailAddresses!: Array<String> = Array<String>(),
        IPAddresses!: Array<IP> = Array<IP>(),
        keyUsage!: ?KeyUsage = None,
        extKeyUsage!: ?ExtKeyUsage = None
    ) {
        for (IPAddress in IPAddresses) {
            if (IPAddress.size != IPV4_SIZE && IPAddress.size != IPV6_SIZE) {
                throw X509Exception("Illegal IP address.")
            }
        }

        this.serialNumber = serialNumber ?? SerialNumber() // cjlint-ignore !G.EXP.03

        match (notBefore) {
            case Some(time) => this.notBefore = time
            case _ => this.notBefore = DateTime.nowUTC()
        }

        match (notAfter) {
            case Some(time) => this.notAfter = time
            case _ => this.notAfter = this.notBefore.addYears(1)
        }

        this.subject = subject
        this.dnsNames = dnsNames
        this.emailAddresses = emailAddresses
        this.IPAddresses = IPAddresses
        this.keyUsage = keyUsage
        this.extKeyUsage = extKeyUsage
    }
}
