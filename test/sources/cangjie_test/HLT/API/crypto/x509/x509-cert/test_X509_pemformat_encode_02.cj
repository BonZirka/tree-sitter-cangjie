/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ../data
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl -o %output %f %cmp_utest_opt
// (not Windows and not OHOS)RUN-EXEC: %run_stdx %output %run_utest_opt %run_args
// (Windows and OHOS)RUN-EXEC: dos2unix "./data/root_ecdsa.cer" && dos2unix "./data/end_ecdsa.cer" && dos2unix "./data/root_rsa_simple.cer" && dos2unix "./data/end_rsa_simple.cer" && %run %run_opt %output %run_utest_opt %run_args
import std.fs.*
import stdx.crypto.x509.*

var sum = 0
@When[os != "Windows"]
let pemData = String.fromUtf8(File.readFrom("./data/root_ecdsa.cer"))
@When[os != "Windows"]
let pemData_1 = String.fromUtf8(File.readFrom("./data/end_ecdsa.cer"))
@When[os != "Windows"]
let pemData_2 = String.fromUtf8(File.readFrom("./data/root_rsa_simple.cer"))
@When[os != "Windows"]
let pemData_3 = String.fromUtf8(File.readFrom("./data/end_rsa_simple.cer"))
@When[os == "Windows"]
let pemData = String.fromUtf8(File.readFrom("./data/root_ecdsa_win.cer"))
@When[os == "Windows"]
let pemData_1 = String.fromUtf8(File.readFrom("./data/end_ecdsa_win.cer"))
@When[os == "Windows"]
let pemData_2 = String.fromUtf8(File.readFrom("./data/root_rsa_simple_win.cer"))
@When[os == "Windows"]
let pemData_3 = String.fromUtf8(File.readFrom("./data/end_rsa_simple_win.cer"))

@Test
class Test_X509_pemformat_encode_02 {
    public override func beforeEach(): Unit {
        sum = 0
    }

    @TestCase
    func test_correct_ecdsa_cert_encode_01(): Unit {
        let pemx509 = X509Certificate.decodeFromPem(pemData)
        let pemx509_1 = pemx509[0].encodeToPem()
        @Expect(pemx509_1.toString(),"PEM CERTIFICATE (571 bytes)")
        @Expect(pemx509_1.encode(), pemData)
    }

    @TestCase
    func test_correct_ecdsa_cert_encode_02(): Unit {
        let pemx509 = X509Certificate.decodeFromPem(pemData_1)
        let pemx509_1 = pemx509[0].encodeToPem()
        @Expect(pemx509_1.toString(),"PEM CERTIFICATE (517 bytes)")
        @Expect(pemx509_1.encode(), pemData_1)
    }

    @TestCase
    func test_correct_rsa_cert_encode_03(): Unit {
        let pemx509 = X509Certificate.decodeFromPem(pemData_2)
        let pemx509_1 = pemx509[0].encodeToPem()
        @Expect(pemx509_1.toString(),"PEM CERTIFICATE (1596 bytes)")
        @Expect(pemx509_1.encode(), pemData_2)
    }

    @TestCase
    func test_correct_rsa_cert_encode_04(): Unit {
        let pemx509 = X509Certificate.decodeFromPem(pemData_3)
        let pemx509_1 = pemx509[0].encodeToPem()
        @Expect(pemx509_1.toString(),"PEM CERTIFICATE (1496 bytes)")
        @Expect(pemx509_1.encode(), pemData_3)
    }
}
