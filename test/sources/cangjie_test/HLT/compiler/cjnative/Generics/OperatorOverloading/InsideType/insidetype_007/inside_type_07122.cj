/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

struct B {}

struct A<T> {
    public operator func !(): B {
        return B()
    }
    //        operator func +():B {return B()}
    public operator func -(): B {
        return B()
    }
    /*
    operator func ++():B {return B()}
    operator func --():B {return B()}
     */
    public operator func [](b: A<T>): B {
        return B()
    }
    // operator ** is illegal
    public operator func *(b: A<T>): B {
        return B()
    }
    public operator func /(b: A<T>): B {
        return B()
    }
    public operator func %(b: A<T>): B {
        return B()
    }
    // operator *& is illegal
    public operator func +(b: A<T>): B {
        return B()
    }
    public operator func -(b: A<T>): B {
        return B()
    }
    public operator func <<(b: A<T>): B {
        return B()
    }
    public operator func >>(b: A<T>): B {
        return B()
    }
    public operator func <(b: A<T>): B {
        return B()
    }
    public operator func <=(b: A<T>): B {
        return B()
    }
    public operator func >(b: A<T>): B {
        return B()
    }
    public operator func >=(b: A<T>): B {
        return B()
    }
    public operator func ==(b: A<T>): B {
        return B()
    }
    public operator func !=(b: A<T>): B {
        return B()
    }
    public operator func &(b: A<T>): B {
        return B()
    }
    public operator func ^(b: A<T>): B {
        return B()
    }
    public operator func |(b: A<T>): B {
        return B()
    }
    //     operator func ^^(b:A<T>):B {return B()}
    // operator +& is illegal
    // operator -& is illegal
}

main(): Int64 {
    var a: A<B> = A<B>()
    var b: A<B> = A<B>()
    var result: Array<(B)> = [b[a], b * a, b / a, b % a, b + a, b - a, b << a, b >> a, b < a, b <= a, b > a, b >= a,
        b == a, b != a, b & a, b ^ a, b | a, !b, !b, -b]
    return 0
}
