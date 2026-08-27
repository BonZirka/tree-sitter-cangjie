/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import stdx.crypto.common.*

const RSAN_ID: Int64 = 6
const ECN_ID: Int64 = 408
const DSAN_ID: Int64 = 116

public struct Signature <: Equatable<Signature> & Hashable {
    let signature_: DerBlob

    init(signature: DerBlob) {
        this.signature_ = signature
    }

    public prop signatureValue: DerBlob {
        get() {
            this.signature_
        }
    }

    public override operator func ==(other: Signature): Bool {
        this.signatureValue == other.signatureValue
    }

    public override operator func !=(other: Signature): Bool {
        !(this == other)
    }

    public override func hashCode(): Int64 {
        this.signatureValue.hashCode()
    }
}

public enum SignatureAlgorithm <: Equatable<SignatureAlgorithm> & ToString {
    | MD2WithRSA
    | MD5WithRSA
    | SHA1WithRSA
    | SHA256WithRSA
    | SHA384WithRSA
    | SHA512WithRSA
    | DSAWithSHA1
    | DSAWithSHA256
    | ECDSAWithSHA1
    | ECDSAWithSHA256
    | ECDSAWithSHA384
    | ECDSAWithSHA512
    | UnknownSignatureAlgorithm

    public override operator func ==(other: SignatureAlgorithm): Bool {
        this.toString() == other.toString()
    }

    public override operator func !=(other: SignatureAlgorithm): Bool {
        !(this == other)
    }

    public override func toString(): String {
        var res: String = "Signature Algorithm: "
        match (this) {
            case MD2WithRSA => res = res + "md2WithRSAEncryption"
            case MD5WithRSA => res = res + "md5WithRSAEncryption"
            case SHA1WithRSA => res = res + "sha1WithRSAEncryption"
            case SHA256WithRSA => res = res + "sha256WithRSAEncryption"
            case SHA384WithRSA => res = res + "sha384WithRSAEncryption"
            case SHA512WithRSA => res = res + "sha512WithRSAEncryption"
            case DSAWithSHA1 => res = res + "dsa_with_SHA1"
            case DSAWithSHA256 => res = res + "dsa_with_SHA256"
            case ECDSAWithSHA1 => res = res + "ecdsa-with-SHA1"
            case ECDSAWithSHA256 => res = res + "ecdsa-with-SHA256"
            case ECDSAWithSHA384 => res = res + "ecdsa-with-SHA384"
            case ECDSAWithSHA512 => res = res + "ecdsa-with-SHA512"
            case UnknownSignatureAlgorithm => res = res + "unknown signature algorithm"
        }
        res
    }

    func getDigest() {
        var md = match (this) {
            case MD2WithRSA => throw X509Exception("X509 get digest failed: Not supported MD2 digest.")
            case MD5WithRSA => md5()
            case SHA1WithRSA | ECDSAWithSHA1 | DSAWithSHA1 => sha1()
            case SHA256WithRSA | ECDSAWithSHA256 | DSAWithSHA256 => sha256()
            case SHA384WithRSA | ECDSAWithSHA384 => sha384()
            case SHA512WithRSA | ECDSAWithSHA512 => sha512()
            case UnknownSignatureAlgorithm => throw X509Exception(
                "X509 create certificate failed: Not supported UnknownSignatureAlgorithm.")
        }
        return md
    }

    func getKeyType() {
        var key = match (this) {
            case MD2WithRSA | MD5WithRSA | SHA1WithRSA | SHA256WithRSA | SHA384WithRSA | SHA512WithRSA => RSAN_ID
            case DSAWithSHA1 | DSAWithSHA256 => DSAN_ID
            case ECDSAWithSHA1 | ECDSAWithSHA256 | ECDSAWithSHA384 | ECDSAWithSHA512 => ECN_ID
            case UnknownSignatureAlgorithm => throw X509Exception(
                "X509 create certificate failed: Not supported UnknownSignatureAlgorithm.")
        }
        return key
    }
}
