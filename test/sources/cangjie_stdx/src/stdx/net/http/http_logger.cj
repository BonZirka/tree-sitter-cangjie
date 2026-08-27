/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.console.Console
import std.env.*
import stdx.logger.SimpleLogger
import stdx.log.*

func mutexLogger(): Logger {
    let l = SimpleLogger(getStdOut())
    return l
}

func httpLog(logger: Logger, level: LogLevel, message: String, attrs: Array<Attr>) {
    let msg = match (ThreadContext.connId) {
        case Some(connId) => "[thread#${Thread.currentThread.id}][conn#${connId}] ${message}"
        case None => "[thread#${Thread.currentThread.id}] ${message}"
    }
    logger.log(level, msg, attrs)
}

func httpLogFatal(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.FATAL, message, attrs)
}

func httpLogError(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.ERROR, message, attrs)
}

func httpLogWarn(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.WARN, message, attrs)
}

func httpLogInfo(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.INFO, message, attrs)
}

func httpLogDebug(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.DEBUG, message, attrs)
}

func httpLogTrace(logger: Logger, message: String, attrs: Array<Attr>) {
    httpLog(logger, LogLevel.TRACE, message, attrs)
}
