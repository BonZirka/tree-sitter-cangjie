package stdx.syntax

import std.collection.ArrayList

public open class ASTRewriter {
    public func walk(startPoint: SyntaxTreeNode, detach!: Bool = false): SyntaxTreeNode {
        let newNode = match (startPoint) {
            case pkg: Package => walkAndRewritePackage(pkg)
            case _ => walkAndRewrite(startPoint)
        }
        // If the node has not been rewritten, there is no need to refresh the node's parent node.
        // The package node has no parent node and does not need to be refreshed.
        if ((!detach && newNode == startPoint) || startPoint is Package) {
            return newNode
        }
        // refresh parent node
        let newParent: ?SyntaxTreeNode = match (detach) {
            case false => getNewParent(startPoint.parentNode, newNode.nodeImpl, startPoint.nodePos.begin)
            case true => None
        }
        return SyntaxNodeImplTranslator.translate(newNode.nodeImpl, startPoint.nodePos.begin, newParent).getOrThrow()
    }

    private func isRewritedChild(hasRewritedChild: Bool, new: SyntaxNodeImpl, old: SyntaxNodeImpl) {
        if (new.id != old.id) {
            return true
        }
        return hasRewritedChild
    }

    private func walkAndRewritePackage(node: Package): Package {
        var hasRewritedChild = false
        let fileList = ArrayList<SourceFile>()
        let fileImpls = ArrayList<(SyntaxNodeImpl, String)>()
        for (file in node.srcFile) {
            let newNode = (walkAndRewrite<SourceFile>(file) as SourceFile).getOrThrow()
            hasRewritedChild = isRewritedChild(hasRewritedChild, newNode.nodeImpl, file.nodeImpl)
            fileImpls.add((newNode.nodeImpl, newNode.path))
            fileList.add(newNode)
        }

        let rewritedNode = if (hasRewritedChild) {
            let (isMacro, name) = checkPackage(fileList)
            let pkg = Package(isMacro, name, fileImpls.toArray())
            rewrite(pkg)
        } else {
            rewrite(node)
        }
        checkNodeKind(rewritedNode, node)
        (rewritedNode as Package).getOrThrow()
    }

    private func walkAndRewrite<T>(node: T): SyntaxTreeNode where T <: SyntaxTreeNode {
        var hasRewritedChild = false
        let childCollector = ChildCollector()
        childCollector.walk(node)
        let collectChildNodeList = childCollector.getChildNodes()
        if (collectChildNodeList.size == 0) {
            return cast<T>(rewrite(node)).getOrThrow()
        }
        let comments = ArrayList<Comment>(node.comments)
        let newNodeImpl = ArrayList<SyntaxNodeImpl>()
        match (node.nodeImpl) {
            case nt: NonTerminal => for (child in nt.children) {
                if (child is Terminal) {
                    newNodeImpl.add(child)
                    continue
                }
                // intermediate node in SyntaxNodeImpl
                if (child.kind == SyntaxNodeKind.CommentGroupList || child.kind == SyntaxNodeKind.AnnotationList ||
                    child.kind == SyntaxNodeKind.ModifierList || child.kind == SyntaxNodeKind.TypeArguments ||
                    child.kind == SyntaxNodeKind.MatchCaseBody || child.kind == SyntaxNodeKind.TokenList) {
                    hasRewritedChild = walkAndRewriteSpecialNode(child, newNodeImpl, collectChildNodeList, comments)
                    continue
                }
                let n = collectChildNodeList.remove(at: 0)
                let newNode = walkAndRewrite(n)
                hasRewritedChild = isRewritedChild(hasRewritedChild, newNode.nodeImpl, child)
                newNodeImpl.add(newNode.nodeImpl)
                // VArrayType only has one child: Property 'size' is NonTerminal, not SyntaxTreeNode
                if (node.nodeImpl.kind == SyntaxNodeKind.VArrayType) {
                    break
                }
            }
            case _ => throw Exception("RewriteException: SyntaxNodeImpl kind not match.")
        }
        let rewritedNode = if (hasRewritedChild) {
            let nodeImpl = NonTerminal(node.nodeImpl.kind, newNodeImpl.toArray())
            let newNode = SyntaxNodeImplTranslator.translate(nodeImpl, node.nodePos.begin, node.parentNode)
            rewrite(newNode.getOrThrow())
        } else {
            rewrite(node)
        }
        checkNodeKind(rewritedNode, node)
        return rewritedNode
    }

