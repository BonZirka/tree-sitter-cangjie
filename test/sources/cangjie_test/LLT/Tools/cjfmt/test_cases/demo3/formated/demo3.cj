// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import foundation.*
internal import component.*
internal import systemlib.*

/**
 * [Detect Aesthetics Score] example, used to detect image.
 */
class detectState <: State {
    var score: float64
    var result: String
    init() {
        score = 0.0
        result = ""
    }
}

class DetectAestheticsScoreDemo <: Component {
    let state: detectState

    init() {
        state = detectState()
    }

    func render() {
        let buttonStyle = Option<InputStyle>.Some(
            InputStyle(
                width: Option<Length>.Some(400.px()),
                height: Option<Length>.Some(200.px()),
                borderRadius: Option<Array<Length>>.Some([5.px(), 5.px(), 5.px(), 5.px()]),
                margin: Option<Array<Px>>.Some([0.px(), 60.px(), 50.px(), 60.px()]),
                color: Option<Color>.Some(Color(255, 255, 255)),
                fontSize: Option<Px>.Some(30.px()),
                backgroundColor: Option<Color>.Some(Color(Colors.lightblue))
            )
        )

        func detect(evt: systemlib.EventBase) {
            systemlib.detectAestheticsScore(
                systemlib.DetectAestheticsObj(
                    uri: "../Common/image/scene.jpg",
                    success: Some<(DetectAestheticsResObj) -> unit>(
                        {res: DetectAestheticsResObj => state.score = res.score}),
                    fail: Some<(String, Int64) -> unit>({error: String, code: Int64 => state.result = error}),
                    complete: Some<() -> unit>({=> state.result = "complete"})
                )
            )
        }

        Div(
            content: Option<Array<ComponentBase>>.Some(
                [
                    Div(
                        content: Option<Array<ComponentBase>>.Some(
                            [
                                Text(
                                    content: Option<String>.Some("Detect Aesthetics Score"),
                                    style: Option<TextStyle>.Some(
                                        TextStyle(
                                            padding: Option<Array<Px>>.Some([30.px(), 40.px(), 30.px(), 40.px()]),
                                            borderWidth: Option<Array<Px>>.Some([0.px(), 0.px(), 2.px(), 0.px()])
                                        )
                                    )
                                ),
                                Image(
                                    src: Option<String>.Some("../Common/image/scene.jpg"),
                                    alt: Option<String>.Some("../Common/image/scene.jpg"),
                                    style: Option<ImageStyle>.Some(
                                        ImageStyle(
                                            width: Option<Length>.Some(650.px()),
                                            margin: Option<Array<Px>>.Some([10.px(), 10.px(), 10.px(), 10.px()]),
                                            objectFit: Option<ObjectFit>.Some(ObjectFit.cover)
                                        )
                                    )
                                )
                            ]
                        ),
                        style: Option<DivStyle>.Some(
                            DivStyle(
                                padding: Option<Array<Px>>.Some([50.px(), 0.px(), 80.px(), 0.px()]),
                                flexDirection: Option<FlexDirection>.Some(FlexDirection.column),
                                justifyContent: Option<JustifyContent>.Some(JustifyContent.center),
                                alignItems: Option<AlignItems>.Some(AlignItems.center),
                                alignSelf: Option<AlignSelf>.Some(AlignSelf.center)
                            )
                        )
                    ),
                    Input(
                        inputType: Option<InputType>.Some(InputType.button),
                        style: buttonStyle,
                        value: Option<String>.Some("检测美学评分"),
                        onClick: Option<(systemlib.EventBase) -> unit>.Some(detect)
                    ),
                    Text(
                        content: bind({=> toString(state.score)}),
                        style: Option<TextStyle>.Some(
                            TextStyle(
                                padding: Option<Array<Px>>.Some([30.px(), 40.px(), 30.px(), 40.px()]),
                                borderWidth: Option<Array<Px>>.Some([0.px(), 0.px(), 2.px(), 0.px()])
                            )
                        )
                    ),
                    Text(
                        content: bind({=> state.result}),
                        style: Option<TextStyle>.Some(
                            TextStyle(
                                padding: Option<Array<Px>>.Some([30.px(), 40.px(), 30.px(), 40.px()]),
                                borderWidth: Option<Array<Px>>.Some([0.px(), 0.px(), 2.px(), 0.px()])
                            )
                        )
                    )
                ]
            ),
            style: Option<DivStyle>.Some(
                DivStyle(
                    flexDirection: Option<FlexDirection>.Some(FlexDirection.column),
                    justifyContent: Option<JustifyContent>.Some(JustifyContent.center),
                    alignItems: Option<AlignItems>.Some(AlignItems.center)
                )
            )
        )
    }
}
