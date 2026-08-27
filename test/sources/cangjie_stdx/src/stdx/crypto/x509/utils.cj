/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509



import std.core.StringBuilder
import std.time.DateTime
import std.collection.*
import stdx.encoding.hex.toHexString
import stdx.crypto.common.*

const NULL_BYTE = "\0"

extend<T> CPointer<T> {
    func ifNotNull<R>(block: (CPointer<T>) -> R): ?R {
        if (isNull()) {
            None
        } else {
            block(this)
        }
    }
}

extend<T> Option<T> {
    func exists() {
        match (this) {
            case Some(_) => true
            case None => false
        }
    }

    func missing() {
        !exists()
    }
}

public class X509Exception <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "X509Exception"
    }
}

func runOnRawPtr<T, R>(data: Array<T>, action: (CPointer<T>, UIntNative) -> R): R where T <: CType {
    unsafe {
        let handle = acquireArrayRawData(data)
        try {
            return action(handle.pointer, UIntNative(data.size))
        } finally {
            releaseArrayRawData(handle)
        }
    }
}

func getRawPubKey(key: PublicKey): CPointer<Unit> {
    var data = key.encodeToDer().body
    unsafe {
        var keyPtr = CPointer<Unit>()
        let dataHandle: CPointerHandle<Byte> = acquireArrayRawData(data)
        try (pubPtr = malloc<CPointer<Byte>>()) {
            pubPtr.pointer.write(dataHandle.pointer)
            keyPtr = getPubKeyPtr(pubPtr.pointer, data.size)
            if (keyPtr.isNull()) {
                throw X509Exception("Fail to load public key.")
            }
        } finally {
            releaseArrayRawData(dataHandle)
        }
        keyPtr
    }
}

func getRawPriKey(key: PrivateKey): CPointer<Unit> {
    var data = key.encodeToDer().body
    unsafe {
        var keyPtr = CPointer<Unit>()
        let dataHandle: CPointerHandle<Byte> = acquireArrayRawData(data)
        try (priPtr = malloc<CPointer<Byte>>()) {
            priPtr.pointer.write(dataHandle.pointer)
            keyPtr = getPriKeyPtr(priPtr.pointer, data.size)
            if (keyPtr.isNull()) {
                throw X509Exception("Fail to load private key.")
            }
        } finally {
            releaseArrayRawData(dataHandle)
        }
        keyPtr
    }
}

func getRawName(name: X509Name): CPointer<Unit> {
    var data = name.blob.blob.body
    unsafe {
        var namePtr = CPointer<Unit>()
        let dataHandle: CPointerHandle<Byte> = acquireArrayRawData(data)
        try (priPtr = malloc<CPointer<Byte>>()) {
            priPtr.pointer.write(dataHandle.pointer)
            namePtr = getNamePtr(priPtr.pointer, data.size)
            if (namePtr.isNull()) {
                throw X509Exception("Fail to load X509Name.")
            }
        } finally {
            releaseArrayRawData(dataHandle)
        }
        namePtr
    }
}

func getCertBody(cert: CPointer<Unit>): Array<Byte> {
    unsafe {
        var certlen = getCertLen(cert, CPointer<CPointer<Byte>>())
        if (certlen < 0) {
            throw X509Exception("Fail to init X509.")
        }
        var certBody = Array<Byte>(certlen, repeat: 0)
        let data: CPointerHandle<Byte> = acquireArrayRawData(certBody)
        try (certPtr = malloc<CPointer<Byte>>()) {
            certPtr.pointer.write(data.pointer)
            certlen = getCertLen(cert, certPtr.pointer)
            if (certlen < 0) {
                throw X509Exception("Fail to init X509.")
            }
        } finally {
            releaseArrayRawData(data)
        }
        certBody
    }
}

let KEY_USAGE_STRINGS: Array<(String, String)> = [
    ("EncipherOnly", "Encipher Only"),
    ("CRLSign", "CRL Sign"),
    ("CertSign", "Certificate Sign"),
    ("KeyAgreement", "Key Agreement"),
    ("DataEncipherment", "Data Encipherment"),
    ("KeyEncipherment", "Key Encipherment"),
    ("NonRepudiation", "Non Repudiation"),
    ("DigitalSignature", "Digital Signature"),
    ("DecipherOnly", "Decipher Only")
]
let EXT_KEY_USAGE_STRINGS: Array<(String, String)> = [
    ("ServerAuth", "TLS Web Server Authentication"),
    ("ClientAuth", "TLS Web Client Authentication"),
    ("EmailProtection", "E-mail Protection"),
    ("CodeSigning", "Code Signing"),
    ("OCSPSigning", "OCSP Signing"),
    ("TimeStamping", "Time Stamping")
]

