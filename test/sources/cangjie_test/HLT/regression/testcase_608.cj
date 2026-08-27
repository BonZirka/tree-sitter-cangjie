/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



public interface Schedule{}

public interface Job{
    func Run():Unit
}

class EntryID{}

public class Entry{
    public let ID: EntryID
    public var Schedule:Schedule
    public var WrappedJob:Job
    public var Job:Job
    init(id:EntryID,s:Schedule,w:Job,j:Job){
        this.ID = id
        this.Schedule = s
        this.Job = j
        this.WrappedJob = w

    }
}
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_accessibility
// ASSERT: scan sema_not_a_type


