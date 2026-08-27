// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

macro package macros.serialize
internal import std.ast.*

    /*
    struct Config {
        var Active: ArrayList<String>
    }
    ////////////=>Expanded as
    struct Config <: Serializable<Config> {
        var Active: ArrayList<String>
        public func serialize(): DataModel {
            return DataModelStruct().add(Field("Active", this.Active.serialize()))
        }
        public static func deserialize(dm: DataModel): Config {
            return match (dm) {
                case dms: DataModelStruct => Config(ArrayList<String>.deserialize((dms.get("Active") as DataModelSeq).getOrThrow()))
                case _ => throw Exception("this data is not DataModelStruct")
            }
        }
    }
*/
public macro SerializeRecord(input: Tokens) : Tokens {
    let structDecl = parseDecl(input).asStructDecl()
    let structIdent = structDecl.getIdentifier()
    let structModifier = structDecl.getModifiers()
    let structBody = structDecl.getBody()
    // for serialize
    var addFields = Tokens()
    // for deserialize
    var constructors = Tokens()
    for (node in structBody) {
        if (node.isVarDecl()) {
            let varDecl = node.asVarDecl()
            let varIdent = varDecl.getIdentifier()
            let varType = varDecl.getType().asRefType() // must have type or throw exceptions
            let varTypeIdent = varType.getIdentifier()
            // add comma for constructors
            if (constructors.size != 0) {
                constructors += quote(,)
            }
            if (varTypeIdent.value == "DataModelStruct") {
                addFields += quote(.add(Field($(varIdent.value), this.$(varIdent))))
                constructors += quote((dms.get($(varIdent.value)) as DataModelStruct).getOrThrow())
            } else if (varTypeIdent.value == "JsonValue") {
                addFields += quote(.add(Field($(varIdent.value), DataModel.fromJson(this.$(varIdent)))))
                constructors += quote((dms.get($(varIdent.value)) as DataModelStruct).getOrThrow().toJson())
            } else if (varTypeIdent.value == "ArrayList") { // ArrayList<String> matches DataModelSeq
                addFields += quote(.add(Field($(varIdent.value), this.$(varIdent).serialize())))
                constructors += quote($(varType).deserialize((dms.get($(varIdent.value)) as DataModelSeq).getOrThrow()))
            }
        }
    }
    return quote ($structModifier struct $structIdent <: Serializable<$structIdent> {
            $structBody

            public func serialize(): DataModel {
                return DataModelStruct() $(addFields)
            }

            public static func deserialize(dm: DataModel): $structIdent {
                return match (dm) {
                    case dms: DataModelStruct => $structIdent($constructors)
                    case _ => throw Exception("this data is not DataModelStruct")
                }
            }
        }
    )
}