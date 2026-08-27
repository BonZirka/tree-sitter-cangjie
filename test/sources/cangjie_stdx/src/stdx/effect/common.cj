/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.effect

class FrameBox {
    var ref: Option<HandlerFrame>

    init() {
        this.ref = None
    }
}

abstract class HandlerCase {
    protected open func tryHandle<R1>(cmd: Command<R1>, box!: FrameBox): Option<R1>
}

// This class represents the possible returns of an immediate handler
enum ImmediateHandlerReturn<T> {
    Result(T)
    | Exc(Exception)
    | Err(Error)
}

abstract class HandlerFrame {
    static let ACTIVE_FRAME_KEY = ThreadLocal<FrameBox>()

    public static func getActiveFrameBox(): FrameBox {
        match (ACTIVE_FRAME_KEY.get()) {
            case Some(box) => box
            case None =>
                let newBox = FrameBox()
                ACTIVE_FRAME_KEY.set(newBox)
                newBox
        }
    }

    public static func getActiveFrame(): Option<HandlerFrame> {
        getActiveFrameBox().ref
    }
    static func setActiveFrame(f: Option<HandlerFrame>) {
        getActiveFrameBox().ref = f
    }

    var handlers = Array<HandlerCase>()
    var parent: Option<HandlerFrame> = None
    var finalizer: () -> Unit = {=>}
    public func setFinally(finalizer: () -> Unit): Unit {
        this.finalizer = finalizer
    }

    func addHandlerCase(h: HandlerCase) {
        this.handlers = Array<HandlerCase>(this.handlers.size + 1) {
            i => if (i == 0) {
                h
            } else {
                this.handlers[i - 1]
            }
        }
    }

    public func setImmediateHandler<Cmd, Res, Ret>(h: (Cmd) -> ImmediateHandlerReturn<Res>): Unit {
        this.addHandlerCase(ImmediateHandlerCase<Cmd, Res, Ret>(this, h))
    }

    public static func perf<Cmd, Res>(cmd: Cmd): Res where Cmd <: Command<Res> {
        let mainBox = getActiveFrameBox()
        var maybeFrame = getActiveFrame()
        while (let Some(frame) <- maybeFrame) {
            for (i in 0..frame.handlers.size) {
                if (let Some(result) <- frame.handlers[i].tryHandle(cmd, box: mainBox)) {
                    return result
                }
            }
            maybeFrame = frame.parent
        }
        cmd.defaultImpl()
    }
}
