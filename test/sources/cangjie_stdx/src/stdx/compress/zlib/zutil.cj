/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * Defines common constants/type/function for compression/decompression
 */
package stdx.compress.zlib

const BESTSPEED_LEVEL: Int32 = 1
const DEFAULTCOMPRESSION_LEVEL: Int32 = 6
const BESTCOMPRESSION_LEVEL: Int32 = 9

/*
 * Compressed Data Format
 *
 * ZlibFormat is not supported currently.
 */
public enum WrapType {
    DeflateFormat
    | GzipFormat
}

/* Compression level */
public enum CompressLevel {
    BestSpeed
    | DefaultCompression
    | BestCompression
}

func getLevelValue(level: CompressLevel): Int32 {
    return match (level) {
        case BestSpeed => BESTSPEED_LEVEL
        case DefaultCompression => DEFAULTCOMPRESSION_LEVEL
        case BestCompression => BESTCOMPRESSION_LEVEL
    }
}

/*
 * Flush Type
 *
 * Z_PARTIAL_FLUSH is not supported currently.
 * Z_SYNC_FLUSH is not supported currently.
 * Z_FULL_FLUSH is not supported currently.
 * Z_BLOCK is not supported currently.
 * Z_TREES is not supported currently.
 */
enum FlushType {
    NoFlush
    | Finish
}

func getFlushValue(flush: FlushType): Int32 {
    return match (flush) {
        case NoFlush => 0
        case Finish => 4
    }
}

/* 
 * Compression Strategy
 *
 * Z_FILTERED is not supported currently.
 * Z_HUFFMAN_ONLY is not supported currently.
 * Z_RLE is not supported currently.
 * Fixed is supported currently but not used.
 * Z_STRATEGY_BUTT is not supported currently.
 */
enum CompressStrategy {
    DefaultStrategy
}

func getStrategyValue(strategy: CompressStrategy): Int32 {
    return match (strategy) {
        case DefaultStrategy => 0
    }
}

/* 
 * Memory level
 *
 * MinMemoryLevel is supported currently but not used.
 * MaxMemoryLevel is supported currently but not used.
 */
enum MemoryLevel {
    DefaultMemoryLevel
}

func getMemLevelValue(mLevel: MemoryLevel): Int32 {
    return match (mLevel) {
        case DefaultMemoryLevel => 8
    }
}

/* 
 * Window Bits
 *
 * MinWindowBits is supported currently but not used.
 * MaxWindowBits is supported currently but not used.
 */
enum WindowBits {
    DefaultWindowBits
}

func getWinBitsValue(wrap: WrapType, winBits: WindowBits): Int32 {
    var wBits: Int32 = match (winBits) {
        case DefaultWindowBits => 15
    }
    return match (wrap) {
        case DeflateFormat => 0 - wBits
        case GzipFormat => wBits + 16
    }
}

/**
 * @throws ZlibException if bufLen <= 0.
 */
func getBufByLen(bufLen: Int64) {
    if (bufLen > 0) {
        return Array<Byte>(bufLen, repeat: 0)
    }
    throw ZlibException("Invalid buffer length: bufLen=${bufLen}")
}
