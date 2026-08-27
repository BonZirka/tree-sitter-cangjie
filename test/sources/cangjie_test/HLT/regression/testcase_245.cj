/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// TIMEOUT: 10
// ERRCHECK: %compiler %cmp_opt %f -o %output 


public enum Keyword <: Rawable {
    | Aggregate
    | Alpha
    | By
    | Get
    | Limit
    | No
    | NoSort
    | One
    | Set
    | Store
    | Weights
    | WithScores
    | ResetStat
    | Rewrite
    | Reset
    | Flush
    | Exists
    | Load
    | Len
    | Help
    | Schedule
    | Match
    | Count
    | Type
    | Keys
    | RefCount
    | Encoding
    | IdleTime
    | Freq
    | Replace
    | GetName
    | SetName
    | List
    | Id
    | Kill
    | Pause
    | Unpause
    | Unblock
    | Streams
    | Create
    | MKStream
    | SetId
    | Destroy
    | DelConsumer
    | MaxLen
    | Group
    | Idle
    | Time
    | Block
    | NoAck
    | RetryCount
    | Stream
    | Groups
    | Consumers
    | JustId
    | WithValues
    | NoMKStream
    | MinId
    | CreateConsumer
    | SetUser
    | GetUser
    | DelUser
    | WhoAmI
    | Users
    | Cat
    | GenPass
    | Log
    | Save
    | DryRun
    | Copy
    | Auth
    | Auth2
    | NX
    | XX
    | EX
    | PX
    | ExAt
    | PxAt
    | CH
    | ABSTTL
    | KeepTTL
    | Incr
    | Info
    | Channels
    | NumPat
    | NumSub
    | Now
    | Rev
    | WithCoord
    | WithDist
    | WithHash
    | Any
    | FromMember
    | FromLonLat
    | ByRadius
    | ByBox
    | ByLex
    | ByScore
    | StoreDist
    | To
    | Force
    | TimeOut
    | DB
    | Unload
    | Abort
    | Idx
    | MinMatchLen
    | WithMatchLen
    | Full
    | Delete
    | LibraryName
    | WithCode
    | Description
    | GetKeys
    | GetKeysAndFlags
    | Docs
    | FilterBy
    | Dump
    | Module
    | AclCat
    | Pattern
    | Doctor
    | Usage
    | Samples
    | Purge
    | Stats
    | Loadex
    | Config
    | Args
    | Asc
    | Desc
    | LCS
    | Strings

public prop raw: Array<Byte> {
        get() {
            match(this){
                    case Aggregate => Aggregate
    case Alpha =>Alpha
    case By => By
    case Get => Get
    case Limit => Limit
    | Limit
    | No
    | NoSort
    | One
    | Set
    | Store
    | Weights
    | WithScores
    | ResetStat
    | Rewrite
    | Reset
    | Flush
    | Exists
    | Load
    | Len
    | Help
    | Schedule
    | Match
    | Count
    | Type
    | Keys
    | RefCount
    | Encoding
    | IdleTime
    | Freq
    | Replace
    | GetName
    | SetName
    | List
    | Id
    | Kill
    | Pause
    | Unpause
    | Unblock
    | Streams
    | Create
    | MKStream
    | SetId
    | Destroy
    | DelConsumer
    | MaxLen
    | Group
    | Idle
    | Time
    | Block
    | NoAck
    | RetryCount
    | Stream
    | Groups
    | Consumers
    | JustId
    | WithValues
    | NoMKStream
    | MinId
    | CreateConsumer
    | SetUser
    | GetUser
    | DelUser
    | WhoAmI
    | Users
    | Cat
    | GenPass
    | Log
    | Save
    | DryRun
    | Copy
    | Auth
    | Auth2
    | NX
    | XX
    | EX
    | PX
    | ExAt
    | PxAt
    | CH
    | ABSTTL
    | KeepTTL
    | Incr
    | Info
    | Channels
    | NumPat
    | NumSub
    | Now
    | Rev
    | WithCoord
    | WithDist
    | WithHash
    | Any
    | FromMember
    | FromLonLat
    | ByRadius
    | ByBox
    | ByLex
    | ByScore
    | StoreDist
    | To
    | Force
    | TimeOut
    | DB
    | Unload
    | Abort
    | Idx
    | MinMatchLen
    | WithMatchLen
    | Full
    | Delete
    | LibraryName
    | WithCode
    | Description
    | GetKeys
    | GetKeysAndFlags
    | Docs
    | FilterBy
    | Dump
    | Module
    | AclCat
    | Pattern
    | Doctor
    | Usage
    | Samples
    | Purge
    | Stats
    | Loadex
    | Config
    | Args
    | Asc
    | Desc
    | LCS
    | Strings
            }
        }
    }
}
// ASSERT: scan parse_nl_warning
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_type_implement_non_interface
// ASSERT: scan sema_undeclared_type_name
// ASSERT: scan sema_mismatched_types
// ASSERT: scan sema_invalid_binary_expr


