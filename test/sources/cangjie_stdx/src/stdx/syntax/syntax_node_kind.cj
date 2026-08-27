/* t
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.deriving.*

@Derive[Equatable]
enum SyntaxNodeKind <: ToString {
    /* NonTerminal */
    | File /* SourceFile */
    | Package
    | FeaturesDirective
    | FeaturesSet
    | FeatureId
    | PackageSpec
    | PackagePrefixes
    | CatchPattern
    | Argument
    | Annotation
    | AnnotationList /* Annotations: @C @When ... */
    | TypeArguments /* <T, V> */
    | ModifierList /* ModifierList: public static */
    | ParameterList /* ParameterList: (x,x,x) */
    | GenericConstraints /*GenericConstraints: where T1 <: I1 & I2, T2 <: I3 & I4 */
    | GenericConstraint /*GenericConstraint: T1 <: I1 & I2 */
    | MatchCase
    | MatchCaseBody
    | Pattern
    | Body
    | DisjunctionCondition
    | ConjunctionCondition
    | ParenCondition
    | LetPattern
    | AtomicCondition
    | TokenList
    | Comment
    | CommentGroup
    | CommentGroupList
    | Modifier
    | GenericParam
    | ImportSpec
    // ImportCotent
    | ImportAlias
    | ImportAll
    | ImportMulti
    | ImportSingle
    // Type_annotations
    | PrimitiveType
    | RefType
    | FuncType
    | ThisType
    | ParenType
    | QualifiedType
    | OptionType
    | OptionalType
    | VArrayType
    | TupleType
    | CompositeType /* pkg1.subpkg0.Type0<args> */
    // Decls
    | MainDecl
    | VarDecl
    | FuncDecl
    | FuncParam
    | LambdaParam
    | Block
    | TypeAlias
    | ClassDecl
    | PropGetterOrSetter
    | PropDecl
    | StaticInit
    | StructDecl
    | InterfaceDecl
    | ExtendDecl
    | EnumDecl
    | EnumConstructor
    | MacroDecl
    | MacroExpandDecl
    | MacroExpandParam
    // Exprs
    | ValuedLiteral
    | UnitLiteral
    | RuneLiteral
    | LineStringLiteral
    | MultiLineStringLiteral
    | MultiLineRawStringLiteral
    | ArrayLiteral
    | TupleLiteral
    | AssignExpr
    | VArrayExpr
    | MemberAccess
    | UnaryExpr
    | BinaryExpr
    | CallExpr
    | RefExpr
    | IsExpr
    | AsExpr
    | ParenExpr
    | ReturnExpr
    | IncOrDecExpr
    | RangeExpr
    | TypeConvExpr
    | OptionalExpr
    | BreakExpr
    | ContinueExpr
    | SubscriptExpr
    | Lambda
    | MatchExpr
    | TryCatch
    | ThrowExpr
    | SynchronizedExpr
    | SpawnExpr
    | IfExpr
    | WhileExpr
    | DoWhileExpr
    | ForInExpr
    | JumpExpr
    | LambdaExpr
    | TryExpr
    | InterpolationExpr
    | QuoteTokenExpr
    | QuoteExpr
    | QuoteInterpolationExpr
    | TrailingClosureExpr
    | UnsafeExpr
    | MacroExpandExpr
    // patterns
    | ExceptTypePattern
    | WildcardPattern
    | ConstPattern
    | VarBindingPattern
    | VarOrEnumPattern
    | TuplePattern
    | TypePattern
    | EnumPattern
    /* Terminal */
    | Token
    // token kind
    | DotToken /* . */
    | CommaToken /*,*/
    | LParenToken /* ( */
    | RParenToken /* ) */
    | LSquareToken /* [ */
    | RSquareToken /* ]*/
    | LCurlToken /* { */
    | RCurlToken /* } */
    | ExpToken /* ** */
    | MulToken /* * */
    | ModToken /* % */
    | DivToken /* / */
    | AddToken /* + */
    | SubToken /* - */
    | IncrToken /* ++ */
    | DecrToken /* -- */
    | AndToken /* && */
    | OrToken /* || */
    | CoalescingToken /* ?? */
    | PipelineToken /* |> */
    | CompositionToken /* ~> */
    | NotToken /* ! */
    | BitAndToken /* & */
    | BitOrToken /* | */
    | BitXorToken /* ^ */
    | BitNotToken /* ~ */
    | LShiftToken /* << */
    | RShiftToken /* >> */
    | ColonToken /* : */
    | SemiToken /* ; */
    | AssignToken /* = */
    | AddAssignToken /* += */
    | SubAssignToken /* -= */
    | MulAssignToken /* *= */
    | ExpAssignToken /* **= */
    | DivAssignToken /* /= */
    | ModAssignToken /* %= */
    | AndAssignToken /* &&= */
    | OrAssignToken /* ||= */
    | BitAndAssignToken /* &= */
    | BitOrAssignToken /* |= */
    | BitXorAssignToken /* ^= */
    | LShiftAssignToken /* <<= */
    | RShiftAssignToken /* >>= */
    | ArrowToken /* -> */
    | BackArrowToken /* <- */
    | DoubleArrowToken /* => */
    | RangeOpToken /* .. */
    | ClosedRangeOpToken /* ..= */
    | EllipsisToken /* ... */
    | HashToken /* # */
    | AtToken /* @ */
    | QuestToken /* ? */
    | LtToken /* < */
    | GtToken /* > */
    | LeToken /* <= */
    | GeToken /* >= */
    | IsToken /* is */
    | AsToken /* as */
    | NotEqToken /* != */
    | EqualToken /* == */
    | WildcardToken /* _ */
    // type keyword
    | Int8Token /* Int8 */
    | Int16Token /* Int16 */
    | Int32Token /* Int32 */
    | Int64Token /* Int64 */
    | IntNativeToken /* IntNative */
    | UInt8Token /* UInt8 */
    | UInt16Token /* UInt16 */
    | UInt32Token /* UInt32 */
    | UInt64Token /* UInt64 */
    | UIntNativeToken /* UIntNative */
    | Float16Token /* Float16 */
    | Float32Token /* Float32 */
    | Float64Token /* Float64 */
    | RuneToken /* Rune */
    | BooleanToken /* Bool */
    | NothingToken /* Nothing */
    | UnitToken /* Unit */
    | StructToken /* struct */
    | EnumToken /* enum */
    | VArrayToken /* VArray */
    | ThisTypeToken /* This */
    | FeaturesToken /* features */
    | PackageToken /* package */
    | ImportToken /* import */
    | ClassToken /* class */
    | InterfaceToken /* interface */
    | FuncToken /* func */
    | MacroToken /* macro */
    | QuoteToken /* quote */
    | DollarToken /* $ */
    | LetToken /* let */
    | VarToken /* var */
    | ConstToken /* const */
    | TypeToken /* type */
    | InitToken /* init */
    | ThisToken /* this */
    | SuperToken /* super */
    | IfToken /* if */
    | ElseToken /* else */
    | CaseToken /* case */
    | TryToken /* try */
    | CatchToken /* catch */
    | FinallyToken /* finally */
    | ForToken /* for */
    | DoToken /* do */
    | WhileToken /* while */
    | ThrowToken /* throw */
    | ReturnToken /* return */
    | ContinueToken /* continue */
    | BreakToken /* break */
    | InToken /* in */
    | NotInToken /* !in */
    | MatchToken /* match */
    | WhereToken /* where */
    | ExtendToken /* extend */
    | WithToken /* with */
    | PropToken /* prop */
    | GetToken /* get */
    | SetToken /* set */
    // modifier keyword
    | StaticToken /* static */
    | PublicToken /* public */
    | PrivateToken /* private */
    | InternalToken /* internal */
    | ProtectedToken /* protected */
    | OverrideToken /* override */
    | RedefToken /* redef */
    | AbstractToken /* abstract */
    | SealedToken /* sealed */
    | OpenToken /* open */
    | ForeignToken /* foreign */
    | InoutToken /* inout */
    | MutToken /* mut */
    | UnsafeToken /* unsafe */
    | OperatorToken /* operator */
    | SpawnToken /* spawn */
    | SynchronizedToken /* synchronized */
    | UpperBoundToken /* <: */
    | MainToken /* main */
    | IdentToken /* x */
    | PackageIdentifierToken /* x-y */
    | IntegerLiteralToken /* e.g. "1" */
    | FloatLiteralToken /* e.g. "'1.0'" */
    | CommentToken /* e.g. "/*xx*/" */
    | NewlineToken /* newline */
    | EndToken /* end of file */
    | SentinelToken /* ; */
    | RunePrefixToken /* r */
    | DoubleQuoteToken /* the raw value of StringLiteral, e.g. ""xx"" */
    | SingleQuoteToken /* e.g. "'xx'" */
    | JStringLiteralToken /* J"" */
    | MultilineStringToken /* e.g. """"aaa"""" */
    | MultilineRawStringToken /* e.g. "#"aaa"#" */
    | BooleanLiteralToken /* "true" or "false" */
    | DollarIdentifierToken /* $x */
    | AnnotationToken /* @When */
    | AtExclToken /* @! */
    | CommonToken /* common */
    | SpecificToken /* specific */
    | HandleToken /* handle */
    | PerformToken /* perform */
    | ResumeToken /* resume */
    | ThrowingToken /* throwing */
    // new token kind
    | TripleSingleQuoteToken
    | TripleDoubleQuoteToken
    | SpaceToken
    | StringLiteralToken
    | Invalid
    | ...

    public func toString(): String {
        match (this) {
            case File => "File"
            case FuncDecl => "FuncDecl"
            case ParameterList => "ParameterList"
            case Block => "Block"
            case UnitLiteral => "UnitLiteral"
            case FuncToken => "func"
            case MainDecl => "main"
            case TripleSingleQuoteToken => "'''"
            case TripleDoubleQuoteToken => '"""'
            case RefType => "RefType"
            case FuncType => "FuncType"
            case TupleType => "TupleType"
            case OptionType => "OptionType"

            case DotToken => "."
            case CommaToken => ","
            case LParenToken => "("
            case RParenToken => ")"
            case LSquareToken => "["
            case RSquareToken => "]"
            case LCurlToken => "{"
            case RCurlToken => "}"
            case ExpToken => "**"
            case MulToken => "*"
            case ModToken => "%"
            case DivToken => "/"
            case AddToken => "+"
            case SubToken => "-"
            case IncrToken => "++"
            case DecrToken => "--"
            case AndToken => "&&"
            case OrToken => "||"
            case CoalescingToken => "??"
            case PipelineToken => "|>"
            case CompositionToken => "~>"
            case NotToken => "!"
            case BitAndToken => "&"
            case BitOrToken => "|"
            case BitXorToken => "^"
            case BitNotToken => "~"
            case LShiftToken => "<<"
            case RShiftToken => ">>"
            case ColonToken => ":"
            case SemiToken => ";"
            case AssignToken => "="
            case AddAssignToken => "+="
            case SubAssignToken => "-="
            case MulAssignToken => "*="
            case ExpAssignToken => "**="
            case DivAssignToken => "/="
            case ModAssignToken => "%="
            case AndAssignToken => "&&="
            case OrAssignToken => "||="
            case BitAndAssignToken => "&="
            case BitOrAssignToken => "|="
            case BitXorAssignToken => "^="
            case LShiftAssignToken => "<<="
            case RShiftAssignToken => ">>="
            case ArrowToken => "->"
            case BackArrowToken => "<-"
            case DoubleArrowToken => "=>"
            case RangeOpToken => ".."
            case ClosedRangeOpToken => "..="
            case EllipsisToken => "..."
            case HashToken => "#"
            case AtToken => "@"
            case QuestToken => "?"
            case LtToken => "<"
            case GtToken => ">"
            case LeToken => "<="
            case GeToken => ">="
            case IsToken => "is"
            case AsToken => "as"
            case NotEqToken => "!="
            case EqualToken => "=="
            case WildcardToken => "_"
            // type
            case UnitToken => "Unit"
            case Int8Token => "Int8"
            case Int16Token => "Int16"
            case Int32Token => "Int32"
            case Int64Token => "Int64"
            case IntNativeToken => "IntNative"
            case UInt8Token => "UInt8"
            case UInt16Token => "UInt16"
            case UInt32Token => "UInt32"
            case UInt64Token => "UInt64"
            case UIntNativeToken => "UIntNative"
            case Float16Token => "Float16"
            case Float32Token => "Float32"
            case Float64Token => "Float64"
            case RuneToken => "Rune"
            case BooleanToken => "Bool"
            case NothingToken => "Nothing"

            case StructToken => "struct"
            case EnumToken => "enum"
            case VArrayToken => "VArray"
            case ThisTypeToken => "This"
            case FeaturesToken => "features"
            case PackageToken => "package"
            case ImportToken => "import"
            case ClassToken => "class"
            case InterfaceToken => "interface"
            case MacroToken => "macro"
            case QuoteToken => "quote"
            case DollarToken => "$"
            case LetToken => "let"
            case VarToken => "var"
            case ConstToken => "const"
            case TypeToken => "type"
            case InitToken => "init"
            case ThisToken => "this"
            case SuperToken => "super"
            case IfToken => "if"
            case ElseToken => "else"
            case CaseToken => "case"
            case TryToken => "try"
            case CatchToken => "catch"
            case FinallyToken => "finally"
            case ForToken => "for"
            case DoToken => "do"
            case WhileToken => "while"
            case ThrowToken => "throw"
            case ReturnToken => "return"
            case ContinueToken => "continue"
            case BreakToken => "break"
            case InToken => "in"
            case NotInToken => "!in"
            case MatchToken => "match"
            case WhereToken => "where"
            case ExtendToken => "extend"
            case WithToken => "with"
            case PropToken => "prop"
            case GetToken => "get"
            case SetToken => "set"
            // modifier keyword
            case StaticToken => "static"
            case PublicToken => "public"
            case PrivateToken => "private"
            case InternalToken => "internal"
            case ProtectedToken => "protected"
            case OverrideToken => "override"
            case RedefToken => "redef"
            case AbstractToken => "abstract"
            case SealedToken => "sealed"
            case OpenToken => "open"
            case ForeignToken => "foreign"
            case InoutToken => "inout"
            case MutToken => "mut"
            case UnsafeToken => "unsafe"
            case OperatorToken => "operator"

            case SpawnToken => "spawn"
            case SynchronizedToken => "synchronized"
            case UpperBoundToken => "<:"
            case MainToken => "main"
            case IdentToken => "IdentToken"
            case PackageIdentifierToken => "PackageIdentifierToken"
            case IntegerLiteralToken => "IntegerLiteralToken"
            case FloatLiteralToken => "FloatLiteralToken"
            case CommentToken => "CommentToken"
            case NewlineToken => "NewlineToken"
            case EndToken => "EndToken"
            case SentinelToken => "SentinelToken"
            case RunePrefixToken => 'r'
            case SingleQuoteToken => "'"
            case DoubleQuoteToken => '"'
            case JStringLiteralToken => "JStringLiteralToken"
            case MultilineStringToken => "MultilineStringToken"
            case MultilineRawStringToken => "MultilineRawStringToken"
            case BooleanLiteralToken => "BooleanLiteralToken"
            case DollarIdentifierToken => "DollarIdentifierToken"
            case AnnotationToken => "AnnotationToken"
            case AtExclToken => "@!"
            case CommonToken => "common"
            case SpecificToken => "specific"
            case HandleToken => "handle"
            case PerformToken => "perform"
            case ResumeToken => "resume"
            case ThrowingToken => "throwing"
            case StringLiteralToken => "StringLiteralToken"
            case Invalid => "Invalid"
            case _ => ""
        }
    }

    public func toTokenKind(): TokenKind {
        match (this) {
            case FuncToken => TokenKind.FUNC
            case DotToken => TokenKind.DOT
            case CommaToken => TokenKind.COMMA
            case LParenToken => TokenKind.LPAREN
            case RParenToken => TokenKind.RPAREN
            case LSquareToken => TokenKind.LSQUARE
            case RSquareToken => TokenKind.RSQUARE
            case LCurlToken => TokenKind.LCURL
            case RCurlToken => TokenKind.RCURL
            case ExpToken => TokenKind.EXP
            case MulToken => TokenKind.MUL
            case ModToken => TokenKind.MOD
            case DivToken => TokenKind.DIV
            case AddToken => TokenKind.ADD
            case SubToken => TokenKind.SUB
            case IncrToken => TokenKind.INCR
            case DecrToken => TokenKind.DECR
            case AndToken => TokenKind.AND
            case OrToken => TokenKind.OR
            case CoalescingToken => TokenKind.COALESCING
            case PipelineToken => TokenKind.PIPELINE
            case CompositionToken => TokenKind.COMPOSITION
            case NotToken => TokenKind.NOT
            case BitAndToken => TokenKind.BITAND
            case BitOrToken => TokenKind.BITOR
            case BitXorToken => TokenKind.BITXOR
            case BitNotToken => TokenKind.BITNOT
            case LShiftToken => TokenKind.LSHIFT
            case RShiftToken => TokenKind.RSHIFT
            case ColonToken => TokenKind.COLON
            case SemiToken => TokenKind.SEMI
            case AssignToken => TokenKind.ASSIGN
            case AddAssignToken => TokenKind.ADD_ASSIGN
            case SubAssignToken => TokenKind.SUB_ASSIGN
            case MulAssignToken => TokenKind.MUL_ASSIGN
            case ExpAssignToken => TokenKind.EXP_ASSIGN
            case DivAssignToken => TokenKind.DIV_ASSIGN
            case ModAssignToken => TokenKind.MOD_ASSIGN
            case AndAssignToken => TokenKind.AND_ASSIGN
            case OrAssignToken => TokenKind.OR_ASSIGN
            case BitAndAssignToken => TokenKind.BITAND_ASSIGN
            case BitOrAssignToken => TokenKind.BITOR_ASSIGN
            case BitXorAssignToken => TokenKind.BITXOR_ASSIGN
            case LShiftAssignToken => TokenKind.LSHIFT_ASSIGN
            case RShiftAssignToken => TokenKind.RSHIFT_ASSIGN
            case ArrowToken => TokenKind.ARROW
            case BackArrowToken => TokenKind.BACKARROW
            case DoubleArrowToken => TokenKind.DOUBLE_ARROW
            case RangeOpToken => TokenKind.RANGEOP
            case ClosedRangeOpToken => TokenKind.CLOSEDRANGEOP
            case EllipsisToken => TokenKind.ELLIPSIS
            case HashToken => TokenKind.HASH
            case AtToken => TokenKind.AT
            case QuestToken => TokenKind.QUEST
            case LtToken => TokenKind.LT
            case GtToken => TokenKind.GT
            case LeToken => TokenKind.LE
            case GeToken => TokenKind.GE
            case IsToken => TokenKind.IS
            case AsToken => TokenKind.AS
            case NotEqToken => TokenKind.NOTEQ
            case EqualToken => TokenKind.EQUAL
            case WildcardToken => TokenKind.WILDCARD
            // type
            case UnitToken => TokenKind.UNIT
            case Int8Token => TokenKind.INT8
            case Int16Token => TokenKind.INT16
            case Int32Token => TokenKind.INT32
            case Int64Token => TokenKind.INT64
            case IntNativeToken => TokenKind.INTNATIVE
            case UInt8Token => TokenKind.UINT8
            case UInt16Token => TokenKind.UINT16
            case UInt32Token => TokenKind.UINT32
            case UInt64Token => TokenKind.UINT64
            case UIntNativeToken => TokenKind.UINTNATIVE
            case Float16Token => TokenKind.FLOAT16
            case Float32Token => TokenKind.FLOAT32
            case Float64Token => TokenKind.FLOAT64
            case RuneToken => TokenKind.RUNE
            case BooleanToken => TokenKind.BOOLEAN
            case NothingToken => TokenKind.NOTHING

            case StructToken => TokenKind.STRUCT
            case EnumToken => TokenKind.ENUM
            case VArrayToken => TokenKind.VARRAY
            case ThisTypeToken => TokenKind.THISTYPE
            case FeaturesToken => TokenKind.FEATURES
            case PackageToken => TokenKind.PACKAGE
            case ImportToken => TokenKind.IMPORT
            case ClassToken => TokenKind.CLASS
            case InterfaceToken => TokenKind.INTERFACE
            case MacroToken => TokenKind.MACRO
            case QuoteToken => TokenKind.QUOTE
            case DollarToken => TokenKind.DOLLAR
            case LetToken => TokenKind.LET
            case VarToken => TokenKind.VAR
            case ConstToken => TokenKind.CONST
            case TypeToken => TokenKind.TYPE
            case InitToken => TokenKind.INIT
            case ThisToken => TokenKind.THIS
            case SuperToken => TokenKind.SUPER
            case IfToken => TokenKind.IF
            case ElseToken => TokenKind.ELSE
            case CaseToken => TokenKind.CASE
            case TryToken => TokenKind.TRY
            case CatchToken => TokenKind.CATCH
            case FinallyToken => TokenKind.FINALLY
            case ForToken => TokenKind.FOR
            case DoToken => TokenKind.DO
            case WhileToken => TokenKind.WHILE
            case ThrowToken => TokenKind.THROW
            case ReturnToken => TokenKind.RETURN
            case ContinueToken => TokenKind.CONTINUE
            case BreakToken => TokenKind.BREAK
            case InToken => TokenKind.IN
            case NotInToken => TokenKind.NOT_IN
            case MatchToken => TokenKind.MATCH
            case WhereToken => TokenKind.WHERE
            case ExtendToken => TokenKind.EXTEND
            case WithToken => TokenKind.WITH
            case PropToken => TokenKind.PROP
            case GetToken | SetToken => TokenKind.IDENTIFIER
            // modifier keyword
            case StaticToken => TokenKind.STATIC
            case PublicToken => TokenKind.PUBLIC
            case PrivateToken => TokenKind.PRIVATE
            case InternalToken => TokenKind.INTERNAL
            case ProtectedToken => TokenKind.PROTECTED
            case OverrideToken => TokenKind.OVERRIDE
            case RedefToken => TokenKind.REDEF
            case AbstractToken => TokenKind.ABSTRACT
            case SealedToken => TokenKind.SEALED
            case OpenToken => TokenKind.OPEN
            case ForeignToken => TokenKind.FOREIGN
            case InoutToken => TokenKind.INOUT
            case MutToken => TokenKind.MUT
            case UnsafeToken => TokenKind.UNSAFE
            case OperatorToken => TokenKind.OPERATOR

            case SpawnToken => TokenKind.SPAWN
            case SynchronizedToken => TokenKind.SYNCHRONIZED
            case UpperBoundToken => TokenKind.UPPERBOUND
            case MainToken => TokenKind.MAIN
            case IdentToken => TokenKind.IDENTIFIER
            case PackageIdentifierToken => TokenKind.PACKAGE_IDENTIFIER
            case IntegerLiteralToken => TokenKind.INTEGER_LITERAL
            case FloatLiteralToken => TokenKind.FLOAT_LITERAL
            case CommentToken => TokenKind.COMMENT
            case NewlineToken => TokenKind.NL
            case EndToken => TokenKind.END
            case SentinelToken => TokenKind.SENTINEL
            case JStringLiteralToken => TokenKind.JSTRING_LITERAL
            case MultilineStringToken => TokenKind.MULTILINE_STRING
            case MultilineRawStringToken => TokenKind.MULTILINE_RAW_STRING
            case BooleanLiteralToken => TokenKind.BOOL_LITERAL
            case DollarIdentifierToken => TokenKind.DOLLAR_IDENTIFIER
            case AnnotationToken => TokenKind.ANNOTATION
            case AtExclToken => TokenKind.AT_EXCL
            case CommonToken => TokenKind.COMMON
            case SpecificToken => TokenKind.SPECIFIC
            case HandleToken => TokenKind.HANDLE
            case PerformToken => TokenKind.PERFORM
            case ResumeToken => TokenKind.RESUME
            case ThrowingToken => TokenKind.THROWING
            case StringLiteralToken => TokenKind.STRING_LITERAL
            case _ => TokenKind.ILLEGAL
        }
    }

    func isWhitespace(): Bool {
        match (this) {
            case NewlineToken | SpaceToken => true
            case _ => false
        }
    }

    func isPattern(): Bool {
        match (this) {
            case WildcardPattern | ConstPattern | VarBindingPattern | VarOrEnumPattern | TuplePattern | EnumPattern
                | TypePattern => true
            case _ => false
        }
    }

    func isDecl(): Bool {
        match (this) {
            case MainDecl | VarDecl | FuncDecl | FuncParam | LambdaParam | TypeAlias | ClassDecl | PropGetterOrSetter
                | PropDecl | StaticInit | StructDecl | InterfaceDecl | ExtendDecl | EnumDecl | EnumConstructor
                | MacroDecl | MacroExpandDecl | MacroExpandParam => true
            case _ => false
        }
    }

    func isExpr(): Bool {
        match (this) {
            case IntegerLiteralToken | FloatLiteralToken | BooleanLiteralToken | UnitLiteral | RuneLiteral
                | LineStringLiteral | MultiLineStringLiteral | MultiLineRawStringLiteral | ArrayLiteral | TupleLiteral
                | AssignExpr | VArrayExpr | MemberAccess | UnaryExpr | BinaryExpr | CallExpr | RefExpr | IsExpr | AsExpr
                | ParenExpr | ReturnExpr | IncOrDecExpr | RangeExpr | TypeConvExpr | OptionalExpr | BreakExpr
                | ContinueExpr | SubscriptExpr | Lambda | MatchExpr | TryCatch | ThrowExpr | SynchronizedExpr
                | SpawnExpr | IfExpr | WhileExpr | DoWhileExpr | ForInExpr | JumpExpr | LambdaExpr | TryExpr
                | InterpolationExpr | QuoteTokenExpr | QuoteExpr | QuoteInterpolationExpr | TrailingClosureExpr
                | UnsafeExpr | MacroExpandExpr | ValuedLiteral => true
            case _ => false
        }
    }

    func isTypeAnnotation(): Bool {
        match (this) {
            case RefType | FuncType | ThisType | ParenType | QualifiedType | OptionType | OptionalType | VArrayType
                | TupleType | CompositeType | Int8Token | Int16Token | Int32Token | Int64Token | IntNativeToken
                | UInt8Token | UInt16Token | UInt32Token | UInt64Token | UIntNativeToken | Float16Token | Float32Token
                | Float64Token | RuneToken | BooleanToken | NothingToken | UnitToken | ThisTypeToken | PrimitiveType => true
            case _ => false
        }
    }

    prop size: Int64 {
        get() {
            return toString().size
        }
    }
}
