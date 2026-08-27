// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC-1: %compiler %noColor %n.cj > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

main()
{
	var a = "$q1"
	var a = "$var"
	var a = $1
	var a = $"cangjie"
	var a = $'s'
	$func
	 $let
	$is
	$as
	$Int8
	$Int16
	$Int32
	$Int64
	$IntNative
	$Float16
	$Float64
	$Rune
	$Bool
	$Nothing
	$Unit
	$struct
	$enum
	$CFunc
	$This
	$package
	$import
	$class
	$interface
	$func
	$macro
	$quote
}
