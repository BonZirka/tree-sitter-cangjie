/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.effect

internal abstract class ImmediateEffectHandlerEarlyExit {}

// This class is used internally when an Exception occurs within an immediate
// handler case
class ImmediateFrameExceptionWrapper <: ImmediateEffectHandlerEarlyExit {
    ImmediateFrameExceptionWrapper(let frame: Option<HandlerFrame>, let exception: Exception) {}
}

// This class is used internally when an Error occurs within an immediate
// handler case
class ImmediateFrameErrorWrapper <: ImmediateEffectHandlerEarlyExit {
    ImmediateFrameErrorWrapper(let frame: Option<HandlerFrame>, let error: Error) {}
}

// This class is used internally when an immediate handler case finishes
// execution without resuming
//
// Note: there's an issue with generics in Cangjie that don't allow us to
// have the type of result be generic
class ImmediateEarlyReturn <: ImmediateEffectHandlerEarlyExit {
    ImmediateEarlyReturn(let frame: Option<HandlerFrame>, let result: Any) {}
}

class ImmediateHandlerCase<Cmd, Res, Ret> <: HandlerCase {
    ImmediateHandlerCase(let frame: HandlerFrame, let h: (Cmd) -> ImmediateHandlerReturn<Res>) {}
    protected override func tryHandle<R1>(maybeCmd: Command<R1>, box!: FrameBox): Option<R1> {
        match (maybeCmd as Cmd) {
            case Some(cmd) =>
                let oldFrame = box.ref
                try {
                    box.ref = frame.parent
                    match (this.h(cmd)) {
                        case Result(v) => v as R1
                        case Exc(e) => throw e
                        case Err(e) => throw e
                    }
                } finally {
                    box.ref = oldFrame
                }
            case None => None
        }
    }
}

class ImmediateFrame<Ret> <: HandlerFrame {
    public ImmediateFrame(let fn: () -> Ret) {}
    public func start(): Ret {
        let box = HandlerFrame.getActiveFrameBox()
        let previous = box.ref
        this.parent = previous
        try {
            box.ref = this
            fn()
        } finally {
            box.ref = previous
            this.finalizer()
        }
    }
}
