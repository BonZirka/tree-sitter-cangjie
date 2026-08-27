/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %n.%suffix %run_args
/*
 * Test description: Test the funcs for buffered_input_stream.cj
 * Test API: public class BufferedInputStream <: InputStream {
 *             public prop length: Int64
 *           }
 */
internal import std.io.*

main() {
    var a = ByteBuffer()
    var b = BufferedInputStream(a)
    if (b.length != 0) {
        return 1
    }
    return 0
}
