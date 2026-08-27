// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package pkg

public interface I1 {
    @Frozen
    public static prop prop_v5: Int64 {
        get() {
            5
        }
    }

    public mut static prop prop_v6: Int64 {
        get() {
            6
        }
        set(v) {
        }
    }
}
