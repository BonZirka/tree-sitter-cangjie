/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

public open class ASTVisitor {
    private var isStop = false
    public func walk(root: SyntaxTreeNode): Unit {
        if (isStop) {
            return
        }
        match (preAction(root)) {
            case Continue => visit(root)
            case Skip => return
            case Stop =>
                isStop = true
                return
        }
        if (isStop) {
            return
        }
        match (postAction(root)) {
            case Continue => return
            case Stop =>
                isStop = true
                return
        }
    }

    private func visit(node: SyntaxTreeNode) {
        for (comment in node.comments) {
            walk(comment)
        }
        match (node) {
            case binaryExpr: BinaryExpr => visitBinaryExpr(binaryExpr)
            case varDecl: VarDecl => visitVarDecl(varDecl)
            case symbolRef: SymbolRef => visitSymbolRef(symbolRef)
            case annotation: Annotation => visitAnnotation(annotation)
            case argument: Argument => visitArgument(argument)
            case arrayLiteral: ArrayLiteral => visitArrayLiteral(arrayLiteral)
            case asExpr: AsExpr => visitAsExpr(asExpr)
            case assignExpr: AssignExpr => visitAssignExpr(assignExpr)
            case atomicType: AtomicType => visitAtomicType(atomicType)
            case block: Block => visitBlock(block)
            case body: Body => visitBody(body)
            case breakExpr: BreakExpr => visitBreakExpr(breakExpr)
            case callExpr: CallExpr => visitCallExpr(callExpr)
            case catchPattern: CatchPattern => visitCatchPattern(catchPattern)
            case classDecl: ClassDecl => visitClassDecl(classDecl)
            case comment: Comment => return
            case compositeType: CompositeType => visitCompositeType(compositeType)
            case conjunctionCondition: ConjunctionCondition => visitConjunctionCondition(conjunctionCondition)
            case constPattern: ConstPattern => visitConstPattern(constPattern)
            case continueExpr: ContinueExpr => visitContinueExpr(continueExpr)
            case disjunctionCondition: DisjunctionCondition => visitDisjunctionCondition(disjunctionCondition)
            case doWhileExpr: DoWhileExpr => visitDoWhileExpr(doWhileExpr)
            case enumConstructor: EnumConstructor => visitEnumConstructor(enumConstructor)
            case enumDecl: EnumDecl => visitEnumDecl(enumDecl)
            case enumPattern: EnumPattern => visitEnumPattern(enumPattern)
            case extendDecl: ExtendDecl => visitExtendDecl(extendDecl)
            case forInExpr: ForInExpr => visitForInExpr(forInExpr)
            case funcDecl: FuncDecl => visitFuncDecl(funcDecl)
            case funcParam: FuncParam => visitFuncParam(funcParam)
            case funcType: FuncType => visitFuncType(funcType)
            case genericConstraint: GenericConstraint => visitGenericConstraint(genericConstraint)
            case genericConstraints: GenericConstraints => visitGenericConstraints(genericConstraints)
            case genericParam: GenericParam => visitGenericParam(genericParam)
            case ifExpr: IfExpr => visitIfExpr(ifExpr)
            case importAlias: ImportAlias => visitImportAlias(importAlias)
            case importAll: ImportAll => visitImportAll(importAll)
            case importContent: ImportContent => visitImportContent(importContent)
            case importList: ImportList => visitImportList(importList)
            case importMulti: ImportMulti => visitImportMulti(importMulti)
            case importSingle: ImportSingle => visitImportSingle(importSingle)
            case incOrDecExpr: IncOrDecExpr => visitIncOrDecExpr(incOrDecExpr)
            case interfaceDecl: InterfaceDecl => visitInterfaceDecl(interfaceDecl)
            case isExpr: IsExpr => visitIsExpr(isExpr)
            case lambda: Lambda => visitLambda(lambda)
            case lambdaParam: LambdaParam => visitLambdaParam(lambdaParam)
            case letPattern: LetPattern => visitLetPattern(letPattern)
            case litConstExpr: LitConstExpr => visitLitConstExpr(litConstExpr)
            case litConstRuneExpr: LitConstRuneExpr => visitLitConstRuneExpr(litConstRuneExpr)
            case litConstStrExpr: LitConstStrExpr => visitLitConstStrExpr(litConstStrExpr)
            case macroDecl: MacroDecl => visitMacroDecl(macroDecl)
            case macroExpandDecl: MacroExpandDecl => visitMacroExpandDecl(macroExpandDecl)
            case macroExpandExpr: MacroExpandExpr => visitMacroExpandExpr(macroExpandExpr)
            case macroExpandParam: MacroExpandParam => visitMacroExpandParam(macroExpandParam)
            case mainDecl: MainDecl => visitMainDecl(mainDecl)
            case matchCase: MatchCase => visitMatchCase(matchCase)
            case matchExpr: MatchExpr => visitMatchExpr(matchExpr)
            case memberAccess: MemberAccess => visitMemberAccess(memberAccess)
            case modifier: Modifier => visitModifier(modifier)
            case optionalExpr: OptionalExpr => visitOptionalExpr(optionalExpr)
            case packageNode: Package => visitPackage(packageNode)
            case packageHeader: PackageHeader => visitPackageHeader(packageHeader)
            case parameterList: ParameterList => visitParameterList(parameterList)
            case parenCondition: ParenCondition => visitParenCondition(parenCondition)
            case parenExpr: ParenExpr => visitParenExpr(parenExpr)
            case parenType: ParenType => visitParenType(parenType)
            case prefixType: PrefixType => visitPrefixType(prefixType)
            case propDecl: PropDecl => visitPropDecl(propDecl)
            case propGetterOrSetter: PropGetterOrSetter => visitPropGetterOrSetter(propGetterOrSetter)
            case quoteExpr: QuoteExpr => visitQuoteExpr(quoteExpr)
            case quoteInterpolationExpr: QuoteInterpolationExpr => visitQuoteInterpolationExpr(quoteInterpolationExpr)
            case quoteToken: QuoteToken => visitQuoteToken(quoteToken)
            case rangeExpr: RangeExpr => visitRangeExpr(rangeExpr)
            case returnExpr: ReturnExpr => visitReturnExpr(returnExpr)
            case sourceFile: SourceFile => visitSourceFile(sourceFile)
            case spawnExpr: SpawnExpr => visitSpawnExpr(spawnExpr)
            case staticInit: StaticInit => visitStaticInit(staticInit)
            case strInterpolationContent: StrInterpolationContent => visitStrInterpolationContent(
                strInterpolationContent)
            case structDecl: StructDecl => visitStructDecl(structDecl)
            case subscriptExpr: SubscriptExpr => visitSubscriptExpr(subscriptExpr)
            case throwExpr: ThrowExpr => visitThrowExpr(throwExpr)
            case trailingClosureExpr: TrailingClosureExpr => visitTrailingClosureExpr(trailingClosureExpr)
            case tryCatch: TryCatch => visitTryCatch(tryCatch)
            case tupleLiteral: TupleLiteral => visitTupleLiteral(tupleLiteral)
            case tuplePattern: TuplePattern => visitTuplePattern(tuplePattern)
            case tupleType: TupleType => visitTupleType(tupleType)
            case typeAlias: TypeAlias => visitTypeAlias(typeAlias)
            case typeConvExpr: TypeConvExpr => visitTypeConvExpr(typeConvExpr)
            case typePattern: TypePattern => visitTypePattern(typePattern)
            case unaryExpr: UnaryExpr => visitUnaryExpr(unaryExpr)
            case unsafeExpr: UnsafeExpr => visitUnsafeExpr(unsafeExpr)
            case varOrEnumPattern: VarOrEnumPattern => visitVarOrEnumPattern(varOrEnumPattern)
            case varPattern: VarPattern => visitVarPattern(varPattern)
            case varrayExpr: VArrayExpr => visitVArrayExpr(varrayExpr)
            case varrayType: VArrayType => visitVArrayType(varrayType)
            case whileExpr: WhileExpr => visitWhileExpr(whileExpr)
            case wildcardPattern: WildcardPattern => visitWildcardPattern(wildcardPattern)
            case synchronizedExpr: SynchronizedExpr => visitSynchronizedExpr(synchronizedExpr)
            case featuresDirective: FeaturesDirective => visitFeaturesDirective(featuresDirective)
            case featuresSet: FeaturesSet => visitFeaturesSet(featuresSet)
            case featureId: FeatureId => visitFeatureId(featureId)
            case _ => throw Exception()
        }
    }

