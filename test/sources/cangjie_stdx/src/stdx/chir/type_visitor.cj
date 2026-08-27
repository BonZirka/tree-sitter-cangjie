/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

/**
 * Controls how `TypeVisitor` proceeds when visiting a type node.
 */
public enum TypeActionMode {
    CONTINUE | SKIP | STOP
}

/**
 * Depth-first visitor over `Type` and its type arguments.
 *
 * Subclasses override `action` to inspect each node; `walk` applies the returned mode.
 */
public abstract class TypeVisitor {
    private var isStop = false

    /**
     * Recursively visits `ty` and its `typeArgs` according to `action` results.
     * @param ty Root type to visit.
     */
    public func walk(ty: Type): Unit {
        if (isStop) {
            return
        }
        match (action(ty)) {
            case CONTINUE =>
                for (arg in ty.typeArgs) {
                    walk(arg)
                }
            case SKIP => return
            case STOP =>
                isStop = true
                return
        }
    }

    /**
     * Decides how to continue after visiting a single type.
     * @param ty Type currently being visited.
     * @return Visitor control mode for this node.
     */
    public open func action(ty: Type): TypeActionMode {
        return TypeActionMode.CONTINUE
    }
}
