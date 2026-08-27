/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

/**
 * Controls how `CHIRVisitor` proceeds when visiting an expression.
 */
public enum IRActionMode <: Equatable<IRActionMode> {
    | Continue
    | Stop
    | Skip
    | ...

    public operator func ==(rhs: IRActionMode): Bool {
        match ((this, rhs)) {
            case (Continue, Continue) => true
            case (Stop, Stop) => true
            case (Skip, Skip) => true
            case _ => false
        }
    }
}

/**
 * Visitor over functions, block groups, blocks, and nested expressions.
 *
 * Override `action` to observe each expression; `walk` dispatches recursively until STOP.
 */
public abstract class CHIRVisitor {
    private var isStop = false

    /**
     * Visits the body of `f` when present.
     * @param f Function whose body should be walked.
     */
    public func walk(f: Function): Unit {
        if (let Some(body) <- f.body) {
            walk(body)
        }
    }

    /**
     * Visits every block in `bg` in order.
     * @param bg Block group to traverse.
     */
    public func walk(bg: BlockGroup): Unit {
        for (b in bg.blocks) {
            if (isStop) {
                return
            }
            walk(b)
        }
    }

    /**
     * Visits every expression in `b` and recursively walks nested block groups.
     * @param b Basic block to traverse.
     */
    public func walk(b: Block): Unit {
        for (e in b.exprs) {
            let actionResult = action(e)
            isStop = (actionResult == IRActionMode.Stop)
            if (isStop) {
                return
            }
            if (actionResult == IRActionMode.Skip) {
                continue
            }
            for (subBg in e.blockGroups) {
                walk(subBg)
                if (isStop) {
                    return
                }
            }
        }
    }

    /**
     * Decides whether to keep walking after visiting one expression.
     * @param ty Current expression node (name kept for compatibility with existing overrides).
     * @return Visitor control mode for this node.
     */
    public open func action(ty: Expression): IRActionMode {
        return IRActionMode.Continue
    }
}