func setTimeString(strBuilder: StringBuilder, timeString: String) {
    if (timeString.size == 1) {
        strBuilder.append("0")
    }
    strBuilder.append(timeString)
}

func getTimeString(data: DateTime): String {
    let zData = data.inUTC()
    let strBuilder = StringBuilder()
    strBuilder.append(zData.year.toString())
    setTimeString(strBuilder, zData.month.toInteger().toString())
    setTimeString(strBuilder, zData.dayOfMonth.toString())
    setTimeString(strBuilder, zData.hour.toString())
    setTimeString(strBuilder, zData.minute.toString())
    setTimeString(strBuilder, zData.second.toString())
    strBuilder.append("Z")
    strBuilder.toString()
}

func formIpv6(ipAddress: IP) {
    const IPV6_STR_LEN = 8
    var arr = Array<String>(IPV6_STR_LEN, repeat: "")
    const UNIT_SIZE = 2
    for (i in 0..arr.size) {
        arr[i] = toHexString(ipAddress[UNIT_SIZE * i]) + toHexString(ipAddress[UNIT_SIZE * i + 1])
    }
    return arr |> collectString<String>(delimiter: ":")
}

func ipAddressToString(ipAddress: IP): String {
    match (ipAddress.size) {
        // IPv4
        case 4 => return ipAddress |> collectString<Byte>(delimiter: ".")
        // IPv6
        case 16 => return formIpv6(ipAddress)
        case _ => throw X509Exception("Illegal IP address.")
    }
}

func getAltNameString(dnsNames: Array<String>, emails: Array<String>, ips: Array<IP>) {
    var strBuilder = StringBuilder()
    let dnsName = "DNS:"
    let emailName = "email:"
    let ipName = "IP:"
    addString(strBuilder, dnsNames, dnsName)
    addString(strBuilder, emails, emailName)
    addString(strBuilder, Array(ips.size, {i => ipAddressToString(ips[i])}), ipName)
    strBuilder.toString()
}

func addString(strBuilder: StringBuilder, extensions: Array<String>, name: String) {
    for (i in 0..extensions.size) {
        if (i == 0 && strBuilder.size != 0) {
            strBuilder.append(", ")
        }
        strBuilder.append(name)
        strBuilder.append(extensions[i])
        if (i != extensions.size - 1) {
            strBuilder.append(", ")
        }
    }
}

func getKeyUsageString(usages: ?KeyUsage) {
    var res: String
    match (usages) {
        case None => res = ""
        case Some(usage) => res = usage.toString()
    }
    for (stringTuple in KEY_USAGE_STRINGS) {
        res = res.replace(stringTuple[0], stringTuple[1])
    }
    res
}

func getExtKeyUsageString(usages: ?ExtKeyUsage) {
    var res: String
    match (usages) {
        case None => res = ""
        case Some(usage) => res = usage.toString()
    }
    for (stringTuple in EXT_KEY_USAGE_STRINGS) {
        res = res.replace(stringTuple[0], stringTuple[1])
    }
    res
}

func getDigest(signatureAlgorithm: ?SignatureAlgorithm) {
    match (signatureAlgorithm) {
        case None => unsafe { sha256() }
        case Some(signatureAlgorithm) => signatureAlgorithm.getDigest()
    }
}

func getKeyType(signatureAlgorithm: ?SignatureAlgorithm) {
    match (signatureAlgorithm) {
        case None => 0
        case Some(signatureAlgorithm) => signatureAlgorithm.getKeyType()
    }
}

func x509MallocOrThrow<T>(count!: Int64 = 1): CPointer<T> where T <: CType {
    let result: CPointer<T> = LibC.malloc<T>(count: count)
    if (result.isNull()) {
        throw X509Exception("Failed to allocate memory.")
    }
    result
}

@When[os == "Windows"]
foreign func DYN_CJ_SystemRootCerts(msg: CPointer<DynMsg>): CString

