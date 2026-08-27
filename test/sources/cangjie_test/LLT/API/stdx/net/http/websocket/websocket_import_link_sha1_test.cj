/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -Woff unused %stdx-package -L $CANGJIE_STDX_PATH -lstdx.unittest.data -lstdx.unittest -lstdx.net.http -lstdx.net.tls.common -lstdx.logger -lstdx.log -lstdx.encoding.url -lstdx.encoding.json.stream -lstdx.crypto.common -lstdx.encoding.base64 --import-path $CANGJIE_STDX_PATH %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *      Verify importing stdx.net.http does not fail to link because of missing DYN_SHA1.
 * Test API:
 *      import stdx.net.http.*
 */
package tests.websocket

import stdx.net.http.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
class TestWebSocketImportLinkSha1 {
    @TestCase
    func webSocketImportLinkSha1(): Unit {
        println("websocket_import_link_sha1_test_ok")
    }
}

/* SCAN-IN
websocket_import_link_sha1_test_ok
 */
