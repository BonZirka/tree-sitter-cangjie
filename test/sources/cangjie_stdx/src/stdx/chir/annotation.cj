/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

/**
 * One annotation occurrence in CHIR, corresponding to source like `@ClassName[v1, v2, ...]`.
 *
 * Stores the annotation class name as written in source and a map from parameter names to
 * string values. Callers may construct instances for tests or plugins; the compiler pipeline
 * also builds these when lowering source annotations.
 */
public class CustomAnnoInstance <: ToString {
    internal var _argValues = ArrayList<String>()
    internal let _classSrcCodeName: String
    internal let _loc: DebugLocation

    /**
     * Gets the `argValues` property.
     * @type { Array<String> }
     */
    public mut prop argValues: Array<String> {
        get() {
            _argValues.toArray()
        }
        set(v) {
            _argValues = ArrayList<String>.of(v)
        }
    }

    /**
     * Source-level name of the annotation class (e.g. `MyAnno`).
     * @type { String }
     */
    public prop classSrcCodeName: String {
        get() {
            return _classSrcCodeName
        }
    }

    /**
     * Source span where this annotation appeared, when known.
     * @type { DebugLocation }
     */
    public prop location: DebugLocation {
        get() {
            return _loc
        }
    }

    /**
     * Creates an annotation with the given class name and an invalid (empty) location.
     * @param classSrcCodeName Annotation class name as written in source.
     */
    public init(classSrcCodeName: String) {
        this._classSrcCodeName = classSrcCodeName
        this._loc = DebugLocation.invalid()
    }

    /**
     * Creates an annotation with the given class name and source location.
     * @param classSrcCodeName Annotation class name as written in source.
     * @param loc Span in source for this annotation occurrence.
     */
    public init(classSrcCodeName: String, loc: DebugLocation) {
        this._classSrcCodeName = classSrcCodeName
        this._loc = loc
    }

    /**
     * Renders this annotation as `@ClassName[v1, v2, ...]`.
     * @return Text form suitable for debugging and dumps.
     */
    public func toString(): String {
        return annoInstanceToString(this, 0)
    }
}

/**
 * Package-internal holder for a list of `Annotation` on one CHIR node.
 *
 * Not exported as public API: external code should use `Array<Annotation>` exposed on
 * `MemberVar` and `EnumCtorInfo`. This type backs those views and may still appear in
 * internal compiler APIs inside `stdx.chir`.
 */
internal class AnnoInfo <: ToString {
    // @class1Name[v1, v2, ...]
    // @class2Name[v1, v2, ...]
    // func foo() { ... }
    internal var _annoInstances = ArrayList<CustomAnnoInstance>()
    // annotation factory function mangled name
    internal var _identifier: String = "none"

    internal init() {
        this._identifier = "none"
        this._annoInstances = ArrayList<CustomAnnoInstance>()
    }

    internal init(identifier: String) {
        this._identifier = identifier
        this._annoInstances = ArrayList<CustomAnnoInstance>()
    }

    /**
     * Concatenates each annotation's `toString()` on its own line.
     * @return Multi-line debug text; may end with a trailing newline when non-empty.
     */
    public func toString(): String {
        return annoInfoToString(this, 0)
    }
}
