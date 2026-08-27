// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// LEVEL 0
 
// ERRCHECK: %compiler %diag_json %f
 
class A {
    static init(): Unit {}
    A(): Unit {}
    init(): Unit {}
    ~init() : Unit {}
}
main() {
    
}
 
// ASSERT: scan-4 parse_invalid_return_type