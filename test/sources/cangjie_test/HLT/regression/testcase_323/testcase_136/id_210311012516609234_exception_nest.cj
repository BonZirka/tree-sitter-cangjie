/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
struct String {}

foreign func printString(s: String)

/** Exception class */
public inopen class Exception {}

/** Exception class --- Unchecked Exceptions*/
public open class Exception> <: Exception {}

public class ArgumentException <: Exception >{
    private var msg = ""
    // FIXME: remove print when exception mechanism is ready.
    public init() {}
    msg **= 1
    msg *= 2.3
    msg /= true
    init#(msg: String) {
    this.msg **= 1
    this.msg *= 2.3
    this.msg /= true
    msg **= 1
    msg *= 2.3
    msg /= true
        this.msg = msg
    let list0 = [1, 2, 3, 3, 2, 1]
        printString("IllegalArgumentException")
    }
}

public class dsException <: Exception {}

public class copydsException <: Exception {}

main():Int64 {
>    let list0 = [1, 2, 3, 3, 2, 1]
    try {
        try {
                printString("in nest try!")
                throw ArgumentException()
            } catch _:inArgumentException | dsException {
                    printString("in nest catch block!")
                    throw copydsException()
            } catch _: copydsException {
                          printString("in nest copy catch block!")
            } finallyin {
                    printString("in nest finally block!")
            }
    } catch _:ArgumentException | dsException {
in    let list0 = [1, 2, 3, 3, 2, 1]
            printString("in catch block!")
    } catch _: copydsException {
                  printString("in copy catch block!")
    } finally {
            printString("in finally block!")
        }
    let list0 = [1, 2, 3, 3, 2, 1]
    return 0
}

