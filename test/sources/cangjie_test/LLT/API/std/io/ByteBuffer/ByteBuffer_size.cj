/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC-PIPE-0: %compiler %cmp_opt -o %n.%suffix %f
// EXEC-PIPE-0: %run %run_opt %n.%suffix %run_args | compare %f
// ASSERT: scan 0
// ASSERT: scan 10

internal import std.io.ByteBuffer

main() {
    var bas = ByteBuffer(123)
    println(bas.length)
    var data = Array<Byte>(10, repeat: 1)
    bas.write(data)
    println(bas.length)
    return 0
}