    // Some SyntaxNodeImpl nodes do not match SyntaxTreeNode nodes. 
    // This function is used to handle special cases with intermediate layers.
    private func walkAndRewriteSpecialNode(impl: SyntaxNodeImpl, newNodeImpl: ArrayList<SyntaxNodeImpl>,
        collectChildNodeList: ArrayList<SyntaxTreeNode>, comments: ArrayList<Comment>) {
        var hasRewritedChild = false
        match (impl.kind) {
            case SyntaxNodeKind.CommentGroupList =>
                var newCommentGroupListImpl = NonTerminal(impl.kind, Array<SyntaxNodeImpl>())
                (hasRewritedChild, newCommentGroupListImpl) = walkAndRewriteComment(impl, comments)
                newNodeImpl.add(newCommentGroupListImpl)
            case SyntaxNodeKind.AnnotationList | SyntaxNodeKind.ModifierList | SyntaxNodeKind.TypeArguments
                | SyntaxNodeKind.MatchCaseBody =>
                var newListImpl = NonTerminal(impl.kind, Array<SyntaxNodeImpl>())
                (hasRewritedChild, newListImpl) = walkAndRewriteNonTerminalList(impl, collectChildNodeList)
                newNodeImpl.add(newListImpl)
            case SyntaxNodeKind.TokenList => newNodeImpl.add(impl)
            case _ => ()
        }
        return hasRewritedChild
    }

    private func walkAndRewriteNonTerminalList(listImpl: SyntaxNodeImpl, childNodeList: ArrayList<SyntaxTreeNode>) {
        var hasRewritedChild = false
        let list = (listImpl as NonTerminal).getOrThrow()
        let newNodeImpl = ArrayList<SyntaxNodeImpl>()
        for (child in list.children) {
            // foreign is NonTerminal in ModifierList, but is not SyntaxTreeNode(Modifier)
            if (child is NonTerminal && child.toString() != "foreign") {
                let n = childNodeList.remove(at: 0)
                let newNode = walkAndRewrite(n)
                hasRewritedChild = isRewritedChild(hasRewritedChild, newNode.nodeImpl, child)
                newNodeImpl.add(newNode.nodeImpl)
            } else {
                newNodeImpl.add(child)
            }
        }
        return if (hasRewritedChild) {
            (hasRewritedChild, NonTerminal(listImpl.kind, newNodeImpl.toArray()))
        } else {
            (hasRewritedChild, list)
        }
    }

    func getNewCommentGroup(nt: NonTerminal, comments: ArrayList<Comment>): (Array<SyntaxNodeImpl>, Bool) {
        var hasRewritedChild = false
        var newCommentGroup = ArrayList<SyntaxNodeImpl>()
        for (comment in nt.children) {
            if (comment is NonTerminal) {
                let n = comments.remove(at: 0)
                let newNode = walkAndRewrite(n)
                hasRewritedChild = isRewritedChild(hasRewritedChild, newNode.nodeImpl, comment)
                newCommentGroup.add(newNode.nodeImpl)
            } else {
                newCommentGroup.add(comment)
            }
        }
        return (newCommentGroup.toArray(), hasRewritedChild)
    }

    private func walkAndRewriteComment(groupListImpl: SyntaxNodeImpl, comments: ArrayList<Comment>) {
        var hasRewritedChild = false
        var newCommentGroup = Array<SyntaxNodeImpl>()
        let list = (groupListImpl as NonTerminal).getOrThrow()
        let newNodeImpl = ArrayList<SyntaxNodeImpl>()
        for (child in list.children) {
            // child is CommentGruop or NL
            match (child) {
                case nt: NonTerminal =>
                    (newCommentGroup, hasRewritedChild) = getNewCommentGroup(nt, comments)
                    newNodeImpl.add(NonTerminal(SyntaxNodeKind.CommentGroup, newCommentGroup))
                case _ => newNodeImpl.add(child)
            }
        }
        return if (hasRewritedChild) {
            (hasRewritedChild, NonTerminal(SyntaxNodeKind.CommentGroupList, newNodeImpl.toArray()))
        } else {
            (hasRewritedChild, list)
        }
    }

