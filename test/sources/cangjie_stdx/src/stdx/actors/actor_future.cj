/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines ActorFuture<T> type which corresponds to the pending result of a closure.
 *
 */

package stdx.actors

import std.sync.{AtomicBool, Mutex, Condition}
import std.time.DateTime

/**
 * ActorFuture<T> class corresponds to the pending result of a closure.
 */
public class ActorFuture<T> {
    /* The closure to be executed. */
    private let closure: () -> T
    /* The result of the closure. */
    private var result: FutureResult<T> = Pending
    /* A flag indicating if the result is ready. */
    private let isReady = AtomicBool(false)
    /* A mutex that is used to synchronize access to the result. */
    private let mtx = Mutex()
    private let cond: Condition

    public func get(): T {
        if (isReady.load()) {
            return result.getOrThrow()
        }

        synchronized(mtx) {
            while (!isReady.load()) {
                cond.wait()
            }
            return result.getOrThrow()
        }
    }

    public func get(timeout: Duration): Option<T> {
        if (timeout <= Duration.Zero) {
            return Some(get())
        }
        if (isReady.load()) {
            return Some(result.getOrThrow())
        }
        let start = DateTime.now()
        synchronized(mtx) {
            while (true) {
                if (isReady.load()) {
                    break
                }
                let timeElapsed = DateTime.now() - start
                if (timeElapsed >= timeout) {
                    break;
                }
                let d = timeout - timeElapsed
                cond.wait(timeout: d)
            }
        }
        return tryGet()
    }

    public func tryGet(): Option<T> {
        if (isReady.load()) {
            return Some(result.getOrThrow())
        }
        return None
    }

    init(f: () -> T) {
        closure = f
        synchronized(mtx) {
            cond = mtx.condition()
        }
    }

    func execute(): Unit {
        // assumption: isReady == false
        synchronized(mtx) {
            try {
                this.result = Okay(closure())
            } catch (e: Exception) {
                this.result = Exc(e)
            } catch (e: Error) {
                this.result = Err(e)
            }

            isReady.store(true)
            cond.notifyAll()
        }
    }
}

private enum FutureResult<T> {
    Pending
    | Okay(T)
    | Exc(Exception)
    | Err(Error)

    func getOrThrow(): T {
        match (this) {
            case Pending => throw IllegalArgumentException("Future is not ready.")
            case Okay(res) => return res
            case Exc(e) => throw e
            case Err(e) => throw e
        }
    }
}
