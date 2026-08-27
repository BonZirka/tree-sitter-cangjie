/*
  * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
  * This source file is part of the Cangjie project, licensed under Apache-2.0
  * with Runtime Library Exception.
  * 
  * See https://cangjie-lang.cn/pages/LICENSE for license information.
  */
 
// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: scan An exception has occurred:JsonException
// ASSERT: scan Failed in JsonException
// ASSERT: scan Caused by: CryptoException
// ASSERT: scan Caused by: UrlSyntaxException: UrlSyntaxException!

import stdx.encoding.json.*
import stdx.crypto.x509.*
import stdx.compress.zlib.*
import stdx.encoding.url.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
class TestCauseby {
    public func test_exception_01(){
        try {
           test_exception_02()
        } catch(e: Exception) {
            let exception = JsonException("Failed in JsonException")
            exception.causedBy = e
            exception.printStackTrace()
            throw exception
        }
    }

    public func test_exception_02(){
        try {
           test_exception_03()
        } catch(e: Exception) {
            e.printStackTrace()
            throw CryptoException(e)
        }
    }

    public func test_exception_03(){
        test_exception_04()
    }

    public func test_exception_04(){
        throw UrlSyntaxException("UrlSyntaxException!")  
    }

    @TestCase
    public func test_01(): Unit {
        test_exception_01()
    } 
  
}

class JsonException <: Exception {
    public init() {
      super()
    }
    public init(message: String) {
      super(message)
    }
    protected override func getClassName(): String {
        return "JsonException"
    }
}

class CryptoException <: Exception {
    public init() {
      super()
    }
    public init(message: String) {
      super(message)
    }
    public init(causedBy: Exception) {
      super(causedBy)
    }
    protected override func getClassName(): String {
        return "CryptoException"
    }
} 

   