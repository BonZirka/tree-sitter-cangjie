/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.{ArrayList, ArrayStack, HashSet, HashMap}

// Expr/Decl on each line is indented with four spaces after format
let FORMAT_INDENTATION = 4

class SyntaxNodeImplCreator {
    private init() {
    }

    static unsafe func checkIdentifier(identifier: String, paramName: String, nodeName: String, useContext!: Bool = true): Unit {
        var textPtr: CString = CString(CPointer<UInt8>())
        try {
            textPtr = LibC.mallocCString(identifier)
            if (textPtr.isNull()) {
                throw Exception("malloc failed")
            }
            let checkRes = unsafe { CJ_CheckIdentifier(textPtr, useContext) }
            if (!checkRes) {
                throw Exception("InitException: Invalid input '${paramName}' for '${nodeName}' init.")
            }
        } finally {
            if (!textPtr.isNull()) {
                unsafe { LibC.free(textPtr) }
            }
        }
    }

    static func createCommentGroup(comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        for (i in 0..comments.size) {
            ret.add(comments[i].nodeImpl)
            if (i < comments.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.CommentGroup, ret.toArray())
    }

    static func createCommentGroupList(comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(createCommentGroup(comments))

        builder.buildNonTerminal(SyntaxNodeKind.CommentGroupList, ret.toArray())
    }

    static func addCommentToNode(ret: ArrayList<SyntaxNodeImpl>, comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        if (comments.size > 0) {
            // the CommentGroupList is placed to the beginning of the Node
            ret.add(createCommentGroupList(comments))
            ret.add(builder.buildNewline(1))
        }
    }

    static func createAnnotationList(annotations: Array<Annotation>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        for (i in 0..annotations.size) {
            ret.add(annotations[i].nodeImpl)
            if (i < annotations.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.AnnotationList, ret.toArray())
    }

    static func createModifierList(modifiers: Array<Modifier>, hasForeign!: Bool = false) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        if (hasForeign) {
            let modifierRet = ArrayList<SyntaxNodeImpl>()
            modifierRet.add(builder.buildBasicTerminal(SyntaxNodeKind.ForeignToken))
            ret.add(builder.buildNonTerminal(SyntaxNodeKind.Modifier, modifierRet.toArray()))

            if (modifiers.size > 0) {
                ret.add(builder.buildSpace(1))
            }
        }

        for (i in 0..modifiers.size) {
            ret.add(modifiers[i].nodeImpl)
            if (i < modifiers.size - 1) {
                ret.add(builder.buildSpace(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.ModifierList, ret.toArray())
    }

    private static func createDeclLikePrefix(annotations: Array<Annotation>, modifiers: Array<Modifier>,
        comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        return (builder, ret)
    }

    private static func addNamedGenericDeclHead(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>,
        name: String, genericParams: Array<GenericParam>) {
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }
    }

    private static func addSuperTyAnnotations(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>,
        superTyAnnotations: Array<TypeAnnotation>) {
        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }
    }

    private static func addGenericConstraints(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>,
        genericConstraints: Option<GenericConstraints>) {
        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }
    }

    private static func addDeclBody(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>, body: Body) {
        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)
    }

