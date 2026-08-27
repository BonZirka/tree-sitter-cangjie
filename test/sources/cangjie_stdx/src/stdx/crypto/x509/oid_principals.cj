/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

struct PrincipalOids {
    // X500
    // cjlint-ignore -start !G.OTH.03
    static let COMMON_NAME: Oid = Oid("2.5.4.3")
    static let COUNTRY_NAME: Oid = Oid("2.5.4.6")
    static let LOCALITY_NAME: Oid = Oid("2.5.4.7")
    static let STATE_OR_PROVINCE_NAME: Oid = Oid("2.5.4.8")
    static let ORGANIZATION_NAME: Oid = Oid("2.5.4.10")
    static let ORGANIZATIONAL_UNIT_NAME: Oid = Oid("2.5.4.11")

    // extensions
    static let EMAIL: Oid = Oid("1.2.840.113549.1.9.1")

    // signatureAlgorithm
    static let MD2WithRSA: Oid = Oid("1.2.840.113549.1.1.2")
    static let MD5WithRSA: Oid = Oid("1.2.840.113549.1.1.4")
    static let SHA1WithRSA: Oid = Oid("1.2.840.113549.1.1.5")
    static let SHA256WithRSA: Oid = Oid("1.2.840.113549.1.1.11")
    static let SHA384WithRSA: Oid = Oid("1.2.840.113549.1.1.12")
    static let SHA512WithRSA: Oid = Oid("1.2.840.113549.1.1.13")
    static let DSAWithSHA1: Oid = Oid("1.2.840.10040.4.3")
    static let DSAWithSHA256: Oid = Oid("2.16.840.1.101.3.4.3.2")
    static let ECDSAWithSHA1: Oid = Oid("1.2.840.10045.4.1")
    static let ECDSAWithSHA256: Oid = Oid("1.2.840.10045.4.3.2")
    static let ECDSAWithSHA384: Oid = Oid("1.2.840.10045.4.3.3")
    static let ECDSAWithSHA512: Oid = Oid("1.2.840.10045.4.3.4")

    // PublicKeyAlgorithm
    static let RSA: Oid = Oid("1.2.840.113549.1.1.1")
    static let DSA: Oid = Oid("1.2.840.10040.4.1")
    static let ECDSA: Oid = Oid("1.2.840.10045.2.1")
    // cjlint-ignore -end
}
