/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import stdx.crypto.common.*
import stdx.crypto.keys.*

public class GeneralDHParameters <: DHParameters {
    GeneralDHParameters(private let blob: DerBlob) {
        describe()
    }

    /**
     * Encode to PemEntry
     * @throws X509Exception if failed to encode
     */
    public func encodeToPem(): PemEntry {
        PemEntry(PemEntry.LABEL_DH_PARAMETERS, encodeToDer())
    }

    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format).
     * @throws X509Exception if failed to decode
     */
    public static func decodeDer(encoded: DerBlob): DHParameters {
        GeneralDHParameters(encoded)
    }

    /**
     * Load the first key from PEM text.
     * @throws X509Exception if failed to parse or decode key or there are no dh parameters in the PEM
     */
    public static func decodeFromPem(text: String): DHParameters {
        for (entry in Pem.decode(text)) {
            if (isDHParameters(entry)) {
                if (let Some(v) <- entry.body) {
                    return decodeDer(v)
                }
            }
        }

        throw X509Exception("No ${PemEntry.LABEL_DH_PARAMETERS} entry found in PEM file.")
    }

    public override func toString(): String {
        "DHParameters(${blob.size} bytes)"
    }

    public override func encodeToDer(): DerBlob {
        blob
    }

    // Check if the DHParameters is valid
    // should only be used to check the not-garanteed inputted data.
    // No need to be called while the inputted data is get from a cert, which is already checked.
    private func describe(): Unit {
        unsafe {
            ExceptionData.withException<Unit> {
                exception => describeImpl(blob.body, exception)
            }
        }
    }

    private static unsafe func describeImpl(
        body: Array<Byte>,
        exception: CPointer<ExceptionData>
    ): Unit {
        describeDHParametersImpl(body, exception)
    }
}
