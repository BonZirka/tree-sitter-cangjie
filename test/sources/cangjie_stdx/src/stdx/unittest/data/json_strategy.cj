/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.unittest.data

import std.unittest.common.*
import std.collection.*
import std.fs.*
import stdx.serialization.serialization.*
import stdx.encoding.json.*

public class SerializableProvider<T> <: DataProvider<T> where T <: Serializable<T> {
    SerializableProvider(let data: DataModelSeq) {}

    public override func provide(): Iterable<T> {
        data.getItems() |> map<DataModel, T> {it => T.deserialize(it)}
    }
}

public class JsonStrategy<T> <: DataStrategy<T> where T <: Serializable<T> {
    JsonStrategy(let data: JsonArray) {}

    init(fileName!: String) {
        let jsonData = JsonValue.fromStr(String.fromUtf8(File.readFrom(fileName)))
        match (jsonData) {
            case arr: JsonArray => this.data = arr
            case _ => throw IllegalArgumentException("Error while reading ${fileName}: expected json array")
        }
    }

    public override func provider(_: Configuration): SerializableProvider<T> {
        let dm = DataModel.fromJson(data) as DataModelSeq ?? throw IllegalArgumentException()
        SerializableProvider(dm)
    }
}

public func json<T>(fileName: String): JsonStrategy<T> where T <: Serializable<T> {
    JsonStrategy<T>(fileName: fileName)
}
