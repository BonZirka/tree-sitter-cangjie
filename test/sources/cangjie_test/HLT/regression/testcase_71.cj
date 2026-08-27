/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan 777

func getNumber_Tuple_1() {
    var n = (0, 0)
    func seven() {
      n = (7, 7)
    }
    func update() {
      seven()
    }
    update()
    print(n[0])
} 


func getNumber_Array() {
    var n = [0, 0]
    func update() {
      n = [7, 7]
    }
    update()
    print(n[0])
}

func getNumber_Array_1() {
    var n = [0, 0]
    func seven() {
      n = [7, 7]
    }
    func update() {
      seven()
    }
    update()
    print(n[0])
}

main(){
    getNumber_Array()
    getNumber_Array_1()
    getNumber_Tuple_1()
}
