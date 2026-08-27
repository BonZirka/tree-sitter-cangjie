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
 * This file defines the options supported by the @Actor and @Receiver macros.
 *
 */

macro package stdx.actors.macros

import std.ast.*
import std.collection.{HashMap, HashSet}
import std.convert.Parsable

private const DEFAULT_PRIORITY = 5

enum MacroOptionKey <: Hashable & ToString & Equatable<MacroOptionKey> {
    EnableReceiverPriority
    | Priority

    public override func hashCode(): Int64 {
        match (this) {
            case EnableReceiverPriority => 0
            case Priority => 1
        }
    }

    public override func toString(): String {
        match (this) {
            case EnableReceiverPriority => "enableReceiverPriority"
            case Priority => "priority"
        }
    }

    public override operator func ==(other: MacroOptionKey): Bool {
        match ((this, other)) {
            case (EnableReceiverPriority, EnableReceiverPriority) => true
            case (Priority, Priority) => true
            case _ => false
        }
    }

    public override operator func !=(other: MacroOptionKey): Bool {
        !(this == other)
    }
}

enum MacroOption {
    EnableReceiverPriority(Bool)
    | Priority(Int64)
}

class MacroOptionSet {
    private let keys = HashSet<MacroOptionKey>()
    private let opts = HashMap<MacroOptionKey, MacroOption>()

    func contains(key: MacroOptionKey): Bool {
        keys.contains(key)
    }

    func add(key: MacroOptionKey, opt: MacroOption): Unit {
        keys.add(key)
        opts.add(key, opt)
    }

    func iterate(f: (MacroOptionKey, MacroOption) -> Bool) {
        for ((key, opt) in opts) {
            if (!f(key, opt)) {
                break
            }
        }
    }

    func checkOptions(allowed: Array<MacroOptionKey>, errors: MacroErrors, name: String): Unit {
        iterate {
            key, _ =>
                if (!allowed.contains(key)) {
                    match (name) {
                        case "@Actor" => errors.add(MacroError.ActorMacroInvalidMacroOption(key))
                        case "@Receiver" => errors.add(MacroError.ReceiverMacroInvalidOption(key))
                        case _ => ()
                    }
                }
                true
        }
    }

    func hasEnabledReceiverPriority(): Bool {
        if (let Some(EnableReceiverPriority(b)) <- opts.get(EnableReceiverPriority)) {
            return b
        }
        return false
    }

    func getPriority(): Int64 {
        if (let Some(Priority(p)) <- opts.get(Priority)) {
            return p
        }
        return DEFAULT_PRIORITY
    }
}

class MacroOptionParser {
    private let it: TokensIterator
    private let opts = MacroOptionSet()
    private let errors: MacroErrors

    static func run(tokens: Tokens, errors: MacroErrors): MacroOptionSet {
        if (tokens.size == 0) {
            return MacroOptionSet()
        }

        let parser = MacroOptionParser(tokens, errors)
        parser.parse()
        return parser.opts
    }

    private init(tokens: Tokens, errors: MacroErrors) {
        this.it = tokens.iterator()
        this.errors = errors
    }

    private func parse(): Unit {
        while (let Some(t) <- it.next()) {
            if (t.kind == TokenKind.NL) {
                continue
            }
            if (t.kind != IDENTIFIER) {
                errors.add(MacroError.MacroOptionUnexpectedToken(t.value))
                break
            }
            // colon
            match (it.next()) {
                case Some(c) where c.kind == TokenKind.COLON => ()
                case Some(c) =>
                    errors.add(MacroError.MacroOptionUnexpectedToken(c.value))
                    break
                case None =>
                    errors.add(MacroError.MacroOptionInvalidFormat)
                    break
            }
            // value
            it.next()
            if (let None <- it.peek()) {
                errors.add(MacroError.MacroOptionInvalidFormat)
                break
            }

            parseOption(t, it.peek().getOrThrow())

            // next token must be a COMMA or nothing
            match (it.next()) {
                case Some(n) where n.kind == TokenKind.COMMA => continue
                case Some(n) where n.kind == TokenKind.NL => continue
                case Some(_) =>
                    errors.add(MacroError.MacroOptionInvalidFormat)
                    break
                case None => break // we are done
            }
        }
    }

    private func parseOption(opt: Token, val: Token): Unit {
        if (opt.value == EnableReceiverPriority.toString()) {
            parseEnableReceiverPriority(val)
        } else if (opt.value == Priority.toString()) {
            parsePriority(val)
        } else {
            errors.add(MacroError.MacroOptionInvalidOption(opt.value))
        }
    }

    private func parseEnableReceiverPriority(t: Token): Unit {
        let val = try {
            Bool.parse(t.value)
        } catch (_: IllegalArgumentException) {
            errors.add(MacroError.MacroOptionEnableReceiverPriorityIllegalArgument)
            return
        }

        addOption(EnableReceiverPriority, EnableReceiverPriority(val))
    }

    private func parsePriority(t: Token): Unit {
        let val = try {
            Int64.parse(t.value)
        } catch (_: IllegalArgumentException) {
            errors.add(MacroError.MacroOptionPriorityIllegalArgument)
            return
        }
        if (val < 1 || val > 10) {
            errors.add(MacroError.MacroOptionPriorityIllegalArgument)
            return
        }

        addOption(Priority, Priority(val))
    }

    private func addOption(key: MacroOptionKey, opt: MacroOption): Unit {
        if (opts.contains(key)) {
            errors.add(MacroOptionDuplicatedOption(key))
            return
        }
        opts.add(key, opt)
    }
}
