/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


class Point {
  Point(var x: Int64, var y: Int64) {
  }
}

foreign func testWithCallBack(clickfun: CFunc<(CPointer<UInt64>) -> Unit>): Unit

main(){
    let p: Point = Point(10, 20)
    let f2: CFunc<(CPointer<UInt64>) -> Unit> = {
      ptr => unsafe { print("${p.x}") }
    }

    unsafe { testWithCallBack(f2) }

    return 0
}
// ASSERT: scan sema_cfunc_cannot_capture_var
