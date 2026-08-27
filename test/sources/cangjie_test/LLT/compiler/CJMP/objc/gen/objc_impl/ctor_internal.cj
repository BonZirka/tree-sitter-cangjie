// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (CJNATIVE and not Windows) RUN-EXEC-0: %compiler %cmp_opt %f -o %output %compile_shared_lib_opt %overflowOpt %import_objc_interop
// (CJNATIVE and not Windows) RUN-EXEC-PIPE: %cat ./objc-gen/A.m | compare %f

/* SCAN-IN
- (id)initWithM:(M*)m {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
*/

package cjworld

import objc.lang.*

@ObjCMirror
public open class M {
    init()
}

@ObjCImpl
public class A <: M {
    @ForeignName["initWithM:"]
    internal init(m: M) {
    }
}
