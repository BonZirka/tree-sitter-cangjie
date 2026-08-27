/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

// Diagnostic
public enum DiagnosticInfo {
    | Error(String, String)
    | Warning(String, String)
    | ...
}

public class Diagnostic {
    public let codePos: CodePositionRange
    public let diagInfo: DiagnosticInfo

    internal init(codePos: CodePositionRange, diagInfo: DiagnosticInfo) {
        this.codePos = codePos
        this.diagInfo = diagInfo
    }
}

// Parse result
public class ParsingResult<T> where T <: SyntaxTreeNode {
    public let diags: Array<Diagnostic>
    public let node: Option<T>

    internal init(node: Option<T>, diags: Array<Diagnostic>) {
        this.node = node
        this.diags = diags
    }
}
