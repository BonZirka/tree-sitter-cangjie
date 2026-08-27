// comment belong to package
package /* inner comment belong to pkg */ define.comment

// comment belong to importList[0]
import testPackage as pkg // comment belong to importList[0]

// leading comment belong to extendDecl
extend A {}

// leading comment belong to enumDecl
enum A {Enum}

// leading comment belong to mainDecl
main() {}

// leading comment belong to structDecl
struct A {}

// leading comment belong to typeAlias
type NewType = Int64

// leading comment belong to macroExpandDecl
@testMacro
class A {}

func a(/* leading comment belong to macroExpandParam */@testMacro[public func]a: Int64) {}

func divide(a: int, b: int): (
    int    /* 商 */,
    bool   // 是否整除
) {}

func calculate(): int {
    let result = 10 +
    // comment belong to `20 * 30`
    20 *
    30 /* comment belong to varDecl */
    return result
}

func printArray() {
    let nums = [
        1 /* the first element */,
        2,
        // the third element
        3
    ]
}

func f5() {
    return 0 + /* comment belong to 5 */ 5
}

main() // comment belong to paramterList
{}


// line comment1
extend<T> A<T> /* block comment1 */ where T <: I1 {
    public func foo() {}
    // line comment2
    public mut prop _prop: Int64 {
        /* block comment2 */
        get( /** document comment1 */ ) { 0 /** document comment2 */}

        set(/* block comment3 */ v) {
            // line comment3
        }
    }
} // line comment4