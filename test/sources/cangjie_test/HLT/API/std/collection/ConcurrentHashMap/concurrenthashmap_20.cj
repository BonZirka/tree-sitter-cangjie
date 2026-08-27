/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt -o %output %f %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.collection.concurrent.*
import std.collection.*
import std.sync.*

var cmap = Option<ConcurrentHashMap<Int64, Int64>>.None
const N: Int64 = 100

@Test
class Test_concurrenthashmap_20 {
    @TestCase
    func test_01(): Unit {
        let arr = Array<(Int64, String)>()
        let cmap = ConcurrentHashMap<Int64, String>(arr)
        for (i in 0..N) {
            cmap.put(i, "i + 1")
        }
        let res = Array<String>(N, repeat: "0")
        let resArr = Array<String>(N, {i => "i + 1"})
        for ((k, v) in cmap) {
            res[k] = v
        }
        @Expect(res, resArr)
        @Expect(res.size, resArr.size)
        @Expect(cmap.size, N)
        @Expect(cmap.isEmpty(), false)
    }

    @TestCase
    func test_02(): Unit {
        let arr = Array<(String, String)>()
        let cmap = ConcurrentHashMap<String, String>(arr)

        let s = "helloword"
        let a = ArrayList<String>()
        for (i in 0..N) {
            a.add(s + "${i}")
        }

        let jobs = Array<Future<Unit>>(N, repeat: unsafe { zeroValue<Future<Unit>>() })
        for (t in 0..10) {
            jobs[t] = spawn {
                for (i in t..N : 10) {
                    cmap.put(a[i], a[(i + 1) % N])
                }
            }
        }

        for (t in 0..10) {
            jobs[t].get()
        }

        for (i in 0..N) {
            @Expect(cmap.get(a[i]).getOrThrow(), a[(i + 1)  % N])
        }
    }

    @TestCase
    func test_03(): Unit {
        let arr = Array<(Float64, String)>()
        let cmap = ConcurrentHashMap<Float64, String>(arr)

        let s = "Helloworld"
        let a = ArrayList<String>()
        for (i in 0..N) {
            a.add(s + "${i}")
        }

        var f: Float64 = 2.3754
        let b = ArrayList<Float64>()
        for (i in 0..N) {
            f += 1.89643
            b.add(f)
        }

        let jobs = Array<Future<Unit>>(N, repeat: unsafe { zeroValue<Future<Unit>>() })
        for (t in 0..10) {
            jobs[t] = spawn {
                for (i in t..N : 10) {
                    cmap.put(b[i], a[i])
                }
            }
        }
        for (t in 0..10) {
            jobs[t].get()
        }

        for (i in 0..N) {
            @Expect(cmap.get(b[i]).getOrThrow(), a[i])
        }
    }

    @TestCase
    func test_04(): Unit {
        let arr = Array<(Int64, String)>()
        let cmap = ConcurrentHashMap<Int64, String>(arr)
        for (i in 0..N) {
            cmap.putIfAbsent(i, "i + 1")
        }
        for (i in 0..2 * N) {
            cmap.putIfAbsent(i, "i + 5")
        }
        let res = Array<String>(N, repeat: "0")
        let res1 = Array<String>(N, repeat: "-1")
        let resArr = Array<String>(N, {i => "i + 1"})
        let resArr1 = Array<String>(N, {i => "i + 5"})

        for ((k, v) in cmap) {
            if (k <= N - 1) {
                res[k] = v
            } else {
                res1[k - N] = v
            }
        }
        @Expect(res, resArr)
        @Expect(res1, resArr1)
        @Expect(res1.size, resArr1.size)
        @Expect(res.size, resArr.size)
    }
    @TestCase
    func test_05(): Unit {
        let arr = Array<(String, String)>()
        let cmap = ConcurrentHashMap<String, String>(arr)

        let s = "helloword"
        let a = ArrayList<String>()
        for (i in 0..N) {
            a.add(s + "${i}")
        }

        let jobs = Array<Future<Unit>>(N, repeat: unsafe { zeroValue<Future<Unit>>() })
        for (t in 0..10) {
            jobs[t] = spawn {
                for (i in t..N : 10) {
                    cmap.putIfAbsent(a[i], a[(i + 1) % N])
                }
            }
        }

        for (t in 0..10) {
            jobs[t].get()
        }

        for (i in 0..N) {
            @Expect(cmap.get(a[i]).getOrThrow(), a[(i + 1)  % N])
        }
    }

    @TestCase
    func test_06(): Unit {
        let arr = Array<(Float64, String)>()
        let cmap = ConcurrentHashMap<Float64, String>(arr)

        let s = "Helloworld"
        let a = ArrayList<String>()
        for (i in 0..N) {
            a.add(s + "${i}")
        }

        var f: Float64 = 2.3754
        let b = ArrayList<Float64>()
        for (i in 0..N) {
            f += 1.89643
            b.add(f)
        }

        let jobs = Array<Future<Unit>>(N, repeat: unsafe { zeroValue<Future<Unit>>() })
        for (t in 0..10) {
            jobs[t] = spawn {
                for (i in t..N : 10) {
                    cmap.putIfAbsent(b[i], a[i])
                }
            }
        }
        for (t in 0..10) {
            jobs[t].get()
        }

        for (i in 0..N) {
            @Expect(cmap.get(b[i]).getOrThrow(), a[i])
        }
    }
}
