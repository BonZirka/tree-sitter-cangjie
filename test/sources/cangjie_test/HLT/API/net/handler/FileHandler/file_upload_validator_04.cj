/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import stdx.net.http.*
import std.fs.*
import std.unittest.*
import std.unittest.testmacro.*


@Test
class TestFileHandler {
    let boundary = "----WebKitFormBoundary7B8HS8VxGf4OHfS7"
    let boundaryArr1 = "------WebKitFormBoundary7B8HS8VxGf4OHfS7".toArray()
    let boundaryArr2 = "------WebKitFormBoundary7B8HS8VxGf4OHfS7--".toArray()
    let CRLF = "\r\n".toArray()
    let CRLF_CRLF = "\r\n\r\n".toArray()
    let server = ServerBuilder().addr("127.0.0.1").port(0).build()
    let client = ClientBuilder().build()

    public func startServer(): Unit {
        server.distributor.register("/upload", FileHandler("./", handlerType: UpLoad, validator: {
            filename => filename.endsWith(".CC")
        }))

        spawn {
            server.serve()
        }
        sleep(Duration.second)
    }

    func buildMultipleFileBodyData(fileName1: String, fileName2: String): String {
        let body = StringBuilder()
        body.appendFromUtf8(boundaryArr1)
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8("Content-Disposition: form-data; name=\"file1\"; filename=\"${fileName1}\"".toArray())
        body.appendFromUtf8(CRLF_CRLF)
        body.appendFromUtf8(
            "[{\r\n\"test\": \"this is a json file\"\r\n}, {\r\n\"test\": \"this is a json file\"\r\n}]\r\n".toArray())
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8(boundaryArr1)
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8("Content-Disposition: form-data; name=\"file2\"; filename=\"${fileName2}\"".toArray())
        body.appendFromUtf8(CRLF_CRLF)
        body.appendFromUtf8(
            "[{\r\n\"test\": \"this is another json file\"\r\n}, {\r\n\"test\": \"this is another json file\"\r\n}]\r\n".toArray())
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8(boundaryArr2)
        body.appendFromUtf8(CRLF)
        return body.toString()
    }

    @TestCase
    func test_validator(): Unit {
        startServer()

        let req = HttpRequestBuilder()
            .post()
            .url("http://127.0.0.1:${server.port}/upload")
            .header("content-type", "multipart/form-data; boundary=${boundary}")
            .body(buildMultipleFileBodyData("upload1.CC", "upload2.CC"))
            .build()
        removeIfExists("upload1.CC") 
        removeIfExists("upload2.CC")    
        let resp = client.send(req)
        @Assert(resp.status, 200) //SUCCESS
        @Expect(exists("upload1.CC"))
        @Expect(exists("upload2.CC"))  

        let req2 = HttpRequestBuilder()
            .post()
            .url("http://127.0.0.1:${server.port}/upload")
            .header("content-type", "multipart/form-data; boundary=${boundary}")
            .body(buildMultipleFileBodyData("upload3.CC", "upload2.txt"))
            .build()
        let resp2 = client.send(req2)
        @Assert(resp2.status, 400) 
        @Expect(!exists("upload3.CC"))
        @Expect(!exists("upload2.txt"))   

        removeIfExists("upload1.CC") 
        removeIfExists("upload2.CC")

        client.close()
        server.close()
    }

    
    
}
