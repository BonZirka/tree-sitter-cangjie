// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package ohos_app_cangjie_entry.TemplatesTest.Frame

internal import ohos.base.LengthProp
internal import ohos.component.Column
internal import ohos.component.Row
internal import ohos.component.Button
internal import ohos.component.Text
internal import ohos.component.CustomView
internal import ohos.component.CJEntry
internal import ohos.component.loadNativeView
internal import ohos.state_manage.SubscriberManager
internal import ohos.state_manage.ObservedProperty
internal import ohos.state_manage.LocalStorage
internal import ohos_app_cangjie_entry.BUTTON_COLOR
import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State
import ohos.state_macro_manage.r
import ohos.router.*
import ohos.base.Color
import ohos.hi_tracemeter.*
import ohos.base.AppLog
import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.component.TextAlign
import std.sync.AtomicInt64
import ohos.component.Scroll
import ohos.component.FontWeight
import ohos.component.Alignment
import std.collection.ArrayList
import std.collection.HashMap
import ohos_app_cangjie_entry.CATEGORY_COLOR
import ohos_app_cangjie_library.library_create_allocation
import encoding.url.URL

@Entry
@Component
class Touch {
    @State
    var message: String = "User Event: Touch"
    var event: String = "Touch"
    var click_cnt: Int64 = 0
    var back: String = "Back"

    func build() {
        Row() {
            Scroll() {
                Column {
                    Text(this.message)
                        .fontSize(10)
                        .fontWeight(FontWeight.Bold)
                        .align(Alignment.Center)

                    Button(this.event)
                        .fontSize(40)
                        .width(80.percent)
                        .height(8.percent)
                        .backgroundColor(BUTTON_COLOR)
                        .margin(top: 50.percent)
                        .onTouch {
                            event => this.message = """
                                    TouchType: ${event.eventType.toString()}
                                    timestamp: ${event.timestamp}
                                    Distance between touch point and touch element:
                                    x: ${event.touches[0].x}
                                    y: ${event.touches[0].y}
                                    Component localPos:(${event.target.area.position.x}, ${event.target.area.position.y})
                                    Component globalPos:(${event.target.area.globalPosition.x}, ${event.target.area.globalPosition.y})
                                    width: ${event.target.area.width}
                                    height: ${event.target.area.height}
                                """
                        }

                    Button(this.back)
                        .fontSize(40)
                        .margin(10)
                        .width(80.percent)
                        .backgroundColor(BUTTON_COLOR)
                        .align(Alignment.Center)
                        .onClick {
                            evt => Router.back()
                        }
                }.width(100.percent)
            }
        }
    }
}