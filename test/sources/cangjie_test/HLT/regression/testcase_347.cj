/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


class Math {
  public static func abs(a: Int64): Int64 {
    if (a >= 0) {
      return a
    } else {
      return -a
    }
  }

  public static func min(a: Int64, b: Int64): Int64 {
    if (a <= b) {
      return a
    } else {
      return b
    }
  }
}

class Main {

  /// CHECK-START: Int32 Main.oneArray(Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  //
  /// CHECK-START: Int32 Main.oneArray(Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func oneArray(a: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < a.size) {
      x += a[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.oneArrayAbs(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  //
  /// CHECK-START: Int32 Main.oneArrayAbs(Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func oneArrayAbs(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = Math.abs(b.size)
    while (i < a.size) {
      x += a[i]
      i++
    }
    return x
  }


  /// CHECK-START: Int32 Main.twoArrays(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  //
  /// CHECK-START: Int32 Main.twoArrays(Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func twoArrays(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < Math.min(a.size, b.size)) {
      x += a[i] + b[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.threeArrays(Array<Int32>, Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  //
  /// CHECK-START: Int32 Main.threeArrays(Array<Int32>, Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func threeArrays(a: Array<Int32>, b: Array<Int32>, c: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < Math.min(Math.min(a.size, b.size), c.size)) {
      x += a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[+= a[i] + b[i] + c[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.fourArrays(Array<Int32>, Array<Int32>, Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  //
  /// CHECK-START: Int32 Main.fourArrays(Array<Int32>, Array<Int32>, Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func fourArrays(a: Array<Int32>, b: Array<Int32>, c: Array<Int32>, d: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < Math.min(Math.min(a.size, b.size), Math.min(c.size, d.size))) {
      x += a[i] + b[i] + c[i] + d[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.oneArrayWithCleanup(Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop1:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop2:B\d+>> outer_loop:none
  //
  /// CHECK-EVAL: "<<Loop1>>" != "<<Loop2>>"
  //
  /// CHECK-START: Int32 Main.oneArrayWithCleanup(Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func oneArrayWithCleanup(a: Array<Int32>): Int32 {
    var x : Int32 = 0
    var n : Int64 = Math.min(4, a.size)
    var i : Int64 = 0
    while (i < n) {
      x += a[i]
      i++
    }
    i = n
    while (i < a.size) {
      x += a[i] * 10
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.twoArraysWithCleanup(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop1:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop1>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop2:B\d+>> outer_loop:none
  //
  /// CHECK-EVAL: "<<Loop1>>" != "<<Loop2>>"
  //
  /// CHECK-START: Int32 Main.twoArraysWithCleanup(Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func twoArraysWithCleanup(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var n : Int64 = Math.min(a.size, b.size)
    var i : Int64 = n - 1
    while (i >= 0) {
      x += a[i] + b[i]
      i--
    }
    i = n
    while (i < a.size) {
      x += a[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.threeArraysWithCleanup(Array<Int32>, Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop1:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop1>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop1>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop2:B\d+>> outer_loop:none
  //
  /// CHECK-EVAL: "<<Loop1>>" != "<<Loop2>>"
  //
  /// CHECK-START: Int32 Main.threeArraysWithCleanup(Array<Int32>, Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func threeArraysWithCleanup(a: Array<Int32>, b: Array<Int32>, c: Array<Int32>): Int32 {
    var x : Int32 = 0
    var n : Int64 = Math.min(a.size, Math.min(b.size, c.size))
    var i : Int64 = n - 1
    while (i >= 0) {
      x += a[i] + b[i] + c[i]
      i--
    }
    i = n
    while (i < a.size) {
      x += a[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.altLoopLogic(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  //
  /// CHECK-START: Int32 Main.altLoopLogic(Array<Int32>, Array<Int32>) BCE (after)
  /// CHECK-NOT: BoundsCheck
  /// CHECK-NOT: Deoptimize
  public static func altLoopLogic(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var n : Int64 = Math.min(a.size, b.size)
    var i : Int64 = n
    while (i > 0) {
      i--
      x += a[i] + b[i]
    }
    return x
  }

  /// CHECK-START: Int32 Main.hiddenMin(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop>>      outer_loop:none
  //
  /// CHECK-START: Int32 Main.hiddenMin(Array<Int32>, Array<Int32>) BCE (after)
  //
  // TODO: make this so
  public static func hiddenMin(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < a.size && i < b.size) {
      x += a[i] + b[i]
      i++
    }
    return x
  }

  /// CHECK-START: Int32 Main.hiddenMinWithCleanup(Array<Int32>, Array<Int32>) BCE (before)
  /// CHECK-DAG: BoundsCheck loop:<<Loop1:B\d+>> outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop1>>      outer_loop:none
  /// CHECK-DAG: BoundsCheck loop:<<Loop2:B\d+>> outer_loop:none
  //
  /// CHECK-EVAL: "<<Loop1>>" != "<<Loop2>>"
  //
  /// CHECK-START: Int32 Main.hiddenMinWithCleanup(Array<Int32>, Array<Int32>) BCE (after)
  //
  // TODO: make this so
  public static func hiddenMinWithCleanup(a: Array<Int32>, b: Array<Int32>): Int32 {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < a.size && i < b.size) {
      x += a[i] + b[i]
      i++
    }
    while (i < a.size) {
      x += a[i]
      i++
    }
    return x
  }

  public static func expectEquals(expected: Int32, result: Int32): Unit {
    if (expected != result) {
      throw Exception("Expected: " + expected.toString() + ", found: " + result.toString())
    }
  }

  public static func expectEquals(expected: Int64, result: Int64): Unit {
    if (expected != result) {
      throw Exception("Expected: " + expected.toString() + ", found: " + result.toString())
    }
  }
}

main(): Int64 {
  var a : Array<Int32> = [ 1, 2, 3, 4, 5 ]
  var b : Array<Int32> = [ 6, 7, 8, 9, 4, 2 ]
  var c : Array<Int32> = [ 1, 2, 3 ]
  var d : Array<Int32> = [ 8, 5, 3, 2 ]
  var e : Array<Int32> = [ ]

  Main.expectEquals(15, Main.oneArray(a))
  Main.expectEquals(36, Main.oneArray(b))
  Main.expectEquals(6,  Main.oneArray(c))
  Main.expectEquals(18, Main.oneArray(d))

  Main.expectEquals(15, Main.oneArrayAbs(a, e))
  Main.expectEquals(5,  Main.oneArrayAbs(a, d))

  Main.expectEquals(30, Main.twoArrays(a, a))
  Main.expectEquals(49, Main.twoArrays(a, b))
  Main.expectEquals(12, Main.twoArrays(a, c))
  Main.expectEquals(28, Main.twoArrays(a, d))

  Main.expectEquals(45, Main.threeArrays(a, a, a))
  Main.expectEquals(33, Main.threeArrays(a, b, c))
  Main.expectEquals(58, Main.threeArrays(a, b, d))
  Main.expectEquals(28, Main.threeArrays(a, c, d))

  Main.expectEquals(60, Main.fourArrays(a, a, a, a))
  Main.expectEquals(49, Main.fourArrays(a, b, c, d))

  Main.expectEquals(60, Main.oneArrayWithCleanup(a))
  Main.expectEquals(90, Main.oneArrayWithCleanup(b))
  Main.expectEquals(6,  Main.oneArrayWithCleanup(c))
  Main.expectEquals(18, Main.oneArrayWithCleanup(d))

  Main.expectEquals(30, Main.twoArraysWithCleanup(a, a))
  Main.expectEquals(49, Main.twoArraysWithCleanup(a, b))
  Main.expectEquals(21, Main.twoArraysWithCleanup(a, c))
  Main.expectEquals(33, Main.twoArraysWithCleanup(a, d))

  Main.expectEquals(45, Main.threeArraysWithCleanup(a, a, a))
  Main.expectEquals(42, Main.threeArraysWithCleanup(a, b, c))
  Main.expectEquals(63, Main.threeArraysWithCleanup(a, b, d))
  Main.expectEquals(37, Main.threeArraysWithCleanup(a, c, d))

  Main.expectEquals(30, Main.altLoopLogic(a, a))
  Main.expectEquals(49, Main.altLoopLogic(a, b))
  Main.expectEquals(12, Main.altLoopLogic(a, c))
  Main.expectEquals(28, Main.altLoopLogic(a, d))

  Main.expectEquals(30, Main.hiddenMin(a, a))
  Main.expectEquals(49, Main.hiddenMin(a, b))
  Main.expectEquals(12, Main.hiddenMin(a, c))
  Main.expectEquals(28, Main.hiddenMin(a, d))

  Main.expectEquals(30, Main.hiddenMinWithCleanup(a, a))
  Main.expectEquals(49, Main.hiddenMinWithCleanup(a, b))
  Main.expectEquals(21, Main.hiddenMinWithCleanup(a, c))
  Main.expectEquals(33, Main.hiddenMinWithCleanup(a, d))

  print("passed")
  return 0
}
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_expected_right_delimiter