    private static func addDelimitedTokenList(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>, tks: Tokens,
        leftToken: SyntaxNodeKind, rightToken: SyntaxNodeKind) {
        ret.add(builder.buildBasicTerminal(leftToken))
        var tokBytes: CPointer<UInt8> = unsafePointerCastFromUint8Array((tks).toBytes())
        var spaceFlag: CPointer<Bool> = unsafe { LibC.malloc<Bool>(count: tks.size) }
        if (spaceFlag.isNull()) {
            unsafe { LibC.free(tokBytes) }
            throw IllegalMemoryException("malloc failed!")
        }
        unsafe { CJ_CheckAddSpaces(tokBytes, spaceFlag) }
        let attrArray = unsafe { tokensToImplArray(tks, tokBytes, spaceFlag) }
        ret.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray))
        ret.add(builder.buildBasicTerminal(rightToken))
    }

    private static func addMacroExpandAnnotations(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>,
        comments: Array<Comment>, annotations: Array<Annotation>) {
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }
    }

    private static func addMacroCalleeAndAttrs(builder: SyntaxNodeBuilder, ret: ArrayList<SyntaxNodeImpl>,
        calleeMacro: Expr, macroAttrs: Tokens) {
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        ret.add(calleeMacro.nodeImpl)

        if (macroAttrs.size != 0) {
            addDelimitedTokenList(builder, ret, macroAttrs, SyntaxNodeKind.LSquareToken, SyntaxNodeKind.RSquareToken)
        }
    }

    static func createAnnotationImpl(
        arguments: Array<Argument>,
        identifier: String,
        opKind: AtOpKind,
        comments!: Array<Comment> = []
    ) {
        unsafe { checkIdentifier(identifier, "identifier", "Annotation") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        match (opKind) {
            case AtOpKind.At => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
            case AtOpKind.AtExcl => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtExclToken))
            case _ => throw Exception("InitException: Invalid input 'opKind' for 'Annotation' init.")
        }
        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        if (arguments.size > 0) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            for (i in 0..arguments.size) {
                ret.add(arguments[i].nodeImpl)
                if (i < arguments.size - 1) {
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    ret.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }

        builder.buildNonTerminal(SyntaxNodeKind.Annotation, ret.toArray())
    }

    static func createArgumentImpl(identifier: Option<String>, isInOut: Bool, value: Expr,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)
        if (let Some(name) <- identifier) {
            unsafe { checkIdentifier(name, "identifier", "Argument") }
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
        }

        if (isInOut) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InoutToken))
            ret.add(builder.buildSpace(1))
        }
        ret.add(value.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.Argument, ret.toArray())
    }

    static func createBlockImpl(nodes: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        for (node in nodes) {
            if (node.nodeImpl.kind != SyntaxNodeKind.VarDecl && node.nodeImpl.kind != SyntaxNodeKind.FuncDecl &&
                !node.nodeImpl.kind.isExpr()) {
                throw Exception("InitException: Invalid input 'nodes' for 'Block' init.")
            }
        }

        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))
        for (i in 0..nodes.size) {
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(nodes[i].nodeImpl)
            ret.add(builder.buildNewline(1))
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.Block, ret.toArray())
    }

    static func createBodyImpl(memberDecls: Array<Decl>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))
        for (i in 0..memberDecls.size) {
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(memberDecls[i].nodeImpl)
            ret.add(builder.buildNewline(1))
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.Body, ret.toArray())
    }

    static func createGenericConstraintImpl(typeArgument: TypeAnnotation, upperTypes: Array<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        if (upperTypes.isEmpty()) {
            throw Exception("InitException: The input 'upperTypes' cannot be empty for 'GenericConstraint' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(typeArgument.nodeImpl)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
        for (i in 0..upperTypes.size) {
            ret.add(upperTypes[i].nodeImpl)
            if (i < upperTypes.size - 1) {
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                ret.add(builder.buildSpace(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.GenericConstraint, ret.toArray())
    }

    static func createGenericConstraintsImpl(constraints: Array<GenericConstraint>, comments!: Array<Comment> = []) {
        if (constraints.isEmpty()) {
            throw Exception("InitException: The input 'Constraints' cannot be empty for 'GenericConstraints' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
        ret.add(builder.buildSpace(1))
        for (i in 0..constraints.size) {
            ret.add(constraints[i].nodeImpl)
            if (i < constraints.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.GenericConstraints, ret.toArray())
    }

    static func createModifierImpl(kind: ModifierKind, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        let modiToken = match (kind) {
            case ModifierKind.Abstract => SyntaxNodeKind.AbstractToken
            case ModifierKind.Internal => SyntaxNodeKind.InternalToken
            case ModifierKind.Mut => SyntaxNodeKind.MutToken
            case ModifierKind.Open => SyntaxNodeKind.OpenToken
            case ModifierKind.Operator => SyntaxNodeKind.OperatorToken
            case ModifierKind.Override => SyntaxNodeKind.OverrideToken
            case ModifierKind.Private => SyntaxNodeKind.PrivateToken
            case ModifierKind.Protected => SyntaxNodeKind.ProtectedToken
            case ModifierKind.Public => SyntaxNodeKind.PublicToken
            case ModifierKind.Redef => SyntaxNodeKind.RedefToken
            case ModifierKind.Sealed => SyntaxNodeKind.SealedToken
            case ModifierKind.Static => SyntaxNodeKind.StaticToken
            case ModifierKind.Unsafe => SyntaxNodeKind.UnsafeToken
            case ModifierKind.Const => SyntaxNodeKind.ConstToken
            case _ => throw Exception("InitException: Invalid input 'kind' for 'Modifier' init.")
        }

        ret.add(builder.buildBasicTerminal(modiToken))
        builder.buildNonTerminal(SyntaxNodeKind.Modifier, ret.toArray())
    }

    // Decl
    static func checkGenericParamAndGenericConstraints(genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>) {
        if (genericParams.isEmpty() && let Some(_) <- genericConstraints) {
            throw Exception(
                "InitException: The input 'genericConstraints' must be None when input 'genericParams' are empty.")
        }
        let paramSet = HashSet<String>()
        for (param in genericParams) {
            paramSet.add(param.name)
        }
        if (let Some(constraints) <- genericConstraints) {
            for (constraint in constraints.constraints) {
                if (!paramSet.contains(constraint.typeArgument.toString())) {
                    throw Exception("InitException: The input 'genericConstraints' mismatch with input 'genericParams'")
                }
            }
        }
    }

    static func createTyepArguments(genericParams: Array<GenericParam>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        for (i in 0..genericParams.size) {
            ret.add(genericParams[i].nodeImpl)
            if (i < genericParams.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))

        builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, ret.toArray())
    }

    static func checkClassOrStructDeclBody(body: Body, declType: String) {
        for (decl in body.memberDecls) {
            if (decl.nodeImpl.kind != SyntaxNodeKind.FuncDecl && decl.nodeImpl.kind != SyntaxNodeKind.VarDecl &&
                decl.nodeImpl.kind != SyntaxNodeKind.StaticInit && decl.nodeImpl.kind != SyntaxNodeKind.MacroExpandDecl &&
                decl.nodeImpl.kind != SyntaxNodeKind.PropDecl) {
                throw Exception("InitException: Invalid input 'body.memberDecls' for '${declType}' init.")
            }
        }
    }

    static func createClassDeclImpl(body: Body, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, name: String, superTyAnnotations: Array<TypeAnnotation>,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        checkClassOrStructDeclBody(body, "ClassDecl")
        unsafe { checkIdentifier(name, "name", "ClassDecl") }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ClassToken))
        addNamedGenericDeclHead(builder, ret, name, genericParams)

        addSuperTyAnnotations(builder, ret, superTyAnnotations)

        addGenericConstraints(builder, ret, genericConstraints)

        addDeclBody(builder, ret, body)

        builder.buildNonTerminal(SyntaxNodeKind.ClassDecl, ret.toArray())
    }

    static func hasModifier(modifiers: Array<Modifier>, modiKind: ModifierKind) {
        for (modifier in modifiers) {
            if (modifier.kind == modiKind) {
                return true
            }
        }
        false
    }

    static func createFuncDeclImpl(body: Option<Block>, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, kind: FuncKind, name: String, params: ParameterList,
        retTyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        match (kind) {
            case FuncKind.Foreign | FuncKind.Normal | FuncKind.PrimaryConstructor => unsafe { checkIdentifier(name,
                "name", "FuncDecl") }
            case _ => ()
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        match (kind) {
            case FuncKind.Foreign =>
                ret.add(createModifierList(modifiers, hasForeign: true))
                ret.add(builder.buildSpace(1))
            case _ =>
                if (modifiers.size != 0) {
                    ret.add(createModifierList(modifiers))
                    ret.add(builder.buildSpace(1))
                }
        }

        match (kind) {
            case FuncKind.Constructor =>
                if (hasModifier(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: The input 'kind' not correspond to input 'modifiers'.")
                }
                if (genericParams.size > 0 || !retTyAnnotation.isNone() || !genericConstraints.isNone()) {
                    throw Exception(
                        "InitException: The input 'genericParams', 'retTyAnnotation' and 'genericConstraints' are not allowed for 'FuncDecl.Constructor' init.")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
            case FuncKind.Foreign =>
                if (hasModifier(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: The input 'kind' not correspond to input 'modifiers'.")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FuncToken))
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.Normal =>
                if (hasModifier(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: The input 'kind' not correspond to input 'modifiers'.")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FuncToken))
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.Operator =>
                if (!hasModifier(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: The input 'kind' not correspond to input 'modifiers'.")
                }
                if (!genericConstraints.isNone() || !genericParams.isEmpty()) {
                    throw Exception(
                        "InitException: The input 'genericParams' and 'genericConstraints' are not allowed for 'FuncDecl.Operator' init.")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FuncToken))
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.PrimaryConstructor =>
                if (hasModifier(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: The input 'kind' not correspond to input 'modifiers'.")
                }
                if (genericParams.size > 0 || !retTyAnnotation.isNone() || !genericConstraints.isNone()) {
                    throw Exception(
                        "The input 'genericParams', 'retTyAnnotation' and 'genericConstraints' are not allowed for 'FuncDecl.PrimaryConstructor' init.")
                }
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.Finalizer =>
                if (!annotations.isEmpty() || !modifiers.isEmpty() || !genericConstraints.isNone() ||
                    !genericParams.isEmpty() || !retTyAnnotation.isNone() || !params.params.isEmpty()) {
                    throw Exception(
                        "InitException: The input 'annotations', 'modifiers', 'genericConstraints', 'genericParams' and 'retTyAnnotation' are not allowed for 'FuncDecl.Finalizer' init.")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitNotToken))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
            case _ => throw Exception("InitException: Invalid input 'kind' for 'FuncDecl' init.")
        }

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        ret.add(params.nodeImpl)

        if (let Some(typeAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(typeAnno.nodeImpl)
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        if (let Some(bd) <- body) {
            ret.add(builder.buildSpace(1))
            ret.add(bd.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.FuncDecl, ret.toArray())
    }

    static func createStructDeclImpl(body: Body, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, name: String, superTyAnnotations: Array<TypeAnnotation>,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        checkClassOrStructDeclBody(body, "StructDecl")
        unsafe { checkIdentifier(name, "name", "StructDecl") }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.StructToken))
        addNamedGenericDeclHead(builder, ret, name, genericParams)

        addSuperTyAnnotations(builder, ret, superTyAnnotations)

        addGenericConstraints(builder, ret, genericConstraints)

        addDeclBody(builder, ret, body)

        builder.buildNonTerminal(SyntaxNodeKind.StructDecl, ret.toArray())
    }

    static func createInterfaceDeclImpl(body: Body, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, name: String, superTyAnnotations: Array<TypeAnnotation>,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        unsafe { checkIdentifier(name, "name", "InterfaceDecl") }
        for (decl in body.memberDecls) {
            if (decl.nodeImpl.kind != SyntaxNodeKind.FuncDecl && decl.nodeImpl.kind != SyntaxNodeKind.MacroExpandDecl) {
                throw Exception("InitException: Invalid input 'body.memberDecls' for 'InterfaceDecl' init.")
            }
        }

        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InterfaceToken))
        addNamedGenericDeclHead(builder, ret, name, genericParams)

        addSuperTyAnnotations(builder, ret, superTyAnnotations)

        addGenericConstraints(builder, ret, genericConstraints)

        addDeclBody(builder, ret, body)

        builder.buildNonTerminal(SyntaxNodeKind.InterfaceDecl, ret.toArray())
    }

    static func createEnumBody(body: Body, constructors: Array<EnumConstructor>, isNonExhaustive: Bool) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (constructor in constructors) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
            ret.add(builder.buildSpace(1))
            ret.add(constructor.nodeImpl)
        }
        if (isNonExhaustive) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.EllipsisToken))
        }
        for (decl in body.memberDecls) {
            if (decl.nodeImpl.kind != SyntaxNodeKind.FuncDecl && decl.nodeImpl.kind != SyntaxNodeKind.PropDecl &&
                decl.nodeImpl.kind != SyntaxNodeKind.MacroExpandDecl) {
                throw Exception("InitException: Invalid 'body.memberDecls' for 'EnumDecl' init.")
            }
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(decl.nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.Body, ret.toArray())
    }

    static func createEnumDeclImpl(body: Body, constructors: Array<EnumConstructor>,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, isNonExhaustive: Bool,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        unsafe { checkIdentifier(name, "name", "EnumDecl") }
        if (constructors.size == 0) {
            throw Exception("InitException: The input 'constructors' cannot be empty for 'EnumDecl' init.")
        }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.EnumToken))
        addNamedGenericDeclHead(builder, ret, name, genericParams)

        addSuperTyAnnotations(builder, ret, superTyAnnotations)

        addGenericConstraints(builder, ret, genericConstraints)

        ret.add(builder.buildSpace(1))
        ret.add(createEnumBody(body, constructors, isNonExhaustive))

        builder.buildNonTerminal(SyntaxNodeKind.EnumDecl, ret.toArray())
    }

    static func createPropDeclImpl(getter: Option<PropGetterOrSetter>, name: String, setter: Option<PropGetterOrSetter>,
        tyAnnotation: TypeAnnotation, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "PropDecl") }
        if (let Some(_) <- setter && getter.isNone()) {
            throw Exception(
                "InitException: The input 'getter' cannot be None if input 'setter' exists during 'PropDecl' init.")
        }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.PropToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        ret.add(builder.buildSpace(1))
        ret.add(tyAnnotation.nodeImpl)
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))

        if (let Some(get) <- getter) {
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(get.nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        if (let Some(set) <- setter) {
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(set.nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.PropDecl, ret.toArray())
    }

    static func createExtendDeclImpl(body: Body, extendedTyAnnotation: TypeAnnotation,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        checkGenericParamAndGenericConstraints(genericConstraints, genericParams)
        for (decl in body.memberDecls) {
            if (decl.nodeImpl.kind != SyntaxNodeKind.FuncDecl && decl.nodeImpl.kind != SyntaxNodeKind.MacroExpandDecl &&
                decl.nodeImpl.kind != SyntaxNodeKind.PropDecl) {
                throw Exception("InitException: Invalid input 'body.memberDecls' for 'ExtendDecl' init.")
            }
        }

        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ExtendToken))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        ret.add(builder.buildSpace(1))
        ret.add(extendedTyAnnotation.nodeImpl)

        addSuperTyAnnotations(builder, ret, superTyAnnotations)

        addGenericConstraints(builder, ret, genericConstraints)

        addDeclBody(builder, ret, body)

        builder.buildNonTerminal(SyntaxNodeKind.ExtendDecl, ret.toArray())
    }

    static func createMacroExpandDeclImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind
            .RefExpr) {
            throw Exception("InitException: Invalid input 'calleeMacro' for 'MacroExpandDecl' init.")
        }

        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addMacroExpandAnnotations(builder, ret, comments, annotations)
        addMacroCalleeAndAttrs(builder, ret, calleeMacro, macroAttrs)

        match (macroInputs) {
            case MacroExpandInput.WithoutParens(decl) =>
                ret.add(builder.buildNewline(1))
                ret.add(decl.nodeImpl)
            case MacroExpandInput.WithParens(toks) =>
                addDelimitedTokenList(builder, ret, toks, SyntaxNodeKind.LParenToken, SyntaxNodeKind.RParenToken)
            case _ => throw Exception("InitException: Invalid input 'macroInputs' for 'MacroExpandDecl' init.")
        }

        builder.buildNonTerminal(SyntaxNodeKind.MacroExpandDecl, ret.toArray())
    }

    static func createEnumConstructorImpl(name: String, paramTyAnnotations: Array<TypeAnnotation>,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "EnumConstructor") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (!paramTyAnnotations.isEmpty()) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..paramTyAnnotations.size) {
                ret.add(paramTyAnnotations[i].nodeImpl)
                if (i < paramTyAnnotations.size - 1) {
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    ret.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }

        builder.buildNonTerminal(SyntaxNodeKind.EnumConstructor, ret.toArray())
    }

    static func createMacroDeclImpl(body: Block, name: String, params: ParameterList,
        retTyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "MacroDecl") }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MacroToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        ret.add(params.nodeImpl)

        if (let Some(tyAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.MacroDecl, ret.toArray())
    }

    static func createMainDeclImpl(body: Block, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MainToken))
        ret.add(params.nodeImpl)

        if (let Some(tyAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.MainDecl, ret.toArray())
    }

    static func createStaticInitImpl(body: Block, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        let modifierRet = ArrayList<SyntaxNodeImpl>()
        modifierRet.add(builder.buildBasicTerminal(SyntaxNodeKind.StaticToken))
        let staticModifier = builder.buildNonTerminal(SyntaxNodeKind.Modifier, modifierRet.toArray())

        let modifierListRet = ArrayList<SyntaxNodeImpl>()
        modifierListRet.add(staticModifier)
        let modifierList = builder.buildNonTerminal(SyntaxNodeKind.ModifierList, modifierListRet.toArray())

        ret.add(modifierList)
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.StaticInit, ret.toArray())
    }

    static func createTypeAliasImpl(aliasName: String, originalTyAnnotation: TypeAnnotation,
        typeParameters: Array<GenericParam>, modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(aliasName, "aliasName", "TypeAlias") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.TypeToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, aliasName))

        if (typeParameters.size > 0) {
            ret.add(createTyepArguments(typeParameters))
        }

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
        ret.add(builder.buildSpace(1))
        ret.add(originalTyAnnotation.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.TypeAlias, ret.toArray())
    }

    static func createVarDeclImpl(initializer: Option<Expr>, kind: VarKind, name: String, pattern: Pattern,
        tyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "VarDecl") }
        if (pattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && pattern.nodeImpl.kind != SyntaxNodeKind
            .VarBindingPattern && pattern.nodeImpl.kind != SyntaxNodeKind.TuplePattern && pattern.nodeImpl.kind != SyntaxNodeKind
            .EnumPattern) {
            throw Exception("InitException: Invalid input 'pattern' for 'VarDecl' init.")
        }

        if (hasModifier(modifiers, ModifierKind.Const)) {
            throw Exception("InitException: The input 'modifiers' cannot have 'Const' for 'VarDecl' init.")
        }

        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        match (kind) {
            case VarKind.Var => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.VarToken))
            case VarKind.Let => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
            case VarKind.Const => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ConstToken))
            case _ => throw Exception("InitException: Invalid input 'kind' for 'VarDecl' init.")
        }

        ret.add(builder.buildSpace(1))

        ret.add(pattern.nodeImpl)

        if (let Some(tyAnno) <- tyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        if (let Some(initEx) <- initializer) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
            ret.add(builder.buildSpace(1))
            ret.add(initEx.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.VarDecl, ret.toArray())
    }

    static func createFuncParamImpl(defaultValue: Option<Expr>, kind: Option<VarKind>, name: String,
        typeAnnotation: TypeAnnotation, isNamed!: Bool = false, annotations!: Array<Annotation> = [],
        modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "FuncParam") }
        if (modifiers.size > 0 && kind.isNone()) {
            throw Exception(
                "InitException: The input 'modifiers' is only supported when input 'kind' exists for 'FuncParam' init.")
        }
        let (builder, ret) = createDeclLikePrefix(annotations, modifiers, comments)

        if (let Some(varKind) <- kind) {
            match (varKind) {
                case VarKind.Var => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.VarToken))
                case VarKind.Let => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
                case _ => throw Exception("InitException: Invalid input 'kind' for 'FuncParam' init.")
            }
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        if (isNamed) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.NotToken))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        ret.add(builder.buildSpace(1))

        ret.add(typeAnnotation.nodeImpl)

        if (let Some(value) <- defaultValue) {
            if (!isNamed) {
                throw Exception(
                    "InitException: The input 'isNamed' must be true when 'defaultValue' given during 'FuncParam' init.")
            }
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
            ret.add(builder.buildSpace(1))
            ret.add(value.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.FuncParam, ret.toArray())
    }

    static func createGenericParamImpl(name: String, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "GenericParam") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        builder.buildNonTerminal(SyntaxNodeKind.GenericParam, ret.toArray())
    }

    static func createMacroExpandParamImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind
            .RefExpr) {
            throw Exception("InitException: Invalid input 'calleeMacro' for 'MacroExpandParam' init.")
        }

        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addMacroExpandAnnotations(builder, ret, comments, annotations)
        addMacroCalleeAndAttrs(builder, ret, calleeMacro, macroAttrs)

        match (macroInputs) {
            case MacroExpandInput.WithoutParens(decl) =>
                ret.add(builder.buildSpace(1))
                ret.add(decl.nodeImpl)
            case MacroExpandInput.WithParens(toks) =>
                addDelimitedTokenList(builder, ret, toks, SyntaxNodeKind.LParenToken, SyntaxNodeKind.RParenToken)
            case _ => throw Exception("InitException: Invalid input 'macroInputs' for 'MacroExpandParam' init.")
        }

        builder.buildNonTerminal(SyntaxNodeKind.MacroExpandParam, ret.toArray())
    }

    static func createLitConstExprImpl(kind: LitConstKind, value: String, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        match (kind) {
            case LitConstKind.BoolLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.BooleanLiteralToken, value))
            case LitConstKind.FloatLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.FloatLiteralToken, value))
            case LitConstKind.IntergerLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.IntegerLiteralToken, value))
            case LitConstKind.UnitLiteral =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                ret.add(builder.buildSpace(value.size - SyntaxNodeKind.LParenToken.size - SyntaxNodeKind.RParenToken.size))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
                return builder.buildNonTerminal(SyntaxNodeKind.UnitLiteral, ret.toArray())
            case _ => throw Exception("InitException: Invalid input 'kind' for 'LitConstExpr' init.")
        }

        builder.buildNonTerminal(SyntaxNodeKind.ValuedLiteral, ret.toArray())
    }

    static func createLitConstStrExprImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64,
        isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        let litToken = builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue)

        match (kind) {
            case LitConstKind.StringLiteral => SyntaxNodeKind.LineStringLiteral
            case _ => throw Exception("InitException: Invalid input 'kind' for 'LitConstStrExpr' init.")
        }

        match (strKind) {
            case LitConstStrKind.StringLiteral => return createStringLiteralImpl(kind, rawValue, delimiterNum,
                isSingleQuote, strKind, strPartExprs, comments: comments)
            case LitConstStrKind.MultiLineString => return createMultiLineStringImpl(kind, rawValue, delimiterNum,
                isSingleQuote, strKind, strPartExprs, comments: comments)
            case LitConstStrKind.MultiLineRawString =>
                if (delimiterNum == 0) {
                    throw Exception(
                        "InitException: The input 'delimiterNum' cannot be zero for LitConstStrExpr.MultiLineRawString init.")
                }
                let quoteToken = builder.buildQuote(isSingleQuote)
                let hashToken = builder.buildHash(delimiterNum)
                ret.add(all: [hashToken, quoteToken, litToken, quoteToken, hashToken])
                return builder.buildNonTerminal(SyntaxNodeKind.MultiLineRawStringLiteral, ret.toArray())

            case _ => throw Exception("InitException: Invalid input 'strKind' for 'LitConstStrExpr' init.")
        }

        builder.buildNonTerminal(SyntaxNodeKind.LineStringLiteral, ret.toArray())
    }

    static func createStringLiteralImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64, isSingleQuote: Bool,
        strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        let quoteToken = builder.buildQuote(isSingleQuote)
        ret.add(quoteToken)
        if (strPartExprs.size > 0) {
            for (strPart in strPartExprs) {
                match (strPart) {
                    case StrInterpolation(strInterExpr) => ret.add(strInterExpr.nodeImpl)
                    case LitConstPart(litConstExpr) => ret.add(litConstExpr.nodeImpl)
                    case _ => throw Exception(
                        "InitException: Invalid input 'strPart' for 'LitConstStrExpr.StringLiteral' init.")
                }
            }
        } else {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
        }
        ret.add(quoteToken)
        builder.buildNonTerminal(SyntaxNodeKind.LineStringLiteral, ret.toArray())
    }

    static func createMultiLineStringImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64,
        isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        let quoteToken = builder.buildTripleQuote(isSingleQuote)
        ret.add(quoteToken)
        ret.add(builder.buildNewline(1))
        if (strPartExprs.size > 0) {
            for (strPart in strPartExprs) {
                match (strPart) {
                    case StrInterpolation(strInterExpr) => ret.add(strInterExpr.nodeImpl)
                    case LitConstPart(litConstExpr) => ret.add(litConstExpr.nodeImpl)
                    case _ => throw Exception(
                        "InitException: Invalid input 'strPart' for 'LitConstStrExpr.MultiLineString' init.")
                }
            }
        } else {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
        }
        ret.add(quoteToken)
        builder.buildNonTerminal(SyntaxNodeKind.MultiLineStringLiteral, ret.toArray())
    }

    static func createLitConstRuneExprImpl(kind: LitConstKind, rawValue: String, isSingleQuote: Bool,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        match (kind) {
            case LitConstKind.RuneLiteral =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RunePrefixToken))
                ret.add(builder.buildQuote(isSingleQuote))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
                ret.add(builder.buildQuote(isSingleQuote))
            case _ => throw Exception("InitException: Invalid input 'kind' for 'LitConstRuneExpr' init.")
        }

        builder.buildNonTerminal(SyntaxNodeKind.RuneLiteral, ret.toArray())
    }

    static func createArrayLiteralImpl(elements: Array<Expr>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
        for (i in 0..elements.size) {
            ret.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))

        builder.buildNonTerminal(SyntaxNodeKind.ArrayLiteral, ret.toArray())
    }

    static func createTupleLiteralImpl(elements: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..elements.size) {
            ret.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        builder.buildNonTerminal(SyntaxNodeKind.TupleLiteral, ret.toArray())
    }

    static func createSymbolRefTyepArguments(typeArguments: Array<TypeAnnotation>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        for (i in 0..typeArguments.size) {
            ret.add(typeArguments[i].nodeImpl)
            if (i < typeArguments.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))

        builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, ret.toArray())
    }

    static func createSymbolRefImpl(name: String, typeArguments: Array<TypeAnnotation>, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "SymbolRef") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (typeArguments.size > 0) {
            ret.add(createSymbolRefTyepArguments(typeArguments))
        }

        builder.buildNonTerminal(SyntaxNodeKind.RefExpr, ret.toArray())
    }

    static func createMemberAccessImpl(base: SyntaxTreeNode, field: SymbolRef, comments!: Array<Comment> = []) {
        if (!base.nodeImpl.kind.isTypeAnnotation() && !base.nodeImpl.kind.isExpr()) {
            throw Exception("InitException: Invalid input 'base' for 'MemberAccess' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        ret.add(field.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.MemberAccess, ret.toArray())
    }

    static func createOptionalExprImpl(base: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.QuestToken))

        builder.buildNonTerminal(SyntaxNodeKind.OptionalExpr, ret.toArray())
    }

    static func createAssignExprImpl(assignOpKind: AssignOpKind, lhs: SyntaxTreeNode, rhs: Expr,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(lhs.nodeImpl)
        ret.add(builder.buildSpace(1))

        let opToken = match (assignOpKind) {
            case AssignOpKind.AddAssign => SyntaxNodeKind.AddAssignToken
            case AssignOpKind.AndAssign => SyntaxNodeKind.AndAssignToken
            case AssignOpKind.Assign => SyntaxNodeKind.AssignToken
            case AssignOpKind.BitAndAssign => SyntaxNodeKind.BitAndAssignToken
            case AssignOpKind.BitOrAssign => SyntaxNodeKind.BitOrAssignToken
            case AssignOpKind.BitXorAssign => SyntaxNodeKind.BitXorAssignToken
            case AssignOpKind.DivAssign => SyntaxNodeKind.DivAssignToken
            case AssignOpKind.ExpAssign => SyntaxNodeKind.ExpAssignToken
            case AssignOpKind.LShiftAssign => SyntaxNodeKind.LShiftAssignToken
            case AssignOpKind.ModAssign => SyntaxNodeKind.ModAssignToken
            case AssignOpKind.MulAssign => SyntaxNodeKind.MulAssignToken
            case AssignOpKind.OrAssign => SyntaxNodeKind.OrAssignToken
            case AssignOpKind.RShiftAssign => SyntaxNodeKind.RShiftAssignToken
            case AssignOpKind.SubAssign => SyntaxNodeKind.SubAssignToken
            case _ => throw Exception("InitException: Invalid input 'assignOpKind' for 'AssignExpr' init.")
        }

        ret.add(builder.buildBasicTerminal(opToken))
        ret.add(builder.buildSpace(1))
        ret.add(rhs.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.AssignExpr, ret.toArray())
    }

    static func createUnsafeExprImpl(body: Block, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UnsafeToken))
        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.UnsafeExpr, ret.toArray())
    }

    static func createSubscriptExprImpl(base: Expr, indexs: Array<Expr>, comments!: Array<Comment> = []) {
        if (indexs.size == 0) {
            throw Exception("InitException: The input 'indexs' cannot be empty for 'SubscriptExpr' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))

        for (i in 0..indexs.size) {
            ret.add(indexs[i].nodeImpl)
            if (i < indexs.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))

        builder.buildNonTerminal(SyntaxNodeKind.SubscriptExpr, ret.toArray())
    }

    static func createLambdaImpl(body: Array<SyntaxTreeNode>, params: ParameterList, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildSpace(1))

        if (!params.getParamsLParenPos().isNone()) {
            throw Exception("InitException: The input 'params' should not have parens for 'Lambda' init.")
        }
        ret.add(params.nodeImpl)
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DoubleArrowToken))
        ret.add(builder.buildSpace(1))

        for (i in 0..body.size) {
            ret.add(body[i].nodeImpl)
            if (i < body.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.Lambda, ret.toArray())
    }

    static func createMatchExprImpl(matchCases: Array<MatchCase>, selector: Option<Expr>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MatchToken))
        ret.add(builder.buildSpace(1))

        if (let Some(sel) <- selector) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(sel.nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            ret.add(builder.buildSpace(1))
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..matchCases.size) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildSpace(FORMAT_INDENTATION))
            ret.add(matchCases[i].nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.MatchExpr, ret.toArray())
    }

    static func createTryCatchImpl(catchBlocks: Array<Block>, catchPatterns: Array<CatchPattern>,
        finallyBlock: Option<Block>, resourceSpec: Array<VarDecl>, tryBlock: Block, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.TryToken))
        if (!resourceSpec.isEmpty()) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))

            for (i in 0..resourceSpec.size) {
                ret.add(resourceSpec[i].nodeImpl)
                if (i < resourceSpec.size - 1) {
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    ret.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        } else if (catchPatterns.isEmpty() && finallyBlock.isNone()) {
            throw Exception(
                "InitException: The input 'catchPatterns' or 'finallyBlock' must exist if 'resourceSpec' is empty when 'SubscriptExpr' init.")
        }

        ret.add(builder.buildSpace(1))
        ret.add(tryBlock.nodeImpl)

        for (i in 0..catchPatterns.size) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CatchToken))
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(catchPatterns[i].nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            ret.add(builder.buildSpace(1))
            ret.add(catchBlocks[i].nodeImpl)
        }

        if (let Some(finalBlock) <- finallyBlock) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FinallyToken))
            ret.add(builder.buildSpace(1))
            ret.add(finalBlock.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.TryExpr, ret.toArray())
    }

    static func createThrowExprImpl(throwVal: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ThrowToken))
        ret.add(builder.buildSpace(1))
        ret.add(throwVal.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.ThrowExpr, ret.toArray())
    }

    static func createSynchronizedExprImpl(block: Block, structuredMutex: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SynchronizedToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(structuredMutex.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(block.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.SynchronizedExpr, ret.toArray())
    }

    static func createSpawnExprImpl(threadContext: Option<Expr>, trailingLambdaExpr: Lambda,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SpawnToken))
        ret.add(builder.buildSpace(1))
        if (let Some(context) <- threadContext) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(context.nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }
        ret.add(builder.buildSpace(1))
        ret.add(trailingLambdaExpr.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.SpawnExpr, ret.toArray())
    }

    static func createIfExprImpl(condition: DisjunctionCondition, elseBlock: Option<Block>, elseIf: Option<IfExpr>,
        ifBlock: Block, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.IfToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(ifBlock.nodeImpl)

        if (let Some(elseIfExpr) <- elseIf) {
            if (!elseIfExpr.elseBlock.isNone() && !elseBlock.isNone()) {
                throw Exception("InitException: IfExpr only support one elseBlock when IfExpr Init")
            }
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ElseToken))
            ret.add(builder.buildSpace(1))
            ret.add(elseIfExpr.nodeImpl)
        }

        if (let Some(elBlock) <- elseBlock) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ElseToken))
            ret.add(builder.buildSpace(1))
            ret.add(elBlock.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.IfExpr, ret.toArray())
    }

    static func createWhileExprImpl(body: Block, condition: DisjunctionCondition, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhileToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.WhileExpr, ret.toArray())
    }

    static func createDoWhileExprImpl(body: Block, condition: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DoToken))
        ret.add(builder.buildSpace(1))

        ret.add(body.nodeImpl)

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhileToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        builder.buildNonTerminal(SyntaxNodeKind.DoWhileExpr, ret.toArray())
    }

    static func createLambdaParamImpl(name: String, typeAnnotation: Option<TypeAnnotation>, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "LambdaParam") }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (let Some(tyAnn) <- typeAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnn.nodeImpl)
        }

        builder.buildNonTerminal(SyntaxNodeKind.LambdaParam, ret.toArray())
    }

    static func createPropGetterOrSetterImpl(block: Block, identifier: Option<String>, isGetter: Bool,
        annotations!: Array<Annotation> = [], comments!: Array<Comment> = []) {
        if (isGetter && (annotations.size != 0 || let Some(_) <- identifier)) {
            throw Exception(
                "InitException: The input 'identifier' and 'annotations' not supported when 'PropGetterOrSetter.Getter' init.")
        }

        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (isGetter) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GetToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        } else {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SetToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            if (let Some(ident) <- identifier) {
                unsafe { checkIdentifier(ident, "identifier", "PropGetterOrSetter") }
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, ident))
            } else {
                throw Exception(
                    "InitException: The input 'identifier' cannot be None when 'PropGetterOrSetter.Setter' init.")
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }

        ret.add(builder.buildSpace(1))
        ret.add(block.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.PropGetterOrSetter, ret.toArray())
    }

    static func createFeatureIdImpl(featureNameIdentifiers: Array<String>, comments!: Array<Comment> = []) {
        if (featureNameIdentifiers.size == 0) {
            throw Exception(
                "InitException: The input 'featureNameIdentifiers' cannot be empty for 'FeatureId' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        for (i in 0..featureNameIdentifiers.size) {
            unsafe { checkIdentifier(featureNameIdentifiers[i], "identifier", "FeatureId") }
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, featureNameIdentifiers[i]))
            if (i + 1 < featureNameIdentifiers.size) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.FeatureId, ret.toArray())
    }

    static func createFeaturesSetImpl(features: Array<FeatureId>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..features.size) {
            ret.add(features[i].nodeImpl)
            if (i + 1 < features.size) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        builder.buildNonTerminal(SyntaxNodeKind.FeaturesSet, ret.toArray())
    }

    static func createFeaturesDirectiveImpl(annotations: Array<Annotation>, set: FeaturesSet,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FeaturesToken))
        ret.add(builder.buildSpace(1))
        ret.add(set.nodeImpl)

        builder.buildNonTerminal(SyntaxNodeKind.FeaturesDirective, ret.toArray())
    }

    static func getPackageIndentKind(s: String): SyntaxNodeKind {
        let isPkgIdent = s.contains(".") || s.contains("-") || s.contains(" ")
        if (isPkgIdent) {
            return SyntaxNodeKind.PackageIdentifierToken
        } else {
            return SyntaxNodeKind.IdentToken
        }
    }

    static func transPackagePrefixes(prefixPaths: Array<String>) {
        let ret = ArrayList<SyntaxNodeImpl>()
        let builder = SyntaxNodeBuilder()
        for (i in 0..prefixPaths.size) {
            ret.add(builder.buildValuedTerminal(getPackageIndentKind(prefixPaths[i]), prefixPaths[i]))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        builder.buildNonTerminal(SyntaxNodeKind.PackagePrefixes, ret.toArray())
    }

    static func createPackageHeaderImpl(accessModifier: Option<Modifier>, isMacroPkg: Bool,
        packageNameIdentifiers: Array<String>, comments!: Array<Comment> = []) {
        if (packageNameIdentifiers.size == 0) {
            throw Exception(
                "InitException: The input 'packageNameIdentifiers' cannot be empty for 'PackageHeader' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(ret, comments)

        if (let Some(modifier) <- accessModifier) {
            match (modifier.kind) {
                case ModifierKind.Internal => SyntaxNodeKind.InternalToken
                case ModifierKind.Protected => SyntaxNodeKind.ProtectedToken
                case ModifierKind.Public => SyntaxNodeKind.PublicToken
                case _ => throw Exception("InitException: Invalid input 'accessModifier' for 'PackageHeader' init.")
            }
            ret.add(modifier.nodeImpl)
            ret.add(builder.buildSpace(1))
        }

        if (isMacroPkg) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MacroToken))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.PackageToken))
        ret.add(builder.buildSpace(1))

        let packageName = packageNameIdentifiers[packageNameIdentifiers.size - 1]

        if (packageNameIdentifiers.size > 1) {
            ret.add(transPackagePrefixes(packageNameIdentifiers[0..packageNameIdentifiers.size - 1]))
        }
        ret.add(builder.buildValuedTerminal(getPackageIndentKind(packageName), packageName))

        builder.buildNonTerminal(SyntaxNodeKind.PackageSpec, ret.toArray())
    }

    static func checkCommentContent(content: String) {
        if (content.startsWith("/*") && content.endsWith("*/") && content != "/*/") {
            return true
        } else if (content.startsWith("//") && !content.contains("\n")) {
            return true
        }
        return false
    }

    static func createCommentImpl(content: String) {
        if (!checkCommentContent(content)) {
            throw Exception("InitException: Invalid input 'content' for 'Comment' init.")
        }
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildTokenTerminal(TokenKind.COMMENT, content, hasEscape: false))

        builder.buildNonTerminal(SyntaxNodeKind.Comment, ret.toArray())
    }

    static func createParameterListImpl(parameters: Array<Parameter>, hasParen!: Bool = true,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        if (hasParen) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..parameters.size) {
                parts.add(parameters[i].nodeImpl)
                if (i < parameters.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        } else {
            for (i in 0..parameters.size) {
                parts.add(parameters[i].nodeImpl)
                if (i < parameters.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
        }
        builder.buildNonTerminal(SyntaxNodeKind.ParameterList, parts.toArray())
    }

    static func createImportListImpl(contents: ImportContent, modifier: Option<Modifier>, comments!: Array<Comment> = []) {
        if (let Some(m) <- modifier) {
            match (m.kind) {
                case ModifierKind.Public | ModifierKind.Private | ModifierKind.Protected | ModifierKind.Internal => ()
                case _ => throw Exception("InitException: Invalid input 'modifier' for 'ImportList' init.")
            }
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        if (let Some(m) <- modifier) {
            parts.add(m.nodeImpl)
            parts.add(builder.buildSpace(1))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ImportToken))
        parts.add(builder.buildSpace(1))
        parts.add(contents.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.ImportSpec, parts.toArray())
    }

    static func createImportSingleImpl(prefixes: Array<String>, identifier: String, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(identifier, "identifier", "ImportSingle") }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        builder.buildNonTerminal(SyntaxNodeKind.ImportSingle, parts.toArray())
    }

    static func createImportAliasImpl(prefixes: Array<String>, identifier: String, alias: String,
        comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(identifier, "identifier", "ImportAlias") }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AsToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, alias))
        builder.buildNonTerminal(SyntaxNodeKind.ImportAlias, parts.toArray())
    }

    static func createImportAllImpl(prefixes: Array<String>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.MulToken))
        builder.buildNonTerminal(SyntaxNodeKind.ImportAll, parts.toArray())
    }

    static func createImportMultiImpl(prefixes: Array<String>, contents: Array<ImportContent>,
        comments!: Array<Comment> = []) {
        if (contents.isEmpty()) {
            throw Exception("InitException: The input 'contents' cannot be empty for 'ImportMulti' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..contents.size) {
            parts.add(contents[i].nodeImpl)
            if (i < contents.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))
        builder.buildNonTerminal(SyntaxNodeKind.ImportMulti, parts.toArray())
    }

    // expr
    static func createForInExprImpl(body: Block, expr: Expr, pattern: Pattern, patternGuard: Option<Expr>,
        comments!: Array<Comment> = []) {
        if (pattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && pattern.nodeImpl.kind != SyntaxNodeKind
            .VarBindingPattern && pattern.nodeImpl.kind != SyntaxNodeKind.TuplePattern && pattern.nodeImpl.kind != SyntaxNodeKind
            .EnumPattern) {
            throw Exception("InitException: Invalid input 'pattern' for 'ForInExpr' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ForToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(pattern.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.InToken))
        parts.add(builder.buildSpace(1))
        parts.add(expr.nodeImpl)
        if (let Some(p) <- patternGuard) {
            parts.add(builder.buildSpace(1))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
            parts.add(builder.buildSpace(1))
            parts.add(p.nodeImpl)
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        parts.add(builder.buildSpace(1))
        parts.add(body.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.ForInExpr, parts.toArray())
    }

    static func createReturnExprImpl(retVal: Option<Expr>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ReturnToken))
        if (let Some(v) <- retVal) {
            parts.add(builder.buildSpace(1))
            parts.add(v.nodeImpl)
        }
        builder.buildNonTerminal(SyntaxNodeKind.ReturnExpr, parts.toArray())
    }

    static func createVArrayExprImpl(argument: Argument, vArrayType: VArrayType, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(vArrayType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(argument.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.VArrayExpr, parts.toArray())
    }

    static func createUnaryExprImpl(opKind: UnaryOpKind, operand: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        match (opKind) {
            case UnaryOpKind.Not => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.NotToken))
            case UnaryOpKind.Sub => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.SubToken))
            case _ => throw Exception("InitException: Invalid input 'opKind' for 'UnaryExpr' init.")
        }
        parts.add(operand.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.UnaryExpr, parts.toArray())
    }

    static func createQuoteExprImpl(tokensOrRefExpr: Array<QuoteExprContent>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.QuoteToken))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..tokensOrRefExpr.size) {
            match (tokensOrRefExpr[i]) {
                case QuoteExprContent.TokenPart(t) => parts.add(t.nodeImpl)
                case QuoteExprContent.QuoteInterpolation(q) => parts.add(q.nodeImpl)
                case _ => throw Exception("InitException: Invalid input 'tokensOrRefExpr' for 'QuoteExpr' init.")
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.QuoteExpr, parts.toArray())
    }

    static func createQuoteTokenImpl(content: Tokens, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        let tokenArray = ArrayList<SyntaxNodeImpl>()
        var tokBytes: CPointer<UInt8> = unsafePointerCastFromUint8Array((content).toBytes())
        var spaceFlag: CPointer<Bool> = unsafe { LibC.malloc<Bool>(count: content.size) }
        if (spaceFlag.isNull()) {
            unsafe { LibC.free(tokBytes) }
            throw IllegalMemoryException("malloc failed!")
        }
        unsafe { CJ_CheckAddSpaces(tokBytes, spaceFlag) }
        try {
            for (i in 0..content.size) {
                parts.add(builder.buildTokenTerminal(content[i].kind, content[i].value))
                if (unsafe { spaceFlag.read(i) }) {
                    parts.add(builder.buildSpace(1))
                }
            }
        } finally {
            unsafe { LibC.free(tokBytes) }
            unsafe { LibC.free(spaceFlag) }
        }
        builder.buildNonTerminal(SyntaxNodeKind.QuoteTokenExpr, parts.toArray())
    }

    static func createQuoteInterpolationExprImpl(expr: Expr, hasParen!: Bool = false, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        if (hasParen) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            parts.add(expr.nodeImpl)
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        } else {
            parts.add(expr.nodeImpl)
        }
        builder.buildNonTerminal(SyntaxNodeKind.QuoteInterpolationExpr, parts.toArray())
    }

    static func createTrailingClosureExprImpl(callee: Expr, arguments: Array<Argument>, trailingLambdaExpr: Lambda,
        comments!: Array<Comment> = []) {
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("InitException: Invalid input 'callee' for 'TrailingClosureExpr' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(callee.nodeImpl)
        if (!arguments.isEmpty()) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..arguments.size) {
                parts.add(arguments[i].nodeImpl)
                if (i < arguments.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }
        parts.add(builder.buildSpace(1))
        parts.add(trailingLambdaExpr.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.TrailingClosureExpr, parts.toArray())
    }

    static unsafe func tokensToImplArray(tks: Tokens, tokBytes: CPointer<UInt8>, spaceFlag: CPointer<Bool>): Array<SyntaxNodeImpl> {
        try {
            let builder = SyntaxNodeBuilder()
            let arr = ArrayList<SyntaxNodeImpl>()
            for (i in 0..tks.size) {
                arr.add(builder.buildTokenTerminal(tks[i].kind, tks[i].value))
                if (spaceFlag.read(i)) {
                    arr.add(builder.buildSpace(1))
                }
            }
            return arr.toArray()
        } finally {
            LibC.free(tokBytes)
            LibC.free(spaceFlag)
        }
    }

    static unsafe func createMacroExpandExprImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput,
        comments!: Array<Comment> = []) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind
            .RefExpr) {
            throw Exception("InitException: Invalid input 'calleeMacro' for 'MacroExpandExpr' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        parts.add(calleeMacro.nodeImpl)
        if (macroAttrs.size != 0) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            var tokBytes: CPointer<UInt8> = unsafePointerCastFromUint8Array((macroAttrs).toBytes())
            var spaceFlag: CPointer<Bool> = LibC.malloc<Bool>(count: macroAttrs.size)
            if (spaceFlag.isNull()) {
                LibC.free(tokBytes)
                throw IllegalMemoryException("malloc failed!")
            }
            CJ_CheckAddSpaces(tokBytes, spaceFlag)
            let attrArray = tokensToImplArray(macroAttrs, tokBytes, spaceFlag)
            parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }
        match (macroInputs) {
            case MacroExpandInput.WithParens(toks) =>
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                var tokBytes: CPointer<UInt8> = unsafePointerCastFromUint8Array((toks).toBytes())
                var spaceFlag: CPointer<Bool> = LibC.malloc<Bool>(count: toks.size)
                if (spaceFlag.isNull()) {
                    LibC.free(tokBytes)
                    throw IllegalMemoryException("malloc failed!")
                }
                CJ_CheckAddSpaces(tokBytes, spaceFlag)
                let attrArray = tokensToImplArray(toks, tokBytes, spaceFlag)
                parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            case MacroExpandInput.WithoutParens(decl) =>
                parts.add(builder.buildNewline(1))
                parts.add(decl.nodeImpl)
            case _ => throw Exception("InitException: Invalid input 'macroInputs' for 'MacroExpandExpr' init.")
        }
        builder.buildNonTerminal(SyntaxNodeKind.MacroExpandExpr, parts.toArray())
    }

    static func createBinaryExprImpl(lhs: Expr, opKind: BinaryOpKind, rhs: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(lhs.nodeImpl)
        parts.add(builder.buildSpace(1))
        let opToken = match (opKind) {
            case BinaryOpKind.Add => SyntaxNodeKind.AddToken
            case BinaryOpKind.And => SyntaxNodeKind.AndToken
            case BinaryOpKind.BitAnd => SyntaxNodeKind.BitAndToken
            case BinaryOpKind.BitOr => SyntaxNodeKind.BitOrToken
            case BinaryOpKind.BitXor => SyntaxNodeKind.BitXorToken
            case BinaryOpKind.Coalescing => SyntaxNodeKind.CoalescingToken
            case BinaryOpKind.Composition => SyntaxNodeKind.CompositionToken
            case BinaryOpKind.Div => SyntaxNodeKind.DivToken
            case BinaryOpKind.Equal => SyntaxNodeKind.EqualToken
            case BinaryOpKind.Exp => SyntaxNodeKind.ExpToken
            case BinaryOpKind.Ge => SyntaxNodeKind.GeToken
            case BinaryOpKind.Gt => SyntaxNodeKind.GtToken
            case BinaryOpKind.Le => SyntaxNodeKind.LeToken
            case BinaryOpKind.LShift => SyntaxNodeKind.LShiftToken
            case BinaryOpKind.Lt => SyntaxNodeKind.LtToken
            case BinaryOpKind.Mod => SyntaxNodeKind.ModToken
            case BinaryOpKind.Mul => SyntaxNodeKind.MulToken
            case BinaryOpKind.NotEq => SyntaxNodeKind.NotEqToken
            case BinaryOpKind.Or => SyntaxNodeKind.OrToken
            case BinaryOpKind.Pipeline => SyntaxNodeKind.PipelineToken
            case BinaryOpKind.RShift => SyntaxNodeKind.RShiftToken
            case BinaryOpKind.Sub => SyntaxNodeKind.SubToken
            case _ => throw Exception("InitException: Invalid input 'opKind' for 'BinaryExpr' init.")
        }
        parts.add(builder.buildBasicTerminal(opToken))
        parts.add(builder.buildSpace(1))
        parts.add(rhs.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.BinaryExpr, parts.toArray())
    }

    // RangeExpr: start .. end : step   or   start ..= end : step
    static func createRangeExprImpl(start: Option<Expr>, kind: RangeKind, end: Option<Expr>, step: Option<Expr>,
        comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        if (let Some(s) <- start) {
            parts.add(s.nodeImpl)
        }
        let rangeToken = match (kind) {
            case RangeKind.RangeOp => SyntaxNodeKind.RangeOpToken
            case RangeKind.ClosedRangeOp => SyntaxNodeKind.ClosedRangeOpToken
            case _ => throw Exception("InitException: Invalid input 'RangeKind' for 'RangeExpr' init.")
        }
        parts.add(builder.buildBasicTerminal(rangeToken))
        if (let Some(e) <- end) {
            parts.add(e.nodeImpl)
        }
        if (let Some(st) <- step) {
            parts.add(builder.buildSpace(1))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            parts.add(st.nodeImpl)
        }
        builder.buildNonTerminal(SyntaxNodeKind.RangeExpr, parts.toArray())
    }

    static func createIncOrDecExprImpl(kind: IncOrDecOpKind, operand: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(operand.nodeImpl)
        match (kind) {
            case IncOrDecOpKind.Incr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IncrToken))
            case IncOrDecOpKind.Decr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DecrToken))
            case _ => throw Exception("InitException: Invalid input 'opKind' for 'IncOrDecExpr' init.")
        }
        builder.buildNonTerminal(SyntaxNodeKind.IncOrDecExpr, parts.toArray())
    }

    static func createParenExprImpl(subExpr: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subExpr.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.ParenExpr, parts.toArray())
    }

    static func createCallExprImpl(callee: Expr, arguments: Array<Argument>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("InitException: Invalid input 'callee' for 'CallExpr' init.")
        }
        parts.add(callee.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..arguments.size) {
            parts.add(arguments[i].nodeImpl)
            if (i < arguments.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.CallExpr, parts.toArray())
    }

    static func createIsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.IsExpr, parts.toArray())
    }

    static func createAsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.AsExpr, parts.toArray())
    }

    static func createTypeConvExprImpl(targetTypeAnnotation: AtomicType, srcVal: Expr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(targetTypeAnnotation.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.TypeConvExpr, parts.toArray())
    }

    static func createMatchCaseImpl(patterns: Array<Pattern>, patternGuardCond: Option<Expr>, caseCond: Option<Expr>,
        body: Array<SyntaxTreeNode>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CaseToken))
        parts.add(builder.buildSpace(1))
        if (!patterns.isEmpty()) {
            for (i in 0..patterns.size) {
                parts.add(patterns[i].nodeImpl)
                if (i < patterns.size - 1) {
                    parts.add(builder.buildSpace(1))
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildSpace(1))
            if (let Some(pcond) <- patternGuardCond) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
                parts.add(builder.buildSpace(1))
                parts.add(pcond.nodeImpl)
                parts.add(builder.buildSpace(1))
            }
        } else if (let Some(cond) <- caseCond) {
            parts.add(cond.nodeImpl)
            parts.add(builder.buildSpace(1))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DoubleArrowToken))
        parts.add(builder.buildSpace(1))
        let matchCaseBody = ArrayList<SyntaxNodeImpl>()
        for (i in 0..body.size) {
            if (!body[i].nodeImpl.kind.isExpr() && body[i].nodeImpl.kind != SyntaxNodeKind.FuncDecl &&
                body[i].nodeImpl.kind != SyntaxNodeKind.VarDecl) {
                throw Exception("InitException: Invalid input 'body' for 'MatchCase' init.")
            }
            matchCaseBody.add(body[i].nodeImpl)
            if (i < body.size - 1) {
                matchCaseBody.add(builder.buildNewline(1))
            }
        }
        parts.add(builder.buildNonTerminal(SyntaxNodeKind.MatchCaseBody, matchCaseBody.toArray()))
        builder.buildNonTerminal(SyntaxNodeKind.MatchCase, parts.toArray())
    }

    static func createCatchPatternImpl(pattern: Pattern, exceptionType: Array<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        if (pattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && pattern.nodeImpl.kind != SyntaxNodeKind
            .VarBindingPattern) {
            throw Exception("InitException: Invalid input 'pattern' for 'CatchPattern' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(pattern.nodeImpl)
        if (!exceptionType.isEmpty()) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            for (i in 0..exceptionType.size) {
                parts.add(exceptionType[i].nodeImpl)
                if (i < exceptionType.size - 1) {
                    parts.add(builder.buildSpace(1))
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                    parts.add(builder.buildSpace(1))
                }
            }
        } else if (pattern.nodeImpl.kind == SyntaxNodeKind.VarBindingPattern) {
            throw Exception(
                "InitException: The input 'exceptionType' cannot be None when 'pattern' is 'VarBindingPattern' for 'CatchPattern' init.")
        }
        builder.buildNonTerminal(SyntaxNodeKind.CatchPattern, parts.toArray())
    }

    static func createBreakExprImpl(comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BreakToken))
        builder.buildNonTerminal(SyntaxNodeKind.BreakExpr, parts.toArray())
    }

    static func createContinueExprImpl(comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ContinueToken))
        builder.buildNonTerminal(SyntaxNodeKind.ContinueExpr, parts.toArray())
    }

    static func createDisjunctionConditionImpl(cond: Array<ConjunctionCondition>, comments!: Array<Comment> = []) {
        if (cond.isEmpty()) {
            throw Exception("InitException: The input 'cond' cannot be empty for 'DisjunctionCondition' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..cond.size) {
            parts.add(cond[i].nodeImpl)
            if (i < cond.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.OrToken))
                parts.add(builder.buildSpace(1))
            }
        }
        builder.buildNonTerminal(SyntaxNodeKind.DisjunctionCondition, parts.toArray())
    }

    static func createConjunctionConditionImpl(cond: Array<AtomicCondition>, comments!: Array<Comment> = []) {
        if (cond.isEmpty()) {
            throw Exception("InitException: The input 'cond' cannot be empty for 'conjunctionCondition' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..cond.size) {
            match (cond[i]) {
                case AtomicCondition.Expression(expr) => parts.add(expr.nodeImpl)
                case AtomicCondition.LetPatternCondition(letPattern) => parts.add(letPattern.nodeImpl)
                case AtomicCondition.ParenConditionConstructor(parenCondition) => parts.add(parenCondition.nodeImpl)
                case _ => throw Exception("InitException: Invalid input 'condition' for 'ConjunctionCondition' init.")
            }
            if (i < cond.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AndToken))
                parts.add(builder.buildSpace(1))
            }
        }
        builder.buildNonTerminal(SyntaxNodeKind.ConjunctionCondition, parts.toArray())
    }

    static func createParenConditionImpl(cond: DisjunctionCondition, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(cond.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.ParenCondition, parts.toArray())
    }

    static func createLetPatternImpl(expr: Expr, patterns: Array<Pattern>, comments!: Array<Comment> = []) {
        if (patterns.isEmpty()) {
            throw Exception("InitException: The input 'patterns' cannot be empty for 'LetPattern' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
        parts.add(builder.buildSpace(1))
        for (i in 0..patterns.size) {
            parts.add(patterns[i].nodeImpl)
            if (i < patterns.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BackArrowToken))
        parts.add(builder.buildSpace(1))
        parts.add(expr.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.LetPattern, parts.toArray())
    }

    /** 
    *   Modify the input block by converting it into a block without NewLines.
    *   Nodes in block are seperated by semiToken.
    */
    static func modifyInterpolationBlock(interpolationBlock: Block) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..interpolationBlock.nodes.size) {
            ret.add(interpolationBlock.nodes[i].nodeImpl)
            if (i < interpolationBlock.nodes.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SemiToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))
        builder.buildNonTerminal(SyntaxNodeKind.Block, ret.toArray())
    }

    static func createStrInterpolationContentImpl(interpolationBlock: Block, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(modifyInterpolationBlock(interpolationBlock))
        builder.buildNonTerminal(SyntaxNodeKind.InterpolationExpr, parts.toArray())
    }

    static func createConstPatternImpl(litConstExpr: LitConstExpr, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(litConstExpr.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.ConstPattern, parts.toArray())
    }

    static func createVarPatternImpl(name: String, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "VarPattern") }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        builder.buildNonTerminal(SyntaxNodeKind.VarBindingPattern, parts.toArray())
    }

    // EnumPattern: case Year(n) => ...
    static func createEnumPatternImpl(enumConstructor: SymbolRef, enumType: Option<CompositeType>,
        subPatterns: Array<Pattern>, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)

        if (let Some(e) <- enumType) {
            parts.add(e.nodeImpl)
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(enumConstructor.nodeImpl)
        if (!subPatterns.isEmpty()) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..subPatterns.size) {
                parts.add(subPatterns[i].nodeImpl)
                if (i < subPatterns.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }

        builder.buildNonTerminal(SyntaxNodeKind.EnumPattern, parts.toArray())
    }

    static func createVarOrEnumPatternImpl(identifier: String, comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(identifier, "identifier", "VarOrEnumPattern") }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        builder.buildNonTerminal(SyntaxNodeKind.VarOrEnumPattern, parts.toArray())
    }

    // TypePattern: case x: T => ...
    static func createTypePatternImpl(subPattern: Pattern, patternType: TypeAnnotation, comments!: Array<Comment> = []) {
        if (subPattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && subPattern.nodeImpl.kind != SyntaxNodeKind
            .VarBindingPattern) {
            throw Exception("InitException: Invalid input 'subPattern' for 'TypePattern' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(subPattern.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        parts.add(builder.buildSpace(1))
        parts.add(patternType.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.TypePattern, parts.toArray())
    }

    /**
    * TuplePattern: case (a, b) => ...
    * @throws Exception if the input 'subPatterns' contains less than two elements.
    */
    static func createTuplePatternImpl(subPatterns: Array<Pattern>, comments!: Array<Comment> = []) {
        if (subPatterns.size <= 1) {
            throw Exception("InitException: The input 'subPatterns' must contain more than one element for 'TuplePattern' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..subPatterns.size) {
            parts.add(subPatterns[i].nodeImpl)
            if (i < subPatterns.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.TuplePattern, parts.toArray())
    }

    // WildcardPattern: case _ => ...
    static func createWildcardPatternImpl(comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WildcardToken))
        builder.buildNonTerminal(SyntaxNodeKind.WildcardPattern, parts.toArray())
    }

    static func createAtomicTypeImpl(kind: AtomicTypeKind, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        let tokenKind = match (kind) {
            case AtomicTypeKind.BoolType => SyntaxNodeKind.BooleanToken
            case AtomicTypeKind.Float16Type => SyntaxNodeKind.Float16Token
            case AtomicTypeKind.Float32Type => SyntaxNodeKind.Float32Token
            case AtomicTypeKind.Float64Type => SyntaxNodeKind.Float64Token
            case AtomicTypeKind.Int8Type => SyntaxNodeKind.Int8Token
            case AtomicTypeKind.Int16Type => SyntaxNodeKind.Int16Token
            case AtomicTypeKind.Int32Type => SyntaxNodeKind.Int32Token
            case AtomicTypeKind.Int64Type => SyntaxNodeKind.Int64Token
            case AtomicTypeKind.IntNativeType => SyntaxNodeKind.IntNativeToken
            case AtomicTypeKind.UInt8Type => SyntaxNodeKind.UInt8Token
            case AtomicTypeKind.UInt16Type => SyntaxNodeKind.UInt16Token
            case AtomicTypeKind.UInt32Type => SyntaxNodeKind.UInt32Token
            case AtomicTypeKind.UInt64Type => SyntaxNodeKind.UInt64Token
            case AtomicTypeKind.UIntNativeType => SyntaxNodeKind.UIntNativeToken
            case AtomicTypeKind.RuneType => SyntaxNodeKind.RuneToken
            case AtomicTypeKind.UnitType => SyntaxNodeKind.UnitToken
            case AtomicTypeKind.NothingType => SyntaxNodeKind.NothingToken
            case AtomicTypeKind.ThisType => SyntaxNodeKind.ThisTypeToken
            case _ => throw Exception("InitException: Invalid input 'kind' for 'AtomicType' init.")
        }
        parts.add(builder.buildBasicTerminal(tokenKind))
        builder.buildNonTerminal(SyntaxNodeKind.PrimitiveType, parts.toArray())
    }

    static func createTupleTypeImpl(elements: Array<TypeAnnotation>, labels: Array<String>,
        comments!: Array<Comment> = []) {
        if (elements.isEmpty()) {
            throw Exception("InitException: The input 'elements' cannot be empty for 'TupleType' init.")
        }
        if (elements.size != labels.size && labels.size != 0) {
            throw Exception("InitException: The input 'elements' and 'labels' mismatch when 'TupleType' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..elements.size) {
            if (labels.size != 0) {
                parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, labels[i]))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
                parts.add(builder.buildSpace(1))
            }
            parts.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.TupleType, parts.toArray())
    }

    static func createFuncTypeImpl(paramTypes: Array<TypeAnnotation>, labels: Array<String>, retType: TypeAnnotation,
        comments!: Array<Comment> = []) {
        if (paramTypes.size != labels.size) {
            throw Exception("InitException: The input 'paramTypes' and 'labels' mismatch when 'FuncType' init.")
        }

        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)

        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..labels.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, labels[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            parts.add(paramTypes[i].nodeImpl)
            if (i < labels.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ArrowToken))
        parts.add(builder.buildSpace(1))
        parts.add(retType.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.FuncType, parts.toArray())
    }

    static func createCompositeTypeImpl(name: String, prefixes: Array<String>, typeArguments: Array<TypeAnnotation>,
        comments!: Array<Comment> = []) {
        unsafe { checkIdentifier(name, "name", "CompositeType") }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        if (!typeArguments.isEmpty()) {
            let subParts = ArrayList<SyntaxNodeImpl>()
            subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
            for (i in 0..typeArguments.size) {
                subParts.add(typeArguments[i].nodeImpl)
                if (i < typeArguments.size - 1) {
                    subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    subParts.add(builder.buildSpace(1))
                }
            }
            subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))
            parts.add(builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, subParts.toArray()))
        }
        builder.buildNonTerminal(SyntaxNodeKind.CompositeType, parts.toArray())
    }

    static func createVArrayTypeImpl(elementType: TypeAnnotation, size: Int64, comments!: Array<Comment> = []) {
        if (size < 0) {
            throw Exception("InitException: Invalid input 'size' for 'VArrayType' init.")
        }
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.VArrayToken))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        parts.add(elementType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(LitConstExpr(LitConstKind.IntergerLiteral, size.toString()).nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))
        builder.buildNonTerminal(SyntaxNodeKind.VArrayType, parts.toArray())
    }

    static func createParenTypeImpl(subType: TypeAnnotation, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        builder.buildNonTerminal(SyntaxNodeKind.ParenType, parts.toArray())
    }

    static func createPrefixTypeImpl(base: TypeAnnotation, prefixOp: PrefixTypeOpKind, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        addCommentToNode(parts, comments)
        match (prefixOp) {
            case PrefixTypeOpKind.Quest => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.QuestToken))
            case _ => throw Exception("InitException: Invalid input 'prefixOp' for 'PrefixType' init.")
        }
        parts.add(base.nodeImpl)
        builder.buildNonTerminal(SyntaxNodeKind.OptionType, parts.toArray())
    }

    static func createSourceFileImpl(importLists: Array<ImportList>, pkgHeader: Option<PackageHeader>,
        topLevelDecls: Array<Decl>, ftrDirective!: Option<FeaturesDirective> = None, comments!: Array<Comment> = []) {
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        if (let Some(f) <- ftrDirective) {
            parts.add(f.nodeImpl)
            parts.add(builder.buildNewline(1))
        }
        if (let Some(p) <- pkgHeader) {
            parts.add(p.nodeImpl)
            parts.add(builder.buildNewline(1))
        }
        for (i in importLists) {
            parts.add(i.nodeImpl)
            parts.add(builder.buildNewline(1))
        }
        for (d in topLevelDecls) {
            parts.add(d.nodeImpl)
            parts.add(builder.buildNewline(1))
        }
        builder.buildNonTerminal(SyntaxNodeKind.File, parts.toArray())
    }
}
