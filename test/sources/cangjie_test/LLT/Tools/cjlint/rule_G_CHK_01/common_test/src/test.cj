// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import std.regex.*
internal import std.core.*
internal import std.process.*
internal import std.console.*
internal import stdx.net.http.*
internal import stdx.encoding.url.*
internal import std.net.*

func outputString(param: String) {}
func outputUInt8(param1: UInt8, param2: UInt8, param3: UInt8) {}

class c1 {
    var c1m1: String = "";
    var c1m2: String = "";
    func c1f1(p1: String, p2: String) {}
}

struct s1 {
    var s1m1: String = ""
    var s1m2: String = ""
}
var cond = true
func classAndStructTest() : String {
    var v0 = Console.stdIn.readln().getOrThrow()
    var ic1 = c1()
    var is1 = s1()
    ic1.c1m1 = v0
    is1.s1m1 = v0
    var v1 = ic1.c1m2
    var v2 = ic1.c1m1
    outputString(ic1.c1m1)
    ic1.c1f1(v0, is1.s1m2)
    var v3 = ic1.c1m1.size
    ic1.c1f1("123", "456")
    if (cond) {
        return ic1.c1m1
    }
    if (cond) {
        return v0
    }
    if (ic1.c1m1.size > 9) {
        return ic1.c1m1
    }
    outputString(is1.s1m1)
    return is1.s1m1
}

func ArrayTest() {
    var server = TcpSocket("xxx", 0)
    var buf: Array<UInt8> = Array<UInt8>(1024*106, repeat: 8)
    var buf2: Array<UInt8> = Array<UInt8>(1024*106, repeat: 8)
    server.read(buf)
    var v0 = buf[1]
    var v1 = Int32(buf[2])
    outputUInt8(UInt8(v1), buf2[1], UInt8(v1))
    var v2 = Int32(v0) + v1
    buf[2] = 44
    buf2[1] = buf[1]
    var v3 = buf[1] > 1 || buf[2] > 3
    if (v3) {
        return
    }
    outputUInt8(v0, UInt8(v1), buf2[1])
}

func matchCaseTest() {
    var v0 = Console.stdIn.readln().getOrThrow()
    outputString(v0)
    match (Regex("^[0-9]+$").matcher(v0).fullMatch()) {
        case None => ()
        case Some(String) => ()
        case _ => return
    }
    outputString(v0)

    var v1 = Console.stdIn.readln().getOrThrow()
    println(v1)
    var abc = Regex("^[0-9]+$").matcher(v1).fullMatch()
    match (abc) {
        case None => throw Exception("")
        case Some(String) => ()
        case _ => ()
    }
    outputString(v1)
}

func loopTest() : String {
    var rep = HttpResponseBuilder().build()
    var v0 = rep.toString()
    var v1 = "1111111"
    var v2 = rep
    var v3 = "123" + v2.toString()
    var v4 = "33333"
    v4 = v3 + "444"
    if (cond) {
        return rep.toString()
    }
    var v5 = Console.stdIn.readln().getOrThrow()
    v4 = v3 + v5

    for (tmp in v0) {
        println(tmp.toString())
    }
    if (v3.size > 9) {
        return v3
    }
    var v6 = v4.toArray()
    return v6[0].toString()
}

func foo(){
  var rep = HttpResponseBuilder().build()
  println(rep.toString())
  UInt64(0)
}

class B{
  static var a: HttpResponse = ClientBuilder().build().get("http://127.0.0.1:10245/foo")
}

struct A{
  static func foo1(){
    return Regex(B.a.toString())
  }
}

main() {}
