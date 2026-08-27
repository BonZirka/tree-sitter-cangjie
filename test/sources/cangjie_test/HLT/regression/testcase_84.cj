/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



public struct Complex64 {
    public var real: Float64
    public var imag: Float64
    public init(real: Float64, imag: Float64) {
        this.real = real
        this.imag = imag
    }
}

public interface Number<T> {}

extend Complex64 <: Number<Complex64> {}

public class Tensor<T> where T <: Number<T> {
    public var ptr: CPointer<T> = CPointer<T>()
    public init() {}
}

main() {
    let a = Tensor<Complex64>()
}
// ASSERT: scan sema_generic_type_argument_not_match_constraint


