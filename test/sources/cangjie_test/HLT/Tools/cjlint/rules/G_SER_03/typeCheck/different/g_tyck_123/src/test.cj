/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import stdx.serialization.serialization.{Serializable, DataModel, DataModelStruct, Field, field}
import std.collection.*

class MySerialize <: Serializable<MySerialize> {
    public static var value:Option<HashSet<UInt64>>=Some(HashSet<UInt64>([3]))

    public init(v: Option<HashSet<UInt64>>) {
        value = v
    }

    public func serialize(): DataModel {
        return DataModelStruct().add(field<Option<HashSet<UInt64>>>("value", value))
    }

    private init(s: DataModelStruct) {
        var v = Option<HashSet<Int64>>.deserialize(s.get("value"))
    }

    public static func deserialize(s: DataModel): MySerialize {
        let d = (s as DataModelStruct).getOrThrow()
        return MySerialize(d)
    }
}

main(){}