@When[os == "Windows"]
func CJ_SystemRootCerts(): CString {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJ_SystemRootCerts(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

foreign {
    func DYN_EVP_md5(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_EVP_sha1(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_EVP_sha256(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_EVP_sha384(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_EVP_sha512(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_i2d_X509(name: CPointer<Byte>, c: CPointer<CPointer<Byte>>, msg: CPointer<DynMsg>): Int32

    func DYN_CJCreateCert(
        pubKey: CPointer<Unit>,
        priKey: CPointer<Unit>,
        issuer: CPointer<Unit>,
        subject: CPointer<Unit>,
        digest: CPointer<Unit>,
        certInfo: CPointer<X509CertInfo>,
        msg: CPointer<DynMsg>
    ): CPointer<Unit>

    func DYN_CJGetCertLen(cert: CPointer<Unit>, out: CPointer<CPointer<Byte>>, msg: CPointer<DynMsg>): Int64

    func DYN_CJCertFree(cert: CPointer<Unit>, msg: CPointer<DynMsg>): Unit

    func DYN_CJKeyFree(key: CPointer<Unit>, msg: CPointer<DynMsg>): Unit

    func DYN_CJGetPubKeyPtr(pubKey: CPointer<CPointer<Byte>>, length: Int64, msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJGetPriKeyPtr(priKey: CPointer<CPointer<Byte>>, length: Int64, msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJGetNamePtr(nameKey: CPointer<CPointer<Byte>>, lenght: Int64, msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJCheckKeyType(key: CPointer<Unit>, keyType: Int64, msg: CPointer<DynMsg>): Bool

    func DYN_CJGetX509DnsNames(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJGetX509EmailAddresses(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJGetX509IpAddresses(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJGetX509KeyUsage(derBlob: CPointer<Byte>, length: UIntNative, msg: CPointer<DynMsg>): UInt16

    func DYN_CJGetX509ExtKeyUsage(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<UInt16Result>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJX509ReqNew(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJX509ReqFree(req: CPointer<Unit>, msg: CPointer<DynMsg>): Unit

    func DYN_CJGetX509ReqDer(req: CPointer<Unit>, c: CPointer<CPointer<Byte>>, msg: CPointer<DynMsg>): Int64

    func DYN_OPENSSL_sk_num(nameStack: CPointer<Unit>, msg: CPointer<DynMsg>): Int64

    func DYN_CJLoadPrivateKey(c: CPointer<CPointer<Byte>>, length: Int64, msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJX509ReqSetSubject(req: CPointer<Unit>, name: CPointer<Unit>, msg: CPointer<DynMsg>): Int64

    func DYN_CJX509ReqSetPubkey(req: CPointer<Unit>, pkey: CPointer<Unit>, msg: CPointer<DynMsg>): Int64

    func DYN_CJX509ReqSign(req: CPointer<Unit>, pkey: CPointer<Unit>, md: CPointer<Unit>, msg: CPointer<DynMsg>): Int64

    func DYN_CJNameStackNew(msg: CPointer<DynMsg>): CPointer<Unit>

    func DYN_CJNameStackFree(nameStack: CPointer<Unit>, msg: CPointer<DynMsg>): Unit

    func DYN_CJAddName(nameStack: CPointer<Unit>, nid: Int64, value: CString, msg: CPointer<DynMsg>): Int64

    func DYN_CJReqAddExtension(req: CPointer<Unit>, nameStack: CPointer<Unit>, msg: CPointer<DynMsg>): Int64

    func DYN_CJVerifyX509Cert(
        cert: CPointer<RawX509Cert>,
        roots: CPointer<RawX509CertArray>,
        intermediates: CPointer<RawX509CertArray>,
        msg: CPointer<DynMsg>
    ): Int32

    func DYN_CJGetX509CsrDnsNames(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJGetX509CsrEmailAddresses(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    func DYN_CJGetX509CsrIpAddresses(
        derBlob: CPointer<Byte>,
        length: UIntNative,
        result: CPointer<ByteArrayResult>,
        msg: CPointer<DynMsg>
    ): Unit

    // return type CPointer<Unit> map to C type (X509_NAME *)
    func DYN_CJNameNew(msg: CPointer<DynMsg>): CPointer<Unit>

    // name type CPointer<Unit> map to C type (X509_NAME *)
    func DYN_CJNameFree(name: CPointer<Unit>, msg: CPointer<DynMsg>): Unit

    // name type CPointer<Unit> map to C type (X509_NAME *)
    func DYN_CJX509NameAddEntry(
        name: CPointer<Unit>,
        field: CString,
        nameType: Int32,
        bytes: CString,
        msg: CPointer<DynMsg>
    ): Int32

    // name type CPointer<Unit> map to C type (X509_NAME *)
    func DYN_CJGetNameDer(name: CPointer<Unit>, c: CPointer<CPointer<Byte>>, msg: CPointer<DynMsg>): Int32

    func MallocDynMsg(): CPointer<DynMsg>

    func FreeDynMsg(dynMsgPtr: CPointer<DynMsg>): Unit
}

func md5(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_EVP_md5(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func sha1(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_EVP_sha1(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func sha256(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_EVP_sha256(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func sha384(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_EVP_sha384(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func sha512(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_EVP_sha512(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func checkKeyType(key: CPointer<Unit>, keyType: Int64): Bool {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJCheckKeyType(key, keyType, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getNameDer(name: CPointer<Unit>, c: CPointer<CPointer<Byte>>): Int32 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetNameDer(name, c, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getNamePtr(nameKey: CPointer<CPointer<Byte>>, lenght: Int64): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetNamePtr(nameKey, lenght, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509ReqSign(req: CPointer<Unit>, pkey: CPointer<Unit>, md: CPointer<Unit>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509ReqSign(req, pkey, md, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509ReqSetPubkey(req: CPointer<Unit>, pkey: CPointer<Unit>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509ReqSetPubkey(req, pkey, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509ReqSetSubject(req: CPointer<Unit>, name: CPointer<Unit>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509ReqSetSubject(req, name, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getX509ReqDer(req: CPointer<Unit>, c: CPointer<CPointer<Byte>>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetX509ReqDer(req, c, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509ReqFree(req: CPointer<Unit>): Unit {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509ReqFree(req, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509ReqNew(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509ReqNew(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func x509NameAddEntry(
    name: CPointer<Unit>,
    field: CString,
    nameType: Int32,
    bytes: CString
): Int32 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJX509NameAddEntry(name, field, nameType, bytes, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func nameFree(name: CPointer<Unit>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJNameFree(name, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func nameNew(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJNameNew(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func reqAddExtension(req: CPointer<Unit>, nameStack: CPointer<Unit>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJReqAddExtension(req, nameStack, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func addName(nameStack: CPointer<Unit>, nid: Int64, value: CString): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJAddName(nameStack, nid, value, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func nameStackNew(): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJNameStackNew(dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func nameStackFree(nameStack: CPointer<Unit>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJNameStackFree(nameStack, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getX509CsrDnsNames(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509CsrDnsNames(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getX509CsrEmailAddresses(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509CsrEmailAddresses(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getX509CsrIpAddresses(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509CsrIpAddresses(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func verifyX509Cert(
    cert: CPointer<RawX509Cert>,
    roots: CPointer<RawX509CertArray>,
    intermediates: CPointer<RawX509CertArray>
): Int32 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJVerifyX509Cert(cert, roots, intermediates, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getX509ExtKeyUsage(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<UInt16Result>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509ExtKeyUsage(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func stackNameNum(nameStack: CPointer<Unit>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_OPENSSL_sk_num(nameStack, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getX509KeyUsage(derBlob: CPointer<Byte>, length: UIntNative): UInt16 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetX509KeyUsage(derBlob, length, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func createCert(
    pubKey: CPointer<Unit>,
    priKey: CPointer<Unit>,
    issuer: CPointer<Unit>,
    subject: CPointer<Unit>,
    digest: CPointer<Unit>,
    certInfo: CPointer<X509CertInfo>
): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJCreateCert(pubKey, priKey, issuer, subject, digest, certInfo, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getX509IpAddresses(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509IpAddresses(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getX509EmailAddresses(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509EmailAddresses(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getX509DnsNames(derBlob: CPointer<Byte>, length: UIntNative, result: CPointer<ByteArrayResult>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJGetX509DnsNames(derBlob, length, result, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getPriKeyPtr(priKey: CPointer<CPointer<Byte>>, length: Int64) {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetPriKeyPtr(priKey, length, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func getCertLen(cert: CPointer<Unit>, out: CPointer<CPointer<Byte>>): Int64 {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetCertLen(cert, out, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func certFree(cert: CPointer<Unit>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJCertFree(cert, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func keyFree(cert: CPointer<Unit>): Unit {
    let dynMsgPtr = generateDynMsg()
    unsafe { DYN_CJKeyFree(cert, dynMsgPtr) }
    checkError(dynMsgPtr)
}

func getPubKeyPtr(pubKey: CPointer<CPointer<Byte>>, length: Int64): CPointer<Unit> {
    let dynMsgPtr = generateDynMsg()
    let res = unsafe { DYN_CJGetPubKeyPtr(pubKey, length, dynMsgPtr) }
    checkError(dynMsgPtr)
    return res
}

func generateDynMsg(): CPointer<DynMsg> {
    unsafe {
        let dynMsgPtr = MallocDynMsg()
        if (dynMsgPtr.isNull()) {
            throw X509Exception("malloc failed")
        }
        return dynMsgPtr
    }
}

func checkError(dynMsgPtr: CPointer<DynMsg>): Unit {
    unsafe {
        if (dynMsgPtr.isNull()) {
            throw X509Exception("Null pointer check failed.")
        }
        try {
            if (!dynMsgPtr.read().found) {
                let funcName = CString(dynMsgPtr.read().funcName).toString()
                throw X509Exception("Can not load openssl library or function ${funcName}.")
            }
        } finally {
            FreeDynMsg(dynMsgPtr)
        }
    }
}

@C
struct DynMsg {
    var found = true
    var funcName = CPointer<UInt8>()
}
