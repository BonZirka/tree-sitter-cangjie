/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 

import std.ast.*

@Test
class LocalTest {
    @TestCase
    func setRefExprValidToken(): Unit {
        let refexpr = RefExpr(quote(refexpraa))
        @Expect(refexpr.commas.toString(),"")
        refexpr.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(refexpr.commas.toString(),",,")
    }

    @TestCase
    func setRefTypeValidToken(): Unit {
        let refType = RefType(quote(refTypeaa))
        @Expect(refType.commas.toString(),"")
        refType.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(refType.commas.toString(),",,")
    }

    @TestCase
    func setQualifiedTypeValidToken(): Unit {
        let qualifiedType = QualifiedType(quote(A.b<Int64, String>))
        @Expect(qualifiedType.commas.toString(),",")
        qualifiedType.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(qualifiedType.commas.toString(),",,")
    }

    @TestCase
    func setFuncTypeValidToken(): Unit {
        let funcType = FuncType(quote((Int64, Int32) -> Array<String>))
        @Expect(funcType.commas.toString(),",")
        funcType.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(funcType.commas.toString(),",,")
    }

    @TestCase
    func setEnumPatternValidToken(): Unit {
        let enumPattern = EnumPattern()
        @Expect(enumPattern.commas.toString(),"")
        enumPattern.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(enumPattern.commas.toString(),",,")
    }

    @TestCase
    func setTuplePatternValidToken(): Unit {
        let tuplePattern = TuplePattern()
        @Expect(tuplePattern.commas.toString(),"")
        tuplePattern.commas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(tuplePattern.commas.toString(),",,")
    }

