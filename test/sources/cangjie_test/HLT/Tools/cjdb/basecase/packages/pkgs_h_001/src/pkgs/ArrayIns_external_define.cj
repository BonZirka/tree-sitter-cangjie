/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */


package pkgs

public enum Times {
    | Year|Year(Int32)
    | Month(Int32, Int64)
    public func f_1(par_1:Int32):Int32 {
        var var_m1 =par_1
        let var_m2 =par_1
        return var_m1
    }
}

public enum TimeUnit_e<X> {
    Year|Month|Day
    public func f_e1(par_1:X):X {
            var var_m1 =par_1
            let var_m2 =par_1
            return var_m1
        }

        public static func fun_se1(par_1:X) :X{
            var var_s1 =par_1
            return var_s1
        }
}

public var arrayInt32 : Array<Int32> = [321, 322, 10]
var array_empty: Array<Array<Int32>> = Array<Array<Int32>>()  //空array

public struct Rectangle_ex1 {
    public var width: Int32 = 10
    public var length: Int32 = 20
    public static var vc_1: Int32 = 79
    public static let vc_2: Int32 = 3    //静态成员变量
    private static var var_pri :Int32 =21
    public var arr_re : Array<Int64> = Array<Int64>(1000, {i => i+1})
    public init (width: Int32, length: Int32) {
        this.width = width
        this.length = length
    }

}


public open class Exter_Cla1 {
    public var width: Int32 = 10
    public var length: Int32 = 20
    public static var vc_1: Int32 = 79
    public static let vc_2: Int32 = 3    //静态成员变量
    private static var var_pri :Int32 =21
    public var rectangle_Ins: Rectangle_ex1 = Rectangle_ex1(100, 100)  //构造Rectangle_ex的实例对象
    public init (width: Int32, length: Int32) {
        this.width = width
        this.length = length
    }
    public static func fc_static() : Int32{
        var vf_1: Int32 = vc_1 +vc_2
        return  vf_1
    }
    public var arrayInt32_1 : Array<Int32> = [arrayInt32[0],-20,arrayInt32[2]]
    public var arrayInt32_d : Array<Array<Int32>> = [arrayInt32_1,arrayInt32]

   public func fc_001(array_1 :Array<Array<Int32>>, array_2 :Array<Array<Int32>>) : Array<Array<Array<Int32>>>{ //返回三维数组，第三个二维为空
       var array_t: Array<Array<Array<Int32>>> = [array_1,array_2,array_empty]
    return array_t
   }
}

public var arr : Array<Int64> = Array<Int64>(5000, {i => i+1})

public struct R1<T> {
    public static var var_R1 : Int16 = 10
    private var var_pri : Int16 = 12
    public var width: T
    public var length: T
    public let r_1: Int64 = C1<Int64>(-12).length
    // 构造函数
    public init (par_1: T, par_2: T) {
        this.width = par_1
        this.length = par_2
    }
    public init (side: T) {
        this(side, side)
    }
    public func fun_r1(par_1:T):T{
    var par_f1 = C1<Int32>(100).length
    let par_return = par_1
    return par_return
    }
}

public open class C1<T> {
    public var width: T
    public var length: T
    public init (side: T) {
        this(side, side)
    }
    public init (par_1: T, par_2: T) {
        this.width = par_1
        this.length = par_2
    }
}

public class cla_sub_1 <: Exter_Cla1{
 public var sub_v1: Int32
    public init(par_1:Int32){
        super(par_1,-69)
        sub_v1 = super.length
    }

}
public class cla_sub_2<T> <: C1<T>{
  public var chwidth: T
  public let chlength: T
  public init (a:T) {
    super(a)
    this.chwidth = super.width
    this.chlength = super.length
   }
}
