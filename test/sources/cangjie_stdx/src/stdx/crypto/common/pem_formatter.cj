/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

import stdx.encoding.base64.toBase64String

const LINE_FEED = "\n"

func format(entries: Iterable<PemEntry>): String {
    let result = StringBuilder()

    for (entry in entries) {
        formatEntry(entry, result)
    }

    return result.toString()
}

func formatEntry(entry: PemEntry, result: StringBuilder) {
    result.append(PEM_BEGIN_PREFIX)
    result.append(entry.label)
    result.append(PEM_SUFFIX)
    result.append(LINE_FEED)

    if (!entry.headers.isEmpty()) {
        for ((name, value) in entry.headers) {
            result.append(name.replace("\n", "\\n").replace("\r", "\\r"))
            result.append(": ")
            result.append(value.replace("\n", "\\n").replace("\r", "\\r"))
            result.append(LINE_FEED)
        }
        result.append(LINE_FEED)
    }

    if (let Some(body) <- entry.body) {
        let bodyText = toBase64String(body.body)
        formatBase64(bodyText, result)
    }

    result.append(PEM_END_PREFIX)
    result.append(entry.label)
    result.append(PEM_SUFFIX)
    result.append(LINE_FEED)
}

func min(a: Int64, b: Int64): Int64 {
    if (a > b) {
        b
    } else {
        a
    }
}

func formatBase64(blob: String, result: StringBuilder) {
    let content = blob.toRuneArray()
    const bits64 = 64
    let lines = (content.size / bits64) + 1
    for (lineNumber in 0..lines) {
        let startIndex = lineNumber * bits64
        let endIndex = min(startIndex + bits64, content.size)
        let slice = content[startIndex..endIndex]
        if (!slice.isEmpty()) {
            result.append(slice)
            result.append(LINE_FEED)
        }
    }
}
