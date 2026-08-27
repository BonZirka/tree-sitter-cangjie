/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.kit

import stdx.crypto.common.*
import stdx.crypto.keys.*
import stdx.crypto.crypto.*
import stdx.crypto.x509.*

public class DefaultCryptoKit <: CryptoKit {
    static init() {
        setGlobalCryptoKit(DefaultCryptoKit())
    }

    public func getRandomGen(): RandomGenerator {
        SecureRandom()
    }

    public func publicKeyFromDer(encoded: DerBlob): PublicKey {
        GeneralPublicKey.decodeDer(encoded)
    }

    public func publicKeyFromPem(text: String): PublicKey {
        GeneralPublicKey.decodeFromPem(text)
    }

    public func privateKeyFromDer(encoded: DerBlob): PrivateKey {
        privateKeyFromDer(encoded, password: None)
    }

    public func privateKeyFromDer(encoded: DerBlob, password!: ?String): PrivateKey {
        GeneralPrivateKey.decodeDer(encoded, password: password)
    }

    public func privateKeyFromPem(text: String): PrivateKey {
        privateKeyFromPem(text, password: None)
    }

    public func privateKeyFromPem(text: String, password!: ?String): PrivateKey {
        for (entry in Pem.decode(text)) {
            if (isPrivateKey(entry) && entry.body.isSome()) {
                return GeneralPrivateKey.decodeFromPem(entry, password)
            }
        }
        throw CryptoException("No supported private key entry found in PEM.")
    }

    public func dhParametersFromDer(encoded: DerBlob): DHParameters {
        GeneralDHParameters.decodeDer(encoded)
    }

    public func dhParametersFromPem(text: String): DHParameters {
        for (entry in Pem.decode(text)) {
            if (isDHParameters(entry)) {
                if (let Some(v) <- entry.body) {
                    return dhParametersFromDer(v)
                }
            }
        }
        throw X509Exception("No ${PemEntry.LABEL_DH_PARAMETERS} entry found in PEM file.")
    }

    public func certificateFromDer(encoded: DerBlob): Certificate {
        X509Certificate.decodeFromDer(encoded)
    }

    public func certificateFromPem(text: String): Array<Certificate> {
        X509Certificate.decodeFromPem(text).map({c => c})
    }
}