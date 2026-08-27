// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

public func fun1<KK>(a:KK) {
  a
}
public func fun2<KK>(a:Int64, b:KK) {
  b
}
public func fun3<T,U>(a:T, b:U) {
  b
}
public func fun4<T, U, KK>(a:T, b:U, c:KK) {
  c
}
main() {
  fun1<Int64>(1)
  fun2<Int32>(1, 2)
  fun3<Int64,Int32>(2, 3)
  fun4<Bool,Int32,Int8>(false,2, 3)
  0
}