    private func checkNodeKind(newNode: SyntaxTreeNode, oldNode: SyntaxTreeNode) {
        if (newNode.nodeImpl.kind != oldNode.nodeImpl.kind) {
            throw Exception(
                "RewriteException: The type of the rewritten node does not match the type of the original node.")
        }
    }

    public open func rewrite(node: SyntaxTreeNode): SyntaxTreeNode {
        return node
    }
}

func getNewPackage(oldPackage: Package, fileImpl: SyntaxNodeImpl, filePath: String) {
    // need to replace this fileImpl node in oldPackage
    let newFile = (SyntaxNodeImplTranslator
        .translateFile(fileImpl, filePath, parent: oldPackage)
        .getOrThrow() as SourceFile)
        .getOrThrow()
    let fileList = ArrayList<SourceFile>()
    let fileImpls = ArrayList<(SyntaxNodeImpl, String)>()
    for (file in oldPackage.srcFile) {
        if (file.name == newFile.name) {
            fileImpls.add((newFile.nodeImpl, newFile.path))
            fileList.add(newFile)
        } else {
            fileImpls.add((file.nodeImpl, file.path))
            fileList.add(file)
        }
    }
    let (isMacro, name) = checkPackage(fileList)
    Package(isMacro, name, fileImpls.toArray())
}

// Refresh the parent node, replace the old child nodes in the parent node with new ones, and create a new parent node.
func getNewParent(oldParent: ?SyntaxTreeNode, impl: SyntaxNodeImpl, targetPos: CodePosition): ?SyntaxTreeNode {
    if (let Some(node) <- oldParent && let Some(pkg) <- (node as Package)) {
        return getNewPackage(pkg, impl, targetPos.filePath)
    }
    return if (let Some(node) <- oldParent) {
        // parentNode must be NonTerminal
        let oldParentImpl = ((node.nodeImpl) as NonTerminal).getOrThrow()
        var curPos = CodePosition(node.nodePos.beginLine, node.nodePos.beginColumn,
            FileInfos(node.nodePos.fileName, node.nodePos.filePath))
        let children = ArrayList<SyntaxNodeImpl>()
        for (child in oldParentImpl.children) {
            if (curPos == targetPos) {
                children.add(impl)
            } else {
                children.add(child)
            }
            curPos = curPos + child.offset
        }
        let newParentImpl = NonTerminal(oldParentImpl.kind, children.toArray())
        let newParent: ?SyntaxTreeNode = match (node.parentNode) {
            case Some(parent) => getNewParent(parent, newParentImpl, node.nodePos.begin)
            case None => node
        }
        SyntaxNodeImplTranslator.translate(newParentImpl, node.nodePos.begin, newParent)
    } else {
        None
    }
}

class ChildCollector <: ASTVisitor {
    private var childNodes: ArrayList<SyntaxTreeNode> = ArrayList<SyntaxTreeNode>()

    public override func preAction(node: SyntaxTreeNode): PreActionMode {
        clearChildNodes()
        collectChildNodes(node)
        return PreActionMode.Skip
    }

