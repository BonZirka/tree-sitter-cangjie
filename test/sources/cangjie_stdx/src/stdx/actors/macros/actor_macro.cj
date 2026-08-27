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
 * This file defines the @Actor macro.
 *
 */

macro package stdx.actors.macros

import std.ast.*
import std.collection.ArrayList

/**
 * This macro can be only defined at non-inheritable class, i.e. a class that is not open nor abstract nor sealed.
 *
 * @since
 *
 * @throws MacroException if input is not a ClassDecl, or if the ClassDecl has either OPEN, ABSTRACT or SEALED modifier.
 */
public macro Actor(attrs: Tokens, input: Tokens): Tokens {
    ActorMacro.run(attrs, input)
}

public macro Actor(input: Tokens): Tokens {
    ActorMacro.run(Tokens(), input)
}

class ActorMacro {
    private let opts: MacroOptionSet
    private let errors: MacroErrors
    private let headDecl: Decl
    private let cd: ClassDecl

    static let ALLOWED_OPTIONS: Array<MacroOptionKey> = [
        EnableReceiverPriority
    ]

    static let ALLOWED_RECEIVER_OPTIONS: Array<MacroOptionKey> = [
        Priority
    ]

    static func run(attrs: Tokens, input: Tokens): Tokens {
        ActorMacro(attrs, input).expand()
    }

    private init(attrs: Tokens, input: Tokens) {
        errors = MacroErrors()
        opts = MacroOptionParser.run(attrs, errors)
        headDecl = parseDecl(input)
        cd = match (findDeclUnderMacro<ClassDecl>(headDecl)) {
            case Some(cd) => cd
            case None =>
                errors.add(MacroError.ActorMacroInvalidDecl)
                errors.doThrow()
        }
    }

    private func expand(): Tokens {
        checkOptions()
        checkClassDecl()
        processBody()
        headDecl.toTokens()
    }

    private func checkOptions(): Unit {
        opts.checkOptions(ALLOWED_OPTIONS, errors, "@Actor")
        errors.report()
    }

    private func checkClassDecl(): Unit {
        if (!checkModifiers(cd.modifiers, [ABSTRACT, OPEN, SEALED])) {
            errors.add(MacroError.ActorMacroInvalidClassModifier)
        }
        errors.report()
    }

    private func processBody(): Unit {
        let newDecls = ArrayList<Decl>()
        processReceivers(
            cd.body.decls,
            { d => newDecls.add(d) },
            { mDecl =>
                let receiverOptions = MacroOptionParser.run(mDecl.macroAttrs, errors)
                receiverOptions.checkOptions(ALLOWED_RECEIVER_OPTIONS, errors, "@Receiver")
                errors.report()
                newDecls.add(ReceiverModification.run(mDecl.macroInputs, opts, receiverOptions, errors))
            }
        )
        cd.body.decls = newDecls
        addActorInstanceVar()
    }

    private func addActorInstanceVar(): Unit {
        let actorInit = quote(
            SequentialDispatcher(enableReceiverPriority: $(opts.hasEnabledReceiverPriority()))
        )

        cd.body.decls.add(VarDecl(quote(
            private let $ACTOR_INSTANCE_TOKEN = $actorInit
        )))
    }
}

private class ReceiverModification {
    private let actorOpts: MacroOptionSet
    private let receiverOptions: MacroOptionSet
    private let errors: MacroErrors
    private let headDecl: Decl
    private var fdOpt: Option<FuncDecl> = None

    static func run(input: Tokens, actorOpts: MacroOptionSet, receiverOptions: MacroOptionSet, errors: MacroErrors): Decl {
        let rModify = ReceiverModification(input, actorOpts, receiverOptions, errors)

        rModify.checkReceiverOptions()

        rModify.checkDecl()

        rModify.checkReceiver()

        rModify.modifyReceiver()

        return rModify.headDecl
    }

    private init(input: Tokens, actorOpts: MacroOptionSet, receiverOptions: MacroOptionSet, errors: MacroErrors) {
        this.actorOpts = actorOpts
        this.receiverOptions = receiverOptions
        this.errors = errors

        this.headDecl = parseDecl(input)
    }

    private func checkDecl(): Unit {
        this.fdOpt = match (findDeclUnderMacro<FuncDecl>(headDecl)) {
            case Some(fd) => Some(fd)
            case None =>
                errors.add(MacroError.ReceiverMacroInvalidDecl)
                errors.doThrow()
        }
    }

    private func checkReceiverOptions(): Unit {
        if (!actorOpts.hasEnabledReceiverPriority()) {
            receiverOptions.iterate {
                key, _ =>
                    if (key == Priority) {
                        errors.add(MacroError.ReceiverMacroPriorityInsideActor)
                    }
                    true
            }
        }
        errors.report()
    }

    private func checkReceiver(): Unit {
        let fd = fdOpt.getOrThrow()
        if (actorOpts.hasEnabledReceiverPriority()) {
            for (param in fd.funcParams) {
                // a named parameter named "priority"
                if (param.not.kind == TokenKind.NOT && param.identifier.value == Priority.toString()) {
                    errors.add(MacroError.ReceiverMacroPriorityNameParameter)
                }
            }
        }
        errors.report()
    }

    private func modifyReceiver(): Unit {
        let fd = fdOpt.getOrThrow()
        if (actorOpts.hasEnabledReceiverPriority()) {
            modifyReceiverWithPriority()
            return
        }

        /*
            @receiverMarker
            func foo(arg1: Ty1, ..., argN: TyN): RetTy { body }
            =>
            func foo(arg1: Ty1, ..., argN: TyN): RetTy {
                actorInstance.post<RetTy>({ => body })
            }
         */
        let retTy = fd.declType
        fd.declType = actorFutureType(retTy)

        let retExpr = ReturnExpr(
            quote(
            return $ACTOR_INSTANCE_TOKEN.post<$retTy>({=> $(fd.block.nodes) })
        ))

        fd.block.nodes.clear()
        fd.block.nodes.add(retExpr)
    }

    private func modifyReceiverWithPriority(): Unit {
        /*
            @receiverMarker
            func foo(arg1: Ty1, ..., argN: TyN): RetTy { body }
            =>
            func foo(arg1: Ty1, ..., argN: TyN, priority!: Int64 = $defaultPriority): RetTy {
                actorInstance.post<RetTy>({ => body })
            }
         */
        let fd = fdOpt.getOrThrow()
        let defaultPriority = receiverOptions.getPriority()

        let retTy = fd.declType
        fd.declType = actorFutureType(retTy)
        fd.funcParams.add(FuncParam(quote(priority!: Int64 = $defaultPriority)))

        let retExpr = ReturnExpr(
            quote(
            return $ACTOR_INSTANCE_TOKEN.post<$retTy>({ => $(fd.block.nodes) }, priority: priority)
        ))

        fd.block.nodes.clear()
        fd.block.nodes.add(retExpr)
    }
}
