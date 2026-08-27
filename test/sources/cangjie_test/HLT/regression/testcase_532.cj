/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


public interface Strbase <: Collection<Byte> & Equatable<String> & Comparable<String> & Hashable & T&String {  }
extend String <: Strbase {  }
main():Int64 {0}
// ASSERT: scan sema_interface_inherit_non_interface
// ASSERT: scan sema_undeclared_type_name


