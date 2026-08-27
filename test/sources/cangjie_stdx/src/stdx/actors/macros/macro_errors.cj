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
 * This file defines a MacroErrors class that is used to collect errors from using the actor macros.
 *
 */

macro package stdx.actors.macros

import std.collection.HashSet

enum MacroError <: ToString {
    ActorMacroInvalidDecl
    | ActorMacroInvalidClassModifier
    | ActorMacroInvalidMacroOption(MacroOptionKey)
    | ActorMacroInternalError
    | ReceiverMacroInsideActor
    | ReceiverMacroInvalidDecl
    | ReceiverMacroInvalidModifier(String)
    | ReceiverMacroInvalidReturnType(String)
    | ReceiverMacroPriorityInsideActor
    | ReceiverMacroPriorityNameParameter
    | ReceiverMacroInvalidOption(MacroOptionKey)
    | MacroOptionInvalidOption(String)
    | MacroOptionInvalidFormat
    | MacroOptionUnexpectedToken(String)
    | MacroOptionEnableReceiverPriorityIllegalArgument
    | MacroOptionPriorityIllegalArgument
    | MacroOptionDuplicatedOption(MacroOptionKey)

    public override func toString(): String {
        match (this) {
            case ActorMacroInvalidDecl => "@Actor macro: must be a class declaration."
            case ActorMacroInvalidClassModifier => "@Actor macro: class declaration cannot be abstract nor open nor sealed."
            case ActorMacroInvalidMacroOption(opt) => "@Actor macro: invalid option '${opt}'."
            case ActorMacroInternalError => "@Actor macro: actor macro framework internal error."

            case ReceiverMacroInsideActor => "@Receiver macro: must be used inside an @Actor macro."
            case ReceiverMacroInvalidDecl => "@Receiver macro: must be used on a function declaration."
            case ReceiverMacroInvalidModifier(name) => "@Receiver macro: receiver method '${name}' cannot be static nor open nor overriding another function."
            case ReceiverMacroInvalidReturnType(name) => "@Receiver macro: receiver method '${name}' must have explicit return type."
            case ReceiverMacroPriorityInsideActor => "@Receiver macro: priority option can only be used inside @Actor[enableReceiverPriority: true]."
            case ReceiverMacroPriorityNameParameter => "@Receiver macro: the name priority cannot be used as a named parameter."
            case ReceiverMacroInvalidOption(opt) => "@Receiver macro: invalid option '${opt}'."

            case MacroOptionInvalidOption(name) => "Macro options: invalid option '${name}'."
            case MacroOptionInvalidFormat => "Macro options: an option must be in the form of 'option1: value1, option2: value2'."
            case MacroOptionUnexpectedToken(name) => "Macro options: unexpected token '${name}'."
            case MacroOptionEnableReceiverPriorityIllegalArgument => "Macro options: enableReceiverPriority must take a boolean literal."
            case MacroOptionPriorityIllegalArgument => "Macro options: priority must be an integer literal inside the range [1..10]."
            case MacroOptionDuplicatedOption(opt) => "Macro options: duplicated option '${opt}'."
        }
    }
}

class MacroErrors {
    private let errors = HashSet<String>()

    func add(e: MacroError): Unit {
        errors.add(e.toString())
    }

    func report() {
        if (!errors.isEmpty()) {
            doThrow()
        }
    }

    func doThrow(): Nothing {
        throw MacroException(String.join(errors.toArray(), delimiter: "\n"))
    }
}
