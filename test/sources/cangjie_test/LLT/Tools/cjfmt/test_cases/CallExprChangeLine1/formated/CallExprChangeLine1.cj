// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component_ndk.*
internal import ohos.state_manage_ndk.*
import ohos.state_macro_manage_ndk.*
internal import ohos.hybrid_base.*
internal import cj_res_entry.*

@CustomDialog
class MyDialog {
    var controller: Option<CustomDialogController> = Option.None
    func build() {
        Row(60) {
            Button("cancel").onClick {
                evt => controller?.close()
            }.id("close")

            Button("confirm").onClick {
                evt => controller?.close()
            }
        }.height(500.px)
    }
}

@HybridComponentEntry
@Component
class HybridCustomDialog {
    var dialogController001: CustomDialogController = CustomDialogController(
        CustomDialogControllerOptions(builder: MyDialog(), backgroundColor: Color(0x9381c3),
            maskColor: Color(255, 192, 203), customStyle: true,
            closeAnimation: AnimateParam(duration: 5000, tempo: 3.0, curve: Curve.ExtremeDeceleration, delay: 3000,
                iterations: 0, playMode: PlayMode.Reverse, onFinish: ({=> AppLog.info("关闭动画完成啦！！！")}))))

    public func build() {
        Column {
            /*
             * -@TestCaseID: CustomDialog_case_001
             * -@TestCaseName: CustomDialog_case_001
             * -@Expect: 自定义弹窗内容构造器
             */
            Text("CustomDialog_case_001,自定义弹窗内容构造器,，包含两个按钮 cancel 和 confirm")
            Button("CustomDialog_case_001").onClick({
                evt => dialogController001.open()
            }).id("CustomDialog_case_001")
        }
    }
}
