// EXEC: %compiler %noColor %f  2>&1 | compare %f
// ASSERT: scan-not the Position is empty!

public open class Class457 <: Resource {
    public init() {}
    public func isClosed(): Bool { return true }
    public func close(): Unit {}
}
 
public func func468() {
    try { 
	
    } catch (e: Exception) {
		try (resource = Class457()) { 
        
		} 
    }
}
 
main(): Int64 {
    return 0;
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
