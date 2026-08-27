// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args
internal import std.ast.*

class MyVisitor <: Visitor {
    public override func visit(curNode: Node) {}

    /* ========== Expr ========= */
    public override func visit(curExpr: Expr) {}

    public override func visit(curExpr: IsExpr) {}

    public override func visit(curExpr: AsExpr) {}

    public override func visit(curExpr: LitConstExpr) {}

    public override func visit(curExpr: UnaryExpr) {}

    public override func visit(curExpr: BinaryExpr) {}

    public override func visit(curExpr: ParenExpr) {}

    public override func visit(curExpr: CallExpr) {}

    public override func visit(curExpr: RefExpr) {}

    public override func visit(curExpr: ReturnExpr) {}

    public override func visit(curExpr: AssignExpr) {}

    public override func visit(curExpr: MemberAccess) {}

    public override func visit(curExpr: IfExpr) {}

    public override func visit(curExpr: MatchExpr) {}

    public override func visit(curExpr: WhileExpr) {}

    public override func visit(curExpr: LambdaExpr) {}

    public override func visit(curExpr: SpawnExpr) {}

    public override func visit(curExpr: SynchronizedExpr) {}

    public override func visit(curExpr: TrailingClosureExpr) {}

    public override func visit(curExpr: TypeConvExpr) {}

    public override func visit(curExpr: ForInExpr) {}

    public override func visit(curExpr: PrimitiveTypeExpr) {}

    public override func visit(curExpr: ArrayLiteral) {}

    public override func visit(curExpr: TupleLiteral) {}

    public override func visit(curExpr: SubscriptExpr) {}

    public override func visit(curExpr: RangeExpr) {}

    public override func visit(curExpr: Block) {}

    public override func visit(curExpr: DoWhileExpr) {}

    public override func visit(curExpr: JumpExpr) {}

    public override func visit(curExpr: IncOrDecExpr) {}

    public override func visit(curExpr: TryExpr) {}

    public override func visit(curExpr: ThrowExpr) {}

    /* ========== Decl ========= */
    public override func visit(curDecl: Decl) {}

    public override func visit(curDecl: ClassDecl) {}

    public override func visit(curDecl: FuncDecl) {}

    public override func visit(curDecl: MainDecl) {}

    public override func visit(curDecl: StructDecl) {}

    public override func visit(curDecl: InterfaceDecl) {}

    public override func visit(curDecl: PropDecl) {}

    public override func visit(curDecl: VarDecl) {}

    public override func visit(curDecl: PrimaryCtorDecl) {}

    public override func visit(curDecl: EnumDecl) {}

    public override func visit(curDecl: TypeAliasDecl) {}

    public override func visit(curDecl: ExtendDecl) {}

    /* ========== Type ========= */
    public override func visit(curType: TypeNode) {}

    public override func visit(curType: RefType) {}

    public override func visit(curType: PrimitiveType) {}

    public override func visit(curType: FuncType) {}

    public override func visit(curType: ThisType) {}

    public override func visit(curType: ParenType) {}

    public override func visit(curType: QualifiedType) {}

    public override func visit(curType: TupleType) {}

    /* ========== Pattern ========= */
    public override func visit(curPattern: Pattern) {}

    public override func visit(curPattern: ConstPattern) {}

    public override func visit(curPattern: WildcardPattern) {}

    public override func visit(curPattern: VarPattern) {}

    public override func visit(curPattern: VarOrEnumPattern) {}

    public override func visit(curPattern: ExceptTypePattern) {}

    public override func visit(curPattern: TypePattern) {}

    public override func visit(curPattern: EnumPattern) {}

    public override func visit(curPattern: TuplePattern) {}
}

main(): Int64 {
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