    private func collectChildNodes(node: SyntaxTreeNode): Unit {
        match (node) {
            case binaryExpr: BinaryExpr =>
                childNodes.add(binaryExpr.lhs)
                childNodes.add(binaryExpr.rhs)
            case varDecl: VarDecl =>
                for (a in varDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in varDecl.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(varDecl.pattern)
                if (let Some(tyAnnotation) <- varDecl.tyAnnotation) {
                    childNodes.add(tyAnnotation)
                }
                if (let Some(initializer) <- varDecl.initializer) {
                    childNodes.add(initializer)
                }
            case symbolRef: SymbolRef => for (t in symbolRef.typeArguments) {
                childNodes.add(t)
            }
            case annotation: Annotation => for (arg in annotation.arguments) {
                childNodes.add(arg)
            }
            case argument: Argument => childNodes.add(argument.value)
            case arrayLiteral: ArrayLiteral => for (element in arrayLiteral.elements) {
                childNodes.add(element)
            }
            case asExpr: AsExpr =>
                childNodes.add(asExpr.srcVal)
                childNodes.add(asExpr.targetTypeAnnotation)
            case assignExpr: AssignExpr =>
                childNodes.add(assignExpr.lhs)
                childNodes.add(assignExpr.rhs)
            case block: Block => for (n in block.nodes) {
                childNodes.add(n)
            }
            case body: Body => for (decl in body.memberDecls) {
                childNodes.add(decl)
            }
            case callExpr: CallExpr =>
                childNodes.add(callExpr.callee)
                for (arg in callExpr.arguments) {
                    childNodes.add(arg)
                }
            case catchPattern: CatchPattern =>
                childNodes.add(catchPattern.pattern)
                for (ty in catchPattern.exceptionType) {
                    childNodes.add(ty)
                }
            case classDecl: ClassDecl =>
                for (a in classDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in classDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in classDecl.genericParams) {
                    childNodes.add(param)
                }
                for (superTy in classDecl.superTyAnnotations) {
                    childNodes.add(superTy)
                }
                if (let Some(constraints) <- classDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                childNodes.add(classDecl.body)
            case compositeType: CompositeType => for (arg in compositeType.typeArguments) {
                childNodes.add(arg)
            }
            case conjunctionCondition: ConjunctionCondition => for (cond in conjunctionCondition.cond) {
                match (cond) {
                    case LetPatternCondition(letPattern) => childNodes.add(letPattern)
                    case Expression(expr) => childNodes.add(expr)
                    case ParenConditionConstructor(parenCondition) => childNodes.add(parenCondition)
                    case _ => throw Exception()
                }
            }
            case constPattern: ConstPattern => childNodes.add(constPattern.litConstExpr)
            case disjunctionCondition: DisjunctionCondition => for (cond in disjunctionCondition.cond) {
                childNodes.add(cond)
            }
            case doWhileExpr: DoWhileExpr =>
                childNodes.add(doWhileExpr.body)
                childNodes.add(doWhileExpr.condition)
            case enumConstructor: EnumConstructor =>
                for (a in enumConstructor.annotations) {
                    childNodes.add(a)
                }
                for (m in enumConstructor.modifiers) {
                    childNodes.add(m)
                }
                for (ty in enumConstructor.paramTyAnnotations) {
                    childNodes.add(ty)
                }
            case enumDecl: EnumDecl =>
                for (a in enumDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in enumDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in enumDecl.genericParams) {
                    childNodes.add(param)
                }
                for (superTy in enumDecl.superTyAnnotations) {
                    childNodes.add(superTy)
                }
                if (let Some(constraints) <- enumDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                childNodes.add(enumDecl.body)
            case enumPattern: EnumPattern =>
                childNodes.add(enumPattern.enumConstructor)
                if (let Some(enumType) <- enumPattern.enumType) {
                    childNodes.add(enumType)
                }
                for (pattern in enumPattern.subPatterns) {
                    childNodes.add(pattern)
                }
            case extendDecl: ExtendDecl =>
                for (a in extendDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in extendDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in extendDecl.genericParams) {
                    childNodes.add(param)
                }
                childNodes.add(extendDecl.extendedTyAnnotation)
                for (superTy in extendDecl.superTyAnnotations) {
                    childNodes.add(superTy)
                }
                if (let Some(constraints) <- extendDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                childNodes.add(extendDecl.body)
            case forInExpr: ForInExpr =>
                childNodes.add(forInExpr.pattern)
                childNodes.add(forInExpr.expr)
                if (let Some(guard) <- forInExpr.patternGuard) {
                    childNodes.add(guard)
                }
                childNodes.add(forInExpr.body)
            case funcDecl: FuncDecl =>
                for (a in funcDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in funcDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in funcDecl.genericParams) {
                    childNodes.add(param)
                }
                childNodes.add(funcDecl.params)
                if (let Some(retTy) <- funcDecl.retTyAnnotation) {
                    childNodes.add(retTy)
                }
                if (let Some(constraints) <- funcDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                if (let Some(body) <- funcDecl.body) {
                    childNodes.add(body)
                }
            case funcParam: FuncParam =>
                for (a in funcParam.annotations) {
                    childNodes.add(a)
                }
                for (m in funcParam.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(funcParam.typeAnnotation)
                if (let Some(defaultValue) <- funcParam.defaultValue) {
                    childNodes.add(defaultValue)
                }
            case funcType: FuncType =>
                for (ty in funcType.paramTypes) {
                    childNodes.add(ty)
                }
                childNodes.add(funcType.retType)
            case genericConstraint: GenericConstraint =>
                childNodes.add(genericConstraint.typeArgument)
                for (bound in genericConstraint.upperBounds) {
                    childNodes.add(bound)
                }
            case genericConstraints: GenericConstraints => for (constraint in genericConstraints.constraints) {
                childNodes.add(constraint)
            }
            case genericParam: GenericParam =>
                for (a in genericParam.annotations) {
                    childNodes.add(a)
                }
                for (m in genericParam.modifiers) {
                    childNodes.add(m)
                }
            case ifExpr: IfExpr =>
                childNodes.add(ifExpr.condition)
                childNodes.add(ifExpr.ifBlock)
                if (let Some(elseIf) <- ifExpr.elseIf) {
                    childNodes.add(elseIf)
                }
                if (let Some(elseBlock) <- ifExpr.elseBlock) {
                    childNodes.add(elseBlock)
                }
            case importList: ImportList =>
                if (let Some(modifier) <- importList.modifier) {
                    childNodes.add(modifier)
                }
                childNodes.add(importList.contents)
            case importMulti: ImportMulti => for (content in importMulti.contents) {
                childNodes.add(content)
            }
            case incOrDecExpr: IncOrDecExpr => childNodes.add(incOrDecExpr.operand)
            case interfaceDecl: InterfaceDecl =>
                for (a in interfaceDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in interfaceDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in interfaceDecl.genericParams) {
                    childNodes.add(param)
                }
                for (superTy in interfaceDecl.superTyAnnotations) {
                    childNodes.add(superTy)
                }
                if (let Some(constraints) <- interfaceDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                childNodes.add(interfaceDecl.body)
            case isExpr: IsExpr =>
                childNodes.add(isExpr.srcVal)
                childNodes.add(isExpr.targetTypeAnnotation)
            case lambda: Lambda =>
                childNodes.add(lambda.params)
                for (n in lambda.body) {
                    childNodes.add(n)
                }
            case lambdaParam: LambdaParam =>
                for (a in lambdaParam.annotations) {
                    childNodes.add(a)
                }
                for (m in lambdaParam.modifiers) {
                    childNodes.add(m)
                }
                if (let Some(tyAnnotation) <- lambdaParam.typeAnnotation) {
                    childNodes.add(tyAnnotation)
                }
            case letPattern: LetPattern =>
                for (pattern in letPattern.patterns) {
                    childNodes.add(pattern)
                }
                childNodes.add(letPattern.expr)
            case litConstStrExpr: LitConstStrExpr => for (part in litConstStrExpr.strPartExprs) {
                match (part) {
                    case StrLiteralPart.LitConstPart(lit) => childNodes.add(lit)
                    case StrLiteralPart.StrInterpolation(strInterpolation) => childNodes.add(strInterpolation)
                    case _ => throw Exception()
                }
            }
            case macroDecl: MacroDecl =>
                for (a in macroDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in macroDecl.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(macroDecl.params)
                if (let Some(retTy) <- macroDecl.retTyAnnotation) {
                    childNodes.add(retTy)
                }
                childNodes.add(macroDecl.body)
            case macroExpandDecl: MacroExpandDecl =>
                for (a in macroExpandDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in macroExpandDecl.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(macroExpandDecl.calleeMacro)
                match (macroExpandDecl.macroInputs) {
                    case MacroExpandInput.WithoutParens(decl) => childNodes.add(decl)
                    case MacroExpandInput.WithParens(_) => return
                    case _ => throw Exception()
                }
            case macroExpandExpr: MacroExpandExpr =>
                childNodes.add(macroExpandExpr.calleeMacro)
                match (macroExpandExpr.macroInputs) {
                    case MacroExpandInput.WithoutParens(decl) => childNodes.add(decl)
                    case MacroExpandInput.WithParens(_) => return
                    case _ => throw Exception()
                }
            case macroExpandParam: MacroExpandParam =>
                for (a in macroExpandParam.annotations) {
                    childNodes.add(a)
                }
                for (m in macroExpandParam.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(macroExpandParam.calleeMacro)
                match (macroExpandParam.macroInputs) {
                    case MacroExpandInput.WithoutParens(decl) => childNodes.add(decl)
                    case MacroExpandInput.WithParens(_) => return
                    case _ => throw Exception()
                }
            case mainDecl: MainDecl =>
                for (a in mainDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in mainDecl.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(mainDecl.params)
                if (let Some(retTy) <- mainDecl.retTyAnnotation) {
                    childNodes.add(retTy)
                }
                childNodes.add(mainDecl.body)
            case matchCase: MatchCase =>
                if (let Some(caseCond) <- matchCase.caseCond) {
                    childNodes.add(caseCond)
                }
                for (pattern in matchCase.patterns) {
                    childNodes.add(pattern)
                }
                if (let Some(patternGuardCond) <- matchCase.patternGuardCond) {
                    childNodes.add(patternGuardCond)
                }
                for (n in matchCase.body) {
                    childNodes.add(n)
                }
            case matchExpr: MatchExpr =>
                if (let Some(selector) <- matchExpr.selector) {
                    childNodes.add(selector)
                }
                for (mCase in matchExpr.matchCases) {
                    childNodes.add(mCase)
                }
            case memberAccess: MemberAccess =>
                childNodes.add(memberAccess.base)
                childNodes.add(memberAccess.field)
            case optionalExpr: OptionalExpr => childNodes.add(optionalExpr.base)
            case packageNode: Package => for (file in packageNode.srcFile) {
                childNodes.add(file)
            }
            case packageHeader: PackageHeader =>
                if (let Some(accessModifier) <- packageHeader.accessModifier) {
                    childNodes.add(accessModifier)
                }
            case parameterList: ParameterList => for (param in parameterList.params) {
                childNodes.add(param)
            }
            case parenCondition: ParenCondition => childNodes.add(parenCondition.cond)
            case parenExpr: ParenExpr => childNodes.add(parenExpr.subExpr)
            case parenType: ParenType => childNodes.add(parenType.subType)
            case prefixType: PrefixType => childNodes.add(prefixType.base)
            case propDecl: PropDecl =>
                for (a in propDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in propDecl.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(propDecl.tyAnnotation)
                if (let Some(getter) <- propDecl.getter) {
                    childNodes.add(getter)
                }
                if (let Some(setter) <- propDecl.setter) {
                    childNodes.add(setter)
                }
            case propGetterOrSetter: PropGetterOrSetter =>
                for (a in propGetterOrSetter.annotations) {
                    childNodes.add(a)
                }
                for (m in propGetterOrSetter.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(propGetterOrSetter.block)
            case quoteExpr: QuoteExpr => for (content in quoteExpr.tokensOrRefExpr) {
                match (content) {
                    case QuoteExprContent.TokenPart(tks) => childNodes.add(tks)
                    case QuoteExprContent.QuoteInterpolation(quoteInterpolation) => childNodes.add(quoteInterpolation)
                    case _ => throw Exception()
                }
            }
            case quoteInterpolationExpr: QuoteInterpolationExpr => childNodes.add(quoteInterpolationExpr.expr)
            case rangeExpr: RangeExpr =>
                if (let Some(start) <- rangeExpr.start) {
                    childNodes.add(start)
                }
                if (let Some(end) <- rangeExpr.end) {
                    childNodes.add(end)
                }
                if (let Some(step) <- rangeExpr.step) {
                    childNodes.add(step)
                }
            case returnExpr: ReturnExpr =>
                if (let Some(retVal) <- returnExpr.retVal) {
                    childNodes.add(retVal)
                }
            case sourceFile: SourceFile =>
                if (let Some(pkgHeader) <- sourceFile.pkgHeader) {
                    childNodes.add(pkgHeader)
                }
                for (importList in sourceFile.importLists) {
                    childNodes.add(importList)
                }
                for (decl in sourceFile.topLevelDecls) {
                    childNodes.add(decl)
                }
                if (let Some(ftr) <- sourceFile.ftrDirective) {
                    childNodes.add(ftr)
                }
            case spawnExpr: SpawnExpr =>
                if (let Some(threadContext) <- spawnExpr.threadContext) {
                    childNodes.add(threadContext)
                }
                childNodes.add(spawnExpr.trailingLambdaExpr)
            case staticInit: StaticInit =>
                for (a in staticInit.annotations) {
                    childNodes.add(a)
                }
                for (m in staticInit.modifiers) {
                    childNodes.add(m)
                }
                childNodes.add(staticInit.body)
            case strInterpolationContent: StrInterpolationContent => childNodes.add(
                strInterpolationContent.interpolationBlock)
            case structDecl: StructDecl =>
                for (a in structDecl.annotations) {
                    childNodes.add(a)
                }
                for (m in structDecl.modifiers) {
                    childNodes.add(m)
                }
                for (param in structDecl.genericParams) {
                    childNodes.add(param)
                }
                for (superTy in structDecl.superTyAnnotations) {
                    childNodes.add(superTy)
                }
                if (let Some(constraints) <- structDecl.genericConstraints) {
                    childNodes.add(constraints)
                }
                childNodes.add(structDecl.body)
            case subscriptExpr: SubscriptExpr =>
                childNodes.add(subscriptExpr.base)
                for (index in subscriptExpr.indexs) {
                    childNodes.add(index)
                }
            case throwExpr: ThrowExpr => childNodes.add(throwExpr.throwVal)
            case trailingClosureExpr: TrailingClosureExpr =>
                childNodes.add(trailingClosureExpr.callee)
                for (arg in trailingClosureExpr.arguments) {
                    childNodes.add(arg)
                }
                childNodes.add(trailingClosureExpr.trailingLambdaExpr)
            case tryCatch: TryCatch =>
                for (varDecl in tryCatch.resourceSpec) {
                    childNodes.add(varDecl)
                }
                childNodes.add(tryCatch.tryBlock)
                // The number of catchPatterns and catchBlocks must be equal for a valid TryCatch Node.
                for (i in 0..tryCatch.catchPatterns.size) {
                    childNodes.add(tryCatch.catchPatterns[i])
                    childNodes.add(tryCatch.catchBlocks[i])
                }
                if (let Some(finallyBlock) <- tryCatch.finallyBlock) {
                    childNodes.add(finallyBlock)
                }
            case tupleLiteral: TupleLiteral => for (element in tupleLiteral.elements) {
                childNodes.add(element)
            }
            case tuplePattern: TuplePattern => for (pattern in tuplePattern.subPatterns) {
                childNodes.add(pattern)
            }
            case tupleType: TupleType => for (element in tupleType.elements) {
                childNodes.add(element)
            }
            case typeAlias: TypeAlias =>
                for (a in typeAlias.annotations) {
                    childNodes.add(a)
                }
                for (m in typeAlias.modifiers) {
                    childNodes.add(m)
                }
                for (param in typeAlias.typeParameters) {
                    childNodes.add(param)
                }
                childNodes.add(typeAlias.originalTyAnnotation)
            case typeConvExpr: TypeConvExpr =>
                childNodes.add(typeConvExpr.targetTypeAnnotation)
                childNodes.add(typeConvExpr.srcVal)
            case typePattern: TypePattern =>
                childNodes.add(typePattern.subPattern)
                childNodes.add(typePattern.patternType)
            case unaryExpr: UnaryExpr => childNodes.add(unaryExpr.operand)
            case unsafeExpr: UnsafeExpr => childNodes.add(unsafeExpr.block)
            case varrayExpr: VArrayExpr =>
                childNodes.add(varrayExpr.vArrayType)
                childNodes.add(varrayExpr.argument)
            case varrayType: VArrayType => childNodes.add(varrayType.elementType)
            case whileExpr: WhileExpr =>
                childNodes.add(whileExpr.condition)
                childNodes.add(whileExpr.body)
            case synchronizedExpr: SynchronizedExpr =>
                childNodes.add(synchronizedExpr.structuredMutex)
                childNodes.add(synchronizedExpr.block)
            case featuresDirective: FeaturesDirective =>
                for (a in featuresDirective.annotations) {
                    childNodes.add(a)
                }
                childNodes.add(featuresDirective.featuresSet)
            case featuresSet: FeaturesSet =>
                for (f in featuresSet.content) {
                    childNodes.add(f)
                }
            case _ => return
            // For SyntaxTreeNode without child nodes, do not add anything
        }
    }

    func getChildNodes(): ArrayList<SyntaxTreeNode> {
        return childNodes
    }

    func clearChildNodes(): Unit {
        childNodes.clear()
    }
}
