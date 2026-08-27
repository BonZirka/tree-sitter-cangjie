/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 

import std.math.numeric.*
import std.math.*

struct TypeCastStruct {
    TypeCastStruct(let d: Decimal, let strategy: OverflowStrategy, let result: String) {}
}

let toInt8TCArray = [
    TypeCastStruct(Decimal.parse("127"), Throwing, "127"),
    TypeCastStruct(Decimal.parse("-128"), Throwing, "-128"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("721"), Throwing, "Out of range of the Int8."),
    TypeCastStruct(Decimal.parse("721"), Wrapping, "-47"),
    TypeCastStruct(Decimal.parse("721"), Saturating, "127"),
    TypeCastStruct(Decimal.parse("-821"), Throwing, "Out of range of the Int8."),
    TypeCastStruct(Decimal.parse("-821"), Wrapping, "-53"),
    TypeCastStruct(Decimal.parse("-821"), Saturating, "-128"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "-95"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "-16"),
    TypeCastStruct(Decimal.parse("127.531515"), Throwing, "127"),
    TypeCastStruct(Decimal.parse("-128.651851"), Throwing, "-128"),
    TypeCastStruct(Decimal.parse("0.541514561"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("721.146161651"), Throwing, "Out of range of the Int8."),
    TypeCastStruct(Decimal.parse("721.315151"), Wrapping, "-47"),
    TypeCastStruct(Decimal.parse("721.651684186416165"), Saturating, "127"),
    TypeCastStruct(Decimal.parse("-821.6515616163"), Throwing, "Out of range of the Int8."),
    TypeCastStruct(Decimal.parse("-821.651561651"), Wrapping, "-53"),
    TypeCastStruct(Decimal.parse("-821.65168181"), Saturating, "-128"),
    TypeCastStruct(Decimal.parse("18446744073709551777.161655616516"), Wrapping, "-95"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.15618618156"), Wrapping, "-16")
]
let toInt16TCArray = [
    TypeCastStruct(Decimal.parse("32767"), Throwing, "32767"),
    TypeCastStruct(Decimal.parse("-32768"), Throwing, "-32768"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873"), Throwing, "Out of range of the Int16."),
    TypeCastStruct(Decimal.parse("2857194873"), Wrapping, "21881"),
    TypeCastStruct(Decimal.parse("2857194873"), Saturating, "32767"),
    TypeCastStruct(Decimal.parse("-834316463"), Throwing, "Out of range of the Int16."),
    TypeCastStruct(Decimal.parse("-834316463"), Wrapping, "22353"),
    TypeCastStruct(Decimal.parse("-834316463"), Saturating, "-32768"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "-272"),
    TypeCastStruct(Decimal.parse("32767.54615151"), Throwing, "32767"),
    TypeCastStruct(Decimal.parse("-32768.46165151"), Throwing, "-32768"),
    TypeCastStruct(Decimal.parse("0.56156165"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873.68416113"), Throwing, "Out of range of the Int16."),
    TypeCastStruct(Decimal.parse("2857194873.6116165"), Wrapping, "21881"),
    TypeCastStruct(Decimal.parse("2857194873.181611651"), Saturating, "32767"),
    TypeCastStruct(Decimal.parse("-834316463.61861681"), Throwing, "Out of range of the Int16."),
    TypeCastStruct(Decimal.parse("-834316463.468431435"), Wrapping, "22353"),
    TypeCastStruct(Decimal.parse("-834316463.168115531"), Saturating, "-32768"),
    TypeCastStruct(Decimal.parse("18446744073709551777.126168161651"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.6516116116"), Wrapping, "-272")
]
let toInt32TCArray = [
    TypeCastStruct(Decimal.parse("2147483647"), Throwing, "2147483647"),
    TypeCastStruct(Decimal.parse("-2147483648"), Throwing, "-2147483648"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873"), Throwing, "Out of range of the Int32."),
    TypeCastStruct(Decimal.parse("2857194873"), Wrapping, "-1437772423"),
    TypeCastStruct(Decimal.parse("2857194873"), Saturating, "2147483647"),
    TypeCastStruct(Decimal.parse("-8343164635"), Throwing, "Out of range of the Int32."),
    TypeCastStruct(Decimal.parse("-8343164635"), Wrapping, "246769957"),
    TypeCastStruct(Decimal.parse("-8343164635"), Saturating, "-2147483648"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "-272"),
    TypeCastStruct(Decimal.parse("2147483647.46416414165"), Throwing, "2147483647"),
    TypeCastStruct(Decimal.parse("-2147483648.1561651651"), Throwing, "-2147483648"),
    TypeCastStruct(Decimal.parse("0.16516516"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873.1651651651"), Throwing, "Out of range of the Int32."),
    TypeCastStruct(Decimal.parse("2857194873.165161641641"), Wrapping, "-1437772423"),
    TypeCastStruct(Decimal.parse("2857194873.1861414645"), Saturating, "2147483647"),
    TypeCastStruct(Decimal.parse("-8343164635.4864684643"), Throwing, "Out of range of the Int32."),
    TypeCastStruct(Decimal.parse("-8343164635.1489161486"), Wrapping, "246769957"),
    TypeCastStruct(Decimal.parse("-8343164635.894844631"), Saturating, "-2147483648"),
    TypeCastStruct(Decimal.parse("18446744073709551777.846413146343"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.4986464443"), Wrapping, "-272")
]
let toInt64TCArray = [
    TypeCastStruct(Decimal.parse("-2147483648"), Throwing, "-2147483648"),
    TypeCastStruct(Decimal.parse("9223372036854775807"), Throwing, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-9223372036854775808"), Throwing, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Wrapping, "-4611686018427387906"),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Saturating, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Wrapping, "8301034833169298229"),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Saturating, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("184467440737095517777"), Wrapping, "1617"),
    TypeCastStruct(Decimal.parse("-184467440737095518888"), Wrapping, "-2728"),
    TypeCastStruct(Decimal.parse("9223372036854775807.681111161"), Throwing, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-9223372036854775808.8941641644341"), Throwing, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("0.1614334835"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("13835058055282163710.04161134"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("13835058055282163710.148131131"), Wrapping, "-4611686018427387906"),
    TypeCastStruct(Decimal.parse("13835058055282163710.46813183413438"), Saturating, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-10145709240540253387.68463413443"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("-10145709240540253387.16811831114"), Wrapping, "8301034833169298229"),
    TypeCastStruct(Decimal.parse("-10145709240540253387.48413414344"), Saturating, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("184467440737095517777.8461344134"), Wrapping, "1617"),
    TypeCastStruct(Decimal.parse("-184467440737095518888.18614843413"), Wrapping, "-2728")
]
let toIntNativeTCArray = [
    TypeCastStruct(Decimal.parse("9223372036854775807"), Throwing, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-9223372036854775808"), Throwing, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Wrapping, "-4611686018427387906"),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Saturating, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Wrapping, "8301034833169298229"),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Saturating, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("184467440737095517777"), Wrapping, "1617"),
    TypeCastStruct(Decimal.parse("-184467440737095518888"), Wrapping, "-2728"),
    TypeCastStruct(Decimal.parse("9223372036854775807.681111161"), Throwing, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-9223372036854775808.8941641644341"), Throwing, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("0.1614334835"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("13835058055282163710.04161134"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("13835058055282163710.148131131"), Wrapping, "-4611686018427387906"),
    TypeCastStruct(Decimal.parse("13835058055282163710.46813183413438"), Saturating, "9223372036854775807"),
    TypeCastStruct(Decimal.parse("-10145709240540253387.68463413443"), Throwing, "Out of range of the Int64."),
    TypeCastStruct(Decimal.parse("-10145709240540253387.16811831114"), Wrapping, "8301034833169298229"),
    TypeCastStruct(Decimal.parse("-10145709240540253387.48413414344"), Saturating, "-9223372036854775808"),
    TypeCastStruct(Decimal.parse("184467440737095517777.8461344134"), Wrapping, "1617"),
    TypeCastStruct(Decimal.parse("-184467440737095518888.18614843413"), Wrapping, "-2728")
]
let toUInt8TCArray = [
    TypeCastStruct(Decimal.parse("255"), Throwing, "255"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("721"), Throwing, "Out of range of the UInt8."),
    TypeCastStruct(Decimal.parse("721"), Wrapping, "209"),
    TypeCastStruct(Decimal.parse("721"), Saturating, "255"),
    TypeCastStruct(Decimal.parse("-821"), Throwing, "Out of range of the UInt8."),
    TypeCastStruct(Decimal.parse("-821"), Wrapping, "203"),
    TypeCastStruct(Decimal.parse("-821"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "240"),
    TypeCastStruct(Decimal.parse("255.145613483"), Throwing, "255"),
    TypeCastStruct(Decimal.parse("0.16611381"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("721.16131115"), Throwing, "Out of range of the UInt8."),
    TypeCastStruct(Decimal.parse("721.14861381851"), Wrapping, "209"),
    TypeCastStruct(Decimal.parse("721.16813481"), Saturating, "255"),
    TypeCastStruct(Decimal.parse("-821.185313841834"), Throwing, "Out of range of the UInt8."),
    TypeCastStruct(Decimal.parse("-821.18613"), Wrapping, "203"),
    TypeCastStruct(Decimal.parse("-821.168131381438"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777.861341341"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.48413434"), Wrapping, "240")
]
let toUInt16TCArray = [
    TypeCastStruct(Decimal.parse("65535"), Throwing, "65535"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873"), Throwing, "Out of range of the UInt16."),
    TypeCastStruct(Decimal.parse("2857194873"), Wrapping, "21881"),
    TypeCastStruct(Decimal.parse("2857194873"), Saturating, "65535"),
    TypeCastStruct(Decimal.parse("-834316463"), Throwing, "Out of range of the UInt16."),
    TypeCastStruct(Decimal.parse("-834316463"), Wrapping, "22353"),
    TypeCastStruct(Decimal.parse("-834316463"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "65264"),
    TypeCastStruct(Decimal.parse("65535.46518413"), Throwing, "65535"),
    TypeCastStruct(Decimal.parse("0.04864141843"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("2857194873.84634344"), Throwing, "Out of range of the UInt16."),
    TypeCastStruct(Decimal.parse("2857194873.8468434984"), Wrapping, "21881"),
    TypeCastStruct(Decimal.parse("2857194873.9451343"), Saturating, "65535"),
    TypeCastStruct(Decimal.parse("-834316463.48463434"), Throwing, "Out of range of the UInt16."),
    TypeCastStruct(Decimal.parse("-834316463.846341344"), Wrapping, "22353"),
    TypeCastStruct(Decimal.parse("-834316463.4861438434"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777.468434134"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.486434343"), Wrapping, "65264")
]
let toUInt32TCArray = [
    TypeCastStruct(Decimal.parse("4294967295"), Throwing, "4294967295"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("28571948739"), Throwing, "Out of range of the UInt32."),
    TypeCastStruct(Decimal.parse("28571948739"), Wrapping, "2802144963"),
    TypeCastStruct(Decimal.parse("28571948739"), Saturating, "4294967295"),
    TypeCastStruct(Decimal.parse("-8343164636"), Throwing, "Out of range of the UInt32."),
    TypeCastStruct(Decimal.parse("-8343164636"), Wrapping, "246769956"),
    TypeCastStruct(Decimal.parse("-8343164636"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "4294967024"),
    TypeCastStruct(Decimal.parse("4294967295.4864413413"), Throwing, "4294967295"),
    TypeCastStruct(Decimal.parse("0.4864134343"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("28571948739.51416468468"), Throwing, "Out of range of the UInt32."),
    TypeCastStruct(Decimal.parse("28571948739.4864646434"), Wrapping, "2802144963"),
    TypeCastStruct(Decimal.parse("28571948739.949343484"), Saturating, "4294967295"),
    TypeCastStruct(Decimal.parse("-8343164636.48443434"), Throwing, "Out of range of the UInt32."),
    TypeCastStruct(Decimal.parse("-8343164636.4846468344863"), Wrapping, "246769956"),
    TypeCastStruct(Decimal.parse("-8343164636.848446343"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551777.946484343"), Wrapping, "161"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.478634949496"), Wrapping, "4294967024")
]
let toUInt64TCArray = [
    TypeCastStruct(Decimal.parse("18446744073709551615"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Wrapping, "6087425544324152029"),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Saturating, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Wrapping, "14203992936756354746"),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551615.846344384"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0.64584344635"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877.4846348434"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("61427657765452806877.8434434434"), Wrapping, "6087425544324152029"),
    TypeCastStruct(Decimal.parse("61427657765452806877.6348464348"), Saturating, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("-22689495210662748486.648646315468"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("-22689495210662748486.4864343854"), Wrapping, "14203992936756354746"),
    TypeCastStruct(Decimal.parse("-22689495210662748486.64534684634"), Saturating, "0")
]
let toUIntNativeTCArray = [
    TypeCastStruct(Decimal.parse("18446744073709551615"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Wrapping, "6087425544324152029"),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Saturating, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Wrapping, "14203992936756354746"),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Saturating, "0"),
    TypeCastStruct(Decimal.parse("18446744073709551615.846344384"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0.64584344635"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877.4846348434"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("61427657765452806877.8434434434"), Wrapping, "6087425544324152029"),
    TypeCastStruct(Decimal.parse("61427657765452806877.6348464348"), Saturating, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("-22689495210662748486.648646315468"), Throwing, "Out of range of the UInt64."),
    TypeCastStruct(Decimal.parse("-22689495210662748486.4864343854"), Wrapping, "14203992936756354746"),
    TypeCastStruct(Decimal.parse("-22689495210662748486.64534684634"), Saturating, "0")
]
let toFloat16TCArray = [
    TypeCastStruct(Decimal.parse("32767"), Throwing, "32768.000000"),
    TypeCastStruct(Decimal.parse("-32768"), Throwing, "-32768.000000"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0.000000"),
    TypeCastStruct(Decimal.parse("2857194873"), Throwing, "inf"),
    TypeCastStruct(Decimal.parse("-834316463"), Throwing, "-inf"),
    TypeCastStruct(Decimal.parse("32767.54615151"), Throwing, "32768.000000"),
    TypeCastStruct(Decimal.parse("-32768.46165151"), Throwing, "-32768.000000"),
    TypeCastStruct(Decimal.parse("0.56156165"), Throwing, "0.561523"),
    TypeCastStruct(Decimal.parse("2857194873.68416113"), Throwing, "inf"),
    TypeCastStruct(Decimal.parse("-834316463.61861681"), Throwing, "-inf"),
    TypeCastStruct(Decimal.parse("123.126168161651"), Wrapping, "123.125000"),
    TypeCastStruct(Decimal.parse("-41.6516116116"), Wrapping, "-41.656250")
]
let toFloat32TCArray = [
    TypeCastStruct(Decimal.parse("2147483647"), Throwing, "2147483648.000000"),
    TypeCastStruct(Decimal.parse("-2147483648"), Throwing, "-2147483648.000000"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0.000000"),
    TypeCastStruct(Decimal.parse("2857194873"), Throwing, "2857194752.000000"),
    TypeCastStruct(Decimal.parse("-8343164635"), Throwing, "-8343164416.000000"),
    TypeCastStruct(Decimal.parse("18446744073709551777"), Wrapping, "18446744073709551616.000000"),
    TypeCastStruct(Decimal.parse("-18446744073709551888"), Wrapping, "-18446744073709551616.000000"),
    TypeCastStruct(Decimal.parse("2147483647.46416414165"), Throwing, "2147483648.000000"),
    TypeCastStruct(Decimal.parse("-2147483648.1561651651"), Throwing, "-2147483648.000000"),
    TypeCastStruct(Decimal.parse("0.16516516"), Throwing, "0.165165"),
    TypeCastStruct(Decimal.parse("2857194873.1651651651"), Throwing, "2857194752.000000"),
    TypeCastStruct(Decimal.parse("-8343164635.4864684643"), Throwing, "-8343164416.000000"),
    TypeCastStruct(Decimal.parse("18446744073709551777.846413146343"), Wrapping, "18446744073709551616.000000"),
    TypeCastStruct(Decimal.parse("-18446744073709551888.4986464443"), Wrapping, "-18446744073709551616.000000"),
    TypeCastStruct(Decimal.parse("-1513.15153E8000"), Throwing, "-inf"),
    TypeCastStruct(Decimal.parse("1513.15153E8000"), Throwing, "inf")
]
let toFloat64TCArray = [
    TypeCastStruct(Decimal.parse("255"), Throwing, "255.000000"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0.000000"),
    TypeCastStruct(Decimal.parse("-2147483648"), Throwing, "-2147483648.000000"),
    TypeCastStruct(Decimal.parse("9223372036854775807"), Throwing, "9223372036854775808.000000"),
    TypeCastStruct(Decimal.parse("-9223372036854775808"), Throwing, "-9223372036854775808.000000"),
    TypeCastStruct(Decimal.parse("13835058055282163710"), Throwing, "13835058055282163712.000000"),
    TypeCastStruct(Decimal.parse("-10145709240540253387"), Throwing, "-10145709240540254208.000000"),
    TypeCastStruct(Decimal.parse("184467440737095517777"), Throwing, "184467440737095516160.000000"),
    TypeCastStruct(Decimal.parse("-184467440737095518888"), Throwing, "-184467440737095516160.000000"),
    TypeCastStruct(Decimal.parse("9223372036854775807.681111161"), Throwing, "9223372036854775808.000000"),
    TypeCastStruct(Decimal.parse("-9223372036854775808.8941641644341"), Throwing, "-9223372036854775808.000000"),
    TypeCastStruct(Decimal.parse("0.1614334835"), Throwing, "0.161433"),
    TypeCastStruct(Decimal.parse("13835058055282163710.04161134"), Throwing, "13835058055282163712.000000"),
    TypeCastStruct(Decimal.parse("-10145709240540253387.68463413443"), Throwing, "-10145709240540254208.000000"),
    TypeCastStruct(Decimal.parse("184467440737095517777.8461344134"), Throwing, "184467440737095516160.000000"),
    TypeCastStruct(Decimal.parse("-184467440737095518888.18614843413"), Throwing, "-184467440737095516160.000000"),
    TypeCastStruct(Decimal.parse("4294967295.4864413413"), Throwing, "4294967295.486441"),
    TypeCastStruct(Decimal.parse("0.4864134343"), Throwing, "0.486413"),
    TypeCastStruct(Decimal.parse("28571948739.51416468468"), Throwing, "28571948739.514164"),
    TypeCastStruct(Decimal.parse("-8343164636.48443434"), Throwing, "-8343164636.484434"),
    TypeCastStruct(Decimal.parse("0.1"), Throwing, "0.100000"),
    TypeCastStruct(Decimal.parse("-1513.15153E8000"), Throwing, "-inf"),
    TypeCastStruct(Decimal.parse("1513.15153E8000"), Throwing, "inf")
]
let toBigIntTCArray = [
    TypeCastStruct(Decimal.parse("18446744073709551615"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877"), Throwing, "61427657765452806877"),
    TypeCastStruct(Decimal.parse("-22689495210662748486"), Throwing, "-22689495210662748486"),
    TypeCastStruct(Decimal.parse("18446744073709551615.846344384"), Throwing, "18446744073709551615"),
    TypeCastStruct(Decimal.parse("0.64584344635"), Throwing, "0"),
    TypeCastStruct(Decimal.parse("61427657765452806877.4846348434"), Throwing, "61427657765452806877"),
    TypeCastStruct(Decimal.parse("-22689495210662748486.648646315468"), Throwing, "-22689495210662748486")
]
let toEngStrTCArray = [
    TypeCastStruct(Decimal.parse("1"), Throwing, "1E0"),
    TypeCastStruct(Decimal.parse("0.1"), Throwing, "100E-3"),
    TypeCastStruct(Decimal.parse("1234.56789"), Throwing, "1.23456789E3"),
    TypeCastStruct(Decimal.parse("-45801681351.515616810"), Throwing, "-45.801681351515616810E9"),
    TypeCastStruct(Decimal.parse("-00000000002561616816.168518616"), Throwing, "-2.561616816168518616E9"),
    TypeCastStruct(Decimal.parse("+16518616.561861685"), Throwing, "16.518616561861685E6"),
    TypeCastStruct(Decimal.parse("00.000000"), Throwing, "0E-6"),
    TypeCastStruct(Decimal.parse("-00.000000"), Throwing, "0E-6"),
    TypeCastStruct(Decimal.parse("-15165E12"), Throwing, "-15.165E15"),
    TypeCastStruct(Decimal.parse("+16810631E-20"), Throwing, "168.10631E-15"),
    TypeCastStruct(Decimal.parse("+18616161.51125312e-10"), Throwing, "1.861616151125312E-3"),
    TypeCastStruct(Decimal.parse("0E5"), Throwing, "0.0E6"),
    TypeCastStruct(Decimal.parse("0E-5"), Throwing, "0.00E-3"),
    TypeCastStruct(Decimal.parse("0.e0"), Throwing, "0E0"),
    TypeCastStruct(Decimal.parse(".0e-0"), Throwing, "0.0E0"),
    TypeCastStruct(Decimal.parse("156161.1681E0"), Throwing, "156.1611681E3"),
    TypeCastStruct(Decimal.parse("24515668.89118"), Throwing, "24.51566889118E6"),
    TypeCastStruct(Decimal.parse("148611161"), Throwing, "148.611161E6"),
    TypeCastStruct(Decimal.parse("115613615631E-10"), Throwing, "11.5613615631E0"),
    TypeCastStruct(Decimal.parse("-.2168168464e+5"), Throwing, "-21.68168464E3"),
    TypeCastStruct(Decimal.parse("0").reScale(-1), Throwing, "0.00E3"),
    TypeCastStruct(Decimal.parse("0").reScale(-2), Throwing, "0.0E3"),
    TypeCastStruct(Decimal.parse("0").reScale(-3), Throwing, "0E3"),
    TypeCastStruct(Decimal.parse("0").reScale(-4), Throwing, "0.00E6"),
    TypeCastStruct(Decimal.parse("0").reScale(-5), Throwing, "0.0E6"),
    TypeCastStruct(Decimal.parse("0").reScale(-6), Throwing, "0E6"),
    TypeCastStruct(Decimal.parse("0").reScale(1), Throwing, "0.0E0"),
    TypeCastStruct(Decimal.parse("0").reScale(2), Throwing, "0.00E0"),
    TypeCastStruct(Decimal.parse("0").reScale(3), Throwing, "0E-3"),
    TypeCastStruct(Decimal.parse("0").reScale(4), Throwing, "0.0E-3"),
    TypeCastStruct(Decimal.parse("0").reScale(5), Throwing, "0.00E-3"),
    TypeCastStruct(Decimal.parse("0").reScale(6), Throwing, "0E-6")
]
let toSciStrTCArray = [
    TypeCastStruct(Decimal.parse("1"), Throwing, "1E0"),
    TypeCastStruct(Decimal.parse("0.1"), Throwing, "1E-1"),
    TypeCastStruct(Decimal.parse("1234.56789"), Throwing, "1.23456789E3"),
    TypeCastStruct(Decimal.parse("-45801681351.515616810"), Throwing, "-4.5801681351515616810E10"),
    TypeCastStruct(Decimal.parse("-00000000002561616816.168518616"), Throwing, "-2.561616816168518616E9"),
    TypeCastStruct(Decimal.parse("+16518616.561861685"), Throwing, "1.6518616561861685E7"),
    TypeCastStruct(Decimal.parse("00.000000"), Throwing, "0E-6"),
    TypeCastStruct(Decimal.parse("-00.000000"), Throwing, "0E-6"),
    TypeCastStruct(Decimal.parse("-15165E12"), Throwing, "-1.5165E16"),
    TypeCastStruct(Decimal.parse("+16810631E-20"), Throwing, "1.6810631E-13"),
    TypeCastStruct(Decimal.parse("+18616161.51125312e-10"), Throwing, "1.861616151125312E-3"),
    TypeCastStruct(Decimal.parse("0E5"), Throwing, "0E5"),
    TypeCastStruct(Decimal.parse("0E-5"), Throwing, "0E-5"),
    TypeCastStruct(Decimal.parse("0.e0"), Throwing, "0E0"),
    TypeCastStruct(Decimal.parse(".0e-0"), Throwing, "0E-1"),
    TypeCastStruct(Decimal.parse("156161.1681E0"), Throwing, "1.561611681E5"),
    TypeCastStruct(Decimal.parse("24515668.89118"), Throwing, "2.451566889118E7"),
    TypeCastStruct(Decimal.parse("148611161"), Throwing, "1.48611161E8"),
    TypeCastStruct(Decimal.parse("115613615631E-10"), Throwing, "1.15613615631E1"),
    TypeCastStruct(Decimal.parse("-.2168168464e+5"), Throwing, "-2.168168464E4"),
    TypeCastStruct(Decimal.parse("0").reScale(-1), Throwing, "0E1"),
    TypeCastStruct(Decimal.parse("0").reScale(-2), Throwing, "0E2"),
    TypeCastStruct(Decimal.parse("0").reScale(-3), Throwing, "0E3"),
    TypeCastStruct(Decimal.parse("0").reScale(-4), Throwing, "0E4"),
    TypeCastStruct(Decimal.parse("0").reScale(-5), Throwing, "0E5"),
    TypeCastStruct(Decimal.parse("0").reScale(-6), Throwing, "0E6"),
    TypeCastStruct(Decimal.parse("0").reScale(1), Throwing, "0E-1"),
    TypeCastStruct(Decimal.parse("0").reScale(2), Throwing, "0E-2"),
    TypeCastStruct(Decimal.parse("0").reScale(3), Throwing, "0E-3"),
    TypeCastStruct(Decimal.parse("0").reScale(4), Throwing, "0E-4"),
    TypeCastStruct(Decimal.parse("0").reScale(5), Throwing, "0E-5"),
    TypeCastStruct(Decimal.parse("0").reScale(6), Throwing, "0E-6")
]

@Test
class DecimalTypeCastTest {
    @TestCase
    func toInt8Test() {
        for (tc in toInt8TCArray) {
            try {
                let actual = tc.d.toInt8(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toInt16Test() {
        for (tc in toInt16TCArray) {
            try {
                let actual = tc.d.toInt16(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toInt32Test() {
        for (tc in toInt32TCArray) {
            try {
                let actual = tc.d.toInt32(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toInt64Test() {
        for (tc in toInt64TCArray) {
            try {
                let actual = tc.d.toInt64(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toIntNativeTest() {
        for (tc in toIntNativeTCArray) {
            try {
                let actual = tc.d.toIntNative(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toUInt8Test() {
        for (tc in toUInt8TCArray) {
            try {
                let actual = tc.d.toUInt8(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toUInt16Test() {
        for (tc in toUInt16TCArray) {
            try {
                let actual = tc.d.toUInt16(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toUInt32Test() {
        for (tc in toUInt32TCArray) {
            try {
                let actual = tc.d.toUInt32(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toUInt64Test() {
        for (tc in toUInt64TCArray) {
            try {
                let actual = tc.d.toUInt64(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toUIntNativeTest() {
        for (tc in toUIntNativeTCArray) {
            try {
                let actual = tc.d.toUIntNative(overflowHandling: tc.strategy).toString()
                @Expect(actual, tc.result)
            } catch (e: OverflowException) {
                @Expect(e.message, tc.result)
            }
        }
    }

    @TestCase
    func toFloat16Test() {
        for (tc in toFloat16TCArray) {
            let actual = tc.d.toFloat16().toString()
            @Expect(actual, tc.result)
        }
    }

    @TestCase
    func toFloat32Test() {
        for (tc in toFloat32TCArray) {
            let actual = tc.d.toFloat32().toString()
            @Expect(actual, tc.result)
        }
    }

    @TestCase
    func toFloat64Test() {
        for (tc in toFloat64TCArray) {
            let actual = tc.d.toFloat64().toString()
            @Expect(actual, tc.result)
        }
    }

    @TestCase
    func toBigIntTest() {
        for (tc in toBigIntTCArray) {
            let actual = tc.d.toBigInt().toString()
            @Expect(actual, tc.result)
        }
    }

    @TestCase
    func toEngStringTest() {
        for (tc in toEngStrTCArray) {
            let actual = tc.d.toEngString()
            @Expect(actual, tc.result)
        }
    }

    @TestCase
    func toSciStringTest() {
        for (tc in toSciStrTCArray) {
            let actual = tc.d.toSciString()
            @Expect(actual, tc.result)
        }
    }
}
