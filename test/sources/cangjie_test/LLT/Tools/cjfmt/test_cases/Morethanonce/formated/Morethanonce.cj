// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import UI.Foundation.*
internal import UI.Components.*
internal import UI.Systemlib.*
internal import UI.Styles.*
internal import UI.Common.*
internal import UI.App.*

let test = Option<DivStyle>.Some(DivStyle(alignSelf: Option<AlignSelf>.Some(AlignSelf.auto)))

@preview
public func previewDivStyleAdd() {
    DivStyleAdd()
}

class DivStyleAdd <: Component {
    func render() {
        Div(
            content: [Text(content: "hello world!")],
            id: "previewAutoTestId",
            style: Option<DivStyle>.Some(DivStyle(alignSelf: Option<AlignSelf>.Some(AlignSelf.auto)))
        )
    }
}
