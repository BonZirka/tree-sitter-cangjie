/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.collection.*
import std.collection.concurrent.*
import std.sync.AtomicBool

extend<K, V> HashMap<K, V> {
    func computeIfAbsent(key: K, genValByKey: (K) -> V): V {
        match (get(key)) {
            case Some(val) => return val
            case None =>
                let val = genValByKey(key)
                add(key, val)
                return val
        }
    }

    func getIfAbsent(key: K, value: V): V {
        var view = this.entryView(key)
        if (view.value.isNone()) {
            view.value = value
        }
        view.value.getOrThrow()
    }
}

class ClosableBlockingQueue<E> <: Resource {
    let queue: LinkedBlockingQueue<E>
    let capacity: Int64
    let quit = AtomicBool(false)

    init(capacity: Int64) {
        queue = LinkedBlockingQueue<E>(capacity)
        this.capacity = capacity
    }

    prop size: Int64 {
        get() {
            queue.size
        }
    }

    func enqueue(element: E): Bool {
        if (isClosed()) {
            return false
        }
        queue.add(element)
        return true
    }

    func dequeue(): Option<E> {
        while (!isClosed() || queue.size > 0) {
            if (let Some(v) <- queue.remove(Duration.millisecond * 100)) {
                return v
            }
        }
        return None
    }

    func dequeue(timeout: Duration): Option<E> {
        queue.remove(timeout)
    }

    func tryDequeue(): Option<E> {
        return queue.tryRemove()
    }

    func isFull(): Bool {
        return queue.size == capacity
    }

    func reset(): Unit {
        while (tryDequeue().isSome()) {}
        quit.store(false)
    }

    public func close(): Unit {
        quit.store(true)
    }

    public func isClosed(): Bool {
        return quit.load()
    }
}

class ClosableNonBlockingQueue<E> <: Resource {
    let queue: ConcurrentLinkedQueue<E> = ConcurrentLinkedQueue<E>()
    let quit = AtomicBool(false)

    func enqueue(element: E): Bool {
        if (isClosed()) {
            return false
        }
        return queue.add(element)
    }

    func dequeue(): Option<E> {
        queue.remove()
    }

    public func close(): Unit {
        quit.store(true)
        while (let Some(v) <- queue.remove()) {}
    }

    public func isClosed(): Bool {
        return quit.load()
    }
}
