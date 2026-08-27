/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: create_jsonarray_data.cj
// EXEC-PIPE: %compiler %import-cangjie-stdx %cmp_opt  %f create_jsonarray_data.cj -o %output
// RUN-EXEC-PIPE: %run_stdx %output %run_args

import stdx.encoding.json.*

main(): Int64 {
    //init(list: Array<JsonValue>)
    var buff = [createjsonvalue(-8, 8, "-9")]
    var init1 = JsonArray(buff)
    var cases1 = Testjsonarray()
    if (cases1.testinit1(init1, exp_size: 1) != 0) {
        println("case 1")
        return 1
    }
    println("time1 add")
    if (cases1.testadd(createjsonvalue(-10, 10, "-20"), init1) != 0) //只添加一个
    {
        println("case 2")
        return 1
    }
    println("time2 add")
    if (cases1.testadd(createjsonvalue(-10, 10, "-20"), init1) != 0) //添加与已存在数据相同的数据
    {
        println("case 3")
        return 1
    }
    println("time3 add")
    if (cases1.testadd(createjsonvalue(-10, 20, "-30"), init1) != 0) //连续添加
    {
        println("case 4")
        return 1
    }
    var exp_data: Array<String> = ["{\"fieldTemp1\":-8,\"fieldTemp2\":8,\"fieldTemp3\":\"-9\"}",
        "{\"fieldTemp1\":-10,\"fieldTemp2\":10,\"fieldTemp3\":\"-20\"}",
        "{\"fieldTemp1\":-10,\"fieldTemp2\":10,\"fieldTemp3\":\"-20\"}",
        "{\"fieldTemp1\":-10,\"fieldTemp2\":20,\"fieldTemp3\":\"-30\"}"]
    if (cases1.testget(exp_data, init1) != 0) {
        println("case 5")
        return 1
    }
    if (cases1.testgetItems(exp_data, init1) != 0) {
        println("case 6")
        return 1
    }
    var exp_toString = "[{\"fieldTemp1\":-8,\"fieldTemp2\":8,\"fieldTemp3\":\"-9\"},{\"fieldTemp1\":-10,\"fieldTemp2\":10,\"fieldTemp3\":\"-20\"},{\"fieldTemp1\":-10,\"fieldTemp2\":10,\"fieldTemp3\":\"-20\"},{\"fieldTemp1\":-10,\"fieldTemp2\":20,\"fieldTemp3\":\"-30\"}]"
    if (cases1.testtoString(exp_toString, init1) != 0) {
        println("case 7")
        return 1
    }
    var exp_toJsonString = """
[
  {
    \"fieldTemp1\": -8,
    \"fieldTemp2\": 8,
    \"fieldTemp3\": \"-9\"
  },
  {
    \"fieldTemp1\": -10,
    \"fieldTemp2\": 10,
    \"fieldTemp3\": \"-20\"
  },
  {
    \"fieldTemp1\": -10,
    \"fieldTemp2\": 10,
    \"fieldTemp3\": \"-20\"
  },
  {
    \"fieldTemp1\": -10,
    \"fieldTemp2\": 20,
    \"fieldTemp3\": \"-30\"
  }
]"""

    if (cases1.testjsonString(exp_toJsonString, init1) != 0) {
        println("case 8")
        return 1
    }
    return 0
}
