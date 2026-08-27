/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


interface update<T> {
    operator func !():T
}

extend Int32 <: update<Int32>{

}


interface R{
    func r():Int32
    operator func [](b:R):R
    operator fuv:R
    operator func !=(b:R):R
    operator func &(b:R):R
    operator func ^(b:R):R
    operator func |(b:R):R
}

class C <: R{
    public var rr : Int32
    public func r():Int32{
        rr
    }
    public init(r:Int32){
        this.rr = r
    }
    public operator func [](b:R):R{
        return C(-2)
    }
    
    public operator func !():R{
        return C(!(this.r()))
    }
    public operator func -():R{
        return C(-(this.r()))
    }

    public operator func **(b:R):R{
        var res : Int32 = 1
        var temp : Int32 = b.r()
        while (temp > 0) {
            res = res * this.r()
            temp = temp - 1
        }
        return C(res)
    }

    public operator func *(b:R):R{
        return C((this.r())*(b.r()))
    }
    public operator func /(b:R):R{
        return C((this.r())/(b.r()))
    }
    public operator func %(b:R):R{
        return C((this.r())%(b.r()))
    }

    public operator func +(b:R):R{
        return C((this.r())+(b.r()))
    }
    public operator func -(b:R):R{
       return C((this.r())-(b.r()))
    }

    public operator func <<(b:R):R{
        return C((this.r())<<(b.r()))
    }
    public operator func >>(b:R):R{
        return C((this.r())>>(b.r()))
    }

    public operator func <(b:R):R{
        if (this.r() < b.r()) {
            return C(this.r())
        }
        return C(b.r())
    }
    public operator func <=(b:R):R{
        if (this.r() <= b.r()) {
            return C(this.r())
        }
        return C(b.r())
    }
    public operator func >(b:R):R{
        if (this.r() > b.r()) {
            return C(this.r())
        }
        return C(b.r())
    }
    public operator func >=(b:R):R{
        if (this.r() >= b.r()) {
            return C(this.r())
        }
        return C(b.r())
    }

    public operator func ==(b:R):R{
        if (this.r() == b.r()) {
            return C(1)
        }
        return C(0)
    }
    public operator func !=(b:R):R{
        if (this.r() != b.r()) {
            return C(1)
        }
        return C(0)
    }

    public operator func &(b:R):R{
        return C((this.r())&(b.r()))
    }

    public operator func ^(b:R):R{
        return C((this.r())^(b.r()))
    }

    public operator func |(b:R):R{
        return C((this.r())|(b.r()))
    }


}

main():Int64{
    var zero : R = C(0)
    var one : R = C(1)
    nc !():R
    operator func -():R
    operator func **(b:R):R
    operator func *(b:R):R
    operator func /(b:R):R
    operator func %(b:R):R
    operator func +(b:R):R
    operator func -(b:R):R
    operator func <<(b:R):R
    operator func >>(b:R):R
    operator func <(b:R):R
    operator func <=(b:R):R
    operator func >(b:R):R
    operator func >=(b:R):R
    operator func ==(b:R)ar two : R = C(2)
    var three : R = C(3)
    var res : R = C(8192)
    var a : R = zero > one << one + three * two ** -zero[zero]
    var final : R =  three ^ one & res == zero > one << one + three * two ** -zero[zero]
    // 1. zero[zero] = C(-2)
    // 2. two ** -zero[zero] = C(4)
    // 3. one + three * two ** -zero[zero] = C(13)
    // 4. one << C(13) = res
    // 5. zero > C(13) = res
    // 6. res == res = one , if 1-5 got any error, 5`s result will be zero.
    // 7. one & one = one , one & zero = zero. So we choose one here.
    // 8. three ^ one = two , one ^ zero = three. So we choose three here.
    // 9. two | two = two , two | three = three. So we choose two here.
    // 10. zero ^^ two = C(123), so final.r = 123
    if (final.r() != 2) {
        return 1
    }

    var first : R
    first = !-C(1) //  first.r == 10
    if (first.r() != 0) {
        return 2
    }

    var second : R
    second = C(2) * C(4) % C(5) / C(2) 
    if (second.r() != 1) {
        return 3
    }

    var third : R
    third = C(-1) + C(5) - C(-2)
    if (third.r() != 6) {
        return 4
    }

    var fourth : R
    fourth = C(1) << C(3) >> C(2)
    if (fourth.r() != 2) {
        return 5
    }

    return 0
}
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_illegal_modifier_in_scope
// ASSERT: scan parse_missing_body


