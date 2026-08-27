/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

/**
 * Represents either a public or private key
 */
public interface Key <: ToString {
    /**
     * Encode key to a DerBlob (DER/ASN1 binary format) without encryption.
     * @throws CryptoException if failed to encode
     */
    func encodeToDer(): DerBlob

    /**
     * Encode to PemEntry without encryption
     * @throws CryptoException if failed to encode
     */
    func encodeToPem(): PemEntry

    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format). The key shouldn't be encrypted.
     * @throws CryptoException if failed to decode
     */
    static func decodeDer(encoded: DerBlob): Key

    /**
     * Load the first key from PEM text. The key shouldn't be encrypted.
     * @throws CryptoException if failed to parse PEM or decode the key's content
     */
    static func decodeFromPem(text: String): Key
}

/**
 * Represents a public key
 */
public interface PublicKey <: Key {
    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format).
     * @throws CryptoException if failed to decode
     */
    static func decodeDer(encoded: DerBlob): PublicKey

    /**
     * Load the first key from PEM text.
     * @throws CryptoException if failed to parse or decode key or there are no public keys in the PEM
     */
    static func decodeFromPem(text: String): PublicKey
}

/**
 * Represents DH Parameters
 */
public interface DHParameters <: Key {
    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format).
     * @throws CryptoException if failed to decode
     */
    static func decodeDer(encoded: DerBlob): DHParameters

    /**
     * Load the first key from PEM text.
     * @throws CryptoException if failed to parse or decode key or there are no dh parameters in the PEM
     */
    static func decodeFromPem(text: String): DHParameters
}

/**
 * Represents a private key
 */
public interface PrivateKey <: Key {
    /**
     * Encode key to a DerBlob (DER/ASN1 binary format) optionally doing encryption
     * using the specified password if any
     * If the passord is None, then the key will be encoded unencrypted.
     * An encrypted key produced by this function is always in PKCS8 format.
     * @throws CryptoException if failed to encode/encrypt or the provided password is empty
     */
    func encodeToDer(password!: ?String): DerBlob

    /**
     * Encode the key to PemEntry optionally doing encryption using the specified password if any
     * If the passord is None, then the key will be encoded unencrypted.
     * An encrypted key produced by this function is always in PKCS8 format.
     * @throws CryptoException if failed to encode/encrypt or the provided password is empty
     */
    func encodeToPem(password!: ?String): PemEntry

    /**
     * Decode a private key from a DerBlob (DER/ASN1 binary format). The private key shouldn't be encrypted.
     * @throws CryptoException if failed to decode key
     */
    static func decodeDer(encoded: DerBlob): PrivateKey

    /**
     * Decode private key from DER/ASN1 format applying decyption if
     * password provided. Please note that the returned key will be decrypted
     * therefore encodeToPem/Der without password will serialize unecrypted key.
     * This only works for PKCS8 encrypted keys.
     *
     * @throws CryptoException if failed to decode or decrypt or the provided password is empty
     */
    static func decodeDer(encoded: DerBlob, password!: ?String): PrivateKey

    /**
     * Load the first private key from PEM text. The private key shouldn't be encrypted.
     * @throws CryptoException if failed to decode key or the PEM doesn't contain a key
     */
    static func decodeFromPem(text: String): PrivateKey

    /**
     * Load the first private key from the PEM text applying decryption if
     * password provided.
     * Please note that the returned key will be already decrypted therefore the subsequent encodeToPem/Der
     * without password will serialize unecrypted key as well
     *
     * @throws CryptoException if failed to parse, decode, decrypt or the provided password is empty
     */
    static func decodeFromPem(text: String, password!: ?String): PrivateKey
}
