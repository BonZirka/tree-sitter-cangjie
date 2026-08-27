/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares  the UrlSyntaxException.
 */

package stdx.encoding.url

/**
 * The UrlSyntaxException.
 */
public class UrlSyntaxException <: Exception {
    var pos: String = ""
    public init(reason: String) {
        super(reason)
    }
    /**
     * Initializes a UrlSyntaxException object.
     *
     * @param input : Native URL
     * @param reason : Reasons for parsing errors
     *
     */
    public init(input: String, reason: String) {
        super(reason + " Input = ${input}.")
    }

    public init(input: String, reason: String, pos: String) {
        super(reason + " Input = ${input} (at '${pos}').")
    }

    protected override func getClassName(): String {
        return "UrlSyntaxException"
    }
}