    private func walkAll<T>(nodes: Array<T>) where T <: SyntaxTreeNode {
        for (node in nodes) {
            walk(node)
        }
    }

    private func walkOptional<T>(node: Option<T>) where T <: SyntaxTreeNode {
        if (let Some(v) <- node) {
            walk(v)
        }
    }

    private func visitMacroOrMainDeclChildren(annotations: Array<Annotation>, modifiers: Array<Modifier>,
        params: ParameterList, retTyAnnotation: Option<TypeAnnotation>, body: Block) {
        for (a in annotations) {
            walk(a)
        }
        for (m in modifiers) {
            walk(m)
        }
        walk(params)
        if (let Some(retTy) <- retTyAnnotation) {
            walk(retTy)
        }
        walk(body)
    }

    private func visitMacroExpandDeclOrParamChildren(annotations: Array<Annotation>, modifiers: Array<Modifier>,
        calleeMacro: Expr, macroInputs: MacroExpandInput) {
        for (a in annotations) {
            walk(a)
        }
        for (m in modifiers) {
            walk(m)
        }
        walk(calleeMacro)
        // macroAttrs is Tokens, no need to walk
        match (macroInputs) {
            case MacroExpandInput.WithoutParens(decl) => walk(decl)
            case MacroExpandInput.WithParens(_) => return
            case _ => throw Exception("VisitException: Failed to match the enumeration value")
        }
    }

