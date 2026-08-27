/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import std.sync.*
import stdx.net.tls.common.TlsException

/**
 * Simple concurrent-safe lazy impl. The provided builder in "configure" may
 * be invoked multiple times but it is guaranteed that only one instance wins.
 */
struct Lazy<T> {
    private let holder: AtomicReference<LazyState<T>>

    init(producer: () -> T) {
        holder = AtomicReference(Producer<T>(producer))
    }

    init() {
        holder = AtomicReference(Uninitialized<T>())
    }

    prop value: T {
        get() {
            compute()
        }
    }

    func set(v: T): Unit {
        holder.store(HasValue<T>(v))
    }

    func configure(producer: () -> T) {
        match (holder.load()) {
            case empty: Uninitialized<T> =>
                if (holder.compareAndSwap(empty, Producer<T>(producer))) {
                    return
                }
            case _ => ()
        }

        throw TlsException("Lazy is already configured")
    }

    private func compute(): T {
        do {
            match (holder.load()) {
                case box: HasValue<T> => return box.value
                case start: Producer<T> =>
                    let box = start.create()
                    if (holder.compareAndSwap(start, box)) {
                        return box.value
                    }
                case _: Uninitialized<T> => throw TlsException(
                    "This lazy is not yet initialized. Invoke configure first.")
                case _ => break // workaround compiler bug
            }
        } while (true)

        throw TlsException("should never reach here.")
    }
}

abstract class LazyState<T> {}

class Uninitialized<T> <: LazyState<T> {}

class Producer<T> <: LazyState<T> {
    Producer(private let producer: () -> T) {}

    func create(): HasValue<T> {
        HasValue<T>(producer())
    }
}

class HasValue<T> <: LazyState<T> {
    HasValue(let value: T) {}
}
