// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main(): Int64 {
    func serialize(): DataModel {
        return DataModelStruct()
            .add(field<String>("os", os))
            .add(field<String>("hostName", hostName))
            .add(field<String>("login", login))
    }

    func deserialize(dm: DataModel): SystemInfo {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct")
        }
        var result = SystemInfo(String.deserialize(dms.get("name")), String.deserialize(dms.get("age")),
            String.deserialize(dms.get("loc")))
        return result
    }

    func ttt() {
        var var40: Int16 = Int16(-18)
        UInt16((Result<Int16>.Ok(Int16(3)) ?? [var40, var40, Int16(64), Int16(-34), Int16(-90), Int16(-56), Int16(38),
            Int16(-111), Int16(-84), var40][5]));
    }

    if (!fut1.isDone() || !fut2.isDone() || !fut3.isDone() || !fut4.isDone() || !fut5.isDone() || !fut6.isDone() ||
        !fut7.isDone() || !fut8.isDone() || !fut9.isDone() || !fut10.isDone()) {
        return 2
    }

    if (TA13() is TI && TA12() is TI && TA11() is TI && TA10() is TI && TA9() is TI && TA8() is TI && TA7() is TI &&
        TA6() is TI && TA5() is TI && TA4() is TI && TA3() is TI && TA2() is TI && TA1() is TI && TA() is TI) {
        return 0
    }
}
