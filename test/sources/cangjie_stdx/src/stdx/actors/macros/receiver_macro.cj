/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines the @Receiver macro.
 *
 */

macro package stdx.actors.macros

import std.ast.*

/**
 * This macro can be only defined at function declaration inside @Actor.
 *
 * @since
 *
 * @throws MacroException if input is not a FuncDecl, or if the FuncDecl
 * 1. has a STATIC modifier; or
 * 2. has a OVERRIDE modifier; or
 * 3. has a OPEN modifier; or
 * 4. does not have an explicit return type.
 *
 */
public macro Receiver(attrs: Tokens, input: Tokens): Tokens {
    ReceiverMacro.run(attrs, input)
}

public macro Receiver(input: Tokens): Tokens {
    ReceiverMacro.run(Tokens(), input)
}

class ReceiverMacro {
    private let opts: MacroOptionSet
    private let errors: MacroErrors
    private let headDecl: Decl
    private let fd: FuncDecl

    static let ALLOWED_OPTIONS: Array<MacroOptionKey> = [
        Priority
    ]

    static func run(attrs: Tokens, input: Tokens): Tokens {
        ReceiverMacro(attrs, input).expand()
    }

    private init(attrs: Tokens, input: Tokens) {
        errors = MacroErrors()
        if (!insideParentContext(ACTOR_MACRO_NAME)) {
            errors.add(MacroError.ReceiverMacroInsideActor)
            errors.doThrow()
        }

        opts = MacroOptionParser.run(attrs, errors)
        headDecl = parseDecl(input)
        fd = match (findDeclUnderMacro<FuncDecl>(headDecl)) {
            case Some(fd) => fd
            case None =>
                errors.add(MacroError.ReceiverMacroInvalidDecl)
                errors.doThrow()
        }
    }

    private func expand(): Tokens {
        checkOptions()
        checkReceiver()
        modifyReceiver()
    }

    private func checkOptions(): Unit {
        opts.checkOptions(ALLOWED_OPTIONS, errors, "@Receiver")
        errors.report()
    }

    private func checkReceiver(): Unit {
        if (!checkModifiers(fd.modifiers, [STATIC, OPEN, OVERRIDE])) {
            errors.add(MacroError.ReceiverMacroInvalidModifier(fd.identifier.value))
        }
        try {
            fd.declType
        } catch (_: ASTException) {
            errors.add(MacroError.ReceiverMacroInvalidReturnType(fd.identifier.value))
        }
        errors.report()
    }

    private func modifyReceiver(): Tokens {
        /*
            @Receiver[expr]
            func foo(arg1: Ty1, ..., argN: TyN): RetTy { body }
            =>
            @prefixReceiver[expr]
            func foo(arg1: Ty1, ..., argN: TyN): RetTy { body }
         */
        let options = if (opts.contains(Priority)) {
            quote([priority: $(opts.getPriority())])
        } else {
            Tokens()
        }
        quote(
            @$RECEIVER_MARKER_TOKEN$options
            $headDecl
        )
    }
}
