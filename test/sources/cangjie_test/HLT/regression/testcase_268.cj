/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

public interface Interface32<T0, T1>  {
    func func96(param97 : Unit, param98 : Int64, namedParam99 ! : Int64, namedParam100 ! : Float32) : Bool { // block id: 101
        let var269 : (Float64) -> Bool = func163<Range<Int8>, Range<UInt16>>;
        69.0|>var269
    }
}

public interface Interface31<T0, T1> <: Interface32<Range<Int8>, Option<UInt16>> {}

public interface Interface30 <: Interface31<Range<UInt16>, Option<Array<Option<Float64>>>>  {}

public open class Class27<T0, T1> <: Interface30  {
    static func func196<T0>(namedParam197 ! : (Rune, Float64, UInt8, (Int16, Float32, Float64), (Int16, Float32, Float64), UInt32), namedParam198 ! : Int16) : Float64 { 
        -2.0
    }
}

func func163<T0, T1>(param164 : Float64) : Bool { 
    var var177 : (Int16, Float32, Float64) = (Int16(-98), Float32(93.0), 34.0);
    param164 > (Class27<Range<UInt8>, Range<Int16>>.func196<Int32>(namedParam197 : (r'3', 81.0, UInt8(56), var177, var177, UInt32(55)), namedParam198 : Int16(-74)))
}

main(): Int64 {
    return 0;
}