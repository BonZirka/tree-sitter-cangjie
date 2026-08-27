/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

// cjlint-ignore -start !G.OTH.03
/**
 * defined status codes
 * RFC 6455 7.4.1.
 * https://www.iana.org/assignments/websocket/websocket.xhtml
 */
// cjlint-ignore -end
struct WebSocketStatusCode {
    // RFC 6455 7.4.1.
    static const NORMAL_CLOSURE: UInt16 = 1000
    static const GOING_AWAY: UInt16 = 1001
    static const PROTOCOL_ERROR: UInt16 = 1002
    static const UNSUPPORTED_DATA: UInt16 = 1003
    static const INVALID_DATA: UInt16 = 1007
    static const POLICY_VIOLATION: UInt16 = 1008
    static const MESSAGE_TOO_BIG: UInt16 = 1009
    static const MANDATORY_EXTENSION: UInt16 = 1010
    static const INTERNAL_ERROR: UInt16 = 1011

    // cjlint-ignore -start !G.OTH.03
    // https://www.iana.org/assignments/websocket/websocket.xhtml
    // cjlint-ignore -end
    static const SERVICE_RESTART: UInt16 = 1012
    static const TRY_AGAIN_LATER: UInt16 = 1013
    static const INVALID_RESPONSE: UInt16 = 1014
}
