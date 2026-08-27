// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f
// ASSERT: scan "Message": "unrecognized escape '\\\\q' in rune literal"
// ASSERT: scan "Message": "found 12 possible escapes: '\\\\r', '\\\\f', '\\\\v', '\\\\n', '\\\\t', '\\\\b', '\\\\0', '\\\\\\\\', '\\\\'', '\\\\\\"', '\\\\u{__}', '\\\\$' in rune literal"

main ()
{
    r'\q'
}
