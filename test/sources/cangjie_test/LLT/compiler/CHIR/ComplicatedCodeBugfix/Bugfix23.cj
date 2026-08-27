// LEVEL: 0

// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %set_stdx_path %run %run_opt %output %run_args | compare %f
// ASSERT: scan 123

 
internal import stdx.encoding.json.JsonValue
internal import stdx.serialization.serialization.{DataModel, DataModelException, DataModelStruct, Serializable,
    DataModelString, DataModelSeq}
 
public interface Custom {
    func test(): String
    static func staticTest(): String
 
    func notStaticTest(): String {
        staticTest()
    }
}
 
class Test <: Custom {
    public func test(): String {
        "1234"
    }
 
    public static func staticTest(): String {
        return "123"
    }
}
 
public interface EnhanceSerializable<T> <: Serializable<T> {
    func deserializeForEnhance(dm: DataModel): T {
        deserialize(dm)
    }
}
 
extend String <: EnhanceSerializable<String> {}
 
main(): Int64 {
    let test = Test()
 
    println(test.notStaticTest())
 
    0
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
