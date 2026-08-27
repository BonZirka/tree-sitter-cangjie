/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./utils
// EXEC: %compiler %cmp_opt -p utils --mock=on %compile_lib_opt --output p1.%middle
// EXEC: %compiler %cmp_opt p1.%middle %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

import utils.*
import std.unittest.*
import std.unittest.mock.*
import std.unittest.testmacro.*
import std.unittest.mock.mockmacro.*
import std.sync.*

abstract class SyncExample {
    public func a(): Unit
    public func b(i: Int64): Int64
}

//
// Checks that internal unittest framework synchronization mechanisms work without additional synchronization.
//

@Test
public class SyncTest {
    let numTasks = 8
    let repeatTimes = 10

    @TestCase
    func concurrentCalls(): Unit {
        success {
            let total = Box<Int64>(0)
            let semaphore = Semaphore(numTasks)
            semaphore.acquire(amount: numTasks)
            let mocks = Array(numTasks) {
                _: Int64 =>
                let mock = mock<SyncExample>()
                @On(mock.a()).returns {
                    total.value += 1
                    ()
                }
                mock
            }

            let tasks = Array(numTasks) {
                i: Int64 =>
                let mock = mocks[i]
                spawn {
                    semaphore.acquire()
                    for (_ in 0..repeatTimes) {
                        mock.a()
                    }
                    semaphore.release()
                }
            }
            semaphore.release(amount: numTasks)
            for (task in tasks) {
                task.get()
            }

            @PowerAssert(total.value == numTasks * repeatTimes)
        }
    }

    @TestCase
    func concurrentStubbing(): Unit {
        success {
            let semaphore = Semaphore(numTasks)
            semaphore.acquire(amount: numTasks)
            let mock = mock<SyncExample>()

            let tasks = Array(numTasks) {
                i: Int64 => spawn {
                    semaphore.acquire()
                    for (j in 0..repeatTimes) {
                        let iterNum = i * repeatTimes + j
                        @On(mock.b(eq(iterNum))).returns(iterNum)
                    }
                    semaphore.release()
                }
            }
            semaphore.release(amount: numTasks)
            for (task in tasks) {
                task.get()
            }

            // check expectations in parallel to speed up mock calls
            let checkTasks = Array(numTasks) {
                i: Int64 => spawn {
                    for (j in 0..repeatTimes) {
                        let v = i * repeatTimes + j
                        @Expect(mock.b(v), v)
                    }
                }
            }

            for (task in checkTasks) {
                task.get()
            }
        }
    }

    @TestCase
    func concurrentVerification(): Unit {
        success {
            let semaphore = Semaphore(numTasks)
            semaphore.acquire(amount: numTasks)
            let mock = mock<SyncExample>()
            @On(mock.a()).returns(())
            mock.a()
            mock.a()

            let tasks = Array(numTasks) {
                _: Int64 => spawn {
                    semaphore.acquire()
                    for (_ in 0..repeatTimes) {
                        Verify.ordered(
                            @Called(mock.a()),
                            @Called(mock.a())
                        )
                    }
                    semaphore.release()
                }
            }
            semaphore.release(amount: numTasks)
            for (task in tasks) {
                task.get()
            }
        }
    }

    @TestCase
    func concurrentCapturing(): Unit {
        success {
            let total = Box<Int64>(0)
            let semaphore = Semaphore(numTasks)
            semaphore.acquire(amount: numTasks)
            let mock = mock<SyncExample>()
            let listener = ValueListener<Int64>.onEach {
                _ => total.value += 1
            }

            @On(mock.b(capture(listener))).returns(0)

            let tasks = Array(numTasks) {
                _: Int64 => spawn {
                    semaphore.acquire()
                    for (_ in 0..repeatTimes) {
                        mock.b(1)
                    }
                    semaphore.release()
                }
            }
            semaphore.release(amount: numTasks)
            for (task in tasks) {
                task.get()
            }

            @PowerAssert(total.value == numTasks * repeatTimes)
        }
    }
}
