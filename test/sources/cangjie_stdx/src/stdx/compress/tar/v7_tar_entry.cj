/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.fs.Path
import std.io.InputStream

public class V7TarEntry <: TarEntry {
    init(header: TarHeader) {
        super(header)
    }

    init(header: TarHeader, stream: ?InputStream) {
        super(header, stream)
    }

    public init(path: String) {
        this(Path(path))
    }

    public init(path: Path) {
        super(path)
    }
}
