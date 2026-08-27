/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.logger

import std.time.DateTime
import std.io.OutputStream
import stdx.encoding.json.stream.{JsonSerializable, JsonWriter}
import stdx.log.*

public class JsonLogger <: Logger {
    let cl: CommonLogger
    init(cl: CommonLogger) {
        this.cl = cl
    }
    public init(output: OutputStream) {
        cl = CommonLogger(output, LogStyle.JSON)
    }
    public mut prop level: LogLevel {
        get() {
            cl.level
        }
        set(v) {
            cl.level = v
        }
    }
    public func withAttrs(attrs: Array<Attr>): Logger {
        return JsonLogger(cl.withAttrs(attrs))
    }
    public func isClosed(): Bool {
        cl.isClosed()
    }
    public func close(): Unit {
        cl.close()
    }
    public func log(record: LogRecord): Unit {
        cl.log(record)
    }
}

class JsonLogWriter <: LogWriter {
    let jw: JsonWriter
    var out: OutputStream
    var haveName = false

    init(out: OutputStream) {
        this.out = out
        jw = JsonWriter(out)
    }
    public func writeNone(): Unit {
        jw.writeValue<String>("None")
    }
    public func writeInt(v: Int64): Unit {
        jw.writeValue(v)
    }
    public func writeBool(v: Bool): Unit {
        jw.writeValue(v)
    }
    public func writeFloat(v: Float64): Unit {
        jw.writeValue(v)
    }
    public func writeString(v: String): Unit {
        jw.writeValue(v)
    }
    public func writeDateTime(v: DateTime): Unit {
        jw.writeValue(v)
    }
    public func writeDuration(v: Duration): Unit {
        jw.writeValue(v.toString())
    }
    public func writeException(v: Exception): Unit {
        jw.writeValue(v.stackToString())
    }
    public func writeKey(v: String): Unit {
        jw.writeName(v)
    }
    public func writeValue(lv: LogValue): Unit {
        match (lv) {
            case v: JsonSerializable => v.toJson(jw)
            case _ => lv.writeTo(this)
        }
    }
    public func startArray(): Unit {
        jw.startArray()
    }
    public func endArray(): Unit {
        jw.endArray()
    }
    public func startObject(): Unit {
        jw.startObject()
    }
    public func endObject(): Unit {
        jw.endObject()
    }
    func flush() {
        jw.writeWrap()
        jw.flush()
    }
}
