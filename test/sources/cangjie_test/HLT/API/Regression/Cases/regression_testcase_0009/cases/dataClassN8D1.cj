/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

public import stdx.serialization.serialization.*
public import stdx.encoding.json.*

class A1N8D1 <: Serializable<A1N8D1> {
    public var Variable2: Int64
    public var Variable3: Int64
    public var Variable4: Int64
    public var Variable5: Int64
    public var Variable6: Int64
    public var Variable7: Int64
    public var Variable8: Int64
    public var Variable9: Int64
    public init(Variable2: Int64, Variable3: Int64, Variable4: Int64, Variable5: Int64, Variable6: Int64,
        Variable7: Int64, Variable8: Int64, Variable9: Int64) {
        this.Variable2 = Variable2
        this.Variable3 = Variable3
        this.Variable4 = Variable4
        this.Variable5 = Variable5
        this.Variable6 = Variable6
        this.Variable7 = Variable7
        this.Variable8 = Variable8
        this.Variable9 = Variable9
    }
    private init(dms: DataModelStruct) {
        this.Variable2 = Int64.deserialize(dms.get("Variable2"))
        this.Variable3 = Int64.deserialize(dms.get("Variable3"))
        this.Variable4 = Int64.deserialize(dms.get("Variable4"))
        this.Variable5 = Int64.deserialize(dms.get("Variable5"))
        this.Variable6 = Int64.deserialize(dms.get("Variable6"))
        this.Variable7 = Int64.deserialize(dms.get("Variable7"))
        this.Variable8 = Int64.deserialize(dms.get("Variable8"))
        this.Variable9 = Int64.deserialize(dms.get("Variable9"))
    }
    public func serialize(): DataModel {
        let dms = DataModelStruct()
        dms.add(Field("Variable2", Variable2.serialize()))
        dms.add(Field("Variable3", Variable3.serialize()))
        dms.add(Field("Variable4", Variable4.serialize()))
        dms.add(Field("Variable5", Variable5.serialize()))
        dms.add(Field("Variable6", Variable6.serialize()))
        dms.add(Field("Variable7", Variable7.serialize()))
        dms.add(Field("Variable8", Variable8.serialize()))
        dms.add(Field("Variable9", Variable9.serialize()))
        return dms
    }
    public static func deserialize(dm: DataModel): A1N8D1 {
        let dms = (dm as DataModelStruct).getOrThrow()
        A1N8D1(dms)
    }
}
