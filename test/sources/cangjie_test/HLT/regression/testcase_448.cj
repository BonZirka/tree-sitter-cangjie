/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


package A

@Differentiable
struct Point {
    public let x: Float64
    public let y: Float64
    public let z: Float64

    @Differentiable
    public init(x1: Float64, y1: Float64, z1: Float64) {
        x = x1
        y = y1
        z = z1
    }
}

@Adjoint [primal: Point]
public func adjoint_init(x1: Float64, y1: Float64, z1: Float64)
{
    print("adjoint init for struct")
    (Point(x1, y1, z1), {sens: Point =>
        (sens.x, sens.y, sens.z)
    })
}

main() {
    return 0
}
// ASSERT: scan sema_accessibility_with_main_hint