    @TestCase
    func setStructDeclValidToken(): Unit {
        let input: Tokens = quote(
        class Data {
            var a: Int32
            init(a_: Int32) {
                a = a_
            }
        })
        let decl = parseDecl(input)
        var classDecl = match (decl as ClassDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        @Expect(classDecl.constraintCommas.toString(),"")
        classDecl.constraintCommas = Tokens(Array(2, repeat: Token(COMMA)))
        @Expect(classDecl.constraintCommas.toString(),",,")

        @Expect(classDecl.superTypeBitAnds.toString(),"")
        classDecl.superTypeBitAnds = Tokens(Array(1, repeat: Token(BITAND)))
        @Expect(classDecl.superTypeBitAnds.toString(),"&")
    }

    @TestCase
    func setPrimitiveTypeValidToken(): Unit {
        let typenode = PrimitiveType()
        var d = typenode.colon
        @Expect(typenode.colon.value,":")
        typenode.colon = Token(COLON)
        @Expect(typenode.colon.value,":")
    }

    @TestCase
    func setStructDeclTypeValidToken(): Unit {
        let input2: Tokens = quote(
        struct Data {
            var a: Int32
            init(a_: Int32) {
                a = a_
            }
        })
        let decl2 = parseDecl(input2)
        var structDecl = match (decl2 as StructDecl) {
            case Some(v) => v
            case None => throw Exception()
        }

        @Expect(structDecl.superTypeBitAnds.toString(),"")
        structDecl.superTypeBitAnds = Tokens(Array(1, repeat: Token(BITAND)))
        @Expect(structDecl.superTypeBitAnds.toString(),"&")
    }

    @TestCase
    func setInterfaceDeclValidToken(): Unit {
        let input3 = quote(
        public interface A <: T1 & T2 & T3 {
            func foo(res: String, count: int64) {
                var a = res
            }
       })
        let interfaceDecl = match (parseDecl(input3) as InterfaceDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        @Expect(interfaceDecl.superTypeBitAnds.toString(),"& &")
        interfaceDecl.superTypeBitAnds = Tokens(Array(1, repeat: Token(BITAND)))
        @Expect(interfaceDecl.superTypeBitAnds.toString(),"&")
    }

    @TestCase
    func setEnumDeclValidToken(): Unit {
        let input4 = quote(
        public enum TimeUnit<T1> <: I1 where T1 <: A {
            Year
            | Month(T1)
            func time() {}
        })
        let enumDecl = match (parseDecl(input4) as EnumDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        @Expect(enumDecl.superTypeBitAnds.toString(),"")
        enumDecl.superTypeBitAnds = Tokens(Array(1, repeat: Token(BITAND)))
        @Expect(enumDecl.superTypeBitAnds.toString(),"&")
    }

    @TestCase
    func setExtendDeclValidToken(): Unit {
        let input5 = quote(
        extend Foo <: I1 & I2 & I3 {
            public func f1(): Unit {}
            public func f2(): Unit {}
            public func f3(): Unit {}
        })
        let extendDecl = match (parseDecl(input5) as ExtendDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        @Expect(extendDecl.superTypeBitAnds.toString(),"& &")
        extendDecl.superTypeBitAnds = Tokens(Array(1, repeat: Token(BITAND)))
        @Expect(extendDecl.superTypeBitAnds.toString(),"&")
    }

    @TestCase
    func setGenericConstraintValidToken(): Unit {
        let genericConstraint = GenericConstraint()
        @Expect(genericConstraint.bitAnds.toString(),"")
        genericConstraint.bitAnds = Tokens(Array(2, repeat: Token(BITAND)))
        @Expect(genericConstraint.bitAnds.toString(),"& &")
    }
    @TestCase
    func setMatchCaseValidToken(): Unit {
        let matchCase = MatchCase()
        @Expect(matchCase.bitOrs.toString(),"")
        matchCase.bitOrs = Tokens(Array(2, repeat: Token(BITOR)))
        @Expect(matchCase.bitOrs.toString(),"| |")
    }

    @TestCase
    func setRefExprInvalidToken(): Unit {
        try {
            let refexpr = RefExpr(quote(refexpraa))
            refexpr.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setRefTypeInvalidToken(): Unit {
        try {
            let refType = RefType(quote(refTypeaa))
            refType.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setQualifiedTypeInvalidToken(): Unit {
        try {
            let qualifiedType = QualifiedType(quote(A.b<Int64, String>))
            qualifiedType.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setFuncTypeInvalidToken(): Unit {
        try {
            let funcType = FuncType(quote((Int64, Int32) -> Array<String>))
            funcType.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setEnumPatternInvalidToken(): Unit {
        try {
            let enumPattern = EnumPattern()
            enumPattern.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setTuplePatternInvalidToken(): Unit {
        try {
            let tuplePattern = TuplePattern()
            tuplePattern.commas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setClassDeclInvalidToken(): Unit {
        let input: Tokens = quote(
        class Data {
            var a: Int32
            init(a_: Int32) {
                a = a_
            }
        })
        let decl = parseDecl(input)
        var classDecl = match (decl as ClassDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        try {
            classDecl.constraintCommas = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COMMA"))
        }
    }

    @TestCase
    func setPrimitiveTypeInvalidToken(): Unit {
        try {
            let typenode = PrimitiveType()
            typenode.colon = Token(COMMA)
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be COLON"))
        }
    }

    @TestCase
    func setStructDeclInvalidToken(): Unit {
        let input2: Tokens = quote(
        struct Data {
            var a: Int32
            init(a_: Int32) {
                a = a_
            }
        })
        let decl2 = parseDecl(input2)
        var structDecl = match (decl2 as StructDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        try {
            structDecl.superTypeBitAnds = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITAND"))
        }
    }

    @TestCase
    func setInterfaceDeclInvalidToken(): Unit {
        let input3 = quote(
        public interface A <: T1 & T2 & T3 {
            func foo(res: String, count: int64) {
                var a = res
            }
       })
        let interfaceDecl = match (parseDecl(input3) as InterfaceDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        try {
            interfaceDecl.superTypeBitAnds = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITAND"))
        }
    }

    @TestCase
    func setEnumDeclInvalidToken(): Unit {
        let input4 = quote(
        public enum TimeUnit<T1> <: I1 where T1 <: A {
            Year
            | Month(T1)
            func time() {}
        })
        let enumDecl = match (parseDecl(input4) as EnumDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        try {
            enumDecl.superTypeBitAnds = Tokens(Array(2, repeat: Token(DOT)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITAND"))
        }
    }

    @TestCase
    func setExtendDeclInvalidToken(): Unit {
        let input5 = quote(
        extend Foo <: I1 & I2 & I3 {
            public func f1(): Unit {}
            public func f2(): Unit {}
            public func f3(): Unit {}
        })
        let extendDecl = match (parseDecl(input5) as ExtendDecl) {
            case Some(v) => v
            case None => throw Exception()
        }
        try {
            extendDecl.superTypeBitAnds = Tokens(Array(2, repeat: Token(BITOR)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITAND"))
        }
    }

    @TestCase
    func setMatchCaseInvalidToken(): Unit {
        try {
            let matchCase = MatchCase()
            matchCase.bitOrs = Tokens(Array(2, repeat: Token(COMMA)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITOR"))
        }
    }

    @TestCase
    func setGenericConstraintInvalidToken(): Unit {
        try {
            let genericConstraint = GenericConstraint()
            genericConstraint.bitAnds = Tokens(Array(2, repeat: Token(COMMA)))
        } catch (e: ASTException) {
            @Expect(e.message.contains("TokenKind should be BITAND"))
        }
    }
}
