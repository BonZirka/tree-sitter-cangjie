/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 



foreign func getFuncPtr(): CFunc<(Int32, Int32) -> Int32>

@rename["getFuncPtr"]
foreign func bbb(): CFunc<(Int32, Int32) -> Int64>

foreign func getCangjieFuncPtr(cb: CFunc<(Int32, Int32) -> Int32>): Unit

foreign func getCangjieFuncPtr2(cb: CFunc<(Int32, Int32) -> Unit>): Unit

@C
func Add(a: Int32, b: Int32) : Int32 {
    println(127.toString())
    var c = unsafe{ getFuncPtr() }
    unsafe { c(a, b) }
    var d = unsafe{ bbb() }
    unsafe { d(a, b) }
    return a + b
}

var AddLambdaVar : CFunc<(Int32, Int32) -> Int32> = {x, y =>
    println(128.toString())
    var c = unsafe{ getFuncPtr() }
    unsafe { c(x, y) }
    var d = unsafe{ bbb() }
    unsafe { d(x, y) }
    x + y
}

let AddLambdaLet : CFunc<(Int32, Int32) -> Int32> = {x, y =>
    println(1288.toString())
    var c = unsafe{ getFuncPtr() }
    unsafe { c(x, y) }
    var d = unsafe{ bbb() }
    unsafe { d(x, y) }
    x + y
}

@C
func Cb1(a: Int32, b: Int32) : Unit {
    println("Cb1 first:" + a.toString())
    println("Cb1 second:" + b.toString())
}

var Cb1LambdaVar : CFunc<(Int32, Int32) -> Unit> = {x, y =>
    println("Cb1LambdaVar first:" + x.toString())
    println("Cb1LambdaVar second:" + y.toString())
}

let Cb1LambdaLet : CFunc<(Int32, Int32) -> Unit> = {x, y =>
     println("Cb1LambdaLet first:" + x.toString())
     println("Cb1LambdaLet second:" + y.toString())
}

unsafe main(): Int64{
    var add: CFunc<(Int32, Int32) -> Int32> = getFuncPtr()
    var bb = unsafe { add(1, 8) }
    println(bb.toString())
    getCangjieFuncPtr(add)

    println(888.toString())
    getCangjieFuncPtr(Add)

    println(999.toString())
    getCangjieFuncPtr(AddLambdaVar)

    println(9999.toString())
    getCangjieFuncPtr(AddLambdaLet)

    println(111.toString())
    var lmbaVar : CFunc<(Int32, Int32) -> Int32> = {x, y =>
      println(129.toString())
      var c = unsafe{ getFuncPtr() }
      unsafe { c(x, y) }
      var d = unsafe{ bbb() }
      unsafe { d(x, y) }
      x + y
    }

    let lmbaLet : CFunc<(Int32, Int32) -> Int32> = {x, y =>
        println(130.toString())
        var c = unsafe{ getFuncPtr() }
        unsafe { c(x, y) }
        var d = unsafe{ bbb() }
        unsafe { d(x, y) }
        x + y
    }

    if (getFuncPtr()(10, 100) != 110) {
        println(11231.toString())
    }
    unsafe {
        Add(5, 2)
        AddLambdaVar(6, 2)
        AddLambdaLet(7, 2)
        lmbaVar(8, 2)
        lmbaLet(9, 2)
    }


    var Cb1lmbaVar : CFunc<(Int32, Int32) -> Unit> = {x, y =>
       println("Cb1lmbaVar first:" + x.toString())
       println("Cb1lmbaVar second:" + y.toString())
    }

    let Cb1lmbaLet : CFunc<(Int32, Int32) -> Unit> = {x, y =>
       println("Cb1lmbaLet first:" + x.toString())
       println("Cb1lmbaLet second:" + y.toString())
    }
    getCangjieFuncPtr2(Cb1)
    getCangjieFuncPtr2(Cb1LambdaVar)
    getCangjieFuncPtr2(Cb1LambdaLet)
    getCangjieFuncPtr2(Cb1lmbaVar)
    getCangjieFuncPtr2(Cb1lmbaLet)
    unsafe {
        Cb1(5, 2)
        Cb1LambdaVar(6, 2)
        Cb1LambdaLet(7, 2)
        Cb1lmbaVar(6, 2)
        Cb1lmbaLet(7, 2)
    }

    return 0
}
// ASSERT: scan sema_undeclared_identifier


