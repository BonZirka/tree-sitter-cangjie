/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

public struct DerBlob <: Equatable<DerBlob> & Hashable {
    protected let content: Array<Byte>

    public init(content: Array<Byte>) {
        this.content = content
    }

    public prop size: Int64 {
        get() {
            content.size
        }
    }

    public prop body: Array<Byte> {
        get() {
            content.clone()
        }
    }

    public override operator func ==(other: DerBlob): Bool {
        this.content == other.content
    }

    public override operator func !=(other: DerBlob): Bool {
        this.content != other.content
    }

    @OverflowWrapping
    public override func hashCode(): Int64 {
        var hash = 0
        let content = content
        for (index in 0..content.size) {
            hash = hash * 31 + content[index].hashCode()
        }
        return hash
    }
}
