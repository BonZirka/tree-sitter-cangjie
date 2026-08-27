/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

public interface CryptoKit {
    func getRandomGen(): RandomGenerator
    func publicKeyFromDer(encoded: DerBlob): PublicKey
    func publicKeyFromPem(text: String): PublicKey
    func privateKeyFromDer(encoded: DerBlob): PrivateKey
    func privateKeyFromPem(text: String): PrivateKey
    func privateKeyFromDer(encoded: DerBlob, password!: ?String): PrivateKey
    func privateKeyFromPem(text: String, password!: ?String): PrivateKey
    func dhParametersFromDer(encoded: DerBlob): DHParameters
    func dhParametersFromPem(text: String): DHParameters
    func certificateFromDer(encoded: DerBlob): Certificate
    func certificateFromPem(text: String): Array<Certificate>
}

var globalCryptoKit: ?CryptoKit = None

public func setGlobalCryptoKit(kit: CryptoKit): Unit {
    globalCryptoKit = kit
}

public func getGlobalCryptoKit(): CryptoKit {
    globalCryptoKit ?? throw CryptoException("Global crypto kit is not set. " + // cjlint-ignore !G.EXP.03
        "If you want to use the default implementation, make sure that package `stdx.crypto.kit` is imported.")
}
