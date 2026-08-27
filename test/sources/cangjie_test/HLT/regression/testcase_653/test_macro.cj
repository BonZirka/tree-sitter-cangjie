/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: macro_definition.cj
// EXEC: %compiler %cmp_macro macro_definition.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f -o %output

import define.*
@echo public let var46 : Int64 = Int64(UInt32(Int16(-102)))
@echo public var var72 : UInt8 = UInt8(12)
@echo public interface Interface16<T0> {}

@echo public open class Class13<T0, T1> <: Interface16<Range<UInt8>> {
    @echo public init() { // block id: 15

    }
;
    @echo public var var30 : Int64 = (-7)
}

@echo public func func18<T0>(param19 : Interface16<Range<UInt8>>, param20 : Int16, optionalParam21 ! : Bool = (Class13<Float32, Array<Int64>>() is String)) : Class13<Float32, Array<Int64>> { // block id: 24
    Class13<Float32, Array<Int64>>()
}

@echo public func func8<T0, T1>(param9 : Int16) : Int64 { // block id: 10
    @echo let var53 : Int64 = Int64(UInt16(Int8(64)));
    @echo let var64 : Array<Int64> = [95, 1, (-68), 34, (-111), (-83), (-27), (-117), 3, (-37)];
    (func18<Range<Int8>>(Class13<Float32, Array<Int64>>(), Int16(57), optionalParam21 : false).var30) ^ if (true) { [var46, 7, var46, var53, (-58), var46, (-127), (-109), 55, var46] } else { var64 } [0]
}

main(): Int64 {
    try {
        @echo var var68 : (Int16) -> Int64 = func8<Int64, Int32>;

    } catch (e: NoneValueException) { println("Exception: NoneValueException") }

    return 0;
}
// ASSERT: scan chir_typecast_overflow
// ASSERT: scan chir_dce_unused_variable
