/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt 

@Test
class ThreadStateTest {
    private func isRunningOrReadyOrPending(state: ThreadState): Bool {
        match (state) {
            case Running => true
            case Ready => true
            case Pending => true
            case _ => false
        }
    }

    private func isTerminated(state: ThreadState): Bool {
        match (state) {
            case Terminated => true
            case _ => false
        }
    }

    private func isReadyOrTerminated(state: ThreadState): Bool {
        match (state) {
            case Ready => true
            case Terminated => true
            case _ => false
        }
    }

    @TestCase
    func testThreadStateBasic(): Unit {
        let future = spawn {
            sleep(Duration.millisecond * 100)
        }
        let thread = future.thread
        
        let state = thread.state
        @Expect(isRunningOrReadyOrPending(state), true)
        
        future.get()
        
        let finalState = thread.state
        @Expect(isTerminated(finalState), true)
    }

    @TestCase
    func testMainThreadState(): Unit {
        let state = Thread.currentThread.state
        @Expect(isRunningOrReadyOrPending(state), true)
    }

    @TestCase
    func testConcurrentStateAccess(): Unit {
        let future = spawn {
            sleep(Duration.millisecond * 200)
        }
        let thread = future.thread
        
        let accessCount = 10
        let threads = Array<Future<Unit>>(accessCount, { _ => spawn { return } })
        
        for (i in 0..accessCount) {
            threads[i] = spawn {
                let _ = thread.state
                return
            }
        }
        
        for (i in 0..accessCount) {
            threads[i].get()
        }
        
        future.get()
        @Expect(isTerminated(thread.state), true)
    }

    @TestCase
    func testStateAfterTermination(): Unit {
        let future = spawn {
            return
        }
        let thread = future.thread
        
        future.get()
        
        let state1 = thread.state
        let state2 = thread.state
        let state3 = thread.state
        
        @Expect(isTerminated(state1), true)
        @Expect(isTerminated(state2), true)
        @Expect(isTerminated(state3), true)
    }

    @TestCase
    func testUnstartedThreadState(): Unit {
        let future = spawn {
            sleep(Duration.millisecond * 500)
        }
        let thread = future.thread
        
        let state = thread.state
        @Expect(isRunningOrReadyOrPending(state) || isTerminated(state), true)
        
        future.get()
    }
}
