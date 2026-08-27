// ERRCHECK: %compiler %f -o %output %diag_json

func Å(a: Int32) {} // \u212b, singleton form

func Å(a: Int8) {} // A\u030a, this is the NFD form

func Å(a: UInt64) {} // \u00c5, this is the NFC form

main() {
    return Å(1) // NFC form
}
// ASSERT: scan-3 "Message": "found candidate",

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
