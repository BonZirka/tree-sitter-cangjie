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
            filename => filename.endsWith("txt")
        }))

        spawn {
            server.serve()
        }
        sleep(Duration.second)
    }

    public func buildBodyData(fileName: String): String {
        let body = StringBuilder()
        body.appendFromUtf8(boundaryArr1)
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8("Content-Disposition: form-data; name=\"myFile\"; filename=\"${fileName}\"".toArray())
        body.appendFromUtf8(CRLF_CRLF)
        body.appendFromUtf8(
            "[{\r\n\"test\": \"this is a json file\"\r\n}, {\r\n\"test\": \"this is a json file\"\r\n}]\r\n".toArray())
        body.appendFromUtf8(CRLF)
        body.appendFromUtf8(boundaryArr2)
        body.appendFromUtf8(CRLF)
        return body.toString()
    }

    @TestCase
    func test_validator(): Unit {
        startServer()

        let req1 = HttpRequestBuilder()
            .post()
            .url("http://127.0.0.1:${server.port}/upload")
            .header("content-type", "multipart/form-data; boundary=${boundary}")
            .body(buildBodyData("upload.txt"))
            .build()
        removeIfExists("upload.txt")    
        let resp1 = client.send(req1)
        @Assert(resp1.status, 200) //success
        @Expect(exists("upload.txt"))
        removeIfExists("upload.txt")

        let req2 = HttpRequestBuilder()
            .post()
            .url("http://127.0.0.1:${server.port}/upload")
            .header("content-type", "multipart/form-data; boundary=${boundary}")
            .body(buildBodyData("upload.ttxt"))
            .build()
        removeIfExists("upload.ttxt")    
        let resp2 = client.send(req2)
        @Assert(resp2.status, 200) //success
        @Expect(exists("upload.ttxt"))
        removeIfExists("upload.ttxt")

        client.close()
        server.close()

        
    }

    
    
}