    private func visitBinaryExpr(node: BinaryExpr) {
        walk(node.lhs)
        walk(node.rhs)
    }

    private func visitVarDecl(node: VarDecl) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        walk(node.pattern)
        if (let Some(tyAnnotation) <- node.tyAnnotation) {
            walk(tyAnnotation)
        }
        if (let Some(initializer) <- node.initializer) {
            walk(initializer)
        }
    }

    private func visitSymbolRef(node: SymbolRef) {
        for (t in node.typeArguments) {
            walk(t)
        }
    }

    private func visitAnnotation(node: Annotation) {
        for (arg in node.arguments) {
            walk(arg)
        }
    }

    private func visitArgument(node: Argument) {
        walk(node.value)
    }

    private func visitArrayLiteral(node: ArrayLiteral) {
        for (element in node.elements) {
            walk(element)
        }
    }

    private func visitAsExpr(node: AsExpr) {
        walk(node.srcVal)
        walk(node.targetTypeAnnotation)
    }

    private func visitAssignExpr(node: AssignExpr) {
        walk(node.lhs)
        walk(node.rhs)
    }

    private func visitAtomicType(node: AtomicType) {
        // kind is AtomicTypeKind, no need to walk
    }

    private func visitBlock(node: Block) {
        for (n in node.nodes) {
            walk(n)
        }
    }

    private func visitBody(node: Body) {
        for (decl in node.memberDecls) {
            walk(decl)
        }
    }

    private func visitBreakExpr(node: BreakExpr) {
        // no child nodes to walk
    }

    private func visitCallExpr(node: CallExpr) {
        walk(node.callee)
        for (arg in node.arguments) {
            walk(arg)
        }
    }

    private func visitCatchPattern(node: CatchPattern) {
        walk(node.pattern)
        for (ty in node.exceptionType) {
            walk(ty)
        }
    }

    private func visitClassDecl(node: ClassDecl) {
        walkAll(node.annotations)
        walkAll(node.modifiers)
        walkAll(node.genericParams)
        walkAll(node.superTyAnnotations)
        walkOptional(node.genericConstraints)
        walk(node.body)
    }

    private func visitCompositeType(node: CompositeType) {
        for (arg in node.typeArguments) {
            walk(arg)
        }
    }

    private func visitConjunctionCondition(node: ConjunctionCondition) {
        for (cond in node.cond) {
            match (cond) {
                case AtomicCondition.LetPatternCondition(letPattern) => walk(letPattern)
                case AtomicCondition.Expression(expr) => walk(expr)
                case AtomicCondition.ParenConditionConstructor(parenCondition) => walk(parenCondition)
                case _ => throw Exception("VisitException: Failed to match the enumeration value")
            }
        }
    }

    private func visitConstPattern(node: ConstPattern) {
        walk(node.litConstExpr)
    }

    private func visitContinueExpr(node: ContinueExpr) {
        // no child nodes to walk
    }

    private func visitDisjunctionCondition(node: DisjunctionCondition) {
        for (cond in node.cond) {
            walk(cond)
        }
    }

    private func visitDoWhileExpr(node: DoWhileExpr) {
        walk(node.body)
        walk(node.condition)
    }

    private func visitEnumConstructor(node: EnumConstructor) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        for (ty in node.paramTyAnnotations) {
            walk(ty)
        }
    }

    private func visitEnumDecl(node: EnumDecl) {
        walkAll(node.annotations)
        walkAll(node.modifiers)
        walkAll(node.genericParams)
        walkAll(node.superTyAnnotations)
        walkOptional(node.genericConstraints)
        walk(node.body)
    }

    private func visitEnumPattern(node: EnumPattern) {
        walk(node.enumConstructor)
        if (let Some(enumType) <- node.enumType) {
            walk(enumType)
        }
        for (pattern in node.subPatterns) {
            walk(pattern)
        }
    }

    private func visitExtendDecl(node: ExtendDecl) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        for (param in node.genericParams) {
            walk(param)
        }
        walk(node.extendedTyAnnotation)
        for (superTy in node.superTyAnnotations) {
            walk(superTy)
        }
        if (let Some(constraints) <- node.genericConstraints) {
            walk(constraints)
        }
        walk(node.body)
    }

    private func visitForInExpr(node: ForInExpr) {
        walk(node.pattern)
        walk(node.expr)
        if (let Some(guard) <- node.patternGuard) {
            walk(guard)
        }
        walk(node.body)
    }

    private func visitFuncDecl(node: FuncDecl) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        for (param in node.genericParams) {
            walk(param)
        }
        if (let Some(constraints) <- node.genericConstraints) {
            walk(constraints)
        }
        walk(node.params)
        if (let Some(retTy) <- node.retTyAnnotation) {
            walk(retTy)
        }
        if (let Some(body) <- node.body) {
            walk(body)
        }
    }

    private func visitFuncParam(node: FuncParam) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        walk(node.typeAnnotation)
        if (let Some(defaultValue) <- node.defaultValue) {
            walk(defaultValue)
        }
    }

    private func visitFuncType(node: FuncType) {
        for (ty in node.paramTypes) {
            walk(ty)
        }
        walk(node.retType)
    }

    private func visitGenericConstraint(node: GenericConstraint) {
        walk(node.typeArgument)
        for (bound in node.upperBounds) {
            walk(bound)
        }
    }

    private func visitGenericConstraints(node: GenericConstraints) {
        for (constraint in node.constraints) {
            walk(constraint)
        }
    }

    private func visitGenericParam(node: GenericParam) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
    }

    private func visitIfExpr(node: IfExpr) {
        walk(node.condition)
        walk(node.ifBlock)
        if (let Some(elseIf) <- node.elseIf) {
            walk(elseIf)
        }
        if (let Some(elseBlock) <- node.elseBlock) {
            walk(elseBlock)
        }
    }

    private func visitImportAlias(node: ImportAlias) {
        // aliasName and identifier are String, no need to walk
    }

    private func visitImportAll(node: ImportAll) {
        // prefix is String, no need to walk
    }

    private func visitImportContent(node: ImportContent) {
        // prefix is String, no need to walk
    }

    private func visitImportList(node: ImportList) {
        if (let Some(modifier) <- node.modifier) {
            walk(modifier)
        }
        walk(node.contents)
    }

    private func visitImportMulti(node: ImportMulti) {
        for (content in node.contents) {
            walk(content)
        }
    }

    private func visitImportSingle(node: ImportSingle) {
        // identifier is String, no need to walk
    }

    private func visitIncOrDecExpr(node: IncOrDecExpr) {
        walk(node.operand)
    }

    private func visitInterfaceDecl(node: InterfaceDecl) {
        walkAll(node.annotations)
        walkAll(node.modifiers)
        walkAll(node.genericParams)
        walkAll(node.superTyAnnotations)
        walkOptional(node.genericConstraints)
        walk(node.body)
    }

    private func visitIsExpr(node: IsExpr) {
        walk(node.srcVal)
        walk(node.targetTypeAnnotation)
    }

    private func visitLambda(node: Lambda) {
        walk(node.params)
        for (n in node.body) {
            walk(n)
        }
    }

    private func visitLambdaParam(node: LambdaParam) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        if (let Some(tyAnnotation) <- node.typeAnnotation) {
            walk(tyAnnotation)
        }
    }

    private func visitLetPattern(node: LetPattern) {
        for (pattern in node.patterns) {
            walk(pattern)
        }
        walk(node.expr)
    }

    private func visitLitConstExpr(node: LitConstExpr) {
        // kind and rawValue are primitive types, no need to walk
    }

    private func visitLitConstRuneExpr(node: LitConstRuneExpr) {
        // isSingleQuote is Bool, no need to walk
    }

    private func visitLitConstStrExpr(node: LitConstStrExpr) {
        // delimiterNum, isSingleQuote, strKind are primitive types
        for (part in node.strPartExprs) {
            match (part) {
                case StrLiteralPart.LitConstPart(lit) => walk(lit)
                case StrLiteralPart.StrInterpolation(strInterpolation) => walk(strInterpolation)
                case _ => throw Exception("VisitException: Failed to match the enumeration value")
            }
        }
    }

    private func visitMacroDecl(node: MacroDecl) {
        visitMacroOrMainDeclChildren(node.annotations, node.modifiers, node.params, node.retTyAnnotation, node.body)
    }

    private func visitMacroExpandDecl(node: MacroExpandDecl) {
        visitMacroExpandDeclOrParamChildren(node.annotations, node.modifiers, node.calleeMacro, node.macroInputs)
    }

    private func visitMacroExpandExpr(node: MacroExpandExpr) {
        walk(node.calleeMacro)
        // macroAttrs is Tokens, no need to walk
        match (node.macroInputs) {
            case MacroExpandInput.WithoutParens(decl) => walk(decl)
            case MacroExpandInput.WithParens(_) => return
            case _ => throw Exception("VisitException: Failed to match the enumeration value")
        }
    }

    private func visitMacroExpandParam(node: MacroExpandParam) {
        visitMacroExpandDeclOrParamChildren(node.annotations, node.modifiers, node.calleeMacro, node.macroInputs)
    }

    private func visitMainDecl(node: MainDecl) {
        visitMacroOrMainDeclChildren(node.annotations, node.modifiers, node.params, node.retTyAnnotation, node.body)
    }

    private func visitMatchCase(node: MatchCase) {
        if (let Some(caseCond) <- node.caseCond) {
            walk(caseCond)
        }
        for (pattern in node.patterns) {
            walk(pattern)
        }
        if (let Some(patternGuardCond) <- node.patternGuardCond) {
            walk(patternGuardCond)
        }
        for (n in node.body) {
            walk(n)
        }
    }

    private func visitMatchExpr(node: MatchExpr) {
        if (let Some(selector) <- node.selector) {
            walk(selector)
        }
        for (mCase in node.matchCases) {
            walk(mCase)
        }
    }

    private func visitMemberAccess(node: MemberAccess) {
        walk(node.base)
        walk(node.field)
    }

    private func visitModifier(node: Modifier) {
        // kind is ModifierKind, no need to walk
    }

    private func visitOptionalExpr(node: OptionalExpr) {
        walk(node.base)
    }

    private func visitPackage(node: Package) {
        // name is String, isMacroPkg is Bool, no need to walk
        for (file in node.srcFile) {
            walk(file)
        }
    }

    private func visitPackageHeader(node: PackageHeader) {
        if (let Some(accessModifier) <- node.accessModifier) {
            walk(accessModifier)
        }
        // isMacroPkg is Bool, packageNameIdentifiers are String
    }

    private func visitParameterList(node: ParameterList) {
        for (param in node.params) {
            walk(param)
        }
    }

    private func visitParenCondition(node: ParenCondition) {
        walk(node.cond)
    }

    private func visitParenExpr(node: ParenExpr) {
        walk(node.subExpr)
    }

    private func visitParenType(node: ParenType) {
        walk(node.subType)
    }

    private func visitPrefixType(node: PrefixType) {
        walk(node.base)
        // prefixTypeOpKind is PrefixTypeOpKind, no need to walk
    }

    private func visitPropDecl(node: PropDecl) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        // name is String, isMut is Bool, no need to walk
        walk(node.tyAnnotation)
        if (let Some(getter) <- node.getter) {
            walk(getter)
        }
        if (let Some(setter) <- node.setter) {
            walk(setter)
        }
    }

    private func visitPropGetterOrSetter(node: PropGetterOrSetter) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        walk(node.block)
    }

    private func visitQuoteExpr(node: QuoteExpr) {
        for (content in node.tokensOrRefExpr) {
            match (content) {
                case QuoteExprContent.TokenPart(tks) => walk(tks)
                case QuoteExprContent.QuoteInterpolation(quoteInterpolation) => walk(quoteInterpolation)
                case _ => throw Exception("VisitException: Failed to match the enumeration value")
            }
        }
    }

    private func visitQuoteInterpolationExpr(node: QuoteInterpolationExpr) {
        walk(node.expr)
    }

    private func visitQuoteToken(node: QuoteToken) {
        // content is Tokens, no need to walk
    }

    private func visitRangeExpr(node: RangeExpr) {
        if (let Some(start) <- node.start) {
            walk(start)
        }
        if (let Some(end) <- node.end) {
            walk(end)
        }
        if (let Some(step) <- node.step) {
            walk(step)
        }
    }

    private func visitReturnExpr(node: ReturnExpr) {
        if (let Some(retVal) <- node.retVal) {
            walk(retVal)
        }
    }

    private func visitSourceFile(node: SourceFile) {
        // name and path are String, no need to walk
        if (let Some(pkgHeader) <- node.pkgHeader) {
            walk(pkgHeader)
        }
        for (importList in node.importLists) {
            walk(importList)
        }
        for (decl in node.topLevelDecls) {
            walk(decl)
        }
    }

    private func visitSpawnExpr(node: SpawnExpr) {
        if (let Some(threadContext) <- node.threadContext) {
            walk(threadContext)
        }
        walk(node.trailingLambdaExpr)
    }

    private func visitStaticInit(node: StaticInit) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        walk(node.body)
    }

    private func visitStrInterpolationContent(node: StrInterpolationContent) {
        walk(node.interpolationBlock)
    }

    private func visitStructDecl(node: StructDecl) {
        walkAll(node.annotations)
        walkAll(node.modifiers)
        walkAll(node.genericParams)
        walkAll(node.superTyAnnotations)
        walkOptional(node.genericConstraints)
        walk(node.body)
    }

    private func visitSubscriptExpr(node: SubscriptExpr) {
        walk(node.base)
        for (index in node.indexs) {
            walk(index)
        }
    }

    private func visitThrowExpr(node: ThrowExpr) {
        walk(node.throwVal)
    }

    private func visitTrailingClosureExpr(node: TrailingClosureExpr) {
        walk(node.callee)
        for (arg in node.arguments) {
            walk(arg)
        }
        walk(node.trailingLambdaExpr)
    }

    private func visitTryCatch(node: TryCatch) {
        for (varDecl in node.resourceSpec) {
            walk(varDecl)
        }
        walk(node.tryBlock)
        for (pattern in node.catchPatterns) {
            walk(pattern)
        }
        for (block in node.catchBlocks) {
            walk(block)
        }
        if (let Some(finallyBlock) <- node.finallyBlock) {
            walk(finallyBlock)
        }
    }

    private func visitTupleLiteral(node: TupleLiteral) {
        for (element in node.elements) {
            walk(element)
        }
    }

    private func visitTuplePattern(node: TuplePattern) {
        for (pattern in node.subPatterns) {
            walk(pattern)
        }
    }

    private func visitTupleType(node: TupleType) {
        for (element in node.elements) {
            walk(element)
        }
    }

    private func visitTypeAlias(node: TypeAlias) {
        for (a in node.annotations) {
            walk(a)
        }
        for (m in node.modifiers) {
            walk(m)
        }
        // aliasName is String, no need to walk
        for (param in node.typeParameters) {
            walk(param)
        }
        walk(node.originalTyAnnotation)
    }

    private func visitTypeConvExpr(node: TypeConvExpr) {
        walk(node.targetTypeAnnotation)
        walk(node.srcVal)
    }

    private func visitTypePattern(node: TypePattern) {
        walk(node.subPattern)
        walk(node.patternType)
    }

    private func visitUnaryExpr(node: UnaryExpr) {
        walk(node.operand)
        // opKind is UnaryOpKind, no need to walk
    }

    private func visitUnsafeExpr(node: UnsafeExpr) {
        walk(node.block)
    }

    private func visitVarOrEnumPattern(node: VarOrEnumPattern) {
        // identifier is String, no need to walk
    }

    private func visitVarPattern(node: VarPattern) {
        // name is String, no need to walk
    }

    private func visitVArrayExpr(node: VArrayExpr) {
        walk(node.argument)
        walk(node.vArrayType)
    }

    private func visitVArrayType(node: VArrayType) {
        walk(node.elementType)
        // size is Int64, no need to walk
    }

    private func visitWhileExpr(node: WhileExpr) {
        walk(node.condition)
        walk(node.body)
    }

    private func visitWildcardPattern(node: WildcardPattern) {
        // no child nodes to walk
    }

    private func visitSynchronizedExpr(node: SynchronizedExpr) {
        walk(node.structuredMutex)
        walk(node.block)
    }

    private func visitFeaturesDirective(node: FeaturesDirective) {
        for (a in node.annotations) {
            walk(a)
        }
        walk(node.featuresSet)
    }

    private func visitFeaturesSet(node: FeaturesSet) {
        for (f in node.content) {
            walk(f)
        }
        // content is Array<FeatureId>
    }

    private func visitFeatureId(node: FeatureId) {
        // featureNameIdentifiers is Array<String>, no need to walk
    }

    public open func preAction(node: SyntaxTreeNode): PreActionMode {
        return PreActionMode.Continue
    }

    public open func postAction(node: SyntaxTreeNode): PostActionMode {
        return PostActionMode.Continue
    }
}

public enum PreActionMode {
    | Continue
    | Skip
    | Stop
}

public enum PostActionMode {
    | Continue
    | Stop
}
