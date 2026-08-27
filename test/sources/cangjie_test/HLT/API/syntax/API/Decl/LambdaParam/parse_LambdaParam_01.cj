/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: LambdaParam_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_LambdaParam_01() {
    let res = parseFile("./LambdaParam_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main(){
    { => 42 }
    { x => x + 1 }
    { x: Int64 => x + 1 }
    { a: Int64, b: Int64 => a + b }
    { x: Int64 =>
        let result = x * 2
        return result
    }
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    @Assert(maindecl.body.nodes.size, 5)

    var lambda_1 = (maindecl.body.nodes[0] as Lambda).getOrThrow()
    @Assert(lambda_1.params.params.size, 0)

    var lambda_2 = (maindecl.body.nodes[1] as Lambda).getOrThrow()
    var p2: LambdaParam = (lambda_2.params.params[0] as LambdaParam).getOrThrow()
    @Assert(p2.toString(), "x")
    @Assert(p2.name, "x")
    @Assert(p2.typeAnnotation.isNone())
    var Pos_2 = p2.getIdentifierPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [11i32, 7i32, 11i32, 8i32])

    var lambda_3 = (maindecl.body.nodes[2] as Lambda).getOrThrow()
    var p3: LambdaParam = (lambda_3.params.params[0] as LambdaParam).getOrThrow()
    @Assert(p3.toString(), "x: Int64")
    @Assert(p3.name, "x")
    @Assert(p3.typeAnnotation.isSome())
    @Assert(p3.typeAnnotation.getOrThrow() is AtomicType)
    var Pos_3 = p3.getIdentifierPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [12i32, 7i32, 12i32, 8i32])
    Pos_3 = p3.getTypeAnnotationColonPos().getOrThrow()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [12i32, 8i32, 12i32, 9i32])

    var lambda_4 = (maindecl.body.nodes[3] as Lambda).getOrThrow()
    var p4_1: LambdaParam = (lambda_4.params.params[0] as LambdaParam).getOrThrow()
    var p4_2: LambdaParam = (lambda_4.params.params[1] as LambdaParam).getOrThrow()
    @Assert(p4_1.toString(), "a: Int64")
    @Assert(p4_2.toString(), "b: Int64")
    @Assert(p4_1.name, "a")
    @Assert(p4_2.name, "b")
    @Assert(p4_1.typeAnnotation.isSome())
    @Assert(p4_1.typeAnnotation.getOrThrow() is AtomicType)
    @Assert(p4_2.typeAnnotation.isSome())
    @Assert(p4_2.typeAnnotation.getOrThrow() is AtomicType)
    var Pos_4 = p4_1.getIdentifierPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [13i32, 7i32, 13i32, 8i32])
    Pos_4 = p4_2.getIdentifierPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [13i32, 17i32, 13i32, 18i32])
    Pos_4 = p4_1.getTypeAnnotationColonPos().getOrThrow()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [13i32, 8i32, 13i32, 9i32])
    Pos_4 = p4_2.getTypeAnnotationColonPos().getOrThrow()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [13i32, 18i32, 13i32, 19i32])

    var lambda_5 = (maindecl.body.nodes[4] as Lambda).getOrThrow()
    var p5: LambdaParam = (lambda_5.params.params[0] as LambdaParam).getOrThrow()
    @Assert(p5.toString(), "x: Int64")
    @Assert(p5.name, "x")
    @Assert(p5.typeAnnotation.isSome())
    @Assert(p5.typeAnnotation.getOrThrow() is AtomicType)
    var Pos_5 = p5.getIdentifierPos()
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [14i32, 7i32, 14i32, 8i32])
    Pos_5 = p5.getTypeAnnotationColonPos().getOrThrow()
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [14i32, 8i32, 14i32, 9i32])
}
}