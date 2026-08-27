/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

/**
 * Checked exception for invalid CHIR construction or inconsistent IR state.
 */
public class CHIRException <: Exception {
    /**
     * Creates an exception with no detail message.
     */
    public init() {
        super()
    }

    /**
     * Creates an exception with the given detail message.
     * @param message Human-readable error text.
     */
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "CHIRException"
    }
}
