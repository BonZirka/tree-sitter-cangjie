/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.sync.*

/*
    A multilevel concurrent queue designed for Single Producer Multiple Consumer scenario.
    In the initializer you can set number of priorities P. The priorities for messages
    range between [0, P-1]. This class creates multiple linked queues, each queue for each priority.
    send() operation is O(1), receive() is O(P), so the number of priorities should be small
    in order for this queue to work efficiently.
 */
class SPMCLevelQueue<T> {
    let levels: Int64
    let reverse: Bool
    let size: AtomicInt64 = AtomicInt64(0)
    let closed: AtomicBool = AtomicBool(false)
    let queues: Array<ClosableNonBlockingQueue<T>>
    let prange: Range<Int64>

    let sendqSizes: Array<AtomicInt64>

    let recvMon: Monitor = Monitor()
    let recvqSize: AtomicInt64 = AtomicInt64(0)

    init(levels: Int64, reverse!: Bool = false) {
        this.levels = levels
        this.sendqSizes = Array<AtomicInt64>(levels, {_ => AtomicInt64(0)})
        this.reverse = reverse
        this.prange = match (reverse) {
            case false => (levels - 1)..=0 : -1
            case true => 0..levels
        }
        this.queues = Array<ClosableNonBlockingQueue<T>>(levels, {
            _ => ClosableNonBlockingQueue<T>()
        })
    }

    func send(elem: T, priority: Int64): Bool {
        if (priority >= levels || priority < 0) {
            throw IllegalArgumentException("Priority can't be negative or larger than ${levels}, received ${priority}.")
        }

        if (queues[priority].enqueue(elem)) {
            size.fetchAdd(1)
            sendqSizes[priority].fetchAdd(1)
            if (recvqSize.load() == 0) {
                return true
            }
            synchronized(recvMon) {
                if (recvqSize.load() != 0) {
                    recvMon.notify()
                }
            }
            return true
        }
        return false
    }

    func receive(): Option<T> {
        while (true) {
            if (let Some(v) <- tryReceive()) {
                return v
            }

            synchronized (recvMon) {
                if (isClosed()) {
                    return None
                }
                recvqSize.fetchAdd(1)
                if (bufferEmpty()) {
                    recvMon.wait(timeout: Duration.second)
                }
                recvqSize.fetchAdd(-1)
            }
        }

        return Option<T>.None
    }

    func receive(timeout!: Duration): Option<T> {
        if (let Some(v) <- tryReceive()) {
            return v
        }

        synchronized (recvMon) {
            recvqSize.fetchAdd(1)
            if (bufferEmpty()) {
                recvMon.wait(timeout: timeout)
            }
            recvqSize.fetchAdd(-1)
        }
        tryReceive()
    }

    func tryReceive(): ?T {
        for (priority in prange) {
            if (sendqSizes[priority].load() > 0) {
                if (let Some(v) <- queues[priority].dequeue()) {
                    sendqSizes[priority].fetchSub(1)
                    size.fetchSub(1)
                    return v
                }
            }
            
        }
        return None
    }

    func close(): Unit {
        synchronized (recvMon) {
            for (priority in 0..levels) {
                queues[priority].close()
                sendqSizes[priority].store(0)
            }
            size.store(0)
            closed.store(true)

            recvMon.notifyAll()
        }
    }

    func isClosed(): Bool {
        return closed.load()
    }

    func bufferEmpty(): Bool {
        return size.load() == 0
    }
}
