/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.collection.{filter, map}
import stdx.crypto.common.*

class X500Principal <: ToString {
    let content: DerField

    X500Principal(seq: DerField) {
        content = seq
    }

    prop blob: DerBlob {
        get() {
            DerBlob(content.blob.body)
        }
    }

    func fieldById(oid: Oid): ?DerField {
        for ((id, parser) in fields()) {
            if (id == oid) {
                return parser()
            }
        }

        return None
    }

    public override func toString(): String {
        let result = StringBuilder()

        for ((id, parser) in fields()) {
            let value = parser()
            let valuePresentation = match {
                case value.fieldType == DerType.UTF8_STRING || value.fieldType == DerType.IA5_STRING ||
                    value.fieldType == DerType.PRINTABLE_STRING => String.fromUtf8(value.body)
                case _ => value.toString()
            }

            result.append(id.toString())
            result.append(": ")
            result.append(valuePresentation)
            result.append(r'\n')
            true
        }

        return result.toString()
    }

    func fields(): Iterator<(Oid, () -> DerField)> {
        let body = DerSequence(content.body, depth: content.depth)
        body |> filter<DerField> {it => it.fieldType == DerType.ISSUER_COMPONENT} |>
            map<DerField, ?(Oid, () -> DerField)> {
            item =>
            var parser = DerParser(item.body)
            parser = DerParser(parser.parseNextDerField(body.depth).body)
            let idField = parser.parseNextDerField(body.depth)

            if (idField.fieldType != DerType.ASN_OBJECT_IDENTIFIER) {
                return None
            }

            var idParser = DerParser(idField.body)
            let id = idParser.parseDerObjId()
            let memo = parser

            (id, {
                    =>
                    var parser = memo
                    parser.parseNextDerField(body.depth)
                })
        } |> filterNotNone
    }
}

func filterNotNone<T>(iterable: Iterable<Option<T>>) {
    iterable |> filter<Option<T>> {
        it => match (it) {
            case Some(_) => true
            case None => false
        }
    } |>
        map<Option<T>, T> {
        it => match (it) {
            case Some(it) => it
            case None => throw X509Exception("Filter not none check failed.")
        }
    }
}
