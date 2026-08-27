// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



package testpkg01

/**
* hello hover
* one
*/
public let one02 : Int32 = 1
public let two02 : Int32 = 2

/**
* hello hover
* pkg
*/
public class pkg02{
    public var aaa:Int32 = 1
    protected var one:Int32 = 1
    private var a:Int32 = 0
    public static var aa:Int32 = 0
    public init(a: Int32) {
        this.a = a
    }
    public func add1(a: Int32, b: Int32){
        return a + b + aa
    // "}" missed
    open func add2(a: Int32, b: Int32) {
        return a + b
    // "}" missed
    static func add3(a: Int32, b: Int32) {
        return a + b
    }
}

/* SCAN
error: unexpected modifier 'open' on function declaration in function body
  ==> class1.cj:29:5:
   | 
26 |     public func add1(a: Int32, b: Int32){
   |            ~~~~ in function
27 |         return a + b + aa
   | ...
29 |     open func add2(a: Int32, b: Int32) {
   |     ^^^^ ~~~~ on function declaration
   |     |
   |     unexpected modifier
   | 

error: unexpected modifier 'static' on function declaration in function body
  ==> class1.cj:32:5:
   | 
29 |     open func add2(a: Int32, b: Int32) {
   |          ~~~~ in function
30 |         return a + b
   | ...
32 |     static func add3(a: Int32, b: Int32) {
   |     ^^^^^^ ~~~~ on function declaration
   |     |
   |     unexpected modifier
   | 

error: unclosed delimiter: '{'
  ==> class1.cj:35:2:
   | 
26 |     public func add1(a: Int32, b: Int32){
   |                                         ~ to match this opening '{'
27 |         return a + b + aa
   | ...
35 | }
   |  ^ expected '}' here
   | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
