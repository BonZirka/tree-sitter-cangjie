/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan 0 1 2 3 

class ListNode {
    var data: Int64
    var next: Option<ListNode>

    init(data: Int64, next: Option<ListNode>) {
        this.data = data
        this.next = next
    }
}

main() {
    var head = ListNode(0, None)
    var tmp = head
    for (i in 1..5) {
        tmp.next = ListNode(i, None)
        tmp = tmp.next.getOrThrow()
    }
    tmp = head
    for (_ in 0..4) {
        print("${tmp.data} ")
        tmp = tmp.next.getOrThrow()
    }
    return 0
}
