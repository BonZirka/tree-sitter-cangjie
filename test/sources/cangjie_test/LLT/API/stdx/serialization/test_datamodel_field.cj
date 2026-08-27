/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// (CJNATIVE) EXEC:  %compiler %import-cangjie-stdx %cmp_opt %f -o %output %cmp_utest_opt
// (CJNATIVE) EXEC: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 

import stdx.serialization.serialization.*
import std.math.*
import stdx.encoding.json.*

/*
 * Test description: Test the funcs for Field
 * Test class:
 * public class Field
 */
@Test
class DataModelFieldTest {
    /*
     * Test description: Test Field ::serialization
     * Test API:
     * public init(name: String, data: DataModel)
     */
    @TestCase
    func testDataModelFieldInit(): Unit {
        Field("test", DataModelString("test String!"))
        @Expect(true)
    }

    /*
     * Test description: Test Field ::serialization
     * Test API:
     * public func getName(): String
     */
    @TestCase
    func testDataModelFieldGetName(): Unit {
        @Expect(Field("test",DataModelString("test String!")).getName(),"test")
    }

    /*
     * Test description: Test Field ::serialization
     * Test API:
     * public func getData(): DataModel
     */
    @TestCase
    func testDataModelFieldGetData(): Unit {
        @Expect(Field("test",DataModelString("test String!")).getData().toJson().toString(),JsonString("test String!").toString())
    }
    /*
     * Test description: Test Field ::serialization
     * Test API:
     * func serialize(): DataModel
     * static func deserialize(dm: DataModel): T
     */
    @TestCase
    func testDataModelFieldSerialization(): Unit {
        var caseID = 1
        let initDatas: Array<A> = [
            A(-10, 10, -20, 20, -30, 30, -40, 40, -50.0, 60.0, 70.0, r'`', true, #"\\"#, "null", "\"null\""),
            A(-0, 0, -0, 0, -0, 0, -0, 0, Float16.MinDenormal, Float32.GetE(), Float64.GetPI(), r'`', false, #"\\"#,
                "null", "\"null\""),
            A(Int8.Min, 0, Int16.Min, 0, Int32.Min, 0, Int64.Min, 0, Float16.Min, Float32.Min, Float64.Min, r'`', false,
                #"\\"#, "null", "\"null\""),
            A(-0, 0, -0, 0, -0, 0, -0, 0, Float16.MinNormal, Float32.GetE(), Float64.GetE(), r'`', false, #"\\"#, "null",
                "\"null\""),
            A(-0, 0, -0, 0, -0, 0, -0, 0, -0.0, 0.0, 0.0, r'`', false, #"\\"#, "null", "\"null\"")
        ]

        for (initData in initDatas) {
            var fieldInits = initData.fieldInit()
            var fieldName: Array<String> = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8",
                "item9", "item10", "item11"]
            var fieldDatas = initData.fieldData()
            for (i in 0..fieldInits.size) {
                var name = fieldInits[i].getName()
                var data = fieldInits[i].getData().toJson().toString()
                if (name == fieldName[i] && data == fieldDatas[i]) {
                    @Expect(true)
                } else {
                    println("testDataModelFieldSerialization case ${caseID} is failed\n")
                    @Expect(false)
                }
            }
            caseID++
        }
    }
}

class A <: Serializable<A> {
    public var item1: Int8
    public var item2: UInt8
    public var item3: Int16
    public var item4: UInt16
    public var item5: Int32
    public var item6: UInt32
    public var item7: Int64
    public var item8: UInt64
    public var item9: B
    public var item10: String
    public var item11: String
    public init(
        item1: Int8,
        item2: UInt8,
        item3: Int16,
        item4: UInt16,
        item5: Int32,
        item6: UInt32,
        item7: Int64,
        item8: UInt64,
        fieldB1: Float16,
        fieldB2: Float32,
        fieldB3: Float64,
        FieldB4: Rune,
        fieldB5: Bool,
        FieldB6: String,
        item10: String,
        item11: String
    ) {
        this.item8 = item8
        this.item2 = item2
        this.item1 = item1
        this.item3 = item3
        this.item6 = item6
        this.item5 = item5
        this.item4 = item4
        this.item7 = item7
        this.item9 = B(fieldB1, fieldB2, fieldB3, FieldB4, fieldB5, FieldB6)
        this.item10 = item10
        this.item11 = item11
    }
    public func fieldInit(): Array<Field> {
        var f1 = Field("item1", item1.serialize())
        var f2 = Field("item2", item2.serialize())
        var f3 = Field("item3", item3.serialize())
        var f4 = Field("item4", item4.serialize())
        var f5 = Field("item5", item5.serialize())
        var f6 = Field("item6", item6.serialize())
        var f7 = Field("item7", item7.serialize())
        var f8 = Field("item8", item8.serialize())
        var f9 = Field("item9", item9.serialize())
        var f10 = Field("item10", item10.serialize())
        var f11 = Field("item11", item11.serialize())
        var fields: Array<Field> = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11]
        //测试Field构造器，各种数据类型

        return fields
    }
    public func fieldData(): Array<String> {
        var fd1 = item1.serialize().toJson().toString()
        var fd2 = item2.serialize().toJson().toString()
        var fd3 = item3.serialize().toJson().toString()
        var fd4 = item4.serialize().toJson().toString()
        var fd5 = item5.serialize().toJson().toString()
        var fd6 = item6.serialize().toJson().toString()
        var fd7 = item7.serialize().toJson().toString()
        var fd8 = item8.serialize().toJson().toString()
        var fd9 = item9.serialize().toJson().toString()
        var fd10 = item10.serialize().toJson().toString()
        var fd11 = item11.serialize().toJson().toString()
        var fieldDatas: Array<String> = [fd1, fd2, fd3, fd4, fd5, fd6, fd7, fd8, fd9, fd10, fd11]
        //测试Field构造器，各种数据类型
        return fieldDatas
    }
    public func serialize(): DataModel {
        let dms = DataModelStruct()
        dms.add(Field("item1", item1.serialize()))
        dms.add(Field("item2", item2.serialize()))
        dms.add(Field("item3", item3.serialize()))
        dms.add(Field("item4", item4.serialize()))
        dms.add(Field("item5", item5.serialize()))
        dms.add(Field("item6", item6.serialize()))
        dms.add(Field("item7", item7.serialize()))
        dms.add(Field("item8", item8.serialize()))
        dms.add(Field("item9", item9.serialize()))
        dms.add(Field("item10", item10.serialize()))
        dms.add(Field("item11", item11.serialize()))
        return dms
    }

    public static func deserialize(dm: DataModel): A {
        let dms = (dm as DataModelStruct).getOrThrow()
        A(dms)
    }
    private init(dms: DataModelStruct) {
        this.item1 = Int8.deserialize(dms.get("item1"))
        this.item2 = UInt8.deserialize(dms.get("item2"))
        this.item3 = Int16.deserialize(dms.get("item3"))
        this.item4 = UInt16.deserialize(dms.get("item4"))
        this.item5 = Int32.deserialize(dms.get("item5"))
        this.item6 = UInt32.deserialize(dms.get("item6"))
        this.item7 = Int64.deserialize(dms.get("item7"))
        this.item8 = UInt64.deserialize(dms.get("item8"))
        this.item9 = B.deserialize(dms.get("item9"))
        this.item10 = String.deserialize(dms.get("item10"))
        this.item11 = String.deserialize(dms.get("item11"))
    }
}

class B <: Serializable<B> {
    public var item1: Float16 = 0.0
    public var item2: Float32 = -2.0
    public var item3: Float64 = 433_4155.0
    public var item4: Rune = r'\n'
    public var item5: Bool = true
    public var item6: String = "hello world ${item4}}"

    public init(item1: Float16, item2: Float32, item3: Float64, item4: Rune, item5: Bool, item6: String) {
        this.item1 = item1
        this.item2 = item2
        this.item3 = item3
        this.item4 = item4
        this.item5 = item5
        this.item6 = item6
    }
    public func serialize(): DataModel {
        let dms = DataModelStruct()
        dms.add(Field("item1", item1.serialize()))
        dms.add(Field("item2", item2.serialize()))
        dms.add(Field("item3", item3.serialize()))
        dms.add(Field("item4", item4.serialize()))
        dms.add(Field("item5", item5.serialize()))
        dms.add(Field("item6", item6.serialize()))
        return dms
    }

    public static func deserialize(dm: DataModel): B {
        let dms = (dm as DataModelStruct).getOrThrow()
        B(dms)
    }
    private init(dms: DataModelStruct) {
        this.item1 = Float16.deserialize(dms.get("item1"))
        this.item2 = Float32.deserialize(dms.get("item2"))
        this.item3 = Float64.deserialize(dms.get("item3"))
        this.item4 = Rune.deserialize(dms.get("item4"))
        this.item5 = Bool.deserialize(dms.get("item5"))
        this.item6 = String.deserialize(dms.get("item6"))
    }
}
