/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 

 
@C
 struct stu {
     var name :CString = unsafe { LibC.mallocCString("CJ_C") }
     var num :Int64 = -10
     var age :Int64 = 20
}
 
/* CPointer */
foreign func StringFromC(): CPointer<UInt8>
foreign func IntPointerFromC(): CPointer<Int32>
foreign func PointerFromShort(): CPointer<Int16>
foreign func PointerFromLong(): CPointer<Int64>
foreign func PointerFromFloat(): CPointer<Float32>
foreign func PointerFromDouble(): CPointer<Float64>
foreign func PointerFromVoid(): CPointer<Unit>
foreign func PointerFromArr(): CPointer<Int32>
//foreign func PointerFromPointer(): CPointer<CPointer<Int32>>
foreign func PointerFromPointer(): CPointer<Int32>
 
/* CFunc */
foreign func getFuncPtr_I(): CFunc<() -> Int32>
foreign func getFuncPtr_C(): CFunc<() -> UInt8>
foreign func getFuncPtr_S(): CFunc<() -> Int16>
foreign func getFuncPtr_L(): CFunc<() -> Int64>
foreign func getFuncPtr_F(): CFunc<() -> Float32>
foreign func getFuncPtr_D(): CFunc<() -> Float64>
foreign func getFuncPtr_I2(para_I : Int32) :Int32
 
/* type_basic */
foreign func IntFromC(): Int32
foreign func CharFromC(): Rune
foreign func structFromC(): stu
foreign func shortFromC(): Int16
foreign func longFromC(par_L:Int64): Int64
foreign func floatFromC(): Float32
foreign func doubleFromC(): Float64
@C
func myCallback(s: Int32): Int32 {
return s;
}
foreign func set_callback(cb: CFunc<(Int32) -> Int32>): Int32
 
unsafe main(): Int32
{
    var str = unsafe { LibC.mallocCString("a\"bc") }
    var str2 = str
    var str3 = str.toString()
 
    // CPointer_invoke
    var pc = unsafe{ StringFromC() }
    var pc_2 = pc.toUIntNative()
    var pc_3 = pc
    var pI = unsafe{ IntPointerFromC() }
    var ps = unsafe{ PointerFromShort() }
    var pl = unsafe{ PointerFromLong() }
    var pf = unsafe{ PointerFromFloat() }
    var pd = unsafe{ PointerFromDouble() }
    var pv = unsafe{ PointerFromVoid() }
    var parr = unsafe{ PointerFromArr() }
    var p_ptr = unsafe{ PointerFromPointer() }
    
    // CFunc_invoke
    var CF_I: CFunc<() -> Int32> = unsafe{ getFuncPtr_I() }
    var CF_I2 = unsafe{ getFuncPtr_I() }
    var CF_I3: CFunc<() -> Int32> = unsafe{ getFuncPtr_I() }
    var v1 = CF_I()
    var v2 = CF_I2
    var CF_C: CFunc<() -> UInt8> = unsafe{ getFuncPtr_C() }
    var CF_S: CFunc<() -> Int16> = unsafe{ getFuncPtr_S() }
    var CF_L: CFunc<() -> Int64> = unsafe{ getFuncPtr_L() }
    var CF_F: CFunc<() -> Float32> = unsafe{ getFuncPtr_F() }
    var CF_D: CFunc<() -> Float64> = unsafe{ getFuncPtr_D() }
    var CF_I4 = unsafe{ getFuncPtr_I2(56) }
 
    // type_basic
    var bt_I :Int32 = unsafe{ IntFromC() }
    var bt_C :Rune = unsafe{ CharFromC() }
    var bt_Struct :stu = unsafe{ structFromC() }
    var bt_S :Int16 = unsafe{ shortFromC() }
    var bt_L :Int64 = unsafe{ longFromC(10242358) }
    var bt_F :Float32 = unsafe{ floatFromC() }
    var bt_D :Float64 = unsafe{ doubleFromC() }
    var v4 = bt_C
    var v5 = unsafe { set_callback(myCallback) }
    var p_L = unsafe{ PointerFromLong() }
 

    var cfunc_1 = cfunc_para<CFunc<() -> Float64>>(CF_D) //Cfunc
    let cfunc_2 = cfunc_para_defalut<CFunc<() -> UInt8>>(CF_C) //Cfunc
    var return_Cfunc = cfunc_para_defalut<CFunc<() -> UInt8>>(CF_C, para_2:[CF_S,CF_S]) //Cfunc
    
    let cpoint_1 = cpointer_para(pd) //Cpointer
    let cpoint_2 = cpointer_para_defalut(pd, para_2:[pl,p_L]) //Cpointer
    var array_cpointer = cpointer_para_defalut(pd) //Cpointer

    return -1
}
 
var p_L2 = unsafe{ PointerFromLong() }
var CF_S2: CFunc<() -> Int16> = unsafe{ getFuncPtr_S() }
 
func cpointer_para(para_1:CPointer<Float64>){
    return para_1
}
 
func cpointer_para_defalut(para_1:CPointer<Float64>, para_2!:Array<CPointer<Int64>>=[p_L2]){
    return para_2
}
 
func cfunc_para<T>(para_1:T){
    return para_1
}
 
func cfunc_para_defalut<T>(para_1:T, para_2!:Array<CFunc<() -> Int16>>=[CF_S2]){
    return para_2
}
// ASSERT: scan sema_invalid_cfunc_return_type


