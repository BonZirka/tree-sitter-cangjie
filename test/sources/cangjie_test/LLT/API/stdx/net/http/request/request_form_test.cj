/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1

/*
 * Test description:
 *       Test HttpRequest
 * Test API:
 *       public prop let form: Form
 */

package tests.request

import std.collection.*
import std.io.*
import stdx.net.http.*

@Test
class TestForm {
    @TestCase
    func getReqWithForm(): Unit {
        let request = HttpRequestBuilder()
            .url("http://www.example.com:8080/path?name1=value1&name1=value2&name2=value3")
            .build()
        let form = request.form
        @Assert(form.getAll("name1"), ArrayList<String>(["value1", "value2"]))
        @Assert(form.getAll("name2"), ArrayList<String>(["value3"]))
    }

    @TestCase
    func getMutilForm(): Unit {
        let request = HttpRequestBuilder()
            .url("http://www.example.com:8080/path?name1=value1&name1=value2&name2=value3")
            .build()
        let form1 = request.form
        @Assert(form1.getAll("name1"), ArrayList<String>(["value1", "value2"]))
        @Assert(form1.getAll("name2"), ArrayList<String>(["value3"]))

        let form2 = request.form
        @Assert(form2.getAll("name1"), ArrayList<String>(["value1", "value2"]))
        @Assert(form2.getAll("name2"), ArrayList<String>(["value3"]))
    }

    @TestCase
    func postReqWithFormAndFormContentType(): Unit {
        let body = BodyFrom("n1=v1&n1=v2&n2=v3".toArray())
        let request = HttpRequestBuilder()
            .method("POST")
            .url("http://www.example.com:8080/path?name1=value1&name1=value2&name2=value3")
            .header("content-type", "application/x-www-form-urlencoded")
            .body(body)
            .build()
        let form = request.form
        @Assert(form.getAll("n1"), ArrayList<String>(["v1", "v2"]))
        @Assert(form.getAll("n2"), ArrayList<String>(["v3"]))
    }

    @TestCase
    func postReqWithFormWithoutFormContentType(): Unit {
        let body = BodyFrom("n1=v1&n1=v2&n2=v3".toArray())
        let request = HttpRequestBuilder()
            .method("POST")
            .url("http://www.example.com:8080/path?name1=value1&name1=value2&name2=value3")
            .body(body)
            .build()
        let form = request.form
        @Assert(form.isEmpty(), true)
    }

    @TestCase
    func postReqWithMultiCT(): Unit {
        let body = BodyFrom("n1=v1&n1=v2&n2=v3".toArray())
        let request = HttpRequestBuilder()
            .method("POST")
            .url("http://www.example.com:8080/path?name1=value1&name1=value2&name2=value3")
            .header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
            .body(body)
            .build()
        let form = request.form
        @Assert(form.getAll("n1"), ArrayList<String>(["v1", "v2"]))
        @Assert(form.getAll("n2"), ArrayList<String>(["v3"]))
    }
}

class BodyFrom <: InputStream {
    var index = 0
    BodyFrom(let data: Array<UInt8>) {}
    public func read(arr: Array<UInt8>): Int64 {
        var readLen = arr.size
        if (data.size - index < arr.size) {
            readLen = data.size - index
        }
        data.copyTo(arr, 0, 0, readLen)
        index += readLen
        return readLen
    }
}
