/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (not Windows)EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// (not Windows)RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan 2557

func large_pregs_bigframe(p22: Int64, p24: Int64, p26: Int64, p28: Int64, p210: Int64, p212: Int64, p214: Int64,
    p216: Int64, p218: Int64, p220: Int64, p222: Int64, p224: Int64, p226: Int64, p228: Int64, p230: Int64, p232: Int64,
    p234: Int64, p236: Int64, p238: Int64, p240: Int64, p242: Int64, p244: Int64, p246: Int64, p248: Int64, p250: Int64,
    p252: Int64, p254: Int64, p256: Int64, p258: Int64, p260: Int64, p262: Int64, p264: Int64, p266: Int64, p268: Int64,
    p270: Int64, p272: Int64, p274: Int64, p276: Int64, p278: Int64, p280: Int64, p282: Int64, p284: Int64, p286: Int64,
    p288: Int64, p290: Int64, p292: Int64, p294: Int64, p296: Int64, p298: Int64, p2100: Int64, p2102: Int64,
    p2104: Int64, p2106: Int64, p2108: Int64, p2110: Int64, p2112: Int64, p2114: Int64, p2116: Int64, p2118: Int64,
    p2120: Int64, p2122: Int64, p2124: Int64, p2126: Int64, p2128: Int64, p2130: Int64, p2132: Int64, p2134: Int64,
    p2136: Int64, p2138: Int64, p2140: Int64, p2142: Int64): Int64 {
    var v20: Int64 = 0
    v20 = v20 + p22
    v20 = v20 + p24
    v20 = v20 + p26
    v20 = v20 + p28
    v20 = v20 + p210
    v20 = v20 + p212
    v20 = v20 + p214
    v20 = v20 + p216
    v20 = v20 + p218
    v20 = v20 + p220
    v20 = v20 + p222
    v20 = v20 + p224
    v20 = v20 + p226
    v20 = v20 + p228
    v20 = v20 + p230
    v20 = v20 + p232
    v20 = v20 + p234
    v20 = v20 + p236
    v20 = v20 + p238
    v20 = v20 + p240
    v20 = v20 + p242
    v20 = v20 + p244
    v20 = v20 + p246
    v20 = v20 + p248
    v20 = v20 + p250
    v20 = v20 + p252
    v20 = v20 + p254
    v20 = v20 + p256
    v20 = v20 + p258
    v20 = v20 + p260
    v20 = v20 + p262
    v20 = v20 + p264
    v20 = v20 + p266
    v20 = v20 + p268
    v20 = v20 + p270
    v20 = v20 + p272
    v20 = v20 + p274
    v20 = v20 + p276
    v20 = v20 + p278
    v20 = v20 + p280
    v20 = v20 + p282
    v20 = v20 + p284
    v20 = v20 + p286
    v20 = v20 + p288
    v20 = v20 + p290
    v20 = v20 + p292
    v20 = v20 + p294
    v20 = v20 + p296
    v20 = v20 + p298
    v20 = v20 + p2100
    v20 = v20 + p2102
    v20 = v20 + p2104
    v20 = v20 + p2106
    v20 = v20 + p2108
    v20 = v20 + p2110
    v20 = v20 + p2112
    v20 = v20 + p2114
    v20 = v20 + p2116
    v20 = v20 + p2118
    v20 = v20 + p2120
    v20 = v20 + p2122
    v20 = v20 + p2124
    v20 = v20 + p2126
    v20 = v20 + p2128
    v20 = v20 + p2130
    v20 = v20 + p2132
    v20 = v20 + p2134
    v20 = v20 + p2136
    v20 = v20 + p2138
    v20 = v20 + p2140
    v20 = v20 + p2142
    return v20
}

func large_pregs_main(R16097: Int32): Int64 {
    let v20: Int64 = 1
    let v22: Int64 = 2
    let v24: Int64 = 3
    let v26: Int64 = 4
    let v28: Int64 = 5
    let v210: Int64 = 6
    let v212: Int64 = 7
    let v214: Int64 = 8
    let v216: Int64 = 9
    let v218: Int64 = 10
    let v220: Int64 = 11
    let v222: Int64 = 12
    let v224: Int64 = 13
    let v226: Int64 = 14
    let v228: Int64 = 15
    let v230: Int64 = 16
    let v232: Int64 = 17
    let v234: Int64 = 18
    let v236: Int64 = 19
    let v238: Int64 = 20
    let v240: Int64 = 21
    let v242: Int64 = 22
    let v244: Int64 = 23
    let v246: Int64 = 24
    let v248: Int64 = 25
    let v250: Int64 = 26
    let v252: Int64 = 27
    let v254: Int64 = 28
    let v256: Int64 = 29
    let v258: Int64 = 30
    let v260: Int64 = 31
    let v262: Int64 = 32
    let v264: Int64 = 33
    let v266: Int64 = 34
    let v268: Int64 = 35
    let v270: Int64 = 36
    let v272: Int64 = 37
    let v274: Int64 = 38
    let v276: Int64 = 39
    let v278: Int64 = 40
    let v280: Int64 = 41
    let v282: Int64 = 42
    let v284: Int64 = 43
    let v286: Int64 = 44
    let v288: Int64 = 45
    let v290: Int64 = 46
    let v292: Int64 = 47
    let v294: Int64 = 48
    let v296: Int64 = 49
    let v298: Int64 = 50
    let v2100: Int64 = 51
    let v2102: Int64 = 52
    let v2104: Int64 = 53
    let v2106: Int64 = 54
    let v2108: Int64 = 55
    let v2110: Int64 = 56
    let v2112: Int64 = 57
    let v2114: Int64 = 58
    let v2116: Int64 = 59
    let v2118: Int64 = 60
    let v2120: Int64 = 61
    let v2122: Int64 = 62
    let v2124: Int64 = 63
    let v2126: Int64 = 65
    let v2128: Int64 = 65
    let v2130: Int64 = 66
    let v2132: Int64 = 67
    let v2134: Int64 = 68
    let v2136: Int64 = 69
    let v2138: Int64 = 70
    let v2140: Int64 = 71
    let retval: Int64 = large_pregs_bigframe(v20, v22, v24, v26, v28, v210, v212, v214, v216, v218, v220, v222, v224,
        v226, v228, v230, v232, v234, v236, v238, v240, v242, v244, v246, v248, v250, v252, v254, v256, v258, v260, v262,
        v264, v266, v268, v270, v272, v274, v276, v278, v280, v282, v284, v286, v288, v290, v292, v294, v296, v298,
        v2100, v2102, v2104, v2106, v2108, v2110, v2112, v2114, v2116, v2118, v2120, v2122, v2124, v2126, v2128, v2130,
        v2132, v2134, v2136, v2138, v2140)
    return retval
}

main(): Int64 {
    print(large_pregs_main(0).toString())
    return 0
}
