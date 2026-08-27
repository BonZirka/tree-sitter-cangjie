// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import std.{console.*, fs.*, io.*}
internal import stdx.log.*
internal import stdx.logger.*

open class MyLogger <: Logger {
  public mut prop level: LogLevel {
    get() {
        LogLevel.OFF
    }
    set(level_) {}
  }
  public func setOutput(output: OutputStream): Unit {}
  public func trace(msg: String): Unit {}
  public func debug(msg: String): Unit {}
  public func info(msg: String): Unit {}
  public func warn(msg: String): Unit {}
  public func error(msg: String): Unit {}
  public func log(level: LogLevel, msg: String): Unit {}
  public func close(): Unit {}
  public func isClosed(): Bool { true }
  public func log(record: LogRecord): Unit {}
  public func withAttrs(attrs: Array<Attr>): Logger { this }
}

main() {
    let logger = SimpleLogger(Console.stdOut)

	logger.log(LogLevel.INFO, "hello")
    logger.log(LogLevel.INFO, "password")
	
}