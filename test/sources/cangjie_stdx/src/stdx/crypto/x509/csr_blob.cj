/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import stdx.crypto.common.*

class X509CsrBlob <: Equatable<X509CsrBlob> & Hashable {
    let content: DerBlob
    private let csrInfo: DerSequence
    private let algorithmSeq: DerSequence
    private let signatureBit: Array<Byte>
    let signature: Signature
    let signatureAlgorithm: SignatureAlgorithm
    let publicKey: DerField
    let publicKeyAlgorithm: PublicKeyAlgorithm
    let subject: X500Principal

    private static const CSR_INFO_OFFSET = 0
    private static const ALGORITHM_INFO_OFFSET = 1
    private static const SIGNATURE_OFFSET = 2

    private static const SUBJECT_OFFSET = 1
    private static const PUBLIC_KEY_OFFSET = 2
    private static const ATTRIBUTES_OFFSET = 3

    init(content: Array<Byte>) {
        this(DerBlob(content))
    }

    init(content: DerBlob) {
        this.content = content
        if (content.content.size == 0) {
            throw X509Exception("X509CSR init failed: the content is empty.")
        }
        let wholeCsr = DerSequence(content.content)[0].asSequence()
        csrInfo = wholeCsr[CSR_INFO_OFFSET].asSequence()
        checkCsrDerType(csrInfo[0].fieldType, DerType.ASN_INT)
        if (csrInfo.size != 4 || wholeCsr.size != 3) {
            throw X509Exception("X509CSR init failed: the content is invalid.")
        }

        algorithmSeq = wholeCsr[ALGORITHM_INFO_OFFSET].asSequence()

        checkCsrDerType(wholeCsr[SIGNATURE_OFFSET].fieldType, DerType.BIT_STREAM)
        signatureBit = wholeCsr[SIGNATURE_OFFSET].body
        if (signatureBit.size <= 1 || signatureBit[0] != 0) {
            throw X509Exception("Wrong signature format: bit stream is not supported.")
        }
        signature = Signature(DerBlob(signatureBit[1..]))

        signatureAlgorithm = parseAndCheckSignatureAlgorithm(algorithmSeq[0].body)

        publicKey = csrInfo[PUBLIC_KEY_OFFSET]
        publicKeyAlgorithm = parseAndCheckPublicKeyAlgorithm(publicKey)

        checkCsrDerType(csrInfo[SUBJECT_OFFSET].fieldType, DerType.SEQUENCE)
        subject = X500Principal(csrInfo[SUBJECT_OFFSET])

        checkCsrDerType(csrInfo[ATTRIBUTES_OFFSET].fieldType, DerType.ATTRIBUTES_TYPE)
    }

    public override operator func ==(other: X509CsrBlob): Bool {
        content == other.content
    }

    public override operator func !=(other: X509CsrBlob): Bool {
        content != other.content
    }

    public override func hashCode(): Int64 {
        content.hashCode()
    }

    // Extensions
    prop dnsNames: Array<String> {
        get() {
            getX509CsrDnsNames(content)
        }
    }

    prop emailAddresses: Array<String> {
        get() {
            getX509CsrEmailAddresses(content)
        }
    }

    prop IPAddresses: Array<IP> {
        get() {
            getX509CsrIpAddresses(content)
        }
    }
}

func checkCsrDerType(inDerType: DerType, defaultDerType: DerType) {
    if (inDerType != defaultDerType) {
        throw X509Exception("X509CSR init failed: Unsupported field type: ${inDerType}.")
    }
}

/**
 * Get the DNS names by calling C interface.
 */
func getX509CsrDnsNames(content: DerBlob): Array<String> {
    let result = x509MallocOrThrow<ByteArrayResult>()
    runOnRawPtr(content.content) {
        rawPtr: CPointer<Byte>, size: UIntNative => getX509CsrDnsNames(rawPtr, size, result)
    }
    cloneStrAndFreeX509Result(result)
}

/**
 * Get the Email addresses by calling C interface.
 */
func getX509CsrEmailAddresses(content: DerBlob): Array<String> {
    let result = x509MallocOrThrow<ByteArrayResult>()
    runOnRawPtr(content.content) {
        rawPtr: CPointer<Byte>, size: UIntNative => getX509CsrEmailAddresses(rawPtr, size, result)
    }
    cloneStrAndFreeX509Result(result)
}

/**
 * Get the IP addresses by calling C interface.
 */
func getX509CsrIpAddresses(content: DerBlob): Array<IP> {
    let result = x509MallocOrThrow<ByteArrayResult>()
    runOnRawPtr(content.content) {
        rawPtr: CPointer<Byte>, size: UIntNative => getX509CsrIpAddresses(rawPtr, size, result)
    }
    cloneAndFreeX509Result(result)
}
