// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (not CJNATIVE) EXEC: %compiler --output-type=cbc %f -o test.cbc
// (not CJNATIVE) EXEC-PIPE: ls *.cbc | compare %f
// (not CJNATIVE) ASSERT: regex-auto test.cbc

main() {
    return 42
}
