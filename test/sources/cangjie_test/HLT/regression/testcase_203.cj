/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

public enum Result<T, E> where E <: Exception {
    Ok(T) | Err(E)

    public func isOk(): Bool {
        return match (this) {
            case Ok(ok) => true
            case _ => false
        }
    }

    public func isErr(): Bool {
        return match (this) {
            case Err(err) => true
            case _ => false
        }
    }

    public func getOk(): Option<T> {
        return match (this) {
            case Ok(t) => Some(t)
            case _ => None
        }
    }

    public func getErr(): Option<E> {
        return match (this) {
            case Err(e) => Some(e)
            case _ => None
        }
    }

    public func getOrThrowErr(): T {
        match (this) {
            case Ok(t) => t
            case Err(e) => throw e
        }
    }
}
main(){}
