/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


main() {
    let a: Array<UInt8> = Array<UInt8>(1, repeat: 0)
    a[0] *= match (0) { case x =>  }
}
// ASSERT: scan parse_case_body_cannot_be_empty


