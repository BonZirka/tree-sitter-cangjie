/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

/**
 * Lightweight signature bundle for a function-like symbol (name, type, generic parameters).
 */
public class FuncSigInfo {
    internal var _genericTypeParams: ArrayList<GenericType>
    internal var _name: String
    internal var _type: FuncType

    public init(name: String, ty: FuncType) {
        this._name = name
        this._type = ty
        this._genericTypeParams = ArrayList<GenericType>()
    }

    /**
     * Builds a signature view from a display name, function type, and generic parameters.
     * @param name Logical name of the symbol.
     * @param ty Function type (parameters and return).
     * @param genericTypeParams Generic type parameters in declaration order.
     */
    public init(name: String, ty: FuncType, genericTypeParams: Array<GenericType>) {
        this._name = name
        this._type = ty
        this._genericTypeParams = ArrayList<GenericType>.of(genericTypeParams)
    }

    /**
     * Generic type parameters attached to this signature.
     * @type { Array<GenericType> }
     */
    public prop genericTypeParams: Array<GenericType> {
        get() {
            return _genericTypeParams.toArray()
        }
    }

    /**
     * Display or mangled name of the symbol.
     * @type { String }
     */
    public prop name: String {
        get() {
            return _name
        }
    }

    /**
     * Function type for this signature.
     * @type { FuncType }
     */
    public prop ty: FuncType {
        get() {
            return _type
        }
    }

    /**
     * Prints the signature to standard output for debugging.
     */
    public func dump(): Unit {
        println(toString())
    }

    /**
     * Renders the signature as `name<generics>(params) -> ret`.
     * @return Single-line textual form of this signature.
     */
    public func toString(): String {
        var result = StringBuilder()
        result.append(_name)
        result.append(typeVecToString("<", genericTypeParams, ">"))
        result.append("(")
        result.append(typeVecToString("", _type.paramTypes, ""))
        result.append(") -> ")
        result.append(_type.returnType.toString())
        return result.toString()
    }
}
