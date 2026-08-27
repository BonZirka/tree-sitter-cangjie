/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *       Test CookieJar#getCookies
 * Test API:
 *       public func getCookies(url: URL, cookies: ArrayList<Cookie>): Unit
 */

package tests.cookie

import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

@Test
class TestCookieJarGetCookies2 {
    @TestCase
    func cookieJarGetCookies2(): Unit {
        let requestUrl = URL.parse("https://foo.example.com/hello/a/b/c/d")
        let httpRequest = HttpRequestBuilder().url(requestUrl).method("GET").version(HTTP1_1).build()
        let httpResponseBuilder = HttpResponseBuilder().request(httpRequest)
        httpResponseBuilder.header("Set-Cookie", "1P_JAR=1; path=/; domain=; ")
        httpResponseBuilder.header("Set-Cookie", "2P_JAR=2; path=; domain=com; ")
        httpResponseBuilder.header("Set-Cookie", "3P_JAR=3; path=/hello/a/; domain=foo.example.com; ")
        let cookie1 = Cookie("4P_JAR", "4", domain: "foo.example.com", path: "/hello/a/b")
        let cookie2 = Cookie("3P_JAR", "5", domain: "foo.example.com", path: "/hello/a/")
        let cookie3 = Cookie("6P_JAR", "6", domain: "baz.example.com")
        let cookie4 = Cookie("7P_JAR", "7", path: "/hello/a/b/c")
        httpResponseBuilder.header("Set-Cookie", cookie1.toSetCookieString())
        httpResponseBuilder.header("Set-Cookie", cookie2.toSetCookieString())
        httpResponseBuilder.header("Set-Cookie", cookie3.toSetCookieString())
        httpResponseBuilder.header("Set-Cookie", cookie4.toSetCookieString())
        httpResponseBuilder.header("Set-Cookie", "8P_JAR=8; path=/hello/a/b/c; domain=example.com; Secure")
        httpResponseBuilder.header("Set-Cookie", "9P_JAR=9; path=/hello/a/b/c/d; domain=example.com;")
        httpResponseBuilder.header("Set-Cookie", "10P_JAR=10; path=/hello/a/b/c/d/e; domain=example.com;")

        let cookieJar = CookieJar.createDefaultCookieJar(ArrayList<String>(["com"]), true)

        let resultCookies = CookieJar.parseSetCookieHeader(httpResponseBuilder.build())

        cookieJar.storeCookies(requestUrl, resultCookies)
        let cookiesFromJar = cookieJar.getCookies(URL.parse("http://baz.foo.example.com/hello/a/b/c/d"))
        println(CookieJar.toCookieString(cookiesFromJar))
        let cookiesFromJar2 = cookieJar.getCookies(URL.parse("http://foo.example.com/hello/a/b/c/d/e"))
        println(CookieJar.toCookieString(cookiesFromJar2))
        println("ok")
    }
}

/* SCAN-IN
9P_JAR=9; 4P_JAR=4; 3P_JAR=5
10P_JAR=10; 9P_JAR=9; 7P_JAR=7; 4P_JAR=4; 3P_JAR=5; 1P_JAR=1
ok
 */
