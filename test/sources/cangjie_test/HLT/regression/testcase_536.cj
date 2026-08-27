/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 

type TASK_TYPE<IN, OUT> = (IN) -> OUT

open class StepN<T, V> {}

class StepNProxy<T, V> <: StepN<T, V> {
    private let stepFunc: TASK_TYPE<T, V>

    public init(stepFunc: TASK_TYPE<T, V>) {
        this.stepFunc = stepFunc
    }

    public func apply(data: T): V {
        return stepFunc(data)
    }

    public func next<R>(nextProxy: StepNProxy<V, R>): StepNProxy<T, R> {
        let f = { data: T =>
            let r = this.apply(data)
            nextProxy.apply(r)
        }
        let combo = StepNProxy<T, R>(f)
        return combo
    }
}

main() {}	
